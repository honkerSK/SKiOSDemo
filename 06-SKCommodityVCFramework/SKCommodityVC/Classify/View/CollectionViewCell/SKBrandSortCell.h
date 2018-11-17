//
//  SKBrandSortCell.h
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

//热门品牌cell (只有image)
#import <UIKit/UIKit.h>
@class SKClassSubItem;
@interface SKBrandSortCell : UICollectionViewCell

/* 品牌数据 */
@property (strong , nonatomic)SKClassSubItem *subItem;

@end
