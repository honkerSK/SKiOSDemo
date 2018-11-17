//
//  SKBtnView.m
//  SKCustomButton
//
//  Created by sunke on 2018/10/16.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "SKBtnView.h"

@implementation SKBtnView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //添加图片
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:imageView];
        self.iconView = imageView;
        
        //添加文字
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.backgroundColor = [UIColor orangeColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor grayColor];
    [self addSubview:imageView];
    self.iconView = imageView;
    
    //添加文字
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor orangeColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    self.iconView.frame = CGRectMake(0, 0, btnW, btnW);
    self.nameLabel.frame = CGRectMake(0, btnW, btnW, btnH - btnW);
}


@end
