//
//  SKInteractiveTransition.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/9/20.
//  Copyright © 2016年 SK. All rights reserved.
// 手势管理者

#import <UIKit/UIKit.h>

typedef void (^GestureConfig)();

typedef NS_ENUM(NSUInteger, SKInteractiveTransitionGestureDirection) {//手势方向
    SKInteractiveTransitionGestureDirectionLeft = 0,
    SKInteractiveTransitionGestureDirectionRight,
    SKInteractiveTransitionGestureDirectionUp,
    SKInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, SKInteractiveTransitionType) { //手势控制哪种转场
    SKInteractiveTransitionTypePresent = 0, //弹出
    SKInteractiveTransitionTypeDismiss,
    SKInteractiveTransitionTypePush,
    SKInteractiveTransitionTypePop,
};



@interface SKInteractiveTransition : UIPercentDrivenInteractiveTransition
/// 记录是否开始手势,判断pop操作是手势触发还是返回键触发
@property (nonatomic, assign) BOOL interation;

///触发手势present的时候的config，config中初始化并present需要弹出的控制器
@property (nonatomic, copy) GestureConfig presentConfig;

///触发手势push的时候的config，config中初始化并push需要弹出的控制器
@property (nonatomic, copy) GestureConfig pushConfig;

///手势管理者初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(SKInteractiveTransitionType)type GestureDirection:(SKInteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(SKInteractiveTransitionType)type GestureDirection:(SKInteractiveTransitionGestureDirection)direction;

///给传入的控制器添加手势
- (void)addPanGestureForViewController:(UIViewController *)viewController;


@end
