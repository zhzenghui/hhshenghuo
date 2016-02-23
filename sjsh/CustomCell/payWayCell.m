//
//  payWayCell.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "payWayCell.h"

@implementation payWayCell

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
    [_contentLabel release];
    [_titlelabel release];
    [super dealloc];
}
@end
