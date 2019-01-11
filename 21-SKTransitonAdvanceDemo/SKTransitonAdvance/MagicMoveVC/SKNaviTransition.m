//
//  SKNaviTransition.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/17.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKNaviTransition.h"
#import "SKMagicMoveController.h"
#import "SKMagicMovePushController.h"
#import "SKMagicMoveCell.h"

@interface SKNaviTransition()
/// 保存动画过渡状态
@property (nonatomic, assign) SKNaviOneTransitionType type;

@end

@implementation SKNaviTransition

+ (instancetype)transitionWithType:(SKNaviOneTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(SKNaviOneTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


#pragma mark -UIViewControllerAnimatedTransitioning
///动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

///执行转场动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case SKNaviOneTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case SKNaviOneTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

///执行push过渡动画
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    SKMagicMoveController *fromVC = (SKMagicMoveController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SKMagicMovePushController *toVC = (SKMagicMovePushController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取当前点击的cell的imageView
    SKMagicMoveCell *cell = (SKMagicMoveCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    
    UIView *containView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.imagView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imagView convertRect:cell.imagView.bounds toView:containView];
    //设置动画前的各个控件的状态
    cell.imagView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0.0 animations:^{
        //动画后imageView的frame
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containView];
        toVC.view.alpha = 1;

    } completion:^(BOOL finished) {
        //完成动画,隐藏图片,tempView先隐藏不销毁，pop的时候还会用
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];

    }];
}

///执行pop过渡动画
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //源控制器
    SKMagicMovePushController *fromVC = (SKMagicMovePushController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //弹出控制器
    SKMagicMoveController *toVC = (SKMagicMoveController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    SKMagicMoveCell *cell = (SKMagicMoveCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    
    //设置初始状态,动画时隐藏控件
    cell.imagView.hidden = YES;
    fromVC.imageView.hidden = YES;
    //显示截图
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:UIViewAnimationOptionLayoutSubviews animations:^{
        tempView.frame = [cell.imagView convertRect:cell.imagView.bounds toView:containerView];
        fromVC.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else {
            //手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.imagView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
    
}



@end
