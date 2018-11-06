//
//  ViewController.m
//  clearTableViewPlainAndGroup
//
//  Created by sunke on 2018/9/14.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "ViewController.h"
#import "SKHeaderView.h"

//屏幕宽度
#define SKScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *arr;

@end

static NSString *const cellID = @"cell";
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这里使用死数据
    self.arr = @[@"AAA", @"BBB", @"CCC", @"DDD", @"EEE"];
    
    CGSize sk_size = self.view.frame.size;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, sk_size.width, sk_size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
    
    //设置数据源
    tableView.dataSource = self;
    //设置代理
    tableView.delegate = self;
    
    self.tableView = tableView;
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    
    return cell;
}


//方法二:
#pragma mark - UITableViewDelegate
//设置每个section 自定义头部视图
//注意:此方法为代理方法, 需要将当前控制作为代理
//注意:自定义section头部视图, 需要配合使用 tableView:heightForHeaderInSection: 否则头部视图高度始终为28
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SKHeaderView *headerView = [[SKHeaderView alloc] initWithFrame:CGRectMake(0, 0, SKScreenW, 44)];
    headerView.backgroundColor = [UIColor blueColor];

    //SKHeaderView *headerView =  [SKHeaderView showWithName:[NSString stringWithFormat:@"section_title_%ld",section]];
    
    headerView.tableView = self.tableView;
    headerView.section = section;
    
    
    return headerView;
}
//设置每个section 自定义头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

//设置每个section 自定义尾部部视图的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//}




//----------------------  UITableViewDataSource   --------------------
//设置每个section 自定义尾部视图
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//}


//根据数组中字符串设置表格索引
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.arr;
//}

//设置每个section头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return self.arr[section];
//}
////设置section尾部标题
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return self.arr[section];
//}


//------------------------  scrollViewDelegate ----------------------------
//方法一:  这个通过重写 tableView 的 scrollViewDidScroll 方法可以实现。要注意的是页面是否有导航控制器，有的话要把自动内边距调整给考虑进去。

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //组头高度
    CGFloat sectionHeaderHeight = 30;
    //获取是否有默认调整的内边距
    //CGFloat defaultEdgeTop = self.navigationController? self.navigationController.navigationBar != nil && self.automaticallyAdjustsScrollViewInsets ? 64 : 0
    
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
*/

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 40;
    CGFloat sectionFooterHeight = 10;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
    }
}
*/


@end
