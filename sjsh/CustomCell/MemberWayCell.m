//
//  MemberWayCell.m
//  sjsh
//
//  Created by savvy on 15/11/26.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MemberWayCell.h"
#import "Define.h"

@implementation MemberWayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.wayIco = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-30)/2, 30, 30)];
        self.wayIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.wayIco];
        
        self.wayTitle = [[UILabel alloc] initWithFrame:CGRectMake(58, self.wayIco.frame.origin.y, 100, 30)];
        self.wayTitle.font = [UIFont systemFontOfSize:14];
        self.wayTitle.textColor = fontGrayColor;
        [self.contentView addSubview:self.wayTitle];
 
        
        self.wayState = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-60, (60-30)/2, 50, 30)];
        self.wayState.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.wayState];
        
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 60-0.5, ScreenWidth-15, 0.5)];
        self.lineView.backgroundColor = lineGrayColor;
         [self.contentView addSubview:self.lineView];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)dic
{
    self.wayIco.image = [UIImage imageNamed:dic[@"payWayIcon"]];
    self.wayTitle.text = dic[@"payWayTitle"];
    
    
    
    if ([dic[@"payWayState"] integerValue]==0) {
        self.wayState.frame = CGRectMake(ScreenWidth-35, (60-15)/2, 15, 15);
        self.wayState.image = [UIImage imageNamed:@"icon_right_arrow"];
    }else if ([dic[@"payWayState"] integerValue]==1) {
        self.wayState.image = [UIImage imageNamed:@"icon_order_unselected"];
    }else{
        self.wayState.image = [UIImage imageNamed:@"icon_order_selected"];
    }
    
}

//更改显示状态
-(void)updateShow{
    self.lineView.hidden = YES;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
