//
//  HHHomeCell.h
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHomeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *homeIcon;
@property (nonatomic, strong) UILabel *homeTitle;
@property (nonatomic, strong) UILabel *homeContent;
@property (nonatomic, strong) UIView *homeFlagView;

@property (nonatomic, strong) UIImageView *homeLookImageView;
@property (nonatomic, strong) UIImageView *homeApproveImageView;
@property (nonatomic, strong) UILabel *homeLookCountLabel;
@property (nonatomic, strong) UILabel *homeApproveCountLabel;

@property (nonatomic, strong) UIImageView *homeLine;

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
