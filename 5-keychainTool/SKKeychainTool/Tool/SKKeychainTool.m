//
//  SKKeychainTool.m
//  17-KeychainTool
//
//  Created by sunke on 2017/9/26.
//  Copyright © 2017年 SK. All rights reserved.
//


#import "SKKeychainTool.h"

NSString * const KEY_UDID_INSTEAD = @"com.myapp.udid.test";

@implementation SKKeychainTool

+ (NSString *)getDeviceIDInKeychain {
    NSString *getUDIDInKeychain = (NSString *)[self load:KEY_UDID_INSTEAD];
    //NSLog(@"从keychain中获取到的 UDID_INSTEAD %@",getUDIDInKeychain);
    
    if (!getUDIDInKeychain ||[getUDIDInKeychain isEqualToString:@""]||[getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        //NSLog(@"\n \n \n _____重新存储 UUID _____\n \n \n  %@",result);
        
        [self save:KEY_UDID_INSTEAD data:result];
        getUDIDInKeychain = (NSString *)[self load:KEY_UDID_INSTEAD];
    }
    //NSLog(@"最终 ———— UDID_INSTEAD %@",getUDIDInKeychain);
    return getUDIDInKeychain;
}

#pragma mark - private
/* 通过 key 获取数据 */
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

/* 保存数据至钥匙串中 */
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/* 从钥匙串中加载数据 */
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

/* 删除数据 */
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}



@end
