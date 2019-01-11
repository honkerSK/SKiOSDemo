//
//  SKInteractiveTransition.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/9/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKInteractiveTransition.h"

@interface SKInteractiveTransition()

@property (nonatomic, weak) UIViewController *vc;
///手势方向
@property (nonatomic, assign) SKInteractiveTransitionGestureDirection direction;
///手势类型
@property (nonatomic, assign) SKInteractiveTransitionType type;

@end

@implementation SKInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(SKInteractiveTransitionType)type GestureDirection:(SKInteractiveTransitionGestureDirection)direction {
    return  [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(SKInteractiveTransitionType)type GestureDirection:(SKInteractiveTransitionGestureDirection)direction {
    if (self = [super init]) {
        _direction = direction;
        _type = type;
    }
    return self;
}

//通过这个方法给控制器的View添加相应的手势
- (void)addPanGestureForViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    //将传入的控制器保存，因为要利用它触发转场操作
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
    
}

/**
 *  关键的手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)pan {
    
    //percent是根据pan的移动距离获取的
    CGFloat percent = 0.0;
    switch (_direction) {
            //注意:不能case语句里定义局部变量,必须加大括号
        case SKInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[pan translationInView:pan.view].x;
            percent = transitionX / pan.view.frame.size.width;
        }
            break;
            
        case SKInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [pan translationInView:pan.view].x;
            percent = transitionX / pan.view.frame.size.width;

        }
            break;
            
        case SKInteractiveTransitionGestureDirectionUp: {
            CGFloat transitionY = -[pan translationInView:pan.view].y;
            percent = transitionY / pan.view.frame.size.width;

        }
            break;
            
        case SKInteractiveTransitionGestureDirectionDown: {
            CGFloat transitionY = [pan translationInView:pan.view].y;
            percent = transitionY / pan.view.frame.size.width;

        }
            break;
            
        default:
            break;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件，它的作用在使用这个类的时候说明
            self.interation = YES;
            //手势开始是触发对应的转场操作
            [self startGesture];
            break;
            
        case UIGestureRecognizerStateChanged:
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比,然后系统会根据百分比自动布局控件，不用我们控制
            [self updateInteractiveTransition:percent];
            break;
            
        case UIGestureRecognizerStateEnded:
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
            }
            break;
            
        default:
            break;
    }
    
}

//触发对应转场操作的代码如下，根据type(type是自定义的枚举值)我们去判断是触发哪种操作，对于push和present由于要传入需要push和present的控制器，为了解耦，我用block把这个操作交个控制器去做了，让这个手势过渡管理者可以充分被复用
- (void)startGesture {
    switch (_type) {
        case SKInteractiveTransitionTypePresent:{
            if (_presentConfig) {
                _presentConfig();
            }
        }
            break;
            
        case SKInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case SKInteractiveTransitionTypePush:{
            if (_pushConfig) {
                _pushConfig();
            }
        }
            break;
            
        case SKInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

@end
