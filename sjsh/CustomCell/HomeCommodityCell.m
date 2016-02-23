//
//  HomeCommodityCell.m
//  sjsh
//
//  Created by savvy on 15/10/19.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "HomeCommodityCell.h"
#import "Define.h"

@implementation HomeCommodityCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        int contentWidth = self.contentView.frame.size.width;
        int contentHeight = self.contentView.frame.size.height;
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, contentWidth, contentHeight)];
        [self.imageView setBackgroundColor:[UIColor orangeColor]];
[self.contentView addSubview:self.imageView];
      
 
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake( 8, contentHeight-40, contentWidth, 15)];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.textColor = fontGrayColor;
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake( 6, contentHeight-22, contentWidth, 15)];
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.priceLabel setTextColor:kRedColor];
        [self.contentView addSubview:self.priceLabel];
        
        CALayer *changeViewTopBorder=[[CALayer alloc]init];
        changeViewTopBorder.frame=CGRectMake(0, contentHeight-0.5, contentWidth, 0.5);
        changeViewTopBorder.backgroundColor=kGrayColor.CGColor;
        [self.contentView.layer addSublayer:changeViewTopBorder];
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
          name = [[myDictionary[@"com"] description] substringToIndex:12];
    }else{
        name = myDictionary[@"com"];
    }
    self.nameLabel.text = name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",myDictionary[@"price"]];
        
}



@end
