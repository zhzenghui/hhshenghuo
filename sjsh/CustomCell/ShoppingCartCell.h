//
//  ShoppingCartCell.h
//  sjsh
//
//  Created by savvy on 15/12/14.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStepper.h"

@protocol ShoppingCartCellDelegate<NSObject>

- (void)getDictionary:(NSDictionary *)myDictionary;//取得修改之后的商品数据

@end

@interface ShoppingCartCell : UITableViewCell<MyStepperDelegate>

@property(nonatomic, assign) id<ShoppingCartCellDelegate> delegate;

@property (strong,nonatomic)  UIImageView *topView;//顶部边距
@property (strong,nonatomic)  UIImageView *cartImageView;//图片
@property (strong,nonatomic)  UILabel *cartName;
//@property (strong,nonatomic)  UILabel *cartMember;//会员价钱
//@property (strong,nonatomic)  UIImageView *cartMemberImageView;//商品背景
@property (strong,nonatomic)  UILabel *cartPrice;//商品价钱
@property (strong,nonatomic)  UIImageView *lineView;
@property(nonatomic, strong) MyStepper *myStepper;  //数值修改控件
@property (strong,nonatomic)  UILabel *cartSpecification;//商品规格

@property(nonatomic, strong) NSMutableDictionary *myDictionary;  //商品数据
@property(nonatomic, assign) NSInteger position;  //cell位置

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
