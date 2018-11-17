//
//  SKTableViewController3.m
//  14-UITableView去掉分割线
//
//  Created by sunke on 2018/9/16.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKTableViewController3.h"

@interface SKTableViewController3 ()

@property (nonatomic, strong) NSArray *dictArr;
@property (nonatomic, strong) NSMutableArray *headerArr;
@end

static NSString * const ID = @"cell";

@implementation SKTableViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    self.dictArr = [NSArray arrayWithContentsOfFile:path];
    
    //获取所有header
    self.headerArr = [NSMutableArray array];
    [self.dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.headerArr addObject:obj[@"header"]];
    }];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //自定义分割线方法三:利用系统属性设置(separatorInset, layoutMargins)共需添加三句代码
    //对tableView的separatorInset, layoutMargins属性的设置
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        self.tableView.layoutMargins = UIEdgeInsetsZero;
//    }
    
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    NSDictionary *dict = self.dictArr[indexPath.section];
    NSArray *cars = dict[@"cars"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cars[indexPath.row]];
    
    //自定义分割线方法三:对cell的LayoutMargins属性的设置
    //以下两个方法, 是对cell的设置可以写在cellForRowAtIndexPath里,也可以写在willDisplayCell方法里
   
    //2.调整(iOS8以上)tableView边距(与上面第2步等效,二选一即可)
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        cell.preservesSuperviewLayoutMargins = NO;
//    }
    
    //3.调整(iOS8以上)view边距
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //2.调整(iOS8以上)tableView边距(与上面第2步等效,二选一即可)
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            cell.preservesSuperviewLayoutMargins = NO;
    }
    //3.调整(iOS8以上)view边距
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//给每个section 添加头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict = self.dictArr[section];
    return dict[@"header"];
}

//增加tableview右侧的索引栏
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.headerArr;
}

//设置section的header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//设置section的footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}


@end
