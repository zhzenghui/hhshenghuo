//
//  CouponSelectCell.h
//  sjsh
//
//  Created by savvy on 15/11/2.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponSelectCell : UITableViewCell

@property(nonatomic, strong) UIImageView *wayIco;
@property(nonatomic, strong) UILabel *wayTitle;
@property(nonatomic, strong) UILabel *wayContent;
@property(nonatomic, strong) UIImageView *wayState;

- (void)setCellInfo:(NSDictionary *)dic;

@end
