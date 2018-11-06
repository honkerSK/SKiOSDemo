//
//  SKTableViewController.m
//  12-KVC字典转模型
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKTableViewController.h"
#import "SKBookModel.h"
#import "SKCell.h"

@interface SKTableViewController ()

@property (nonatomic, strong) NSArray <SKBookModel *> *modelArr;

@end

//定义cell标识
static NSString *const cellId = @"cell";
@implementation SKTableViewController

//懒加载
- (NSArray<SKBookModel *> *)modelArr{
    if (!_modelArr) {
        _modelArr = [SKBookModel bookModelsWithPlistName:@"requestData1"];
    }
    return _modelArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SKCell" bundle:nil] forCellReuseIdentifier:cellId];
   
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.bookModel = self.modelArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{    
    return 60;
}


@end
