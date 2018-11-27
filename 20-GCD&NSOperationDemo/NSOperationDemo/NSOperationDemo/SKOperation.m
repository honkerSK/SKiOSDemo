//
//  SKOperation.m
//  NSOperationDemo
//
//  Created by sunke on 28/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "SKOperation.h"

@implementation SKOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}


@end
