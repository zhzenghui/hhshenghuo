//
//  shopListViewCell.m
//  sjsh
//
//  Created by ce on 14-8-24.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "shopListViewCell.h"
#import "Define.h"

@implementation shopListViewCell
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
        
        self.tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 14.0f, 160.0f, 15.0f)];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor colorWithRed:0x6d/255.0f green:0x6d/255.0f blue:0x6d/255.0f alpha:1];
        tipLabel.numberOfLines = 2;
        tipLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:tipLabel];
        [tipLabel release];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 64, 64)];
        [picImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:picImageView];
        [picImageView release];
        
//        self.decribeLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 35.0f, 140.0f, 35.0f)];
//        decribeLabel.textAlignment = NSTextAlignmentLeft;
//        decribeLabel.backgroundColor = [UIColor clearColor];
//        decribeLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
//        decribeLabel.numberOfLines = 3;
//        decribeLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
//        [self addSubview:decribeLabel];
//        [decribeLabel release];
        
        self.nowPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 30.0f, 160.0f, 15.0f)];
        nowPriceLabel.textAlignment = NSTextAlignmentLeft;
        nowPriceLabel.backgroundColor = [UIColor clearColor];
        nowPriceLabel.textColor = [UIColor colorWithRed:0xfa/255.0f green:0x63/255.0f blue:0x38/255.0f alpha:1];
        nowPriceLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:nowPriceLabel];
        [nowPriceLabel release];
        
        
        
        self.memberPriceLabel  = [[UILabel alloc]initWithFrame:CGRectMake(94.0f, 50.0f, 120.0f, 20.0f)];
        self.memberPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.memberPriceLabel.backgroundColor = [UIColor clearColor];
        self.memberPriceLabel.font = [UIFont systemFontOfSize:14];
        self.memberPriceLabel.backgroundColor = kRedColor;
        self.memberPriceLabel.textColor = [UIColor whiteColor];
        self.memberPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.memberPriceLabel.layer.cornerRadius = 3;
        self.memberPriceLabel.layer.masksToBounds = YES;

        [self addSubview:self.memberPriceLabel];
        
        
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
        
        lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 83, 228, 1)];
        [lineImage setBackgroundColor:[UIColor colorWithRed:0xdd/255. green:0xdd/255. blue:0xdd/255. alpha:1]];
        [self addSubview:lineImage];
        [lineImage release];

        
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
