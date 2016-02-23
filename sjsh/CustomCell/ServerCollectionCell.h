//
//  ServerCollectionCell.h
//  sjsh
//
//  Created by savvy on 15/11/5.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

//首页服务Cell
@interface ServerCollectionCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *icoImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, assign)UIImageView *markImageView;


- (void)setCellInfo:(NSDictionary *)dic;
@end
