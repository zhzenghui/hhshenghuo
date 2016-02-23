//
//  HHUserCenterController.h
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
@import HealthKit;

@interface HHUserCenterController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView                  *profileTableView;//设置数据列表
    UIImageView                     *avatarImageView;//头像
    UILabel                      *nickLabel;//昵称
    UILabel                      *phoneLabel;//手机号
    UILabel                      *addressLabel;//地址
    UILabel                      *moneyNum;//生活币
    UILabel                      *discountNumLabel;//优惠券数量
}
@property (nonatomic, retain) NSDictionary *userInfo;

@property (nonatomic,strong) HKHealthStore *healthStore;
@end

