//
//  SpecificationsCell.h
//  sjsh
//  商品的规格cell
//  Created by savvy on 15/11/30.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecificationsCell : UITableViewCell


@property (strong,nonatomic)  UILabel *specificationsName;
@property (strong,nonatomic)  UILabel *specificationsPrice;//商品价钱
@property (strong,nonatomic)  UIImageView *specificationsState;//箭头
@property (strong,nonatomic)  UIView *lineView;

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
