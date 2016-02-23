//
//  ShoppingCartTableViewCell.h
//  sjsh
//
//  Created by 杜 计生 on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingCartCellDelegate <NSObject>

- (void)transforSelectResult:(NSInteger)itemId select:(BOOL)select;
- (void)transforEditTap:(NSInteger)itemId;
@end
@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, assign) id<ShoppingCartCellDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIImageView *myLine;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (retain, nonatomic) IBOutlet UILabel *skuLabel;
@property (retain, nonatomic) IBOutlet UILabel *numLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iconImageview;
@property (retain, nonatomic) IBOutlet UIButton *selectButton;
@property (retain, nonatomic) IBOutlet UIButton *editButton;
- (IBAction)selectedTapped:(UIButton *)sender;
- (IBAction)editButtonTapped:(UIButton *)sender;
@end
