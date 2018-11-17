//
//  ViewController.m
//  SKKeychainTool
//
//  Created by sunke on 2017/9/26.
//  Copyright © 2017 SK. All rights reserved.
//

#import "ViewController.h"
#import "SKKeychainTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *keyid = [SKKeychainTool getDeviceIDInKeychain];
    NSLog(@"**---%@", keyid);
}


@end
