//
//  SKTableViewController.m
//  SKDetailsPageHeaderDemo
//
//  Created by sunke on 7/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "SKTableViewController.h"

@interface SKTableViewController ()

@end

@implementation SKTableViewController

static NSString *ID = @"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID ];
    
    //设置tableView头部标题
    //tableView的头部视图宽度由系统决定
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
    tableHeadView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = tableHeadView;
    
    //    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    //在iOS7 之后,只要是导航控制器下所有UIScrollView顶部都会添加额外的滚动区域
    
    //1.设置当前控制器不要调节ScrollView
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //2.隐藏导航控制器
    // 完全隐藏了再也不会显示,,正确做法是把导航条背景色设置为透明
    //    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.alpha = 0.0;
    
    // 将导航条背景色设置为透明
    // 必须传入UIBarMetricsDefault
    // 注意:传入空图片image对象,快速隐藏导航条背景图片
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //3.清空导航条阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    //    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"%f", self.tableView.contentInset.top);
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    
    return cell;
}

// 设置每组头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 无法在这个方法中设置每组头部视图高度
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    headView.backgroundColor = [UIColor orangeColor];
    return headView;
    
}

// 设置头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


@end
