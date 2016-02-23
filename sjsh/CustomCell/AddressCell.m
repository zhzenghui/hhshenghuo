//
//  AddressCell.m
//  sjsh
//
//  Created by savvy on 15/11/17.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AddressCell.h"
#import "Define.h"

@implementation AddressCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 70, 15)];
        self.nameLabel.textColor = fontGrayColor;
        self.nameLabel.text = @"暂无";
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
        
        self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-165, 20, 150, 15)];
        self.phoneLabel.font = [UIFont systemFontOfSize:14];
        self.phoneLabel.text = @"暂无";
        self.phoneLabel.textColor = fontGrayColor;
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, ScreenWidth-40, 15)];
        self.addressLabel.font = [UIFont systemFontOfSize:14];
        self.addressLabel.text = @"暂无";
        self.addressLabel.textColor = fontDilutedGrayColor;
        [self.addressLabel setUserInteractionEnabled:NO];
        [self.contentView addSubview:self.addressLabel];
        
        
        CALayer *changeViewTopBorder=[[CALayer alloc]init];
        changeViewTopBorder.frame=CGRectMake(0, 70-1, ScreenWidth, 1);
        changeViewTopBorder.backgroundColor=lineGrayColor.CGColor;
        [self.contentView.layer addSublayer:changeViewTopBorder];
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    NSLog(@"地址cell数据：%@!!!!",myDictionary)

//    NSLog(@"是否默认：%@!!!!!!!!!!!",dic[@"default_id"]);
    self.nameLabel.text = myDictionary[@"firstname"];
    self.phoneLabel.text = myDictionary[@"mobile_num"];
    
    if ([myDictionary[@"default_id"] integerValue]==1) {
         NSMutableAttributedString *addressAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[默认]%@  %@",myDictionary[@"xiaoqu"],myDictionary[@"louhao"]]];
        [addressAttributedString addAttribute:NSForegroundColorAttributeName value:kRedColor range:NSMakeRange(0,4)];
        self.addressLabel.attributedText = addressAttributedString;
    }else{
    self.addressLabel.text = [NSString stringWithFormat:@"%@  %@",myDictionary[@"xiaoqu"],myDictionary[@"louhao"]];
    }

    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
