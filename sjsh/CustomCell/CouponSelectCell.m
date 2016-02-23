//
//  CouponSelectCell.m
//  sjsh
//
//  Created by savvy on 15/11/2.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CouponSelectCell.h"
#import "Define.h"

@implementation CouponSelectCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.wayTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 15)];
        self.wayTitle.font = [UIFont systemFontOfSize:14];
        self.wayTitle.textColor = fontGrayColor;
        [self.contentView addSubview:self.wayTitle];
        
        self.wayContent = [[UILabel alloc] initWithFrame:CGRectMake(15, self.contentView.frame.size.height-20, 200, 15)];
        self.wayContent.font = [UIFont systemFontOfSize:12];
        self.wayContent.textColor = fontGrayColor;
        [self.contentView addSubview:self.wayContent];
        
        self.wayState = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-80, (self.contentView.frame.size.height-30)/2, 50, 30)];
        self.wayState.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.wayState];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)dic
{
    
    self.wayTitle.text = dic[@"name"];
    self.wayContent.text = dic[@"discount"];
    
    if ([dic[@"selectState"] integerValue]==1) {
        self.wayState.image = [UIImage imageNamed:@"icon_order_unselected"];
    }else{
        self.wayState.image = [UIImage imageNamed:@"icon_order_selected"];
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