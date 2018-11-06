//
//  SKHeaderView.h
//  clearTableViewPlainAndGroup
//
//  Created by sunke on 2018/9/15.
//  Copyright © 2018年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKHeaderView : UIView

@property NSUInteger section;

@property (nonatomic, weak) UITableView *tableView;

//+ (SKHeaderView *)showWithName:(NSString *)sectionName;
//+ (CGFloat)getSectionHeight;

@end
