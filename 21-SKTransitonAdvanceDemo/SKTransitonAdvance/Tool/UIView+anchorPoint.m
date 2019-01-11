//
//  UIView+anchorPoint.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/20.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "UIView+anchorPoint.h"

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end
