//
//  ViewController.m
//  SKCarouseView
//
//  Created by sunke on 2016/12/20.
//  Copyright © 2016 KentSun. All rights reserved.
//

#import "ViewController.h"
#import "SKScrollerViewController.h"
#import "SKCollectionViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}



- (IBAction)scrollerViewBtnClick:(id)sender {
    //两边加多余页方式
    SKScrollerViewController *scrollerViewController = [[SKScrollerViewController alloc] init];
    
    [self.navigationController pushViewController:scrollerViewController animated:YES];
    
}


- (IBAction)collectionViewBtnClick:(id)sender {
    //三张页面循环方式
    SKCollectionViewController *collectionViewController = [[SKCollectionViewController alloc] init];
    
    [self.navigationController pushViewController:collectionViewController animated:YES];
    
}



@end
