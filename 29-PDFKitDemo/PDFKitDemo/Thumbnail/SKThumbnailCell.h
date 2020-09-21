//
//  SKThumbnailCell.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKThumbnailCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgViewThumb;
@property (nonatomic, strong) UILabel *pageNum;
@end

NS_ASSUME_NONNULL_END
