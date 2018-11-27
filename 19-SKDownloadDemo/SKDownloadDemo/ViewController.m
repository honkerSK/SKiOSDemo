//
//  ViewController.m
//  SKDownloadDemo
//
//  Created by sunke on 24/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "ViewController.h"
#import "NSDataDownloadSmallFileVC.h"

#import "NSURLConnectionDownloadSmallFileVC.h"
#import "NSURLConnectionDownloadBigFileVC.h"
#import "NSURLConnectionBreakpointDownloadVC.h"

#import "NSURLSessionBlockDownloadVC.h"
#import "NSURLSessionDelegateDownloadVC.h"
#import "NSURLSessionBreakpointDownloadVC.h"
#import "NSURLSessionOfflineBreakpointDownloadVC.h"

#import "AFNetworkingDownloadFileVC.h"
#import "AFNetworkingOfflineFileDownloadFileVC.h"


#define SKColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define SKRandomColor SKColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

// https://upload-images.jianshu.io/upload_images/126164-db45433316a063ec.jpg

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTranslucent:NO];

}

/**
 * NSData下载小文件Demo页按钮
 */
- (IBAction)NSDataDownloadFileBtnClick:(id)sender {
    NSDataDownloadSmallFileVC *VC = [[NSDataDownloadSmallFileVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}


/**
 * NSURLConnection下载小文件Demo页按钮
 */
- (IBAction)NSURLConnectionDownloadSmallFileBtnClick:(id)sender {
    NSURLConnectionDownloadSmallFileVC *VC = [[NSURLConnectionDownloadSmallFileVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * NSURLConnection下载大文件Demo页按钮
 */
- (IBAction)NSURLConnectionDownloadBigFileBtnClick:(id)sender {
    NSURLConnectionDownloadBigFileVC *VC = [[NSURLConnectionDownloadBigFileVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * NSURLConnection断点下载（支持离线）Demo页按钮
 */
- (IBAction)NSURLConnectionBreakpointDownloadBtnClick:(id)sender {
    NSURLConnectionBreakpointDownloadVC *VC = [[NSURLConnectionBreakpointDownloadVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}


/**
 * NSURLSession的block方式下载文件Demo页按钮
 */
- (IBAction)NSURLSessionBlockDownloadBtnClick:(id)sender {
    NSURLSessionBlockDownloadVC *VC = [[NSURLSessionBlockDownloadVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
    
}

/**
 * NSURLSession的delegate方法下载文件Demo页按钮
 */
- (IBAction)NSURLSessionDelegateDownloadBtnClick:(id)sender {
    NSURLSessionDelegateDownloadVC *VC = [[NSURLSessionDelegateDownloadVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * NSURLSession断点下载（不支持离线）Demo页按钮
 */
- (IBAction)NSURLSessionBreakpointDownloadBtnClick:(id)sender {
    NSURLSessionBreakpointDownloadVC *VC = [[NSURLSessionBreakpointDownloadVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
    
}

/**
 * NSURLSession断点下载（支持离线）Demo页按钮
 */
- (IBAction)NSURLSessionOfflineBreakpointDownloadBtnClick:(id)sender {
    
    NSURLSessionOfflineBreakpointDownloadVC *VC = [[NSURLSessionOfflineBreakpointDownloadVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * AFNetworking下载文件Demo页按钮
 */
- (IBAction)AFNetworkingDownloadFileBtnClick:(id)sender {
    
    AFNetworkingDownloadFileVC *VC = [[AFNetworkingDownloadFileVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * AFNetworking断点下载（支持离线）Demo页按钮
 */
- (IBAction)AFNetworkingOfflineDownloadFileBtnClick:(id)sender {
    AFNetworkingOfflineFileDownloadFileVC *VC = [[AFNetworkingOfflineFileDownloadFileVC alloc] init];
    VC.view.backgroundColor = SKRandomColor;
    [self.navigationController pushViewController:VC animated:YES];
}





@end
