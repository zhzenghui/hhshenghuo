//
//  LoginViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
//#import "CustomNavigationBar.h"

@interface BindRegisterViewController : UITempletViewController{

}
@property (nonatomic, retain) UITextField *userNameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;
@property (nonatomic, retain) UITextField *repeatPasswordTextField;
@property (nonatomic, retain) NSDictionary *infoDictionary;
@end
