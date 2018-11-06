//
//  UIImage+SKImage.h
//  SKBulgeTabBar-iOS
//
//  Created by sunke on 2017/5/9.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKImage)


/**
 根据颜色生成一张图片

 @param color 提供的颜色
 @return 返回一张有颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


@end
