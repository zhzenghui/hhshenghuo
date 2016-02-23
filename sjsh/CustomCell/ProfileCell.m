//
//  ProfileCell.m
//  BeautyMakeup
//
//  Created by hers on 13-11-14.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import "ProfileCell.h"

@implementation ProfileCell

 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 0, 20.0f, 50)];
        self.userImageView.backgroundColor = [UIColor clearColor];
        self.userImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.userImageView];
       
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.frame.origin.x+self.userImageView.frame.size.width+12, 0, 130.0f, 50)];
        self.userNameLabel.font = [UIFont systemFontOfSize:14];
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
//        titleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
        self.userNameLabel.textColor = fontGrayColor;
//        self.userNameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.userNameLabel];
       
        self.userContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-185, 0, 150.0f, 50)];
        self.userContentLabel.font = [UIFont systemFontOfSize:14];
        self.userContentLabel.textAlignment = NSTextAlignmentRight;
        //        titleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
        self.userContentLabel.textColor = kRedColor;
        self.userContentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.userContentLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
