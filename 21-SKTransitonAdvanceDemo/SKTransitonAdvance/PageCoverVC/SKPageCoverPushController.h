//
//  SKPageCoverPushController.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/19.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SKPageCoverPushControllerDelegate <NSObject>

//push转场
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface SKPageCoverPushController : UIViewController 

@property (nonatomic, weak) id<SKPageCoverPushControllerDelegate> delegate;

@end
