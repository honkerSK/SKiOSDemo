//
//  ViewController.m
//  CircleClipDemo
//
//  Created by sunke on 16/4/15.
//  Copyright © 2016年 sunke. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CircleClip.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 如果要做裁剪,必须先设置裁剪区域
    
    //    _imageV.image = [self imageWithCircleBorderW:2 color:[UIColor blueColor] imageName:@"girl"];
    
    _imageV.image = [UIImage imageWithCircleBorderW:6 color:[UIColor yellowColor] imageName:@"girl"];
    
    //6.把图片转换成二进制数据
    //    NSData *data = UIImagePNGRepresentation(image);
    
    //compressionQuality :图片质量
    NSData *data = UIImageJPEGRepresentation(_imageV.image, 0.5);
    
    //7.写入到桌面
    [data writeToFile:@"/Users/sunke/Desktop/girlClip.png" atomically:YES];
    
    
}

/*
- (void)imageCutCircle{
    
    //只是裁剪图层, 不会裁剪图片
    _imageV.image = [UIImage imageNamed:@"girl"];
    // 圆角半径
    _imageV.layer.cornerRadius = _imageV.frame.size.width * 0.5;
    // 超出主图边框的都会被裁剪
    _imageV.layer.masksToBounds = YES;
    // 设置边框
    _imageV.layer.borderWidth = 6;
    _imageV.layer.borderColor = [UIColor grayColor].CGColor;
    
    //6.把图片转换成二进制数据
    //    NSData *data = UIImagePNGRepresentation(image);
    
    //compressionQuality :图片质量
    NSData *data = UIImageJPEGRepresentation(_imageV.image, 0.5);
    
    //7.写入到桌面
    [data writeToFile:@"/Users/sunke/Desktop/girlClip.png" atomically:YES];
}

 */
 
/*
 - (UIImage *)imageWithCircleBorderW:(CGFloat)borderW color:(UIColor *)circleColor imageName:(NSString *)imageName {
 
 // 1.设置圆环宽度
 CGFloat borderWH = borderW;
 
 // 2.加载图片
 UIImage *image  = [UIImage imageNamed:imageName];
 
 // 3.计算大圆
 CGFloat ctxWH = image.size.width + 2 * borderWH;
 
 CGRect ctxRect = CGRectMake(0, 0, ctxWH, ctxWH);
 
 //4. 开启位图上下文
 UIGraphicsBeginImageContextWithOptions(ctxRect.size , NO, 0);
 
 //5.画大圆
 UIBezierPath *bigCriclePath = [UIBezierPath bezierPathWithOvalInRect:ctxRect];
 
 // 设置圆环颜色
 [circleColor set];
 
 [bigCriclePath fill];
 
 //6.设置裁剪区域
 //6.1 绘制小圆路径
 CGRect clipRect = CGRectMake(borderWH, borderWH, image.size.width, image.size.height);
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
 
 */


// 圆形裁剪
/*
 - (void)circleImage {
 
 // 加载图片
 UIImage *image  = [UIImage imageNamed:@"girlClip"];
 //1.开启位图上下文
 UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
 
 //2.设置圆形裁剪区域
 //2.1 描绘圆形路径
 UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
 
 //2.2 把圆形路径设置成裁剪区域
 [path addClip];
 
 // 3.绘制图像
 [image drawAtPoint:CGPointZero];
 
 //4. 把上下文中内容生成一张图片
 image = UIGraphicsGetImageFromCurrentImageContext();
 
 //5.结束上下文
 UIGraphicsEndImageContext();
 
 _imageV.image = image;
 
 
 }
 
 */


@end
