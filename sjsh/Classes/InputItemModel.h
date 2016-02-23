//
//  InputItemModel.h
//  sjsh
//
//  Created by 计生 杜 on 14/12/18.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inputModelDelegate <NSObject>
- (void)textFieldShouldBeginEditing:(UITextField *)textField;
@end

@interface InputItemModel : UIImageView <UITextFieldDelegate>

@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, assign) id<inputModelDelegate>delegate;
- (id)initWithFrame:(CGRect)frame iconImage:(NSString *)imageName text:(NSString *)text placeHolderText:(NSString *)placeholder;
@end
