//
//  ListItemModel.h
//  runtime-dictToModel
//
//  Created by sunke on 2017/9/28.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

//第二层 List数组中的 item模型
@interface ListItemModel : NSObject

@property (nonatomic, copy) NSArray *infoname;

@property (nonatomic, strong) NSNumber *plusprice;

@end
