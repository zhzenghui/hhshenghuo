//
//  HHShoppingCommodityCell.m
//  sjsh
//
//  Created by savvy on 16/1/20.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHShoppingCommodityCell.h"
#import "Define.h"

@implementation HHShoppingCommodityCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        int contentWidth = self.contentView.frame.size.width;
        int contentHeight = self.contentView.frame.size.height;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, contentWidth, contentHeight)];
//        [self.imageView setBackgroundColor:[UIColor whiteColor]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, contentHeight-55, contentWidth-25, 15)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.textColor = fontGrayColor;
//        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        self.nameLabel.numberOfLines = 0;//上面两行设置多行显示
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, contentHeight-30, contentWidth-100, 15)];
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.priceLabel setTextColor:[UIColor colorWithRed:250.0f/255.0f green:102.0f/255.0f blue:51.0f/255.0f alpha:1.0f]];
        [self.contentView addSubview:self.priceLabel];
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake( contentWidth-100, contentHeight-30, 85, 15)];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        self.numberLabel.textAlignment = NSTextAlignmentRight;
        [self.numberLabel setTextColor:fontDilutedGrayColor];
        self.numberLabel.text = @"已售0件";
        [self.contentView addSubview:self.numberLabel];
        
//        CALayer *changeViewTopBorder=[[CALayer alloc]init];
//        changeViewTopBorder.frame=CGRectMake(0, contentHeight-0.5, contentWidth, 0.5);
//        changeViewTopBorder.backgroundColor=kGrayColor.CGColor;
//        [self.contentView.layer addSublayer:changeViewTopBorder];
    }
    return self;
}
- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    //      [self.contentView setBackgroundColor:[UIColor greenColor]];
    
    
    NSLog(@"cell的数据为%@!!!!!!!!",myDictionary);
    [self.imageView setImageWithURL:[NSURL URLWithString:myDictionary[@"image"]]];
    //    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *name = nil;
    if ([myDictionary[@"com"] description].length>12 ) {
        name = [[myDictionary[@"com"] description] substringToIndex:9];
    }else{
        name = myDictionary[@"com"];
    }
    self.nameLabel.text = name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",myDictionary[@"price"]];
    
}



@end