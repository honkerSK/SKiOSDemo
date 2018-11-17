//
//  ViewController.m
//  SKCustomButton
//
//  Created by sunke on 2018/10/16.
//  Copyright © 2018 sunke. All rights reserved.
//

/*
 方案1: 使用UIButton属性contentEdgeInsets、titleEdgeInsets、imageEdgeInsets；（基本的视图属性，三个属性的设置效果可在XIB或storyboard中观察出来，常用属性）。
 方案2：使用 -(void)layoutSubviews;方法，在这个方法中获取子视图UIImageView, UILabel重新对子视图的位置调整。（常用的方法）
 
 方案3：使用视图位置调整方法（只需要调整按钮布局时,可以考虑）
 - (CGRect)contentRectForBounds:(CGRect)bounds;
 - (CGRect)titleRectForContentRect:(CGRect)contentRect;
 - (CGRect)imageRectForContentRect:(CGRect)contentRect;
 
 方案4：不使用系统按钮的子视图属性，自己在自定义的控件上添上UIImageView和UILabel视图（常用的方法）
 
 方案5：使用objective-c中runtime的方法或属性替换，针对上面的方法和属性进行替换。
 
 */

#import "ViewController.h"

//方案一:
#import "UIButton+SKEdgeInsets.h"

//方案二:
#import "SKLayoutBtn.h"

//方案三:
#import "SKRectBtn.h"

//方案四:
#import "SKBtnView.h"


//方案五:
#import "UIButton+SKRuntime.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //方案一
    [self edgeInsetsBtn];
    
    //方案二:
    [self layoutBtn];
    
    //方案三:
    [self rectBtn];
    
    //方案四:
    [self btnView];
    
    //方案五:runtime
    [self runtimeBtn];
    
}

//方案一
- (void)edgeInsetsBtn{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20,50,150,150)];
    [btn1 setTitle:@"首页" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn1 setImage:[UIImage imageNamed:@"home_normal"] forState:UIControlStateNormal];
    [btn1 setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:10];
    btn1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn1];
}


//方案二:
- (void)layoutBtn{
    SKLayoutBtn *btn2 = [SKLayoutBtn buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 100, 80, 100);
    
    [btn2 setImage:[UIImage imageNamed:@"home_normal"] forState:UIControlStateNormal];
    [btn2 setTitle:@"首页2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    btn2.titleLabel.backgroundColor = [UIColor yellowColor];
    btn2.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:btn2];
}

//方案三:
- (void)rectBtn{
    SKRectBtn *btn3 = [SKRectBtn buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(20, 250, 100, 100);
    
    //图片在上, 文字在下
    btn3.imageRect = CGRectMake(10, 0, 80, 80);
    btn3.titleRect = CGRectMake(0, 80, 100, 20);
    
    //文本在图片中, 居中
//    btn3.imageRect = btn3.bounds;
//    btn3.titleRect = CGRectMake(0, 40, 100, 20);
    
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn3.titleLabel.backgroundColor = [UIColor orangeColor];
    btn3.backgroundColor = [UIColor greenColor];
    
    [btn3 setImage:[UIImage imageNamed:@"home_normal"] forState:UIControlStateNormal];
    [btn3 setTitle:@"首页3" forState:UIControlStateNormal];
    
    [self.view addSubview:btn3];
    
}

//方案四:
- (void)btnView{
    SKBtnView *btnView = [[SKBtnView alloc] init];
    
    btnView.backgroundColor = [UIColor purpleColor];
    btnView.frame = CGRectMake(20, 400, 100, 120);
    btnView.iconView.image = [UIImage imageNamed:@"home_normal"];
    btnView.nameLabel.text = @"首页4";
    
    [self.view addSubview:btnView];
}

//方案五:
- (void)runtimeBtn{
    UIButton * runtimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    runtimeBtn.frame = CGRectMake(200, 440, 100, 100);

    [runtimeBtn setImage:[UIImage imageNamed:@"home_normal"] forState:UIControlStateNormal];
    [runtimeBtn setTitle:@"首页5" forState:UIControlStateNormal];
    runtimeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [runtimeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    runtimeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //图片在上, 文本在下
    runtimeBtn.imageRect = CGRectMake(10, 0, 80, 80);
    runtimeBtn.titleRect = CGRectMake(0, 80, 100, 20);
    
    //文本在图片中, 居中
//    runtimeBtn.imageRect = runtimeBtn.bounds;
//    runtimeBtn.titleRect = CGRectMake(0, 40, 100, 20);
    
    [self.view addSubview:runtimeBtn];
    
    runtimeBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
    
}

@end
