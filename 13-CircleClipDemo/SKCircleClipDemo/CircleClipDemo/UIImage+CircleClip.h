//
//  UIImage+CircleClip.h
//  05-圆形裁剪-a
//
//  Created by sunke on 16/4/15.
//  Copyright © 2016年 sunke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleClip)


/**
 *  返回一个带圆环的圆形图片
 *
 *  @param borderW     圆环宽度
 *  @param circleColor 圆环颜色
 *  @param imageName   图片名称
 *
 *  
 */
+ (UIImage *)imageWithCircleBorderW:(CGFloat)borderW color:(UIColor *)circleColor imageName:(NSString *)imageName;

@end
