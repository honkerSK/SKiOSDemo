//
//  SKOutlineViewController.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//
// 大纲控制器
#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SKOutlineViewController;

@protocol SKOutlineViewControllerDelegate <NSObject>
/**
 did select outline delegate

 @param controller controller
 @param outline outline
 */
- (void)outlineViewController:(SKOutlineViewController *)controller didSelectOutline:(PDFOutline *)outline;

@end

@interface SKOutlineViewController : UIViewController
@property (nonatomic, strong) PDFOutline *outlineRoot;
@property (nonatomic, weak) id<SKOutlineViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
