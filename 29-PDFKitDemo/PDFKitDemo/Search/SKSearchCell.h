//
//  SKSearchCell.h
//  PDFKitDemo
//
//  Created by sunke on 2020/9/21.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDestination;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end

NS_ASSUME_NONNULL_END
