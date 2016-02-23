//
//  CategoryCell.m
//  sjsh
//
//  Created by ce on 14-7-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize mainTitleLabel;
@synthesize secondTitleLabel;
@synthesize itemImageView;
@synthesize backgroundViews;
@synthesize addButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        backgroundViews = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 300.0f, 74.0f)];
        [backgroundViews setImage:[UIImage imageNamed:@"cellBackground"]];
        backgroundViews.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundViews];
        [backgroundViews release];
        
        itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.0f, 8.0f, 60.0f, 60.0f)];
        itemImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:itemImageView];
        [itemImageView release];
        
        mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 20.0f, 130.0f, 15.0f)];
        mainTitleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        mainTitleLabel.textAlignment = NSTextAlignmentLeft;
        mainTitleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
        mainTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:mainTitleLabel];
        [mainTitleLabel release];
        
        secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 40.0f, 164.0f, 13.0f)];
        secondTitleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        secondTitleLabel.textAlignment = NSTextAlignmentLeft;
        secondTitleLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1.0f];
        secondTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:secondTitleLabel];
        [secondTitleLabel release];
        
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setFrame:CGRectMake(320-69, 11, 50, 50)];
        [self addSubview:addButton];
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
