//
//  SKBrandSortCell.m
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKBrandSortCell.h"

//Vendors
#import <Masonry.h>
#import <UIImageView+WebCache.h>

//Models
#import "SKClassSubItem.h"

@interface SKBrandSortCell()

/* imageView */
@property (strong , nonatomic)UIImageView *brandImageView;

@end

@implementation SKBrandSortCell


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = SKBGColor;
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_brandImageView];
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.sk_width - 20, self.sk_height - 25));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setSubItem:(SKClassSubItem *)subItem
{
    _subItem = subItem;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
}

@end
