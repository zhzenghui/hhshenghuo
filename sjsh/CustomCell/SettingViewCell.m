//
//  SettingViewCell.m
//  sjsh
//
//  Created by ce on 14-11-5.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell
@synthesize textsLabel;
@synthesize rightImageView;
@synthesize nameLabel;
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
        self.nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(14.0f, 15.0f, 80.0f, 20.0f)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.numberOfLines = 0;
        nameLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:nameLabel];
        [nameLabel release];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MRScreenWidth-40, 5, 40, 44)];
        [rightImageView setBackgroundColor:[UIColor clearColor]];
        [rightImageView setImage:[UIImage imageNamed:@"toRight"]];
        [self addSubview:rightImageView];
        [rightImageView release];
        
        self.textsLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 15.0f, 200.0f, 20.0f)];
        textsLabel.textAlignment = NSTextAlignmentRight;
        textsLabel.backgroundColor = [UIColor clearColor];
        textsLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        textsLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:textsLabel];
        [textsLabel release];
    }
    return self;
}


@end
