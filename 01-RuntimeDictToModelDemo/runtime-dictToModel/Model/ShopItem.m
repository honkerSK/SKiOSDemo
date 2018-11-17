//
//  ShopItem.m
//  runtime-dictToModel
//
//  Created by sunke on 2017/9/28.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "ShopItem.h"

@implementation ShopItem

//指定 数组list 对应类是谁
// @{plist中的key : 对应的模型类名}
+ (NSDictionary *)arrayContainModelClass{
    return @{@"list": @"ListItemModel"};
}
// 指定 字典AttrModel对应类是谁
+ (NSDictionary *)dictWithModelClass {
    return @{@"attr" : @"AttrModel"};
}

@end




