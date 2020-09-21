//
//  SKSearchViewController.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/21.
//  Copyright © 2020 KentSun. All rights reserved.
//

//搜索控制器
#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SKSearchViewController;

@protocol SKSearchViewControllerDelegate <NSObject>
/**
 did select search result delegate

 @param controller controller
 @param selection selection
 */
- (void)searchViewController:(SKSearchViewController *)controller didSelectSearchResult:(PDFSelection *)selection;

@end

@interface SKSearchViewController : UIViewController

@property (nonatomic, strong) PDFDocument *pdfDocment;
@property (nonatomic, weak) id<SKSearchViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
