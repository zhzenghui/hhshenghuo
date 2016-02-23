//
//  ShoppingCartTableViewCell.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectedTapped:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(transforSelectResult:select:)]) {
        [self.delegate transforSelectResult:self.tag select:sender.tag?NO:YES];
    }
    if (sender.tag == 0) {
        [sender setBackgroundImage:[UIImage imageNamed:@"selectted"] forState:UIControlStateNormal];
        sender.tag = 1;
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        sender.tag = 0;
    }
}

- (IBAction)editButtonTapped:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(transforEditTap:)]) {
        [self.delegate transforEditTap:self.tag];
    }
}

- (void)dealloc {
    [_selectButton release];
    [_iconImageview release];
    [_titleLabel release];
    [_descriptionLabel release];
    [_priceLabel release];
    [_originalPriceLabel release];
    [_skuLabel release];
    [_numLabel release];
    [_editButton release];
    [_myLine release];
    [super dealloc];
}
@end
