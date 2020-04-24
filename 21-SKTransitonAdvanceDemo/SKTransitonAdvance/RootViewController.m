//
//  RootViewController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义转场动画";
//    self.navigationController.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.masksToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];

    [self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"cell"];
}

#pragma mark - 懒加载
- (NSArray *)data {
    if (!_data) {
        _data = @[@"神奇移动", @"移动pop", @"翻页效果", @"小圆点扩散"];
    }
    return _data;
}

- (NSArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = @[@"SKMagicMoveController", @"SKPresentOneController", @"SKPageCoverController", @"SKCircleSpreadController"];
    }
    return _viewControllers;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //注意:不要加*
//    Class VC = NSClassFromString(self.viewControllers[indexPath.row]);
//    [self.navigationController pushViewController:[[VC alloc] init] animated:true];

    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];

}


@end
