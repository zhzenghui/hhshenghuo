//
//  RegisterViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

enum registType {
    getVerificationCode = 1,//获取验证码
    regist = 2,// 完成注册
};
@interface RegisterViewController : UITempletViewController

@property (nonatomic, assign) enum registType type;
@property (nonatomic, retain) UITextField *inputTextField;
@property (nonatomic, retain) UITextField *nickNameTextField;
@property (nonatomic, retain) UITextField *passWTextField;
@property (nonatomic, retain) UITextField *repeatPassTextField;
@property (nonatomic, retain) UITextField *recommendedTextField;


@end
