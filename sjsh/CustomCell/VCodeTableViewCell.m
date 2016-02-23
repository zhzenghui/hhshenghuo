//
//  VCodeTableViewCell.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/13.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "VCodeTableViewCell.h"

@implementation VCodeTableViewCell
@synthesize tipLabel;
@synthesize statusLabel;
@synthesize descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self.descriptionLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 10.0f, 135.0f, 30.0f)];
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.textColor = [UIColor colorWithRed:0x94/255.0f green:0xc4/255.0f blue:0x00/255.0f alpha:1];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont fontWithName:@"Arial" size:17.0f];
        [self addSubview:descriptionLabel];
        [descriptionLabel release];
        
        self.statusLabel  = [[UILabel alloc]initWithFrame:CGRectMake(220.0f, 15.0f, 64.0f, 21.0f)];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textColor = [UIColor colorWithRed:0x94/255.0f green:0xc4/255.0f blue:0x00/255.0f alpha:1];
        statusLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:statusLabel];
        [statusLabel release];
        
        self.tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 15.0f, 64.0f, 21.0f)];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        tipLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:tipLabel];
        [tipLabel release];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
