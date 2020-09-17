//
//  ViewController.m
//  EventDemo
//
//  Created by sunke on 2020/9/17.
//  Copyright © 2020 KentSun. All rights reserved.
//
// 事件传递 
#import "ViewController.h"
#import "CustomButton.h"

@interface ViewController ()
{
    CustomButton *cornerButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cornerButton = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    cornerButton.backgroundColor = [UIColor blueColor];
    [cornerButton addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cornerButton];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)doAction:(id)sender{
    NSLog(@"click");
}

@end
