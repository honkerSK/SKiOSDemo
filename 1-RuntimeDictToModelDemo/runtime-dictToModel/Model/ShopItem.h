//
//  ShopItem.h
//  runtime-dictToModel
//
//  Created by sunke on 2017/9/28.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

//2.导入分类
#import "NSObject+EnumDict.h"

@class AttrModel;
//4.遵守分类协议, 实现协议方法
@interface ShopItem : NSObject <ModelDelegate>

//3.定义模型属性
@property (nonatomic, strong) AttrModel *attr; //模型名 要和plist中字典名一致
@property (nonatomic, strong) NSArray *list;


// 实现协议中的方法
//指定 数组list 对应类是谁
+ (NSDictionary *)arrayContainModelClass;
// 指定 字典AttrModel对应类是谁
+ (NSDictionary *)dictWithModelClass ;

@end
