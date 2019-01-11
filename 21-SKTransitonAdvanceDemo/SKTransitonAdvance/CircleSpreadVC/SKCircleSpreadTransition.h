//
//  SKCircleSpreadTransition.h
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SKCircleSpreadTransitionType) {
    SKCircleSpreadTransitionTypePresent = 0,
    SKCircleSpreadTransitionTypeDismiss
};

@interface SKCircleSpreadTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SKCircleSpreadTransitionType type;

+ (instancetype)transitonWithTransitionType:(SKCircleSpreadTransitionType)type;
- (instancetype)initWithTransitionType:(SKCircleSpreadTransitionType)type;

@end
