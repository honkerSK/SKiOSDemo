//
//  SKNavigationController.m
//  BuDeJie
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKNavigationController.h"

@interface SKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SKNavigationController

+ (void)load{
    
    //获取全局导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]]; //ios9.0 以上
    
    //设置导航条标题字体->拿到导航条设置
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    navBar.titleTextAttributes = attr;
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

/*
 滑动手势
 <UIScreenEdgePanGestureRecognizer: 0x7fe714c1b000; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe714d179a0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe714c1aec0>)>>
 
 target=<_UINavigationInteractiveTransition 0x7fe714c1aec0>)>>
 action=handleNavigationTransition:
 
 UIScreenEdgePanGestureRecognizer 触发手势 , 就会有滑动功能,就会触发target的action方法
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //全屏手势:滑动功能
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    //验证代理
    // <_UINavigationInteractiveTransition: 0x7f847940aa80> 滑动手势代理
//    SKLog(@"%@", self.interactivePopGestureRecognizer.delegate);
    
    //清理原来手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //不应该在根控制器下,滑动返回
    //清空手势代理,回复滑动返回功能
//    self.interactivePopGestureRecognizer.delegate = self;
    
    //将当前导航控制器作为 手势的代理,控制手势什么时候触发
    //注意:这步不能少.清空手势代理, 回复滑动返回功能
    pan.delegate = self;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    //导航控制器默认有个滑动返回功能, 从屏幕左边边缘开始往右滑动
    //注意:把系统返回按钮覆盖,就没有滑动返回功能
    //滑动返回功能为什么失效?用了滑动手势去做, 验证滑动手势在不在
//    SKLog(@"%@", self.interactivePopGestureRecognizer);
    //代理可以控制手势是否有效. 验证: 代理做了一些事情,导致滑动手势失效
    
    //只有非根控制器才需要设置返回按钮
    if (self.childViewControllers.count > 0) {
        //只要是非根控制器, 就要隐藏tabBar条
        viewController.hidesBottomBarWhenPushed = YES;

        //设置返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [backButton setTitle:@"返回" forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //SKLog(@"%@", self.interactivePopGestureRecognizer);

    }
    
    //这个方法才是真正的跳转
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark ============= UIGestureRecognizerDelegate ===================
//是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //在根控制器下,不要触发手势
    return self.childViewControllers.count > 1;
}




@end
