//
//  PersonalInfoViewController.h
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"



@interface PersonalInfoViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView                  *profileTableView;//设置数据列表
    UIImageView                     *avatarImageView;//头像
    UILabel                      *nickLabel;//昵称
     UILabel                      *phoneLabel;//手机号
    UILabel                      *addressLabel;//地址
    UILabel                      *moneyNum;//生活币
    UILabel                      *discountNumLabel;//优惠券数量
}
@property (nonatomic, retain) NSDictionary *userInfo;
@end
