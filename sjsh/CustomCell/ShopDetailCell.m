//
//  ShopDetailCell.m
//  sjsh
//
//  Created by ce on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ShopDetailCell.h"

@implementation ShopDetailCell
@synthesize imageViews;
@synthesize priceLabel;
@synthesize productNameLabel;
@synthesize buyButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.productNameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(140.0f, 14.0f, 126.0f, 27.0f)];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        productNameLabel.backgroundColor = [UIColor clearColor];
        productNameLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
        productNameLabel.numberOfLines = 2;
        productNameLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:productNameLabel];
        [productNameLabel release];
        
        self.imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 100)];
        [imageViews setBackgroundColor:[UIColor clearColor]];
        [self addSubview:imageViews];
        [imageViews release];
        
        self.priceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(140.0f, 48.0f, 140.0f, 15.0f)];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor colorWithRed:0xff/255.0f green:0x42/255.0f blue:0x6e/255.0f alpha:1];
        priceLabel.numberOfLines = 3;
        priceLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:priceLabel];
        [priceLabel release];
        
        self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyButton setBackgroundImage:[UIImage imageNamed:@"buyButton"] forState:UIControlStateNormal];
        [buyButton setFrame:CGRectMake(140, 68, 100, 30)];
        [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [buyButton setTintColor:[UIColor whiteColor]];
        [self addSubview:buyButton];
//        self.nowPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(250.0f, 16.0f, 50.0f, 19.0f)];
//        nowPriceLabel.textAlignment = NSTextAlignmentRight;
//        nowPriceLabel.backgroundColor = [UIColor clearColor];
//        nowPriceLabel.textColor = [UIColor colorWithRed:0xff/255.0f green:0x42/255.0f blue:0x6e/255.0f alpha:1];
//        nowPriceLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
//        [self addSubview:nowPriceLabel];
//        [nowPriceLabel release];
//        
//        self.originPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(250.0f, 44.0f, 50.0f, 15.0f)];
//        originPriceLabel.textAlignment = NSTextAlignmentRight;
//        originPriceLabel.backgroundColor = [UIColor clearColor];
//        originPriceLabel.textColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
//        originPriceLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
//        [self addSubview:originPriceLabel];
//        [originPriceLabel release];
//        
//        UILabel *smallLine = [[UILabel alloc] init];
//        smallLine  = [[UILabel alloc]initWithFrame:CGRectMake(265.0f, 53.0f, 40.0f, 1.0f)];
//        smallLine.textAlignment = NSTextAlignmentRight;
//        smallLine.backgroundColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
//        //        smallLine.textColor = [UIColor colorWithRed:0x99/255.0f green:0x99/255.0f blue:0x99/255.0f alpha:1];
//        smallLine.font = [UIFont fontWithName:@"Arial" size:14.0f];
//        [self addSubview:smallLine];
//        [smallLine release];
//        
//        lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 83, 290, 1)];
//        [lineImage setBackgroundColor:[UIColor colorWithRed:0xdc/255. green:0xdc/255. blue:0xdc/255. alpha:1]];
//        [self addSubview:lineImage];
//        [lineImage release];
        
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
