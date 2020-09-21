//
//  SKOutlineCell.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SKOutlineButtonBlock)(UIButton *button);

@interface SKOutlineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOffset;
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPage;
@property (nonatomic, copy) SKOutlineButtonBlock outlineBlock;

@end

NS_ASSUME_NONNULL_END
