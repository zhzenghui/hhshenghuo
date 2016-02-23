//
//  HHAddressCell.h
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAddressCell : UITableViewCell

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *phoneLabel;
@property(nonatomic, strong) UILabel *addressLabel;

- (void)setCellInfo:(NSDictionary *)dic;

@end
