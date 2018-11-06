//
//  SKTabBarController.m
//  SKBulgeTabBar-iOS
//
//  Created by sunke on 2017/5/9.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKTabBarController.h"


#import "SKNavigationController.h"
#import "SKTabBar.h"

#import "SKHomeVC.h"
#import "SKFishVC.h"
#import "SKMessageVC.h"
#import "SKMineVC.h"
#import "SKPostVC.h"

@interface SKTabBarController ()<SKTabBarDelegate>

@end

@implementation SKTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {
    //获取全局的tabBarItem
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    //添加子控制器
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    SKTabBar *tabbar = [[SKTabBar alloc] init];
    tabbar.tabBarDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];

}

#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc {
    
    SKHomeVC *homeVC = [[SKHomeVC alloc] init];
    [self setUpOneChildVcWithVc:homeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    SKFishVC *fishVC = [[SKFishVC alloc] init];
    [self setUpOneChildVcWithVc:fishVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];
    
    SKMessageVC *messageVC = [[SKMessageVC alloc] init];
    [self setUpOneChildVcWithVc:messageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    SKMineVC *mineVC = [[SKMineVC alloc] init];
    [self setUpOneChildVcWithVc:mineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
    
}


#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 设置单个tabBarButton

 @param Vc 每一个按钮对应的控制器
 @param image 每一个按钮对应的普通状态下图片
 @param selectedImage 每一个按钮对应的选中状态下的图片
 @param title 每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    SKNavigationController *nav = [[SKNavigationController alloc] initWithRootViewController:Vc];
    
    Vc.view.backgroundColor = [self randomColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
        Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(SKTabBar *)tabBar {
    SKPostVC *postVC = [[SKPostVC alloc] init];
    postVC.view.backgroundColor = [self randomColor];
    
    SKNavigationController *navVc = [[SKNavigationController alloc] initWithRootViewController:postVC];
    
    [self presentViewController:navVc animated:YES completion:nil];
    

}

/* 随机色 */
- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}


@end
