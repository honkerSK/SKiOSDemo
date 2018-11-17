//
//  UIImage+RenderImage.h
//  sunke的分类
//
//  Created by sunke on 2017/7/20.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderImage)

//提供一个不要渲染图片的方法
+ (UIImage *)imageNameWithOriginal:(NSString *)imageName;

//生成一个圆角图片
- (UIImage *)circleImage;


@end
