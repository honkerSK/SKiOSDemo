//
//  ViewController.m
//  runtime-dictToModel
//
//  Created by sunke on 2017/9/21.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "ViewController.h"

#import "ShopItem.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation ViewController

- (NSMutableArray *)modelArr {
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //plist 解析
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"ShopItem.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
    
    //遍历数据
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        //字典转模型
        ShopItem *shopItem = [ShopItem sk_modelWithDict:dict];
        //保存模型到数组中
        [self.modelArr addObject:shopItem];
    }];
    
    NSLog(@"%@", _modelArr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
