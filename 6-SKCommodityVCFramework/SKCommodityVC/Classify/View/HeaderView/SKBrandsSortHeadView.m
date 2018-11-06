//
//  SKBrandsSortHeadView.m
//  SKCommodityVC
//
//  Created by sunke on 2017/9/28.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKBrandsSortHeadView.h"
#import "SKClassMianItem.h"

@interface SKBrandsSortHeadView()
/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end

@implementation SKBrandsSortHeadView

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
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR13Font;
    _headLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_headLabel];
    
    _headLabel.frame = CGRectMake(SKMargin, 0, self.sk_width, self.sk_height);
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(SKClassMianItem *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = headTitle.title;
}


@end
