//
//  ViewController2.m
//  clearTableViewPlainAndGroup
//
//  Created by sunke on 2018/9/14.
//  Copyright © 2018年 SK. All rights reserved.
//

//情况: 1.sction的头部视图和尾部视图,无任何内容
//2.sction有头部标题 尾部标题
//3.sction自定义头部视图和尾部视图

//此外 还分为是否有导航视图情况

#import "ViewController2.h"


@interface ViewController2 ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSArray *arr;

@end

static NSString *const cellID2 = @"cell2";

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    //这里使用死数据
    self.arr = @[@"AAA", @"BBB", @"CCC", @"DDD", @"EEE"];
    
    CGSize sk_size = self.view.frame.size;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, sk_size.width, sk_size.height) style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    
    //设置数据源
    tableView.dataSource = self;
    
    //设置代理
    tableView.delegate = self;

    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID2];
    
    //如果是分组样式, 默认每一组都会有头部和尾部间距
    //设置tableView主间距
//    tableView.sectionHeaderHeight = 30;
//    tableView.sectionFooterHeight = 0;
    
    //设置顶部额滚动区域 -25
//    tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //-----------------
    
    //第一步:隐藏UITableViewStyleGrouped上边多余的间隔
    //设置属性tableHeaderView的高度为特小值，但不能为零，若为零的话，iOS会取默认值，就无法消除头部间距了。
    //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

    //此外, 还可以设置tableFooterView, 来去掉第一个section上边多余间距处理. 但是一定要设置完tableView代理后执行下面代码
    //tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

    
}


#pragma mark - UITableViewDelegate
//应用场景三:
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

//第二步:隐藏UITableViewStyleGrouped下边多余的间隔
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}
//// 注意:return height 为 0，则 height 被设置成默认值
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    
    return cell;
}

//----------------------------------------------
//根据数组中字符串设置表格索引
//UITableViewStyleGrouped 也可以设置索引
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.arr;
//}

//应用场景二
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return self.arr[section];
//}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return self.arr[section];
//}

//查看contentOffset
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"_______ y = %f",(scrollView.contentOffset.y));
}


@end
