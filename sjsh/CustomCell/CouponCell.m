//
//  CouponCell.m
//  sjsh
//  优惠券cell
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CouponCell.h"
#import "Define.h"

@implementation CouponCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = dilutedGrayColor;
        
        self.backageView = [[UIImageView alloc] init];
        self.backageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.backageView.image = [UIImage imageNamed:@"backage_coupon_disable"];
//        self.backageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.backageView];
        
        self.couponPriceLabel = [[UILabel alloc] init];
        self.couponPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.couponPriceLabel.font = [UIFont systemFontOfSize:60];
        self.couponPriceLabel.text = @"￥0";
        self.couponPriceLabel.textColor = kRedColor;
        [self.backageView addSubview:self.couponPriceLabel];
        
        self.couponNameLabel = [[UILabel alloc] init];
        self.couponNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.couponNameLabel.font = [UIFont systemFontOfSize:14];
        self.couponNameLabel.text = @"暂无名称";
        self.couponNameLabel.textColor = fontGrayColor;
        [self.backageView addSubview:self.couponNameLabel];
        
        self.couponContentLabel = [[UILabel alloc] init];
        self.couponContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.couponContentLabel.font = [UIFont systemFontOfSize:14];
        self.couponContentLabel.text = @"暂无内容";
        self.couponContentLabel.textColor = fontGrayColor;
        [self.backageView addSubview:self.couponContentLabel];
        
        self.couponDateLabel = [[UILabel alloc] init];
        self.couponDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.couponDateLabel.font = [UIFont systemFontOfSize:12];
        self.couponDateLabel.text = @"暂无日期";
        self.couponDateLabel.textColor = fontGrayColor;
        self.couponDateLabel.textAlignment = NSTextAlignmentRight;
        [self.backageView addSubview:self.couponDateLabel];
        
        self.couponFlagImageView = [[UIImageView alloc] init];
        self.couponFlagImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.couponFlagImageView.image = [UIImage imageNamed:@"ico_coupon_used"];
         self.couponFlagImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.backageView addSubview:self.couponFlagImageView];

        
        self.lineView = [[UIImageView alloc] init];
        self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineView.image = [UIImage imageNamed:@"icon_order_line"];
        self.lineView.contentMode = UIViewContentModeScaleToFill;
        [self.backageView addSubview:self.lineView];
        
        [self initAutoLayout];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    
        NSLog(@"优惠券cell信息%@!!!!!!!",myDictionary);
    
    
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString:@"￥0"];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    self.couponPriceLabel.attributedText = orderStateAttributedString;
    
    if ([myDictionary[@"type"] integerValue]==1) {
        self.couponPriceLabel.textColor = kRedColor;
        self.couponNameLabel.textColor = fontGrayColor;
        self.couponContentLabel.textColor = fontGrayColor;
        self.couponDateLabel.textColor = fontGrayColor;
         self.couponFlagImageView.hidden = YES;
//        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backage_coupon_usable"]];
        self.backageView.image = [UIImage imageNamed:@"backage_coupon_usable"];
    }else{
        self.couponPriceLabel.textColor = fontDilutedGrayColor;
         self.couponNameLabel.textColor = fontDilutedGrayColor;
         self.couponContentLabel.textColor = fontDilutedGrayColor;
         self.couponDateLabel.textColor = fontDilutedGrayColor;
        self.couponFlagImageView.hidden = NO;
//    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backage_coupon_disable"]];
        self.backageView.image = [UIImage imageNamed:@"backage_coupon_disable"];
    }
    
 
     self.couponPriceLabel.text = [NSString stringWithFormat:@"%ld", (long)[myDictionary[@"total"]integerValue] ];
     self.couponNameLabel.text = myDictionary[@"name"];
    self.couponDateLabel.text = myDictionary[@"date_end"];
    
 
}

- (void)initAutoLayout{
    
    //背景
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.backageView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0
                                     constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.backageView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.0
                                     constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.backageView
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.0
                                     constant:-10]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.backageView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                     constant:0]];
    
    //背景内布局
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponPriceLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                     constant:-14]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponPriceLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:20.0]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponPriceLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:70]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponPriceLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:50]];
    
    //名称
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.couponPriceLabel
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:4]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:140]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:150]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:20]];
    
    //内容
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponContentLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:5]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponContentLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.couponNameLabel
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:0]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponContentLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:150]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponContentLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:20]];
    
    //分割线
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:-30]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:20]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.0
                                     constant:0]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:0.5]];
    
    //标记
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponFlagImageView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:-15]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponFlagImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:90]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponFlagImageView
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.0
                                     constant:-10]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponFlagImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:70]];
    
    //日期
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponDateLabel
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:-6]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponDateLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:200]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponDateLabel
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.0
                                     constant:-10]];
    [self.backageView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.couponDateLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.backageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:20]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
