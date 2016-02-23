//
//  MyStepper.h
//  sjsh
//
//  Created by savvy on 15/10/23.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyStepperDelegate<NSObject>

- (void)getNumber:(NSInteger)number state:(NSInteger)state;

@end

@interface MyStepper : UIView

@property(nonatomic, assign) id<MyStepperDelegate> delegate;

@property(nonatomic, strong) UIButton* subtractButton;  //减号
@property(nonatomic, strong) UIButton* addButton;       //加号
@property(nonatomic, strong) UIImageView* subtractImageView;  //减号
@property(nonatomic, strong) UIImageView* addImageView;       //加号
@property(nonatomic, strong) UILabel* numberLabel;      //数量
@property(nonatomic, strong) UIImageView* numberTopLine;
@property(nonatomic, strong) UIImageView* numberBottomLine;

@property(nonatomic, assign) NSInteger number;      //数量


@end
