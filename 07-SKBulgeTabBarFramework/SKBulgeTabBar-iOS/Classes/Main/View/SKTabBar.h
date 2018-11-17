//
//  SKTabBar.h
//  SKBulgeTabBar-iOS
//
//  Created by sunke on 2017/5/9.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTabBar;
@protocol SKTabBarDelegate <NSObject>
@optional

- (void)tabBarPlusBtnClick:(SKTabBar *)tabBar;

@end


@interface SKTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<SKTabBarDelegate> tabBarDelegate;

@end
