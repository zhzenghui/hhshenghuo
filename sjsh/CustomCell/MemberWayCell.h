//
//  MemberWayCell.h
//  sjsh
//
//  Created by savvy on 15/11/26.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberWayCell : UITableViewCell

@property(nonatomic, strong) UIImageView *wayIco;
@property(nonatomic, strong) UILabel *wayTitle;
@property(nonatomic, strong) UIImageView *wayState;
@property(nonatomic, strong) UIView *lineView;

- (void)setCellInfo:(NSDictionary *)dic;
- (void)updateShow; //更改显示状态
@end
