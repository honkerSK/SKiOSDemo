//
//  SKThumbnailViewController.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

//缩略图控制器
#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SKThumbnailViewController;
@protocol SKThumbnailViewControllerDelegate <NSObject>
/**
 缩略图被点击

 @param controller 缩略图controller
 @param indexPath indexPath
 */
- (void)thumbnailViewController:(SKThumbnailViewController *)controller didSelectAtIndex:(NSIndexPath *)indexPath;

@end

@interface SKThumbnailViewController : UIViewController
@property (nonatomic, strong) PDFDocument *pdfDocument;
@property (nonatomic, weak) id<SKThumbnailViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
