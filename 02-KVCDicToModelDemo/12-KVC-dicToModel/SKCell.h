//
//  SKCell.h
//  12-KVC字典转模型
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKBookModel.h"

@interface SKCell : UITableViewCell

@property (nonatomic, strong) SKBookModel *bookModel;

@end
