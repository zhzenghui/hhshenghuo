//
//  HHShoppingCategoryCell.h
//  sjsh
//
//  Created by savvy on 16/1/20.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHShoppingCategoryCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleView;
//@property(nonatomic, strong) UILabel *contentView01;
//@property(nonatomic, strong) UILabel *contentView02;

//@property(nonatomic, assign) int type;//cell 样式
@property(nonatomic, assign) int position;//位置

- (void)setCellInfo:(NSDictionary *)dic;

@end
