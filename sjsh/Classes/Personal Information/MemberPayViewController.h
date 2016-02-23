//
//  MemberPayViewController.h
//  sjsh
//  会员支付页面
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "UPPayPluginDelegate.h"

@interface MemberPayViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UPPayPluginDelegate>

@property(nonatomic, strong) NSString *remainderValue;//余额

@end
