//
//  UIButton+HitTestInsets.m
//  ButtonHitTest
//
//  Created by sunke on 2020/10/10.
//

#import "UIButton+HitTestInsets.h"
#import <objc/runtime.h>

static const char *hitTestInsetsKey = "SKHitTestInsetsKey";
static const char *useHitTestInsetsKey = "SKUseHitTestInsetsKey";

//@dynamic hitTestEdgeInsets;

@implementation UIButton (HitTestInsets)


- (void)setHitTestInsets:(UIEdgeInsets)hitTestInsets{
    NSValue *value = [NSValue valueWithBytes:&hitTestInsets objCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &useHitTestInsetsKey, @(YES), OBJC_ASSOCIATION_RETAIN);
     objc_setAssociatedObject(self, &hitTestInsetsKey, value, OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)hitTestInsets{
    NSValue *value = objc_getAssociatedObject(self, &hitTestInsetsKey);
    UIEdgeInsets insets;
    [value getValue:&insets];
    return insets;
}

//扩大按钮的点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSNumber *useHitTestInsets = objc_getAssociatedObject(self, &useHitTestInsetsKey);
    BOOL status = [useHitTestInsets boolValue];
    if (status) {
        CGRect bounds = self.bounds;
        CGFloat extendX = self.hitTestInsets.left + self.hitTestInsets.right;
        CGFloat extendY = self.hitTestInsets.top + self.hitTestInsets.bottom;
        bounds = CGRectOffset(bounds, self.hitTestInsets.top, self.hitTestInsets.left);
        bounds = CGRectInset(bounds, extendX, extendY);
        return CGRectContainsPoint(bounds, point);
    }
    CGRect bounds = self.bounds;
    return CGRectContainsPoint(bounds, point);
}


@end
