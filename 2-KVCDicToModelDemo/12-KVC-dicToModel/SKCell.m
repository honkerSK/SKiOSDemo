//
//  SKCell.m
//  12-KVC字典转模型
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKCell.h"

@interface SKCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *bookID;

@property (weak, nonatomic) IBOutlet UILabel *bookName;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation SKCell

- (void)setBookModel:(SKBookModel *)bookModel{
    _bookModel = bookModel;

    self.bookID.text = bookModel.bookId;
    self.bookName.text = bookModel.nameStr;
    
    //self.iconView.image = [UIImage imageNamed:bookModel.imgUrlStr]; //UIImage获取本地图片
    
    //UIImage 获取网络图片 , 但是这么做会直接阻塞UI线程了
    NSURL *imageUrl = [NSURL URLWithString:bookModel.imgUrlStr];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    self.iconView.image = image;
    
    //利用NSOperationQueue来异步加载图片
//    self.operationQueue = [[NSOperationQueue alloc] init];
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
//    [self.operationQueue addOperation:op];
    
}

//- (void)downloadImage {
//    NSURL *imageUrl = [NSURL URLWithString:self.bookModel.imgUrlStr];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//    self.iconView.image = image;
//}
//不过这这样的设计，虽然是异步加载，但是没有缓存图片。重新加载时又要重新从网络读取图片，重复请求，实在不科学，所以可以考虑第一次请求时保存图片。



@end
