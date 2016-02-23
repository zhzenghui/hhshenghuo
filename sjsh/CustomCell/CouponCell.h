//
//  CouponCell.h
//  sjsh
//
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell


@property(nonatomic, strong) UIImageView *backageView;//背景

@property(nonatomic, strong) UILabel *couponPriceLabel;
@property(nonatomic, strong) UILabel *couponNameLabel;
@property(nonatomic, strong) UILabel *couponContentLabel;
@property(nonatomic, strong) UILabel *couponDateLabel;
@property(nonatomic, strong) UIImageView *couponFlagImageView;//标记
@property(nonatomic, strong) UIImageView *lineView;




- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据
@end
