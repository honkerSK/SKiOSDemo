//
//  UIWebViewJSExportController.m
//  iOSInteractJS
//
//  Created by sunke on 2020/7/10.
//  Copyright © 2020 KentSun. All rights reserved.
//


/*
 介绍如何使用JSExport协议在 UIWebView上实现iOS与JS交互。
 JSExport是JavaScriptCore框架里的一个协议。如果一个协议遵守了JSExport，那么该协议的方法会对JS开放，允许JS直接调用。
 */

/*
 一、JS调用iOS：
 实现原理：
 1、JS与iOS约定好OCJSBridge类名和jsToOc方法，作为JS调用iOS的入口OCJSBridge.jsToOc；
 2、iOS创建遵守JSExport协议的OCJSExport协议，在该协议中声明-jsToOc:params:方法(起个别名jsToOc)；
 3、UIWebViewJSExportController遵守OCJSExport协议，实现该协议中的-jsToOc:params:方法；
 4、iOS通过[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]获取JS代码的上下文JSContext;
 5、iOS通过context[@"OCJSBridge"] = self;在context注册OCJSBridge对象为self(UIWebViewJSExportController的实例)；
 3、JS调用OCJSBridge.jsToOc方法，iOSUIWebViewJSExportController的-jsToOc:params:方法会响应JS的调用请求和参数；
 PS1：JS的方法命名规则与OC不一样，当OCJSExport协议中的方法有多个参数时，需要使用JSExportAs(<#PropertyName#>, <#Selector#>)为OC方法起个别名。否则，JS就需要很别扭的使用OCJSBridge.jsToOcParams来调用OC的-jsToOc:params:方法（无参数和单参数时可不起别名）。
 PS2：context[@"OCJSBridge"] = self;会有循环引用问题，导致self的-dealloc方法不被执行。因为JS中没有弱引用，所以__weak在这里不起作用。一般来说，可以使用单独的类来处理OCJSExport协议的相关方法，以解决此问题（比如：context[@"OCJSBridge"] = [OCJSBridge new];）
 
 
 二、iOS调用JS：
 iOS调用JS方式与 使用JavaScriptCore 一致，都是通过JavaScriptCore框架提供的能力来实现的：
 1、使用JSContext的-evaluateScript:方法执行一段JS代码ocToJs('loginSucceed', 'oc_tokenString')；
 2、先通过[context[@"ocToJs"]获取到JS的ocToJs方法对应的JSValue，然后使用JSValue的-callWithArguments:方法调用JS的ocToJs方法。

 */

#import "UIWebViewJSExportController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol OCJSExport <JSExport>

- (void)login;
- (void)loginSucceed:(NSString *)token;
//为OC方法起个别名
JSExportAs(jsToOc, - (void)jsToOc:(NSString *)action params:(NSString *)params);

@end

@interface UIWebViewJSExportController () <UIWebViewDelegate, OCJSExport>
//! UIWebView-webView
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewJSExportController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //! 登录按钮
    UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItems = @[loginBtnItem];
    
    //! UIWebView
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    if (@available(ios 11.0,*)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebView-JSExport" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark - Action functions

//! 登录方法
- (void)login:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        [context[@"ocToJs"] callWithArguments:@[@"loginSucceed", @"oc_tokenString"]];
    });
}


#pragma mark - JSExport functions

//! OCJSBridge.login()
- (void)login {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self login:nil];
    });
}

//! OCJSBridge.loginSucceed(token)
- (void)loginSucceed:(NSString *)token {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIWebViewJSExportController showAlertWithTitle:@"loginScceed" message:token cancelHandler:nil];
    });
}

//! OCJSBridge.jstoOc(action, params)
- (void)jsToOc:(NSString *)action params:(NSString *)params {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIWebViewJSExportController showAlertWithTitle:action message:params cancelHandler:nil];
    });
}


#pragma mark - UIWebViewDelegate

//! UIWebView在每次加载请求完成后会调用此方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.title = [context evaluateScript:@"document.title"].toString;
    //获取JS代码的执行环境/上下文/作用域
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"JS Exception: %@", exception.toString);
        });
    }];
    
    //在context注册OCJSBridge对象为self
    //! 有循环引用的问题，可用独立类解决
    context[@"OCJSBridge"] = self;
}


#pragma mark - Util functions

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Dealloc

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
