//
//  HHSpecificationsCell.h
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSpecificationsCell : UITableViewCell

@property (strong,nonatomic)  UILabel *specificationsTitle;//规格标题
@property (strong,nonatomic)  UILabel *specificationsName;
@property (strong,nonatomic)  UIImageView *specificationsState;//箭头
@property (strong,nonatomic)  UIView *lineView;

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
