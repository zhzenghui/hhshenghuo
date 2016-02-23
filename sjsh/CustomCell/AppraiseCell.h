//
//  AppraiseCell.h
//  sjsh
//  商品评价cell
//  Created by savvy on 15/11/19.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"

@interface AppraiseCell : UITableViewCell


@property(nonatomic, strong) UILabel *userNameLabel;
@property(nonatomic, strong) UILabel *appraiseDate;
@property(nonatomic, strong) DJQRateView *commodityGradeView;//商品评分控件
@property(nonatomic, strong) UILabel *sizeLabel;//规格
@property(nonatomic, strong) UILabel *appraiseContent;  //评价内容
@property(nonatomic, strong) UIScrollView *appraiseImageScroll;  //评价图片
@property(nonatomic, strong) UIView *lineView;




- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
