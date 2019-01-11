//
//  SKCircleSpreadPresentedController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKCircleSpreadPresentedController.h"
#import "SKCircleSpreadTransition.h"
#import "SKInteractiveTransition.h"

@interface SKCircleSpreadPresentedController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) SKInteractiveTransition *interactiveTransition;

@end

@implementation SKCircleSpreadPresentedController

- (void)dealloc{
    NSLog(@"销毁了");
}

//1.重写init方法,设置动画代理,
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //自定义转场动画格式,保存开始的View
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic4"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [btn setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
//    NSLog(@"%@", self.view.subviews);

    ///添加手势管理者
    self.interactiveTransition = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypeDismiss GestureDirection:SKInteractiveTransitionGestureDirectionDown];
    
    [self.interactiveTransition addPanGestureForViewController:self];
    
}

- (void)dismiss{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
//设置present控制器
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [SKCircleSpreadTransition transitonWithTransitionType:SKCircleSpreadTransitionTypePresent];
}

//设置pop的控制器
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [SKCircleSpreadTransition transitonWithTransitionType:SKCircleSpreadTransitionTypeDismiss];
}

///返回一个管理pop动画过渡的对象
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}

@end
