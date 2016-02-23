//
//  FindWayViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/11/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

typedef enum : NSUInteger {
    Phone = 1, //
    Email = 2,//
    VCode = 3,//
    SetPW = 4,//
    Input_old_pw = 5,//
    Modify_PW = 6,//
    InputPW_phone = 7,//
    InputPW_email = 8,//
    InPutPhone_bd = 9,//
    InputEmail_bd = 10,//
    InputVcode_p_bd = 11,//
    InputVcode_E_bd = 12,//
} pageStyel;

@interface FindWayViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *settingTableView;
}
@property (nonatomic ,assign) pageStyel pStytl;
@property (nonatomic, retain) NSArray *params;
@end
