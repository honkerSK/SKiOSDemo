//
//  SKTableViewController.m
//  14-UITableView去掉分割线
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKTableViewController.h"
#import "SKCell.h"

@interface SKTableViewController ()

//保存解析plist后所有的字典
@property (nonatomic, strong) NSArray *dictArr;
//保存section头部标题
@property (nonatomic, strong) NSMutableArray *headerArr;

@end

static NSString * const cellId = @"cell";

@implementation SKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    self.dictArr = [NSArray arrayWithContentsOfFile:path];
    
    //获取所有section头部标题数据
    self.headerArr = [NSMutableArray array];
    [self.dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.headerArr addObject:obj[@"header"]];
    }];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    //storyboard中静态单元格可以 设置separator 去掉storyboard显示效果中的分割线
    
    
    //自定义分割线方法一: 去掉分割线
    //设置一开始就将分割线设置为clearColor,然后根据需要加分割线
//    self.tableView.separatorColor = [UIColor clearColor];
    //或者
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - Table view data source
//注意: 使用静态单元格 需要去掉数据源方法
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    NSDictionary *dict = self.dictArr[indexPath.section];
    NSArray *cars = dict[@"cars"];
    //cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cars[indexPath.row]];
    
    
    //自定义分割线方法一: 通过addSubview的方式添加一条分割线
    //在自定义cell 里面给每个cell添加高度为2的红色分割线
    CGFloat cellH = cell.frame.size.height;
    if(indexPath.row != cars.count - 1){
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cellH-2, self.view.frame.size.width, 2)];
        line.backgroundColor = [UIColor redColor];
        [cell addSubview:line];
    }
    
    return cell;
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
