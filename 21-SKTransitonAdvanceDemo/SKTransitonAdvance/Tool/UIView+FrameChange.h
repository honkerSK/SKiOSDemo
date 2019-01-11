//
//  UIView+FrameChange.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//  提供快速更改frame的几个属性的方法

#import <UIKit/UIKit.h>

@interface UIView (FrameChange)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat bottomFromSuperView;

@end
