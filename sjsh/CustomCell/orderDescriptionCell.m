//
//  orderDescriptionCell.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "orderDescriptionCell.h"

@implementation orderDescriptionCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_orderNo release];
    [_orderTime release];
    [_orderState release];
    [_orderPrice release];
    [_orderPostPrice release];
    [_orderReceiver release];
    [_orderAddress release];
    [_orderPhone release];
    [super dealloc];
}
@end
