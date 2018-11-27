//
//  NSDataDownloadSmallFileVC.m
//  SKDownloadDemo
//
//  Created by sunke on 24/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "NSDataDownloadSmallFileVC.h"

@interface NSDataDownloadSmallFileVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation NSDataDownloadSmallFileVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"NSData下载小文件";

}

/**
 * 点击按钮 -- 使用NSData下载图片文件，并显示在imageView上
 */
- (IBAction)downloadBtnClick:(id)sender {
    // 在子线程中发送下载文件请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 创建下载路径
        NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/126164-db45433316a063ec.jpg"];
        
        // NSData的dataWithContentsOfURL:方法下载
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 回到主线程，刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = [UIImage imageWithData:data];
        });
    });
    
}



@end
