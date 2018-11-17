//
//  SKTitleButton.m
//  SKTopSlideTitleBar
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKTitleButton.h"

@implementation SKTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        // 文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  不让按钮达到高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {}


@end
