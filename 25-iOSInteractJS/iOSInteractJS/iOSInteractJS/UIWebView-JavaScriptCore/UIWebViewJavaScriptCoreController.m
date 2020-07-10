//
//  UIWebViewJavaScriptCoreController.m
//  iOSInteractJS
//
//  Created by sunke on 2020/7/10.
//  Copyright © 2020 KentSun. All rights reserved.
//

//介绍如何使用JavaScriptCore框架在 UIWebView上实现iOS与JS交互。
/*
 一、JS调用iOS：
 实现原理：
 1、JS与iOS约定好jsToOc方法，作为JS调用iOS的入口；
 2、iOS通过[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]获取JS代码的上下文JSContext;
 3、JS调用jsToOc方法，iOS使用Block形式监听（重写）此方法context[@"jsToOc"] = ^() {}，收到JS的调用请求和参数；
 PS：在使用Block形式监听（重写）JS的方法的时候，不要在Block中直接使用外部的JSValue和JSContent，因为JSContext强引用Block，Block强引用外部变量，JSValue又强引用JSContext（JSValue需要JSContext来执行JS代码），会形成循环引用。因为JS没有弱引用的概念，所以__weak不会奏效，可以通过将JSValue作为Block内部参数和[JSContext currentContext]的方式分别解决两类循环引用的问题。

 
 二、iOS调用JS：
 实现原理：
 1、iOS通过UIWebView的-valueForKeyPath:方法获取JSContext对象（保证在最新的JS环境中执行JS代码）；
 2、iOS通过JSContext的-evaluateScript:方法执行一段JS代码ocToJs('loginSucceed', 'oc_tokenString')；
 3、JS在ocToJs方法中将iOS传过来的数据显示在div元素中。
 PS：除了使用JSContext的-evaluateScript:方法之外，还可以先通过[context[@"ocToJs"]获取到JS的ocToJs方法对应的JSValue，然后使用JSValue的-callWithArguments:方法调用JS的ocToJs方法。
 */


#import "UIWebViewJavaScriptCoreController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebViewJavaScriptCoreController () <UIWebViewDelegate>
//! UIWebView-webView
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewJavaScriptCoreController

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
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebView-JavaScriptCore" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark - Action functions

//! 登录方法
- (void)login:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        //! JSContext -evaluateScript:方式调用JS方法
        // [context evaluateScript:[NSString stringWithFormat:@"ocToJs('loginSucceed', 'oc_tokenString')"]];
        //! JSValue -callWithArguments:方式调用JS方法
        [context[@"ocToJs"] callWithArguments:@[@"loginSucceed", @"oc_tokenString"]];
    });
}

//! 使用context监听JS的方法
- (void)addActionsWithContext:(JSContext *)context {
    
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"JS Exception: %@", exception.toString);
        });
    }];
    
    context[@"jsToOc"] = ^(NSString *action, NSString *params) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIWebViewJavaScriptCoreController showAlertWithTitle:action message:params cancelHandler:nil];
        });
    };
    /*
    context[@"loginSucceed"] = ^(NSString *token) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIWebViewJavaScriptCoreController showAlertWithTitle:@"loginScceed" message:token cancelHandler:nil];
        });
    };
     */
    /*
    context[@"login"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self login:nil];
        });
    };
     */
}


#pragma mark - UIWebViewDelegate

//! UIWebView在每次加载请求完成后会调用此方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 获取JS代码的执行环境/上下文/作用域
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.title = [context evaluateScript:@"document.title"].toString;
    
    [self addActionsWithContext:context];
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
