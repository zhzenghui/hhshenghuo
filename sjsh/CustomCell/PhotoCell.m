//
//  PhotoCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "PhotoCell.h"
#import "AppDelegate.h"
@implementation PhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 114)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MRScreenWidth - 115, 20, 75, 75)];
        self.headImageView.backgroundColor = [UIColor whiteColor];// TODO
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.height / 2.0;
        self.headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.headImageView];
        
    }
    return self;
}

@end
