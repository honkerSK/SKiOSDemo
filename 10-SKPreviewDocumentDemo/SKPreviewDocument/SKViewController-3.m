//
//  SKViewController-3.m
//  SKPreviewDocument
//
//  Created by sunke on 2018/10/15.
//  Copyright © 2018 SK. All rights reserved.
//

#import "SKViewController-3.h"

//第三种方式：UIWebView

@interface SKViewController_3 ()<UIWebViewDelegate>

@end

@implementation SKViewController_3

- (void)viewDidLoad {
    [super viewDidLoad];

    [self readDocfile];
    
    //[self createImageView];
}


- (void)readDocfile {
    NSString * ducumentLocation = [[NSBundle mainBundle] pathForResource:@"OC总结" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    webView.multipleTouchEnabled = YES;
    webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}


- (void)createImageView{
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"iOSDoc" ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = image;
    
    [self.view addSubview:imageView];
}

@end
