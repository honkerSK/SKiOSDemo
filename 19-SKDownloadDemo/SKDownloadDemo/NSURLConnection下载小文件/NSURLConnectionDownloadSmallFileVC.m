//
//  NSURLConnectionDownloadSmallFileVC.m
//  SKDownloadDemo
//
//  Created by sunke on 24/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "NSURLConnectionDownloadSmallFileVC.h"

@interface NSURLConnectionDownloadSmallFileVC ()

/** 显示下载图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation NSURLConnectionDownloadSmallFileVC

/**
 * 点击按钮 -- 使用NSURLConnection下载图片文件，并显示再imageView上
 */
- (IBAction)downloadBtnClick:(id)sender {
    
    // 创建下载路径
    NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/126164-db45433316a063ec.jpg"];
    
    // NSURLConnection发送异步Get请求，该方法iOS9.0之后就废除了，推荐NSURLSession
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        self.imageView.image = [UIImage imageWithData:data];
        
        // 可以在这里把下载的文件保存
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"NSURLConnection下载小文件";

}





@end
