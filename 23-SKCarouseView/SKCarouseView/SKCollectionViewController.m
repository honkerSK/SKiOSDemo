//
//  SKCollectionViewController.m
//  SKCarouseView
//
//  Created by sunke on 2020/4/24.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import "SKCollectionViewController.h"
#import "CarouselScrollView.h"

@interface SKCollectionViewController ()<CarouselScrollViewDelegate>
@property (nonatomic,strong) CarouselScrollView *horScrollView;
@property (nonatomic,strong) CarouselScrollView *verScrollView;

@end

@implementation SKCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setScrollView];
    [self setVerScrollView];
    
}

- (void)setScrollView{
    NSArray *urlArray = @[@"https://upload-images.jianshu.io/upload_images/126164-b603b6ecb743903e.jpg",@"https://upload-images.jianshu.io/upload_images/126164-5469a26c0007191c.jpg",@"https://upload-images.jianshu.io/upload_images/126164-b8d49eda4b8acbaa.jpg"];
    _horScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 200)];
    _horScrollView.imageArray = urlArray;
    _horScrollView.delegate = self;
    [self.view addSubview:_horScrollView];
}

- (void)setVerScrollView{
    NSArray *imageArray = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"2"]];
    _verScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 400, CGRectGetWidth(self.view.bounds), 200)];
    _verScrollView.imageArray = imageArray;
    _verScrollView.delegate = self;
    _verScrollView.direction = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:_verScrollView];
}

#pragma mark - CarouselScrollViewDelegate
- (void)didSelectedIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
}



@end
