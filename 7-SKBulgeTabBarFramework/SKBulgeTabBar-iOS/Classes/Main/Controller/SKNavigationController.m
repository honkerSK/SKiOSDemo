//
//  SKNavigationController.m
//  SKBulgeTabBar-iOS
//
//  Created by sunke on 2017/5/9.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKNavigationController.h"
#import "SKTabBar.h"

//黄色导航栏
#define NavBarColor [UIColor colorWithRed:250/255.0 green:227/255.0 blue:111/255.0 alpha:1.0]

@interface SKNavigationController ()

@end

@implementation SKNavigationController

+ (void)load {
    //获取UIBarButtonItem
//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil ]; //iOS5-8
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]]; //iOS9+
    
    //设置UIBarButtonItem字体
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    //获取到导航条
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置导航条背景图片
    [bar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
   //设置导航条标题字体
    NSMutableDictionary *dicBar = [NSMutableDictionary dictionary];
    dicBar[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [bar setTitleTextAttributes:dic];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    return [super pushViewController:viewController animated:animated];
}


@end
