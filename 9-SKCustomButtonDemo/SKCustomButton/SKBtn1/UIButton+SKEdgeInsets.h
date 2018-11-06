//
//  UIButton+SKEdgeInsets.h
//  SKCustomButton
//
//  Created by sunke on 2018/10/16.
//  Copyright © 2018 sunke. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

@interface UIButton (SKEdgeInsets)

/*
 如果你想要你的按钮中的图片和文字整体的水平居左，或者水平居右，或者垂直居上或者垂直居下则可以用UIButton的原生(UIControl)属性：
 // how to position content vertically inside control. default is center
 @property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;
 
 // how to position content hozontally inside control. default is center
 @property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
 */

//注意:请在建立完UIButton对象并且指定一个具体的frame值或者自动布局的约束尺寸后，并且调用setTitle:forState:和setImage:forSate:后再调用：
/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding:是调整布局时整个按钮和图文的间隔。
 */
- (void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

@end

