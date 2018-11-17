//
//  UIBarButtonItem+SKBarButtonItem.h
//  BuDeJie
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SKBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image lightImage:(UIImage *)highImage target:(nullable id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(nullable id)target action:(SEL)action;

@end
