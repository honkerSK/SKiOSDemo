//
//  SKPageCoverTransition.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/19.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKPageCoverTransition.h"
#import "UIView+FrameChange.h"
#import "UIView+anchorPoint.h"


@interface SKPageCoverTransition()

@property (nonatomic, assign, getter=isPopInitialized) BOOL popInitialized;

@end

@implementation SKPageCoverTransition

+ (instancetype)transitionWithType:(SKPageCoverTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(SKPageCoverTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case SKPageCoverTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
        case SKPageCoverTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
        
    }
}

///执行push动画
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    //将要动画的视图加入containerView
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    //containerView 中有3个控件,fromView,toView,tempView
    NSLog(@"%@", containerView.subviews);
    
    NSLog(@"fromView = %@", fromVC.view);
    NSLog(@"toView = %@", toVC.view);
    NSLog(@"tempView = %@", tempView);
    
    //动画前设置
    fromVC.view.hidden = true;
    [containerView insertSubview:toVC.view atIndex:0];
    NSLog(@"之后%@=", containerView.subviews);
    //insertSubview: 方法将toVC.view插入到的0位置,将原来0位置的控件放到原来toVC.view的位置
    //将要插入的控件,和0位置控件位置互换
    
    //设置锚点,设置AnchorPoint，并增加3D透视效果
    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transform3d;
    
    /**
     *  增加阴影功能,转场时候对对应图层设置
     */
    //CAGradientLayer 渐变层
    //源渐变层
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = fromVC.view.bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor blackColor].CGColor];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
    fromGradient.endPoint = CGPointMake(0.8, 0.5);
    
    //源阴影视图
    UIView *fromShadow = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    fromShadow.backgroundColor = [UIColor clearColor];
    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
    fromShadow.alpha = 0.0;
    //将阴影视图添加到截图上
    [tempView addSubview:fromShadow];
    
    //弹出渐变层
    CAGradientLayer *toGradient = [CAGradientLayer layer];
    toGradient.frame = fromVC.view.bounds;
    toGradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor blackColor].CGColor];
    toGradient.startPoint = CGPointMake(0.0, 0.5);
    toGradient.endPoint = CGPointMake(0.8, 0.5);
    
    //弹出阴影视图
    UIView *toShadow = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    toShadow.backgroundColor = [UIColor clearColor];
    [toShadow.layer insertSublayer:toGradient atIndex:1];
    toShadow.alpha = 1.0;
    //注意:将弹出阴影视图添加到弹出控制器视图上
    [toVC.view addSubview:toShadow];
    
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //翻转截图视图
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        //给阴影效果动画
        fromShadow.alpha = 1.0;
        toShadow.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //失败后记得移除截图，下次push又会创建
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
    
}

///执行pop动画
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //containerView 两个控件 ,toVC.view ,tempView
    NSLog(@"pop %@=", containerView.subviews);

    //拿到push的时候的截图视图
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //把截图视图翻转回来
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.subviews.lastObject.alpha = 1.0;
        tempView.subviews.lastObject.alpha = 0.0;
        
        NSLog(@"fromView中控件 = %@", fromVC.view.subviews);
        NSLog(@"tempView中控件 = %@", tempView.subviews);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        } else {
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        }
        
    }];
}

@end
