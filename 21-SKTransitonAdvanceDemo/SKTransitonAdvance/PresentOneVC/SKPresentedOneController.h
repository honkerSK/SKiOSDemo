//
//  SKPresentedOneController.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/11.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKPresentedOneControllerDelegate <NSObject>
///点击
- (void)presentedOneControllerPressedDissmiss;
//接收手势管理者
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end


//弹出的控制器
@interface SKPresentedOneController : UIViewController

@property (nonatomic, assign) id<SKPresentedOneControllerDelegate> delegate;

@end
