//
//  SKMagicMovePushController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/17.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKMagicMovePushController.h"
#import "UIView+FrameChange.h"
#import "Masonry.h"
#import "SKNaviTransition.h"

#import "SKInteractiveTransition.h"

@interface SKMagicMovePushController ()<UINavigationControllerDelegate>

@property (nonatomic, strong)SKInteractiveTransition *interactiveTransition;

@end

@implementation SKMagicMovePushController

- (void)dealloc {
    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"展示神奇移动";
    //view懒加载
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2"]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 280, 280);
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"这是类似于KeyNote的神奇移动效果，向右滑动可以通过手势控制POP动画";
    textView.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero).priorityLow();
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
    
    
    ///添加手势管理者
    self.interactiveTransition = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypePop GestureDirection:SKInteractiveTransitionGestureDirectionLeft];
    
    //给当前控制器的视图添加手势
    [_interactiveTransition addPanGestureForViewController:self];
    
}

#pragma mark - UINavigationControllerDelegate
//导航栏控制器,导航栏不变,控制器的View中实现动画 需要执行以下方法 - 返回转场动画过渡管理对象
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    //UINavigationControllerOperationPush 1
    //SKNaviOneTransitionTypePush 0
    //SKNaviOneTransitionTypePop 1
    NSLog(@"operation = %ld",operation);
    //warning: Returning 'SKNaviTransition *' from a function with incompatible result type 'id<UIViewControllerAnimatedTransitioning> _Nullable'
    return [SKNaviTransition transitionWithType:operation == UINavigationControllerOperationPush ? SKNaviOneTransitionTypePush : SKNaviOneTransitionTypePop];
    
}


 //返回手势过渡管理对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}



@end
