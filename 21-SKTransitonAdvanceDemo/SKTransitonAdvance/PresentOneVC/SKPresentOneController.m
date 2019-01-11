//
//  SKPresentOneController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//

//开始展现的控制器
#import "SKPresentOneController.h"
#import "Masonry.h"
#import "SKPresentedOneController.h"

#import "SKInteractiveTransition.h"

@interface SKPresentOneController ()<SKPresentedOneControllerDelegate>

//push手势管理者
@property (nonatomic, strong) SKInteractiveTransition *interactivePush;

@end

@implementation SKPresentOneController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
    //1.添加imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    //代码布局
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(250.0, 250.0));
    }];
    
    //2.添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击或者向上滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    //代码布局
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
    }];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    ///添加手势管理者,Present类型
    _interactivePush = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypePresent GestureDirection:SKInteractiveTransitionGestureDirectionUp];
    typeof(self)weakSelf = self;
    _interactivePush.presentConfig = ^(){
        [weakSelf present];
    };
    
    [_interactivePush addPanGestureForViewController:self.navigationController];
}

/// 手势管理者调用的方法
- (void)present {
    SKPresentedOneController *presentedVC = [[SKPresentedOneController alloc] init]
    ;
    //设置代理
    presentedVC.delegate = self;
    
    [self presentViewController:presentedVC animated:true completion:nil];
    
}

#pragma mark -SKPresentedOneControllerDelegate 实现代理方法
- (void)presentedOneControllerPressedDissmiss {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent {
    return _interactivePush;
}




@end
