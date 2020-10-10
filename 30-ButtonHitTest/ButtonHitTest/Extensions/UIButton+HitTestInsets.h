//
//  UIButton+HitTestInsets.h
//  ButtonHitTest
//
//  Created by sunke on 2020/10/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HitTestInsets)
///top,left,bottom,right的值大于0的时候代表热区范围减小，反之代表热区范围扩大
@property (nonatomic,assign) UIEdgeInsets hitTestInsets;

//@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;


@end

NS_ASSUME_NONNULL_END
