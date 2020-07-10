//
//  WKWebViewWKScriptMessageHandlerController.m
//  iOSInteractJS
//
//  Created by sunke on 2020/7/10.
//  Copyright © 2020 KentSun. All rights reserved.
//

/*
 WKScriptMessageHandler是WebKit提供的一种在WKWebView上进行JS消息控制的协议。
 一、JS调用iOS：
 实现原理：
 1、JS与iOS约定好jsToOc方法，用作JS在调用iOS时的方法；
 2、iOS使用WKUserContentController的-addScriptMessageHandler:name:方法监听name为jsToOc的消息；
 3、JS通过window.webkit.messageHandlers.jsToOc.postMessage()的方式对jsToOc方法发送消息；
 4、iOS在-userContentController:didReceiveScriptMessage:方法中读取name为jsToOc的消息数据message.body。
 PS：[userContentController addScriptMessageHandler:self name:@"jsToOc"]会引起循环引用问题。一般来说，在合适的时机removeScriptMessageHandler可以解决此问题。比如：在-viewWillAppear:方法中执行add操作，在-viewWillDisappear:方法中执行remove操作。如下

 二、iOS调用JS：
OS调用JS方式与之前 一致，
 都是通过WKWebView的-evaluateJavaScript:completionHandler:方法来实现的。
 
 
 */

#import "WKWebViewWKScriptMessageHandlerController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewWKScriptMessageHandlerController () <WKNavigationDelegate, WKScriptMessageHandler>
//! WKWebView-webView
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WKWebViewWKScriptMessageHandlerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //! 登录按钮
    UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItems = @[loginBtnItem];
    
    //! WKWebView
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //为userContentController添加ScriptMessageHandler，并指明name
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:userScript];
   
    //使用添加了ScriptMessageHandler的userContentController配置configuration
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    //使用configuration对象初始化webView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.autoresizesSubviews = YES;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    if (@available(ios 11.0,*)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKWebView-WKScriptMessageHandler" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //监听name为jsToOc的消息
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"jsToOc"];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //解决addScriptMessageHandler 引起循环引用问题
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"jsToOc"];
}


#pragma mark - Action functions

//! 登录方法
- (void)login:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *jsString = [NSString stringWithFormat:@"ocToJs('loginSucceed', 'oc_tokenString')"];
        [self.webView evaluateJavaScript:jsString completionHandler:^(id response, NSError * error) {
            NSLog(@"error: %@", error.description);
            NSLog(@"response: %@", response);
        }];
    });
}


#pragma mark - WKNavigationDelegate

//! WKWebView在每次加载请求完成后会调用此方法
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *title, NSError *error) {
        self.title = title;
    }];
}


#pragma mark - WKScriptMessageHandler

//! WKWebView收到ScriptMessage时回调此方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        [WKWebViewWKScriptMessageHandlerController showAlertWithTitle:message.name message:message.body cancelHandler:nil];
    }
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
