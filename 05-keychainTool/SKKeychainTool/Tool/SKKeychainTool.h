//
//  SKKeychainTool.h
//  17-KeychainTool
//
//  Created by sunke on 2017/9/26.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SKKeychainTool : NSObject

/**
 利用keyChain和UUID永久获得设备的唯一标识
 
 本方法是得到 UUID 后存入系统中的 keychain 的方法
 不用添加 plist 文件
 程序删除后重装,仍可以得到相同的唯一标示
 但是当系统升级或者刷机后,系统中的钥匙串会被清空,此时本方法失效
 */
+ (NSString *)getDeviceIDInKeychain;



@end
