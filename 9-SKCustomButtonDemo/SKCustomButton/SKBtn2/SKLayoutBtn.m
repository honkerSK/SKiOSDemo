//
//  SKLayoutBtn.m
//  SKCustomButton
//
//  Created by sunke on 2018/10/16.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "SKLayoutBtn.h"

@implementation SKLayoutBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.imageView.backgroundColor = [UIColor redColor];
//        self.titleLabel.backgroundColor = [UIColor blueColor];
        //文字居中
        //self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = imageW;
    self.imageView.frame = CGRectMake(0, 0, imageW , imageH);
    
    CGFloat titleY = imageH;
    CGFloat titleW = imageW;
    CGFloat titleH = self.frame.size.height - imageH;
    self.titleLabel.frame = CGRectMake(0, titleY, titleW, titleH);
}


@end
