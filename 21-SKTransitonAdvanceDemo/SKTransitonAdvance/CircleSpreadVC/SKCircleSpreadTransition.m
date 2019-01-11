//
//  SKCircleSpreadTransition.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKCircleSpreadTransition.h"
#import "SKCircleSpreadController.h"

@interface SKCircleSpreadTransition()



@end

@implementation SKCircleSpreadTransition

+ (instancetype)transitonWithTransitionType:(SKCircleSpreadTransitionType)type {
    return [[self alloc]initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(SKCircleSpreadTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case SKCircleSpreadTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case SKCircleSpreadTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark - 动画功能
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //拿到控制器获取button的frame来设置动画的开始结束的路径
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //一定要将toVC.view 添加到containerView 中
    [containerView addSubview:toVC.view];
    
    SKCircleSpreadController *tempVC = fromVC.viewControllers.lastObject;
    NSLog(@"fromVC子控件 = %@", fromVC.viewControllers);
    
    
    ///画两个圆路径
    //开始路径, 从按钮的rect开始
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithOvalInRect:tempVC.buttonFrame];
    //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
    CGFloat x = MAX(tempVC.buttonFrame.origin.x, containerView.frame.size.width - tempVC.buttonFrame.origin.x);
    CGFloat y = MAX(tempVC.buttonFrame.origin.y, containerView.frame.size.height - tempVC.buttonFrame.origin.y);
    
    //勾股定理计算半径
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    //以按钮中心为圆心，按钮中心到屏幕边缘的最大距离为半径，得到转场后的path
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //设置layer的path保证动画后layer不会回弹
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    //动画的节奏,设置淡入淡出
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

//Dismiss动画逻辑
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    SKCircleSpreadController *tempVC = toVC.viewControllers.lastObject;
    
    ///画两个圆圈
    //containerView 宽和高
    CGFloat containerViewW = containerView.frame.size.width;
    CGFloat containerViewH = containerView.frame.size.height;
    
    CGFloat radius = sqrtf(containerViewW * containerViewW + containerViewH * containerViewH) * 0.5;
    
    //开始路径
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:true];
    //结束路径,按钮的rect结束
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithOvalInRect:tempVC.buttonFrame];
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    ///创建路径动画 (抽取)
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //一定要设置动画代理
    maskLayerAnimation.delegate = self;

    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    
    maskLayerAnimation.delegate = self;
    
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
}


 //监听动画是否完成,设置动画完成
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    switch (_type) {
        case SKCircleSpreadTransitionTypePresent: {
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:true];
        }
            break;
          
        case SKCircleSpreadTransitionTypeDismiss: {
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            
        }
            break;
        
    }
    
}



@end
