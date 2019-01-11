//
//  SKPageCoverController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/19.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKPageCoverController.h"
#import "Masonry.h"
#import "SKPageCoverPushController.h"

#import "SKInteractiveTransition.h"

@interface SKPageCoverController ()<SKPageCoverPushControllerDelegate>

@property (nonatomic, strong) SKInteractiveTransition *interactiveTransitionPush;

@end

@implementation SKPageCoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic4"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我或向左滑动push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;

    ///添加手势管理者, push, left
    _interactiveTransitionPush = [SKInteractiveTransition interactiveTransitionWithTransitionType:SKInteractiveTransitionTypePush GestureDirection:SKInteractiveTransitionGestureDirectionLeft];
    typeof(self)weakSelf = self;
    _interactiveTransitionPush.pushConfig = ^() {
        [weakSelf push];
    };
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
    [_interactiveTransitionPush addPanGestureForViewController:self];
    
    
}

- (void)push {
    SKPageCoverPushController *pushVC = [[SKPageCoverPushController alloc] init];

    self.navigationController.delegate = pushVC;
    //设置SKPageCoverPushController的转场代理
    pushVC.delegate = self;
    
    [self.navigationController pushViewController:pushVC animated:true];
    
}

- (void)backToRoot {
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:true];
    
}

#pragma mark - UIViewControllerInteractiveTransitioning
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush {
    return _interactiveTransitionPush;
}



@end
