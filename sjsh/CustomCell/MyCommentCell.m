//
//  MyCommentCell.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/12.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyCommentCell.h"

@implementation MyCommentCell

@synthesize tipLabel;
@synthesize picImageView;
@synthesize descriptionLabel;
@synthesize reviewButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 18.0f, 180.0f, 18.0f)];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        tipLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:tipLabel];
        [tipLabel release];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 64, 64)];
        [picImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:picImageView];
        [picImageView release];
        
        self.descriptionLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 36.0f, 100.0f, 16.0f)];
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        descriptionLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
        [self addSubview:descriptionLabel];
        [descriptionLabel release];
        
        self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reviewButton.frame = CGRectMake(94, 53, 100, 30);
        [self.reviewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.reviewButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:reviewButton];
        [reviewButton release];
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
