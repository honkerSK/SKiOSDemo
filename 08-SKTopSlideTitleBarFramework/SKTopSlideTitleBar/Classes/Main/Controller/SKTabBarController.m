//
//  SKTabBarController.m
//  BuDeJie
//
//  Created by sunke on 2017/7/19.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKTabBarController.h"

//category
#import "UIImage+RenderImage.h"

//controller
#import "SKNavigationController.h"
#import "SKEssenceViewController.h"
#import "SKNewViewController.h"
#import "SKPublishViewController.h"
#import "SKFriendTrendViewController.h"
#import "SKMeTableViewController.h"
//View
#import "SKTabBar.h"

@interface SKTabBarController ()

@end

@implementation SKTabBarController

+ (void)load {
    //获取全局的tabBarItem
    UITabBarItem *item = [UITabBarItem appearance];
    
    //设置所有item选中时颜色
    //创建字典去描述文件
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    //文本颜色->描述富文本属性的key ->NSAttributedString.h
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    //设置字体
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    //注意:tabBarButton按钮字体大小和 nornal有关, 每个tabBarButton 有个tabBarItem模型
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    //设置字体
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所有子控制器
    [self setupAllChildViewController];
    
    //设置tabBar上对应按钮内容 -> 由对应的子控制器的tabBarItem决定
    [self setupAllTitleButton];
    
    //自定义tabBar
    [self setupTabBar];
        
}

#pragma mark ================== 自定义tabBar ======================
- (void)setupTabBar {
    //替换系统tabBar , KVC:设置readonly属性
    SKTabBar *tabBar = [[SKTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];

}

#pragma mark ================== 添加所有子控制器 ======================
- (void)setupAllChildViewController {
    //精华
    SKEssenceViewController *essenceVc = [[SKEssenceViewController alloc] init];
    SKNavigationController *nav = [[SKNavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    essenceVc.view.backgroundColor = [UIColor redColor];
    
    //新帖
    SKNewViewController *newVc = [[SKNewViewController alloc] init];
    SKNavigationController *nav2 = [[SKNavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav2];
    newVc.view.backgroundColor = [UIColor blueColor];

    //发布
    SKPublishViewController *publishVc = [[SKPublishViewController alloc] init];
    [self addChildViewController:publishVc];
    publishVc.view.backgroundColor = [UIColor orangeColor];
    
    //关注
    SKFriendTrendViewController *concernVc = [[SKFriendTrendViewController alloc] init];
    SKNavigationController *nav4 = [[SKNavigationController alloc] initWithRootViewController:concernVc];
    [self addChildViewController:nav4];
    concernVc.view.backgroundColor = [UIColor yellowColor];

    
    //我
    SKMeTableViewController *myVc = [[SKMeTableViewController alloc] init];
    SKNavigationController *nav5 = [[SKNavigationController alloc] initWithRootViewController:myVc];
    [self addChildViewController:nav5];
    myVc.view.backgroundColor = [UIColor purpleColor];

}

#pragma mark ================== 设置tabBar上所有对应按钮内容 ======================
- (void)setupAllTitleButton {
    //0 精华
    SKNavigationController *nav = self.childViewControllers[0];
    //标题
    nav.tabBarItem.title = @"精华";
    //图片
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //选中图片
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    //返回一个没有渲染的图片
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_essence_click_icon"];
    
    //1 新帖
    SKNavigationController *nav2 = self.childViewControllers[1];
    //标题
    nav2.tabBarItem.title = @"新帖";
    //图片
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    //选中图片
//    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_new_click_icon"];

    
    //2 发布


    //3 关注
    SKNavigationController *nav4 = self.childViewControllers[2];
    //标题
    nav4.tabBarItem.title = @"关注";
    //图片
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    //选中图片
//    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_friendTrends_click_icon"];

    
    //4 我
    SKNavigationController *nav5 = self.childViewControllers[3];
    //标题
    nav5.tabBarItem.title = @"我";
    //图片
    nav5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //选中图片
    nav5.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_me_click_icon"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
