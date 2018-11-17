//
//  SKBtnView.h
//  SKCustomButton
//
//  Created by sunke on 2018/10/16.
//  Copyright © 2018 sunke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SKBtnView : UIButton

/** SKBtnView图片 */
@property (nonatomic, weak) UIImageView *iconView;
/** SKBtnView文本 */
@property (nonatomic, weak) UILabel *nameLabel;

@end

