//
//  SKGoodsSortCell.h
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

// 常用cellectionCell(image和label)
#import <UIKit/UIKit.h>

@class SKClassSubItem;
@interface SKGoodsSortCell : UICollectionViewCell

/* 品牌数据 */
@property (strong , nonatomic)SKClassSubItem *subItem;

@end
