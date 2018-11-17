//
//  SKHeaderView.m
//  clearTableViewPlainAndGroup
//
//  Created by sunke on 2018/9/15.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKHeaderView.h"

#define SKScreenW [UIScreen mainScreen].bounds.size.width

@implementation SKHeaderView

- (void)setFrame:(CGRect)frame {
    NSLog(@"_______ frame = %@",NSStringFromCGRect(frame));
    
    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [super setFrame:newFrame];
}


//----------------------------------------------

/*
 
//自定义section头部视图的内容
+ (SKHeaderView *)showWithName:(NSString *)sectionName {
    
    SKHeaderView  *sectionView = [[SKHeaderView alloc] initWithFrame:CGRectMake(0, 0, SKScreenW, 44)];
    sectionView.backgroundColor = [UIColor colorWithRed:0.1 green:0.5 blue:0.8 alpha:0.2f];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    CGRect rect = [sectionName boundingRectWithSize:CGSizeMake(SKScreenW -20, 20) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context: nil];
    CGFloat titleWidth = CGRectGetWidth(rect);
    
    // title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, SKScreenW - 20, 20)];
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.text = sectionName;
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sectionView addSubview:titleLabel];
    
    
    // grayLine
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, sectionView.frame.size.height - 1, CGRectGetWidth(sectionView.frame) - 20, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [sectionView addSubview:lineView];
    
    // redLine
    UIView *lineSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 1)];
    lineSelectView.backgroundColor = [UIColor redColor];
    [lineView addSubview:lineSelectView];
    
    
    return sectionView;
}

+ (CGFloat)getSectionHeight {
    return 44;
}

*/

@end
