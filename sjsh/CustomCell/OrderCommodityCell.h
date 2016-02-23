//
//  OrderCommodityCell.h
//  sjsh
//
//  Created by savvy on 15/10/22.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStepper.h"

@protocol OrderCommodityCellDelegate<NSObject>

- (void)getDictionary:(NSDictionary *)myDictionary;//取得修改之后的商品数据

@end

//提交订单，所选商品
@interface OrderCommodityCell : UITableViewCell<MyStepperDelegate>

@property(nonatomic, assign) id<OrderCommodityCellDelegate> delegate;

@property(nonatomic, strong) UIImageView *commodityImageView;
@property(nonatomic, strong) UILabel *commodityTitle;
@property(nonatomic, strong) UILabel *commodityContent;
@property(nonatomic, strong) UILabel *commoditySize;
@property(nonatomic, strong) UILabel *commodityPrice;
@property(nonatomic, strong) MyStepper *myStepper;  //数值修改控件

@property(nonatomic, strong) NSMutableDictionary *myDictionary;  //商品数据

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
