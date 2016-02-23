//
//  HHLoginViewController.h
//  sjsh
//
//  Created by savvy on 16/2/23.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"

@interface HHLoginViewController : UITempletViewController{
    
    NSDictionary *infoDictionary;
}
@property (nonatomic, retain) UITextField *userNameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;

@property (nonatomic, retain) NSDictionary *infoDictionary;
@property (nonatomic, assign) BOOL noShowReturn;
- (void)pushToBindRegisterVc:(NSDictionary *)info;

@end
