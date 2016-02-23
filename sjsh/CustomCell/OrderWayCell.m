//
//  OrderWayCell.m
//  sjsh
//
//  Created by savvy on 15/10/22.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "OrderWayCell.h"
#import "Define.h"

@implementation OrderWayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.wayIco = [[UIImageView alloc] initWithFrame:CGRectMake(10, (60-30)/2, 30, 30)];
        self.wayIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.wayIco];
        
        self.wayTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, self.wayIco.frame.origin.y, 100, 15)];
        self.wayTitle.font = [UIFont systemFontOfSize:14];
        self.wayTitle.textColor = fontGrayColor;
        [self.contentView addSubview:self.wayTitle];
        
        self.wayContent = [[UILabel alloc] initWithFrame:CGRectMake(50, self.wayTitle.frame.origin.y+self.wayTitle.frame.size.height, 200, 15)];
         self.wayContent.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.wayContent];
        
        self.wayState = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-60, (60-30)/2, 50, 30)];
        self.wayState.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.wayState];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)dic
{
    self.wayIco.image = [UIImage imageNamed:dic[@"payWayIcon"]];
    self.wayTitle.text = dic[@"payWayTitle"];
     self.wayContent.text = dic[@"payWayContent"];
    
    
    if ([dic[@"payWayState"] integerValue]==0) {
        self.wayState.frame = CGRectMake(ScreenWidth-35, (60-15)/2, 15, 15);
         self.wayState.image = [UIImage imageNamed:@"icon_right_arrow"];
    }else if ([dic[@"payWayState"] integerValue]==1) {
        self.wayState.frame = CGRectMake(ScreenWidth-40, (60-25)/2, 25, 25);
     self.wayState.image = [UIImage imageNamed:@"icon_order_unselected"];
    }else{
        self.wayState.frame = CGRectMake(ScreenWidth-40, (60-25)/2, 25, 25);
    self.wayState.image = [UIImage imageNamed:@"hh_icon_order_select"];
    }
    
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
