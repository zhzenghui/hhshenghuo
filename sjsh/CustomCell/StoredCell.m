//
//  StoredCell.m
//  sjsh
//
//  Created by ce on 14-9-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "StoredCell.h"

@implementation StoredCell
@synthesize tipLabel;
@synthesize picImageView;
@synthesize nowPriceLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 10.0f, 180.0f, 42.0f)];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.numberOfLines = 0;
        tipLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        tipLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:tipLabel];
        [tipLabel release];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 64, 64)];
        [picImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:picImageView];
        [picImageView release];
        
        self.nowPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 53.0f, 100.0f, 20.0f)];
        nowPriceLabel.textAlignment = NSTextAlignmentLeft;
        nowPriceLabel.backgroundColor = [UIColor clearColor];
        nowPriceLabel.textColor = [UIColor colorWithRed:0xff/255.0f green:0x42/255.0f blue:0x6e/255.0f alpha:1];
        nowPriceLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        [self addSubview:nowPriceLabel];
        [nowPriceLabel release];
    }
    return self;
}

@end
