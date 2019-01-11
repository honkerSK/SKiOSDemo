//
//  SKPresentOneTransition.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SKPresentOneTransitionType) {
    SKPresentOneTransitionTypePresent = 0, //管理present动画
    SKPresentOneTransitionTypeDismiss //管理dismiss动画
};


//过渡动画管理的类,同时管理present和dismiss2个动画
@interface SKPresentOneTransition : NSObject <UIViewControllerAnimatedTransitioning>

//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(SKPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(SKPresentOneTransitionType)type;

@end
