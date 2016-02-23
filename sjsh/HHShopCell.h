//
//  HHShopCell.h
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHShopCellDelegate<NSObject>

- (void)getDictionary:(NSDictionary *)myDictionary;//取得修改之后的商品数据

@end

@interface HHShopCell : UITableViewCell

@property(nonatomic, assign) id<HHShopCellDelegate> delegate;

@property(nonatomic,strong) UILabel  *tipLabel;
@property(nonatomic,strong) UILabel  *decribeLabel;
@property(nonatomic,strong) UIImageView  *picImageView;
@property(nonatomic,strong) UIImageView  *lineImage;
@property(nonatomic,strong) UILabel  *smallLine;
@property(nonatomic,strong) UILabel  *originPriceLabel;
@property(nonatomic,strong) UILabel  *nowPriceLabel;

@property(nonatomic,strong) NSDictionary  *myDictionary;
//@property(nonatomic,strong) UILabel  *sellLabel;

@property(nonatomic,strong) UIButton  *addCartButton;//加入购物车

@end
