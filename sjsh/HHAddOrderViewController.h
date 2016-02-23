//
//  HHAddOrderViewController.h
//  sjsh
//  下单页面
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "UITempletViewController.h"
#import "Define.h"
#import "HHOrderCommodityCell.h"
#import "OrderWayCell.h"
#import "UPPayPluginDelegate.h"
#import "SelectAlertView.h"
#import "OpenURLViewController.h"

@interface HHAddOrderViewController : UITempletViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,HHOrderCommodityCellDelegate,UPPayPluginDelegate,SelectAlertViewDelegate>

@property(nonatomic,assign)BOOL isFirst;//第一次支付
@property(nonatomic,assign)BOOL isAll;//全部商品支付（废弃）
@property(nonatomic,assign)NSString *orderID;//订单编号

@end
