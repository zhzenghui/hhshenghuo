//
//  EditAddressCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "EditAddressCell.h"
#import "AppDelegate.h"
@implementation EditAddressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 50)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, MRScreenWidth - 100, 50)];
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.text = @"";
        [self.contentView addSubview:self.textField];
        
    }
    return self;
}
@end
