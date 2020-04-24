//
//  CarouseViewPlus.h
//  SKCarouseView
//
//  Created by sunke on 16/9/13.
//  Copyright © 2016年 KentSun. All rights reserved.
//

// 无限循环的轮播图封装类（优化版） 

#import <UIKit/UIKit.h>

// 定义block用于外部点击回调
typedef void (^TapCarouseViewBlock)(NSInteger pageIndex);

@interface CarouseViewPlus : UIView

// 填充分页并设置回调
- (void)setupSubviewPages:(NSArray *)pageViews withCallbackBlock:(TapCarouseViewBlock)block;

@end
