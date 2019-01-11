//
//  SKPageCoverPushController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/19.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKPageCoverPushController.h"
#import "Masonry.h"
#import "SKPageCoverTransition.h"

#import "SKInteractiveTransition.h"

@interface SKPageCoverPushController ()

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, strong) SKInteractiveTransition *interactiveTransitionPop;

@end

@implementation SKPageCoverPushController

- (void)dealloc {
    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic3"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我或向右滑动pop" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    
    //初始化手势管理者
    _interactiveTransitionPop = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypePop GestureDirection:SKInteractiveTransitionGestureDirectionRight];
    
    //给当前控制器的视图添加手势
    [_interactiveTransitionPop addPanGestureForViewController:self];
    
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - UINavigationControllerDelegate
///返回手势过渡管理对象
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _operation = operation;
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [SKPageCoverTransition transitionWithType:operation == UINavigationControllerOperationPush ? SKPageCoverTransitionTypePush : SKPageCoverTransitionTypePop];
    
}

///返回转场动画过渡管理对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (_operation == UINavigationControllerOperationPush) {
        SKInteractiveTransition *interactiveTransitionPush = [_delegate interactiveTransitionForPush];
        
        return interactiveTransitionPush.interation ? interactiveTransitionPush : nil;
    }else {
        return _interactiveTransitionPop.interation ? _interactiveTransitionPop : nil;
    }
}


@end
