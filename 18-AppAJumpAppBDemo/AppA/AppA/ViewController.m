//
//  ViewController.m
//  AppA
//
//  Created by sunke on 22/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)jumpToAppB:(id)sender {
    // 1.获取应用程序AppB的URL Scheme
//    NSURL *appBUrl = [NSURL URLWithString:@"AppB://"];
    NSURL *appBUrl = [NSURL URLWithString:@"AppB://?AppA"];

    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        // 3. 打开应用程序AppB
        //openURL:' is deprecated: first deprecated in iOS 10.0 - Please use openURL:options:completionHandler: instead
       // [[UIApplication sharedApplication] openURL:appBUrl];
        
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appBUrl options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:appBUrl];
        }
        
//        UIApplication *application = [UIApplication sharedApplication];
//        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//            //iOS10 以后
//            [application openURL:appBUrl options:@{}
//               completionHandler:^(BOOL success) {
//                   NSLog(@"%d",success);
//               }];
//        } else {
//            BOOL success = [application openURL:appBUrl];
//            NSLog(@"%d",success);
//        }
        
        // Objective-C
//        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
//        [application openURL:appBUrl options:options completionHandler:nil];

        
    } else {
        NSLog(@"没有安装");
    }
    
}


- (IBAction)jumpToAppBPage1:(id)sender {
    // 1.获取应用程序AppB的Page1页面的URL
    NSURL *appBUrl = [NSURL URLWithString:@"AppB://Page1?AppA"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        // 3. 打开应用程序AppB的Page1页面
//        [[UIApplication sharedApplication] openURL:appBUrl];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appBUrl options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:appBUrl];
        }
        
    } else {
        NSLog(@"没有安装");
    }
    
}



- (IBAction)jumpToAppBPage2:(id)sender {
   
    // 1.获取应用程序AppB的Page2页面的URL
    NSURL *appBUrl = [NSURL URLWithString:@"AppB://Page2?AppA"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        // 3. 打开应用程序AppB的Page2页面
//        [[UIApplication sharedApplication] openURL:appBUrl];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appBUrl options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:appBUrl];
        }
        
    } else {
        NSLog(@"没有安装");
    }
    
}


@end
