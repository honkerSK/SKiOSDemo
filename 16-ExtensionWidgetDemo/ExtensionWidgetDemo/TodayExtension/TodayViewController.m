//
//  TodayViewController.m
//  TodayExtension
//
//  Created by sunke on 2018/5/24.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置widget展示视图的大小
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    
    //Today Extension的页面加一个可点击打开containingAPP的label
    UILabel *openAppLabel = [[UILabel alloc] init];
    openAppLabel.textColor = [UIColor colorWithRed:(97.0/255.0) green:(97.0/255.0) blue:(97.0/255.0) alpha:1];
    openAppLabel.backgroundColor = [UIColor clearColor];
    openAppLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    openAppLabel.textAlignment = NSTextAlignmentCenter;
    openAppLabel.text = @"点击打开SKApp";
    openAppLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:openAppLabel];
    
    openAppLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *openURLContainingAPP = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openURLContainingAPP)];
    [openAppLabel addGestureRecognizer:openURLContainingAPP];
    
    
    
}

//设置widget展示视图的大小。关于widget的背景色，以及具体展示的内容大家按需绘制，这里暂且不表。
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//通过openURL的方式启动Containing APP
- (void)openURLContainingAPP
{
    //scheme为app的scheme
    [self.extensionContext openURL:[NSURL URLWithString:@"ExtensionWidgetDemo://xxxx"]
                 completionHandler:^(BOOL success) {
                     NSLog(@"open url result:%d",success);
                 }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    //执行必要的任何设置以更新视图。
    //如果遇到错误，请使用NCUpdateResultFailed
    //如果不需要更新，请使用NCUpdateResultNoData
    //如果有更新，请使用NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
