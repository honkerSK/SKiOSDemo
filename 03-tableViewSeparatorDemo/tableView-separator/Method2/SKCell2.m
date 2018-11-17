//
//  SKCell2.m
//  14-UITableView去掉分割线
//
//  Created by sunke on 2018/9/16.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKCell2.h"

@implementation SKCell2

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    // 给cellframe赋值
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
