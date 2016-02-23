//
//  MemberAccountCell.h
//  sjsh
//  会员消费流水
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberAccountCell : UITableViewCell


@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *numberLabel;

- (void)setCellInfo:(NSDictionary *)dic;

@end
