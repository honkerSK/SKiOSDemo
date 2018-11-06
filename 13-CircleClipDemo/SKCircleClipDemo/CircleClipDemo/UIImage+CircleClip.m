//
//  UIImage+CircleClip.m
//  05-圆形裁剪-a
//
//  Created by sunke on 16/4/15.
//  Copyright © 2016年 sunke. All rights reserved.
//

#import "UIImage+CircleClip.h"

@implementation UIImage (CircleClip)

+ (UIImage *)imageWithCircleBorderW:(CGFloat)borderW color:(UIColor *)circleColor imageName:(NSString *)imageName {
    
    // 1.设置圆环宽度
    CGFloat borderWH = borderW;
    
    // 2.加载图片
    UIImage *image  = [UIImage imageNamed:imageName];
    
    // 3.计算大圆
//    CGFloat ctxWH = image.size.width + 2 * borderWH;
    CGFloat ctxWH = image.size.width;

    CGRect ctxRect = CGRectMake(0, 0, ctxWH, ctxWH);
    
    //4. 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(ctxRect.size , NO, 0);
    
    //5.画大圆
    UIBezierPath *bigCriclePath = [UIBezierPath bezierPathWithOvalInRect:ctxRect];
    
    // 设置圆环颜色
    [circleColor set];
    // 填充区域
    [bigCriclePath fill];
    
    //6.设置裁剪区域
    //6.1 绘制小圆路径
    CGRect clipRect = CGRectMake(borderWH, borderWH, image.size.width-2 * borderWH, image.size.height-2 * borderWH);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipRect];
    //6.2 把小圆路径设置成裁剪区域
    [clipPath addClip];
    
    //7.画图片
    [image drawAtPoint:CGPointZero];
    
    //8.从上下文中获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //9.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}




@end
