//
//  TextFieldCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "TextFieldCell.h"
#import "AppDelegate.h"
@implementation TextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, MRScreenWidth - 105, 50)];
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.textField.text = @"";
        self.textField.placeholder = @"请输入";
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.clearButtonMode = UITextFieldViewModeNever;
        [self.contentView addSubview:self.textField];
        
        self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delBtn.frame = CGRectMake(MRScreenWidth - 46, 2, 46, 46);
        [self.delBtn setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        [self.delBtn addTarget:self action:@selector(delBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.delBtn];
        
    }
    return self;
}

- (void)delBtnAction:(UIButton *)dender
{
    self.textField.text = @"";
}

@end
