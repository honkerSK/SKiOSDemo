//
//  Page1ViewController.h
//  AppB
//
//  Created by sunke on 22/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Page1ViewController : UIViewController

// 用于接受、截取出跳转回的应用（即AppA）的URL Schemes，执行跳转。
@property (nonatomic, copy) NSString *urlString;

@end

