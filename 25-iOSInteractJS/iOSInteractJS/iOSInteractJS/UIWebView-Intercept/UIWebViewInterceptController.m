//
//  UIWebViewInterceptController.m
//  iOSInteractJS
//
//  Created by sunke on 2020/7/10.
//  Copyright © 2020 KentSun. All rights reserved.
//


/*
 介绍通过 UIWebView协议拦截的方式实现iOS与JS交互。
 
 一、JS调用iOS：
 实现逻辑：点击JS的登录按钮，JS将登录成功后的token数据传递给iOS，iOS将收到的数据展示出来。
 实现原理：
 1、JS与iOS约定好jsToOc协议，用作JS在调用iOS时url的scheme；
 2、JS在登录成功后加载含有token数据的url：(jsToOc://loginSucceed?js_tokenString)；
 3、iOS的UIWebView在加载请求前都会调用-webView:shouldStartLoadWithRequest:navigationType:方法来确认是否加载此请求；
 4、iOS在此方法内截取jsToOc协议获取JS传过来的数据，用UIAlertController显示出来，并不允许加载此请求。

 PS：除了显示截取到的数据，iOS还可以将request.URL.host看作JS想调用的方法名，将request.URL.query看作该方法的参数集，从而体现出JS调用iOS的概念。
 
 二、iOS调用JS：
 实现逻辑：点击iOS的登录按钮，iOS将登录成功后的token数据传递给JS，JS将收到的数据展示出来。
 实现原理：
 1、iOS使用UIWebView的-stringByEvaluatingJavaScriptFromString:方法访问JS；
 2、iOS与JS约定好ocToJs方法，用作iOS在调用JS时的入口方法；
 3、iOS在登录成功后以loginSucceed和oc_tokenString为参数访问ocToJs方法；
 4、JS在ocToJs方法中将iOS传过来的数据显示在div元素中。
 PS：UIWebView的-stringByEvaluatingJavaScriptFromString:方法可以执行JS代码。但只有在整个webView加载完成之后调用此方法才会有响应。比如：我们可以通过如下方式获取JS的标题。

 
 
 */
#import "UIWebViewInterceptController.h"

@interface UIWebViewInterceptController () <UIWebViewDelegate>

//! UIWebView-webView
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewInterceptController

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
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebView-Intercept" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark - Action functions

//! 登录方法
- (void)login:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *jsString = [NSString stringWithFormat:@"ocToJs('loginSucceed', 'oc_tokenString')"];
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    });
}


#pragma mark - UIWebViewDelegate

//! UIWebView在每次加载请求前会调用此方法来确认是否加载此请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.scheme caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        [UIWebViewInterceptController showAlertWithTitle:request.URL.host message:request.URL.query cancelHandler:nil];
        return NO;
    }
    
    return YES;
}

//! UIWebView在每次加载请求完成后会调用此方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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
