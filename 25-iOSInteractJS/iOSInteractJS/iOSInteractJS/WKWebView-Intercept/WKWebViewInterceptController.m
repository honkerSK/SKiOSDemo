//
//  WKWebViewInterceptController.m
//  iOSInteractJS
//
//  Created by sunke on 2020/7/10.
//  Copyright © 2020 KentSun. All rights reserved.
//

/*
 介绍通过 WKWebView协议拦截的方式实现iOS与JS交互。
 
 一、JS调用iOS：
 实现原理：
 1、JS与iOS约定好jsToOc协议，用作JS在调用iOS时url的scheme；
 2、JS在登录成功后加载含有token数据的url：(jsToOc://loginSucceed?js_tokenString)；
 3、iOS的WKWebView在请求跳转前会调用-webView:decidePolicyForNavigationAction:decisionHandler:方法来确认是否允许跳转；
 4、iOS在此方法内截取jsToOc协议获取JS传过来的数据，用UIAlertController显示出来，并通过decisionHandler不允许此请求跳转。
 PS1：除了显示截取到的数据，iOS还可以将navigationAction.request.URL.host看作JS想调用的方法名，将navigationAction.request.URL.query看作该方法的参数集，从而体现出JS调用iOS的概念。
 PS2：在-webView:decidePolicyForNavigationAction:decisionHandler:方法中一定要调用decisionHandler回调来制定允许请求跳转WKNavigationActionPolicyAllow或者不允许跳转WKNavigationActionPolicyAllow，不然会崩溃。

 
 二、iOS调用JS：
 实现原理：
 1、iOS与JS约定好ocToJs方法，用作iOS在调用JS时的入口方法；
 2、iOS在登录成功后以loginSucceed和oc_tokenString为参数拼接JS代码ocToJs('loginSucceed', 'oc_tokenString');
 3、iOS使用WKWebView的-evaluateJavaScript:completionHandler:方法执行拼接好的JS代码；
 3、JS在ocToJs方法中将iOS传过来的数据显示在div元素中；
 4、iOS通过completionHandler收到JS中ocToJs方法的回调。
 PS：WKWebView的-evaluateJavaScript:completionHandler:方法可以执行JS代码。但只有在整个webView加载完成之后调用此方法才会有响应。比如：我们可以通过如下方式获取JS的标题。

 
 */

#import "WKWebViewInterceptController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewInterceptController () <WKNavigationDelegate>
//! WKWebView-webView
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WKWebViewInterceptController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //! 登录按钮
    UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItems = @[loginBtnItem];
    
    //! WKWebView
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wkWebConfig];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.autoresizesSubviews = YES;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    if (@available(ios 11.0,*)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKWebView-Intercept" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark - Action functions

//! 登录方法
- (void)login:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView evaluateJavaScript:@"ocToJs('loginSucceed', 'oc_tokenString')" completionHandler:^(id response, NSError *error) {
            NSLog(@"response: %@", response);
        }];
    });
}


#pragma mark - WKNavigationDelegate

//! WKWeView在每次加载请求前会调用此方法来确认是否进行请求跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if ([navigationAction.request.URL.scheme caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        [WKWebViewInterceptController showAlertWithTitle:navigationAction.request.URL.host message:navigationAction.request.URL.query cancelHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//! WKWebView在每次加载请求完成后会调用此方法
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *title, NSError *error) {
        self.title = title;
    }];
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
