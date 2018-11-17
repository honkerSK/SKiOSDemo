//
//  NSObject+EnumDict.h
//  runtime-dictToModel
//
//  Created by sunke on 2017/9/21.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

@optional
// 提供一个协议，只要准备这个协议的类，都能把数组中的字典转模型
// 用在三级数组转换
//告诉 我数组对应哪个类
+ (NSDictionary *)arrayContainModelClass;
//告诉 我字典对应哪个类
+ (NSDictionary *)dictWithModelClass ;

@end

@interface NSObject (EnumDict)


/**
 根据字典转模型

 @param dict 第一层字典
 @return 返回根据字典转化后的模型
 */
+ (instancetype)sk_modelWithDict:(NSDictionary *)dict;

@end
