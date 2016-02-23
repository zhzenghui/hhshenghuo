//
//  orderDescriptionCell.h
//  sjsh
//
//  Created by 杜 计生 on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderDescriptionCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *orderNo;
@property (retain, nonatomic) IBOutlet UILabel *orderTime;
@property (retain, nonatomic) IBOutlet UILabel *orderState;
@property (retain, nonatomic) IBOutlet UILabel *orderPrice;
@property (retain, nonatomic) IBOutlet UILabel *orderPostPrice;
@property (retain, nonatomic) IBOutlet UILabel *orderReceiver;
@property (retain, nonatomic) IBOutlet UILabel *orderAddress;
@property (retain, nonatomic) IBOutlet UILabel *orderPhone;

@end
