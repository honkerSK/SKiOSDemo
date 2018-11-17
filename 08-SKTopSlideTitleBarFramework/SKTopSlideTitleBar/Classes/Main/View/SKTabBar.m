//
//  SKTabBar.m
//  BuDeJie
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKTabBar.h"
#import "SKPublishViewController.h"


@interface SKTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation SKTabBar

//默认局部变量是强指针
- (UIButton *)plusButton {
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //根据内容(标题 图片) 去计算尺寸
        [btn sizeToFit];
        _plusButton = btn;
        [btn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    return _plusButton;
}

- (void)publishClick{
    SKLog(@"点击中间加号按钮");
    //SKPublishViewController *publishVC = [[SKPublishViewController alloc] init];
    //publishVC.view.backgroundColor = SKRandomColor;
    //[self.window.rootViewController presentViewController:publishVC animated:YES completion:nil];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置加号按钮居中
    self.plusButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    //获取按钮个数
    NSInteger count = self.items.count;
    NSLog(@"%ld" , (long)count);
    //调整内部子控件位置
    //NSLog(@"%@", self.subviews);
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;

    int i = 0;
    //遍历子控件
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            btnX = i * btnW;
            //UITabBarButton
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    
    
}

@end
