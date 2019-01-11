//
//  SKCircleSpreadController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKCircleSpreadController.h"
#import "Masonry.h"
#import "SKCircleSpreadPresentedController.h"

@interface SKCircleSpreadController ()

@property (nonatomic, weak) UIButton *btn;

@end

@implementation SKCircleSpreadController

- (void)dealloc {
    NSLog(@"SKCircleSpreadController 销毁");
}

//重写get方法
- (CGRect)buttonFrame {
    return _btn.frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic3"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    [btn setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //内容水平对齐方式,居中
    btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor grayColor];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(0, 0)).priorityLow();
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.greaterThanOrEqualTo(self.view);
        make.top.greaterThanOrEqualTo(self.view).offset(64);
        make.bottom.right.lessThanOrEqualTo(self.view);
    }];
    
    //添加点击手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [btn addGestureRecognizer:pan];
    
}

- (void)present {
    SKCircleSpreadPresentedController *presentedVC = [[SKCircleSpreadPresentedController alloc] init];
    [self presentViewController:presentedVC animated:true completion:nil];
}

- (void)pan:(UIPanGestureRecognizer *)panGesture {
    
    UIView *button = panGesture.view;
    
    //手势触摸点
    CGPoint startPoint = [panGesture translationInView:panGesture.view];
    //屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    //移动后中心点(按钮设置居中,拖动时计算绝对距离,需要减去屏幕宽高的一半)
//    CGPoint newCenter = CGPointMake(startPoint.x + button.center.x, startPoint.y + button.center.y);
    CGPoint newCenter = CGPointMake(startPoint.x + button.center.x - screenW * 0.5, startPoint.y + button.center.y - screenH * 0.5);
    
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];

    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
}


@end
