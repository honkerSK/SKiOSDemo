//
//  ImageCollectionViewCell.h
//  SKCarouseView
//
//  Created by sunke on 2017/11/23.
//  Copyright © 2017年 KentSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,strong) UIImage *image;
@end
