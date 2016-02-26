//
//  CheckmarkCellId.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "CheckmarkCellId.h"
#import "AppDelegate.h"
@implementation CheckmarkCellId

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 52.5)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkBtn.frame = CGRectMake(MRScreenWidth - 46, (52.5-46)/2, 46, 46);
        [self.checkBtn setImage:[UIImage imageNamed:@"hh_user_address_select"] forState:UIControlStateSelected];

        [self.contentView addSubview:self.checkBtn];
        
    }
    return self;
}

@end
