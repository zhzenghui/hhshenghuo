//
//  HomeCommodityCell.h
//  sjsh
//
//  Created by savvy on 15/10/19.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface HomeCommodityCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *priceLabel;
- (void)setCellInfo:(NSDictionary *)dic;

@end
