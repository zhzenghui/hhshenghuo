//
//  AddressCell.h
//  sjsh
//
//  Created by savvy on 15/11/17.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell


@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *phoneLabel;
@property(nonatomic, strong) UILabel *addressLabel;

- (void)setCellInfo:(NSDictionary *)dic;

@end
