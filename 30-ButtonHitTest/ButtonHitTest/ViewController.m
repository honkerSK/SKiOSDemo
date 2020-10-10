//
//  ViewController.m
//  ButtonHitTest
//
//  Created by sunke on 2020/10/10.
//

#import "ViewController.h"
#import "UIButton+HitTestInsets.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton new];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 80);
    button.backgroundColor = [UIColor redColor];
    button.center = self.view.center;
    [self.view addSubview:button];

    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.hitTestInsets = UIEdgeInsetsMake(15, 15, 15, 15);// 缩小响应范围
//    button.hitTestInsets = UIEdgeInsetsMake(-20, -20, -20, -20);// 扩展响应范围
    
}


#pragma mark - - - - UIEvent - - - -
- (void)buttonClicked:(UIButton *)button{
    NSLog(@"AAAAAA");
}



@end
