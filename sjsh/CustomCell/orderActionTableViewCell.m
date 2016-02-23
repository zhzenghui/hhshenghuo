//
//  orderActionTableViewCell.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "orderActionTableViewCell.h"

@implementation orderActionTableViewCell
@synthesize state;
@synthesize actionButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.state = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
        state.textAlignment = NSTextAlignmentLeft;
        state.backgroundColor = [UIColor clearColor];
        state.textColor = [UIColor colorWithRed:0xff/255.0f green:0x42/255.0f blue:0x6e/255.0f alpha:1];
        state.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:state];
        [state release];
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.frame = CGRectMake(200, 10, 100, 30);
        [self addSubview:actionButton];
        [actionButton release];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
