//
//  SKPresentedOneController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKPresentedOneController.h"
#import "SKPresentOneTransition.h"
#import "Masonry.h"

#import "SKInteractiveTransition.h"

@interface SKPresentedOneController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SKInteractiveTransition *interactiveDismiss;
@property (nonatomic, strong) SKInteractiveTransition *interactivePush;

@end

@implementation SKPresentedOneController

- (void)dealloc {
    NSLog(@"SKPresentedOneController -销毁了!!");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置转场代理
        self.transitioningDelegate = self;
        //设置转场类型
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置控制器的view
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = true;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.UITextView
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"小家碧玉介绍:xxxxooooo";
    textView.font = [UIFont systemFontOfSize:13];
    textView.editable = false; //是否可编辑
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    //3.按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(textView.mas_bottom).offset(20);
    }];
    
    ///添加手势管理者
    self.interactiveDismiss = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypeDismiss GestureDirection:SKInteractiveTransitionGestureDirectionDown];
    
    [self.interactiveDismiss addPanGestureForViewController:self];
    
}

- (void)dismiss {
    
//    [self dismissViewControllerAnimated:true completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
//转场控制器代理方法
//返回一个管理prenent动画过渡的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [SKPresentOneTransition transitionWithTransitionType:SKPresentOneTransitionTypePresent];
}

//返回一个管理dismiss动画过渡的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [SKPresentOneTransition transitionWithTransitionType:SKPresentOneTransitionTypeDismiss];
}

#pragma mark - UIViewControllerInteractiveTransitioning
///返回dissmiss的手势过渡管理
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    //在没有用手势触发的dismiss的时候需要传nil，否者无法点击dimiss，所以interation就是用来判断是否是手势触发转场的
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

///返回present的手势管理，这个手势管理者是在vc1中创建的，用代理传过来的
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    SKInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
    
    return interactivePresent.interation ? interactivePresent : nil;
    
}



@end
