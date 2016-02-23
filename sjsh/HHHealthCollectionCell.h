//
//  HHHealthCollectionCell.h
//  sjsh
//
//  Created by savvy on 16/1/20.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHealthCollectionCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *icoImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, assign)UIView *lineView;
@property(nonatomic, assign)UIView *tagView;

- (void)setCellInfo:(NSDictionary *)dic;

@end
