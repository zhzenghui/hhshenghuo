//
//  HomeCategoryCell.h
//  sjsh
//
//  Created by savvy on 15/10/18.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface HomeCategoryCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleView;
@property(nonatomic, strong) UILabel *contentView01;
@property(nonatomic, strong) UILabel *contentView02;

@property(nonatomic, assign) int type;//cell 样式


- (void)setCellInfo:(NSDictionary *)dic;
@end
