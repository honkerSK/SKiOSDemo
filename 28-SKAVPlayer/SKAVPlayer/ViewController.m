//
//  ViewController.m
//  SKAVPlayer
//
//  Created by sunke on 2020/9/17.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayView.h"
#import "FullViewController.h"

@interface ViewController ()
@property (weak, nonatomic) VideoPlayView *playView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加播放器
    [self setupVideoPlayView];
    
    // 2.设置资源,播放远程视频
//    [self.playView setUrlString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    
    //播放本地视频
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story.mp4" ofType:nil];
    [self.playView setFilePathString:path];

}

#pragma mark - 添加播放器
- (void)setupVideoPlayView
{
    VideoPlayView *playView = [VideoPlayView videoPlayView];
    playView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view addSubview:playView];
    self.playView = playView;
    playView.contrainerViewController = self;
}


// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 默认的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
