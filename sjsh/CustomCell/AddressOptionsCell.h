//
//  AddressOptionsCell.h
//  sjsh
//
//  Created by savvy on 15/11/24.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

//地址选项的cell
@interface AddressOptionsCell : UICollectionViewCell

@property(nonatomic, strong)UILabel *nameLabel;

- (void)setCellInfo:(NSDictionary *)dic;

@end
