//
//  SKBrandsSortHeadView.h
//  SKCommodityVC
//
//  Created by sunke on 2017/9/28.
//  Copyright © 2017年 SK. All rights reserved.
//

// 每组CollectionView 的头部视图
#import <UIKit/UIKit.h>

@class SKClassMianItem;
@interface SKBrandsSortHeadView : UICollectionReusableView

/* 头部标题 */
@property (strong , nonatomic)SKClassMianItem *headTitle;

@end
