//
//  AddAddressCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "AddAddressCell.h"
#import "AppDelegate.h"
@implementation AddAddressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 52.5)];
        self.nameLabel.text = @"新增地址";
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.addIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, (52.5-18)/2, 18, 18)];
        self.addIcon.image = [UIImage imageNamed:@"add_Address"];
        [self.contentView addSubview:self.addIcon];
        
    }
    return self;
}

@end
