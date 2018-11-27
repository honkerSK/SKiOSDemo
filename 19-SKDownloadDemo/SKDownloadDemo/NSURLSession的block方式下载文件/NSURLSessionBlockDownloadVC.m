//
//  NSURLSessionBlockDownloadVC.m
//  SKDownloadDemo
//
//  Created by sunke on 25/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "NSURLSessionBlockDownloadVC.h"

@interface NSURLSessionBlockDownloadVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation NSURLSessionBlockDownloadVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"NSURLSession的block方式下载文件";
}

/**
 * 点击按钮 -- 使用NSURLSession的block方法下载文件
 */
- (IBAction)downloadBtnClicked:(UIButton *)sender {
    // 创建下载路径
    NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/126164-db45433316a063ec.jpg"];
    
    // 创建NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建下载任务,其中location为下载的临时文件路径
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSLog(@"location = %@", location);
        
        // 文件将要移动到的指定目录
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        // 新文件路径
        NSString *newFilePath = [documentsPath stringByAppendingPathComponent:@"126164-db45433316a063ec.jpg"];
        
        NSLog(@"File downloaded to: %@",newFilePath);
        // 移动文件到新路径
        [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:newFilePath error:nil];
        // 回到主线程，刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithContentsOfFile:newFilePath];
        });
        
    }];
    
    // 开始下载任务
    [downloadTask resume];
}




@end
