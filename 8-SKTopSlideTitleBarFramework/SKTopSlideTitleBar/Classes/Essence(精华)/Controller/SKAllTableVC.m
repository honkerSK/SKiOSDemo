//
//  SKAllTableVC.m
//  SKTopSlideTitleBar
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKAllTableVC.h"

@interface SKAllTableVC ()

@end

@implementation SKAllTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = SKRandomColor;
//    self.tableView.contentInset = UIEdgeInsetsMake(SKNavBarMaxY + SKTitlesViewH, 0, SKTabBarH, 0);
    
    self.tableView.contentInset = UIEdgeInsetsMake(SKTitlesViewH, 0, SKTabBarH, 0);

    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    SKFunc
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.class, indexPath.row];
    
    return cell;
}

@end
