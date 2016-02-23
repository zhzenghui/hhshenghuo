//
//  ShowAddressCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "ShowAddressCell.h"
#import "AppDelegate.h"
@implementation ShowAddressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, MRScreenWidth - 40, 18)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, MRScreenWidth - 40, 18)];
        self.valueLabel.font = [UIFont systemFontOfSize:14];
        self.valueLabel.textColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:1];
//        self.valueLabel.textAlignment = NSTextAlignmentRight;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.valueLabel];
        
    }
    return self;
}
@end
