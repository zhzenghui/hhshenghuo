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

@interface LoginViewController : UITempletViewController{

    NSDictionary *infoDictionary;
}
@property (nonatomic, retain) UITextField *userNameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;

@property (nonatomic, retain) NSDictionary *infoDictionary;
@property (nonatomic, assign) BOOL noShowReturn;
- (void)pushToBindRegisterVc:(NSDictionary *)info;
@end
