//
//  AddOrderViewController.h
//  sjsh
//
//  Created by savvy on 15/10/22.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "Define.h"
#import "OrderCommodityCell.h"
#import "OrderWayCell.h"
#import "UPPayPluginDelegate.h"
#import "SelectAlertView.h"
#import "OpenURLViewController.h"

 


//填写订单页面
@interface AddOrderViewController : UITempletViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,OrderCommodityCellDelegate,UPPayPluginDelegate,SelectAlertViewDelegate>

@property(nonatomic,assign)BOOL isFirst;//第一次支付
@property(nonatomic,assign)BOOL isAll;//全部商品支付（废弃）
@property(nonatomic,assign)NSString *orderID;//订单编号

@end
