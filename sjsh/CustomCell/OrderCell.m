//
//  OrderCell.m
//  sjsh
//
//  Created by savvy on 15/11/10.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "OrderCell.h"
#import "Define.h"
//#import "AppraiseViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//我的订单列表cell
@implementation OrderCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
//       UIView *lineView00 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//        lineView00.backgroundColor = kRedColor;
//        [self.contentView addSubview:lineView00];
        
        self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
        self.shopNameLabel.font = [UIFont boldSystemFontOfSize:14];
        self.shopNameLabel.textColor = fontGrayColor;
        [self.contentView addSubview:self.shopNameLabel];
        
        self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-155, 0, 140, 40)];
        self.dataLabel.font = [UIFont systemFontOfSize:12];
        self.dataLabel.textAlignment = NSTextAlignmentRight;
         self.dataLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.dataLabel];

        
        self.lineView01 = [[UIView alloc] initWithFrame:CGRectMake(15, 40, ScreenWidth-15, 0.5)];
        self.lineView01.backgroundColor = kGrayColor;
        [self.contentView addSubview:self.lineView01];
        
        self.commodityScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, self.lineView01.frame.origin.y+self.lineView01.frame.size.height,  ScreenWidth-40, 70)];
        self.commodityScroll .contentSize = CGSizeMake(ScreenWidth, 100);
        self.commodityScroll.userInteractionEnabled = NO;
        [self.contentView addSubview:self.commodityScroll];
        
        self.finishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-87, 11, 75, 75)];
        self.finishImageView.image = [UIImage imageNamed:@"order_complete"];
        self.finishImageView.hidden = YES;
        [self.contentView addSubview:self.finishImageView];

        self.commodityName = [[UILabel alloc] initWithFrame:CGRectMake(90, self.lineView01.frame.origin.y+self.lineView01.frame.size.height, ScreenWidth-100, 70)];
        self.commodityName.font = [UIFont systemFontOfSize:12];
        self.commodityName.textColor = fontGrayColor;
        self.commodityName.lineBreakMode = NSLineBreakByWordWrapping;
        self.commodityName.numberOfLines = 0;//上面两行设置多行显示
         self.commodityName.userInteractionEnabled = NO;
        [self.contentView addSubview:self.commodityName];

        self.lineView02 = [[UIView alloc] initWithFrame:CGRectMake(15,  self.commodityScroll.frame.origin.y+self.commodityScroll.frame.size.height, ScreenWidth-15, 0.5)];
        self.lineView02.backgroundColor = kGrayColor;
        [self.contentView addSubview:self.lineView02];

        self.commodityNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.lineView02.frame.origin.y+self.lineView02.frame.size.height+5, 100, 15)];
        self.commodityNumberLabel.font = [UIFont systemFontOfSize:12];
        self.commodityNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.commodityNumberLabel];

        self.commodityMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.commodityNumberLabel.frame.origin.y+self.commodityNumberLabel.frame.size.height+5, 100, 15)];
        self.commodityMoneyLabel.textColor = kRedColor;
        self.commodityMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:self.commodityMoneyLabel];

        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-70*2-10-15, self.lineView02.frame.origin.y+self.lineView02.frame.size.height+10, 70, 35)];
        self.deleteButton.tag = 198801;
        self.deleteButton.hidden = YES;
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.deleteButton.layer.borderWidth = 1;
        self.deleteButton.layer.borderColor = [kRedColor CGColor];
        self.deleteButton.clipsToBounds = YES;
        self.deleteButton.layer.cornerRadius = 5;
         [self.deleteButton setTitleColor:kRedColor forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize: 12.0];
          [self.deleteButton addTarget:self action:@selector(operateOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteButton];
        
        self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-70*1-15, self.lineView02.frame.origin.y+self.lineView02.frame.size.height+10, 70, 35)];
        self.submitButton.tag = 198802;
        self.submitButton.hidden = YES;
        self.submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.submitButton.layer.borderWidth = 1;
        self.submitButton.layer.borderColor = [kGreenColor CGColor];
        self.submitButton.clipsToBounds = YES;
        self.submitButton.layer.cornerRadius = 5;
        [self.submitButton setTitleColor:kGreenColor forState:UIControlStateNormal];
         self.submitButton.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [self.submitButton addTarget:self action:@selector(operateOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.submitButton];
        
        UIView *lineView03 = [[UIView alloc] initWithFrame:CGRectMake(0, 176-10, ScreenWidth, 10)];
        lineView03.backgroundColor = dilutedGrayColor;
        [self.contentView addSubview:lineView03];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    
    NSLog(@"订单cell:%@!!!!!!!",myDictionary);
    
    self.orderDictionary =  [myDictionary mutableCopy];

    
    self.shopNameLabel.text= [myDictionary objectForKey:@"shop_name"];
    self.dataLabel.text= [myDictionary objectForKey:@"date_added"];
    self.commodityName.text=[myDictionary objectForKey:@"products"][0][@"name"];
     self.commodityNumberLabel.text= [NSString stringWithFormat:@"共%lu件商品",(unsigned long)[[myDictionary objectForKey:@"products"] count]];
//     self.commodityMoneyLabel.text= [NSString stringWithFormat:@"实付款 ￥%lu",(unsigned long)[[myDictionary objectForKey:@"order_total"] integerValue]];
    
    NSMutableAttributedString *commodityMoneyAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款 ￥%lu",(unsigned long)[[myDictionary objectForKey:@"order_total"] integerValue]]];
    [commodityMoneyAttributedString addAttribute:NSForegroundColorAttributeName value:fontGrayColor range:NSMakeRange(0,3)];
    [commodityMoneyAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 3)];
    self.commodityMoneyLabel.attributedText = commodityMoneyAttributedString;
    
    
    [self updateScrollView:[myDictionary objectForKey:@"products"]];
    if ([[myDictionary objectForKey:@"products"] count]>1) {
        self.commodityName.hidden = YES;
    }
    
    
    //根据订状态显示不同样式
    switch ([[myDictionary objectForKey:@"order_status_id"] integerValue]) {
        case 1://待处理
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        case 5://完成
             self.finishImageView.hidden = NO;
            self.deleteButton.hidden = NO;
             self.deleteButton.tag = 198801;
            [self.deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
            self.submitButton.hidden = NO;
             self.submitButton.tag = 198802;
             [self.submitButton setTitle:@"评价晒单" forState:UIControlStateNormal];
            break;
        case 9://取消恢复
            break;
        case 10://已关闭
            self.deleteButton.hidden = NO;
            self.deleteButton.tag = 198801;
            [self.deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
            self.submitButton.hidden = YES;
            break;
        case 11://已退款
             self.deleteButton.hidden = YES;
             self.submitButton.hidden = YES;
            break;
        case 15://已发货
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        case 17://待发货
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        case 18://待付款
            self.deleteButton.hidden = NO;
            self.submitButton.hidden = NO;
            [self.deleteButton setTitle:@"取消订单" forState:UIControlStateNormal];
            self.deleteButton.tag = 198803;
            [self.submitButton setTitle:@"去付款" forState:UIControlStateNormal];
            self.submitButton.tag = 198804;
            break;
        case 20://打回订单
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        case 22://已付款
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        default:
            break;
    }
}

- (void) updateScrollView:(NSArray *) myArray{

    for (int i=0; i<myArray.count; i++) {
        
        NSDictionary *myDictionary = myArray[i];
        
        UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*70, 10, 70, 50)];
        NSString *imageUrl = [NSString stringWithFormat:@"%@",myDictionary[@"image"]];
        myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [myImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        [self.commodityScroll addSubview:myImageView];
    }
 
}

//操作订单
-(void)operateOrder:(UIButton *)myButton{
    
    
    self.orderDictionary[@"type"] = [NSNumber numberWithInteger:myButton.tag-198800];
 
    
    if ([_delegate respondsToSelector:@selector(operateOrder:)]) {
        [_delegate operateOrder:self.orderDictionary];
    }
}

//跳转到评价页
-(void)goAppraise{
     
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
