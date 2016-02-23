//
//  HHShopCell.m
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHShopCell.h"
#import "Define.h"

@implementation HHShopCell

@synthesize tipLabel;
@synthesize decribeLabel;
@synthesize picImageView;
@synthesize nowPriceLabel;
@synthesize smallLine;
@synthesize originPriceLabel;
@synthesize lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(78+10.0f, 10, ScreenWidth-60-12, 35.0f)];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor colorWithRed:0x6d/255.0f green:0x6d/255.0f blue:0x6d/255.0f alpha:1];
        tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
        tipLabel.numberOfLines = 0;//上面两行设置多行显示
        tipLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:tipLabel];
        
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 68, 68)];
        [picImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:picImageView];
        
        
        //        self.decribeLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 35.0f, 140.0f, 35.0f)];
        //        decribeLabel.textAlignment = NSTextAlignmentLeft;
        //        decribeLabel.backgroundColor = [UIColor clearColor];
        //        decribeLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        //        decribeLabel.numberOfLines = 3;
        //        decribeLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
        //        [self addSubview:decribeLabel];
        //        [decribeLabel release];
        
        self.nowPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(78+10.0f, 60.0f, 160.0f, 20.0f)];
        nowPriceLabel.textAlignment = NSTextAlignmentLeft;
        nowPriceLabel.backgroundColor = [UIColor clearColor];
        nowPriceLabel.textColor = [UIColor colorWithRed:0xfa/255.0f green:0x63/255.0f blue:0x38/255.0f alpha:1];
        nowPriceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nowPriceLabel];
       
        
        
        
//        self.sellLabel  = [[UILabel alloc]initWithFrame:CGRectMake(78+10.0f, 60.0f, 100.0f, 20.0f)];
//        self.sellLabel.textAlignment = NSTextAlignmentLeft;
//        self.sellLabel.font = [UIFont systemFontOfSize:12];
//        self.sellLabel.textColor = lineGrayColor;
//        [self addSubview:self.sellLabel];
        
         self.addCartButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-60-12-25, 12.5+68-25, 25, 25)];
        [self.addCartButton setImage:[UIImage imageNamed:@"hh_shop_cart_yellow"] forState:UIControlStateNormal];
//        self.addCartButton.layer.cornerRadius = 8;
//        self.addCartButton.layer.masksToBounds = YES;
        //设置边框及边框颜色
//        self.addCartButton.layer.borderWidth = 0.5;
//        self.addCartButton.layer.borderColor =[ [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f] CGColor];
        [self.addCartButton addTarget:self action:@selector(buyCommodity) forControlEvents:UIControlEventTouchUpInside];
          [self addSubview:self.addCartButton];
        
        //        self.originPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(240.0f, 44.0f, 60.0f, 15.0f)];
        //        originPriceLabel.textAlignment = NSTextAlignmentRight;
        //        originPriceLabel.backgroundColor = [UIColor clearColor];
        //        originPriceLabel.textColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
        //        originPriceLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        //        [self addSubview:originPriceLabel];
        //        [originPriceLabel release];
        //
        //        self.smallLine = [[UILabel alloc] init];
        //        smallLine  = [[UILabel alloc]initWithFrame:CGRectMake(255.0f, 53.0f, 50.0f, 1.0f)];
        //        smallLine.textAlignment = NSTextAlignmentRight;
        //        smallLine.backgroundColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
        ////        smallLine.textColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
        //        smallLine.font = [UIFont fontWithName:@"Arial" size:14.0f];
        //        [self addSubview:smallLine];
        //        [smallLine release];
        
        lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 92.5, 228, 0.5)];
        [lineImage setBackgroundColor:[UIColor colorWithRed:0xdd/255. green:0xdd/255. blue:0xdd/255. alpha:1]];
        [self addSubview:lineImage];
        [lineImage release];
        
       
        
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark 控件代理方法
//修改商品数量
- (void)buyCommodity{
    NSLog(@"商品信息为%@！！！！！",self.myDictionary);
    if ([_delegate respondsToSelector:@selector(getDictionary:)]) {
        [_delegate getDictionary: self.myDictionary];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
