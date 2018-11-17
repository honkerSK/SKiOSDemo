//
//  SKCell.m
//  14-UITableView去掉分割线
//
//  Created by sunke on 2018/9/17.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKCell.h"

@implementation SKCell

//自定义cell, 重写drawRect:  自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 2, rect.size.width, 2));
}



@end
