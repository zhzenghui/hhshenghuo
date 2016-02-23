//
//  OrderCell.h
//  sjsh
//
//  Created by savvy on 15/11/10.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderOperateDelegate<NSObject>
- (void)operateOrder:(NSDictionary *)myDictionary;
@end


@interface OrderCell : UITableViewCell

@property(nonatomic, assign) id<OrderOperateDelegate> delegate;

@property(nonatomic, strong) UILabel *shopNameLabel;
@property(nonatomic, strong) UILabel *dataLabel;
@property(nonatomic, strong) UIView *lineView01;
@property(nonatomic, strong) UIImageView *finishImageView;
@property(nonatomic, strong) UIScrollView *commodityScroll;
@property(nonatomic, strong) UILabel *commodityName;
@property(nonatomic, strong) UIView *lineView02;
@property(nonatomic, strong) UILabel *commodityNumberLabel;
@property(nonatomic, strong) UILabel *commodityMoneyLabel;
@property(nonatomic, strong) UIButton *deleteButton;
@property(nonatomic, strong) UIButton *submitButton;

@property(nonatomic, strong) NSMutableDictionary *orderDictionary;

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
