//
//  MyOrderDetailViewController.h
//  sjsh
//  订单详情
//  Created by 杜 计生 on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "exchangeCodeCell.h"
#import "payWayCell.h"
#import "orderDescriptionCell.h"
#import "orderGoodsCell.h"
#import "orderActionTableViewCell.h"

//订单详情页
@interface MyOrderDetailViewController : UITempletViewController 
{
   
    
}
@property(nonatomic, retain) NSMutableArray *dataArray;
 
@property (nonatomic, retain) NSString *orderID;
@property (nonatomic, retain) NSDictionary *infoDic;
@end
