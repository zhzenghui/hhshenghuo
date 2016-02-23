//
//  MsgTableViewCell.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/13.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MsgTableViewCell.h"

@implementation MsgTableViewCell
@synthesize statusLabel;
@synthesize descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self.descriptionLabel  = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 60.0f)];
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:descriptionLabel];
        [descriptionLabel release];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 60, 290, 1)];
        view.backgroundColor = [UIColor colorWithRed:0xb2/255.0f green:0xb2/255.0f blue:0xb2/255.0f alpha:0.4];
        [self addSubview:view];
        [view release];
        
        self.statusLabel  = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 70.0f, 290.0f, 30.0f)];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        statusLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:statusLabel];
        [statusLabel release];
        
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
