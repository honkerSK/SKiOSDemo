//
//  SKViewController-1.m
//  SKPreviewDocument
//
//  Created by sunke on 2018/10/15.
//  Copyright © 2018 SK. All rights reserved.
//

#import "SKViewController-1.h"

//第一种方式：UIDocumentInteractionController

@interface SKViewController_1 ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

@end

@implementation SKViewController_1


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readDocWithDucument];
    
    //    [self performSelectorOnMainThread:@selector(readDocWithDucument) withObject:nil waitUntilDone:NO];
    
}

- (void)readDocWithDucument{
    NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:@"OC总结" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
    _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
    _documentInteractionController.delegate = self;
    
//    [_documentInteractionController presentPreviewAnimated:YES];
    
    [_documentInteractionController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
}


#pragma mark - UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}


@end
