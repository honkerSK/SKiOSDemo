//
//  SKNewViewController.m
//  SKTopSlideTitleBar
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKNewViewController.h"

@interface SKNewViewController ()

@end

@implementation SKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];
}


- (void)setupNavBar{
    //左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] lightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagSub)];
    
    self.navigationItem.leftBarButtonItem =  leftItem;
    
    //中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}



//点击了订阅标签
- (void)tagSub{
    SKLog(@"订阅标签");
    
    
}

@end
