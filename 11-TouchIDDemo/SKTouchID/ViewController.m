//
//  ViewController.m
//  SKTouchID
//
//  Created by sunke on 2016/8/24.
//  Copyright © 2016 SK. All rights reserved.
//

#import "ViewController.h"

//由于Touch ID基于本地身份验证框架，因此需要将其导入项目。
#import <LocalAuthentication/LocalAuthentication.h>

/*
 1.从本地身份验证框架获取身份验证上下文
 2.canEvaluatePolicy方法检查设备上是否有Touch ID可用
 3.评估策略，其中第三个参数是完成处理程序块。
 4.Touch ID身份验证成功与否显示警报消息
 5.如果Touch ID不可用，则会显示Alert消息。
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)anyWithTouchID:(id)sender {
    
    //1
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    
    //2.检查TouchID是否存在
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //3
        NSString *reason = @"Authenticate with Touch ID";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            //4.
            if (success) {
                [self showAlertController:@"Touch ID Authentication Succeeded"];
            }else{
                [self showAlertController:@"Touch ID Authentication Failed"];
            }
            
        }];
    }else{
        //5.
        [self showAlertController:@"Touch ID not available"];
    }
    
    
}

//警报控制器中显示消息
- (void)showAlertController:(NSString *)message{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


@end
