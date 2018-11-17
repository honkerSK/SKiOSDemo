//
//  UIView+SKExtension.h
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SKExtension)

@property (nonatomic , assign) CGFloat sk_width;
@property (nonatomic , assign) CGFloat sk_height;
@property (nonatomic , assign) CGSize  sk_size;
@property (nonatomic , assign) CGFloat sk_x;
@property (nonatomic , assign) CGFloat sk_y;
@property (nonatomic , assign) CGPoint sk_origin;
@property (nonatomic , assign) CGFloat sk_centerX;
@property (nonatomic , assign) CGFloat sk_centerY;
@property (nonatomic , assign) CGFloat sk_right;
@property (nonatomic , assign) CGFloat sk_bottom;

/* 判断视图是否有重叠 */
- (BOOL)intersectWithView:(UIView *)view;
/* 加载xib */
+ (instancetype)sk_viewFromXib;

- (BOOL)isShowingOnKeyWindow;

@end
