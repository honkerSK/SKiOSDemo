//
//  SKPostVC.m
//  SKBulgeTabBar-iOS
//
//  Created by sunke on 2017/5/9.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKPostVC.h"

@interface SKPostVC ()

@end

@implementation SKPostVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
}

- (void)setUpNav {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}


- (void)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
