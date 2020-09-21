//
//  SKOutlineCell.m
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import "SKOutlineCell.h"

@implementation SKOutlineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.indentationLevel == 0) {
        self.lblTitle.font = [UIFont systemFontOfSize:17];
    }
    else{
        self.lblTitle.font = [UIFont systemFontOfSize:15];
    }
    
    self.leftOffset.constant = self.indentationWidth * self.indentationLevel;
}

- (IBAction)btnArrowAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.isSelected;

    if (self.outlineBlock){
        self.outlineBlock(button);
    }
}


@end
