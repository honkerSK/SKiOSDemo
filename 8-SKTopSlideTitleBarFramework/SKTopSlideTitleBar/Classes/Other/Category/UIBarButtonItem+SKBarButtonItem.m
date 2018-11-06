//
//  UIBarButtonItem+SKBarButtonItem.m
//  BuDeJie
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "UIBarButtonItem+SKBarButtonItem.h"

@implementation UIBarButtonItem (SKBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image lightImage:(UIImage *)highImage target:(nullable id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    //监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //注意:把btn包装成UIView, 解决导航条按钮范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:btnView];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(nullable id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    //监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //注意:把btn包装成UIView, 解决导航条按钮范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:btnView];
}

@end
