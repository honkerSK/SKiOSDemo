//
//  SKNaviTransition.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/17.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, SKNaviOneTransitionType) {
    SKNaviOneTransitionTypePush = 0,
    SKNaviOneTransitionTypePop
};

@interface SKNaviTransition : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(SKNaviOneTransitionType)type;
- (instancetype)initWithTransitionType:(SKNaviOneTransitionType)type;

@end
