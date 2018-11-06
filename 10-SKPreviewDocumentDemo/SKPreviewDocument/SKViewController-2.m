//
//  SKViewController-2.m
//  SKPreviewDocument
//
//  Created by sunke on 2018/10/15.
//  Copyright © 2018 SK. All rights reserved.
//

#import "SKViewController-2.h"


//第二种方式：QLPreviewController
#import <QuickLook/QuickLook.h>

@interface SKViewController_2 ()<QLPreviewControllerDataSource>

@end

@implementation SKViewController_2

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self quickLook];
    [self performSelectorOnMainThread:@selector(quickLook) withObject:nil waitUntilDone:NO];

}


- (void)quickLook{
    self.view.backgroundColor = [UIColor grayColor];
    QLPreviewController * preVC = [[QLPreviewController alloc]init];
    preVC.dataSource = self;
    [self presentViewController:preVC animated:YES completion:nil];
    
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:@"OC总结" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
    return  url;
}

@end
