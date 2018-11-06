//
//  SKBookModel.m
//  12-KVC字典转模型
//
//  Created by sunke on 2018/9/13.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "SKBookModel.h"

@implementation SKBookModel

//方法一: 一个一个地为每个属性分别写setValue (不建议使用)
/*
+ (instancetype)getSKBookModelWithDict:(NSDictionary *)dict {
    SKBookModel *bookModel = [[self alloc] init];
    [bookModel setValue:[dict valueForKey:@"id"] forKey:@"id"];
    [bookModel setValue:[dict valueForKey:@"imgUrlStr"] forKey:@"imgUrlStr"];
    [bookModel setValue:[dict valueForKey:@"nameStr"] forKey:@"nameStr"];

    return bookModel;
}
*/

//方法二:(建议使用这个方法)
+ (instancetype)bookModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        //setValuesForKeysWithDictionary :遍历字典中的所有Key,去模型中查找有没有对应的属性名,如果就给这个属性赋值
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//setValue:forUndefinedKey: 防止与后台字段不匹配而造成崩溃
//JSON数据里面会有一个id的字段, 而id是iOS的一个关键字，不能用关键字定义属性名，此时我们就需要在model类中修改这个属性的名字
//并在- (void)setValue:(id)value forUndefinedKey:(NSString *)key的方法体中重写该方法，以针对id字段作特殊处理。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]){
        //self.bookId = value;//不推荐
        [self setValue:value forKey:@"bookId"]; // 推荐
    }
}

//加载plist文件, 字典转模型
+ (NSArray<SKBookModel *> *)bookModelsWithPlistName:(NSString *)plistName {
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    //读取plist
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
    //字典转模型
    NSMutableArray *modelArr = [NSMutableArray array];
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        [modelArr addObject:[self bookModelWithDict:dict]];
    }];
    return modelArr.copy;
    
}


@end
