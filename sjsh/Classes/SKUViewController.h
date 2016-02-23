//
//  SKUViewController.h
//  sjsh
//  商品详情，规格选择页面
//  Created by 杜 计生 on 14-9-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
typedef enum dataSource {
    AddToCart = 0,
    onceBuy = 1,
    ModifyCart = 2
} DataSourceType;

@protocol SkuResultDelegate <NSObject>
@optional
- (void)transforEditResult:(NSDictionary *)dic;
- (void)enterNetPageForOrder;
- (void)refreashCartNum;
@end

@interface SKUViewController : UITempletViewController

@property (retain, nonatomic) NSDictionary *productDic;
@property (strong,nonatomic) IBOutlet UITableView* myTableView;
@property (retain, nonatomic) IBOutlet UILabel *numlabel;
@property (nonatomic, assign) DataSourceType type;
@property (retain, nonatomic) IBOutlet UIButton *addCartButton;
@property (retain, nonatomic) IBOutlet UIButton *buyButton;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIImageView *waveImage;
@property (nonatomic, assign) id<SkuResultDelegate>delegate;
- (IBAction)changeNum:(UIButton *)sender;
- (IBAction)tapToDismissed:(id)sender;
- (IBAction)addtoCar:(UIButton *)sender;
- (IBAction)goToPay:(UIButton *)sender;
@end
