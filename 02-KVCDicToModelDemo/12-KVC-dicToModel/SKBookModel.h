//
//  SKBookModel.h
//  12-KVC字典转模型
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKBookModel : NSObject

@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, copy) NSString *imgUrlStr;
@property (nonatomic, copy) NSString *nameStr;

+ (instancetype)bookModelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
//加载plist文件, 字典转模型
+ (NSArray <SKBookModel *> *)bookModelsWithPlistName:(NSString *)plistName;

@end
