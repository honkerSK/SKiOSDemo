//
//  SKPageCoverTransition.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/19.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SKPageCoverTransitionType) {
    SKPageCoverTransitionTypePush = 0,
    SKPageCoverTransitionTypePop
};

@interface SKPageCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>
///动画过渡代理管理的是push还是pop
@property (nonatomic, assign) SKPageCoverTransitionType type;

+ (instancetype)transitionWithType:(SKPageCoverTransitionType)type;
- (instancetype)initWithTransitionType:(SKPageCoverTransitionType)type;

@end
