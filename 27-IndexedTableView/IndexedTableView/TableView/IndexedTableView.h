//
//  IndexedTableView.h
//  IndexedTableView
//
//  Created by sunke on 2020/9/17.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexedTableViewDataSource <NSObject>

// 获取一个tableview的字母索引条数据的方法
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexedTableView : UITableView

///索引数据源
@property (nonatomic, weak) id <IndexedTableViewDataSource> indexedDataSource;

@end

NS_ASSUME_NONNULL_END
