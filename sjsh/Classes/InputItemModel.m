//
//  InputItemModel.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/18.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "InputItemModel.h"

@implementation InputItemModel

- (id)initWithFrame:(CGRect)frame iconImage:(NSString *)imageName text:(NSString *)text placeHolderText:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.image = INPUT_BG;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(14,12, 20, 20)];
        icon.image = [UIImage imageNamed:imageName];
        [self addSubview:icon];
        self.iconImageView = icon;
        [icon release];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(44, 0, 211, 44)];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = [UIColor colorWithRed:51/255. green:204/255. blue:204/255. alpha:1];
        textField.delegate = self;
        textField.placeholder = placeholder;
        textField.text = text;
        self.textField = textField;
        [self addSubview:textField];
        [textField release];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.image = [UIImage imageNamed:@"input_bg_text"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length==0) {
        self.image = INPUT_BG;
    }
}
@end
