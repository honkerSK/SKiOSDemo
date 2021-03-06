//
//  SKClassMianItem.h
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKClassSubItem;
@interface SKClassMianItem : NSObject

/** 文标题  */
@property (nonatomic, copy ,readonly) NSString *title;

/** goods  */
@property (nonatomic, copy ,readonly) NSArray<SKClassSubItem *> *goods;

@end
