//
//  SKTableViewController2.m
//  14-UITableView去掉分割线
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKTableViewController2.h"
#import "SKCell2.h"

#define SKSize self.view.frame.size

@interface SKTableViewController2 ()

@property (nonatomic, strong) NSArray *dictArr;

@property (nonatomic, strong) NSMutableArray *headerArr;

@end

static NSString * const ID = @"cell";
@implementation SKTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建tableView的头部视图
//    CGSize size = self.tableView.frame.size;
//    UIView *tableHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 40)];
//    tableHeaderV.backgroundColor = [UIColor greenColor];
//    self.tableView.tableHeaderView = tableHeaderV;
    
    //加载plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    self.dictArr = [NSArray arrayWithContentsOfFile:path];
    
    //获取所有header
    self.headerArr = [NSMutableArray array];
    [self.dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [self.headerArr addObject:obj[@"header"]];
    }];
    
    //注册cell
    [self.tableView registerClass:[SKCell2 class] forCellReuseIdentifier:ID];
    
    //自定义分割线方法二: 重写cell的setFrame方法,高度-1,露出背景色
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    // 设置tableView背景色
    self.tableView.backgroundColor = [UIColor colorWithWhite:215 / 255.0 alpha:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dictArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //数组每个元素为一个字典
    NSDictionary *dict = self.dictArr[section];
    NSArray *cars = dict[@"cars"];
    return cars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
 
    
    NSDictionary *dict = self.dictArr[indexPath.section];
    NSArray *cars = dict[@"cars"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cars[indexPath.row]];
    
    
    //cell.separatorInset = UIEdgeInsetsMake(0.f, self.view.frame.size.width, 0.f, 0.f);

    return cell;
}

//给每个section 添加头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict = self.dictArr[section];
    return dict[@"header"];
}

//增加tableview右侧的索引栏
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.headerArr;
//}

//设置section的header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//设置section的footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}


@end
