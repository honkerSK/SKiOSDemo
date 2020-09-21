//
//  SKThumbnailCell.m
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import "SKThumbnailCell.h"

@implementation SKThumbnailCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    CGFloat cellWidth = floor(([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3.0);
    CGFloat cellHeight = cellWidth * 1.5;
    
    _imgViewThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    _imgViewThumb.userInteractionEnabled = YES;
    
    [self addSubview:_imgViewThumb];
    
    _pageNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    _pageNum.center = CGPointMake(cellWidth / 2, cellHeight - 20);
    _pageNum.textColor = [UIColor whiteColor];
    _pageNum.textAlignment = NSTextAlignmentCenter;
    _pageNum.layer.cornerRadius = 2;
    _pageNum.layer.masksToBounds = YES;
    _pageNum.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_pageNum];
}

@end
