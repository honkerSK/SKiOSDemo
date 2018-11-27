//
//  Page1ViewController.m
//  AppB
//
//  Created by sunke on 22/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "Page1ViewController.h"

@interface Page1ViewController ()


@end

@implementation Page1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)page1BackToAppA:(id)sender {
    
    // 1.拿到对应应用程序的URL Scheme
    NSString *urlSchemeString = [[self.urlString componentsSeparatedByString:@"?"] lastObject];
    NSString *urlString = [urlSchemeString stringByAppendingString:@"://"];
    
    // 2.获取对应应用程序的URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 3.判断是否可以打开
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        [[UIApplication sharedApplication] openURL:url];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    }
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
