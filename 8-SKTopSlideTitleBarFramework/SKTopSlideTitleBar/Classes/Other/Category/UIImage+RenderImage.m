//
//  UIImage+RenderImage.m
//  sunke的分类
//
//  Created by sunke on 2017/7/20.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "UIImage+RenderImage.h"

@implementation UIImage (RenderImage)
//返回一个没有渲染的图片
+ (UIImage *)imageNameWithOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    //返回一个没有渲染的图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


//生成一个圆角图片
- (UIImage *)circleImage {
    
    //裁剪图片:获取图形上下文
    //1.开启图形上下文 scale:比例因素 点:像素比例 填0:自动识别比例因素
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述圆形裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置为裁剪区域
    [clipPath addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


@end
