//
//  SpecificationsCell.m
//  sjsh
//
//  Created by savvy on 15/11/30.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "SpecificationsCell.h"
#import "Define.h"

@implementation SpecificationsCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.contentView.backgroundColor = dilutedGrayColor;
        
        self.specificationsName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
        self.specificationsName.font = [UIFont systemFontOfSize:15];
        self.specificationsName.textColor = fontGrayColor;
        [self.contentView addSubview:self.specificationsName];
        
        self.specificationsPrice = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.5-10, 0, 100, 50)];
        self.specificationsPrice.font = [UIFont systemFontOfSize:14];
         self.specificationsPrice.text = @"0元";
        self.specificationsPrice.textColor = fontDilutedGrayColor;
        [self.contentView addSubview:self.specificationsPrice];
        
        self.specificationsState = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-40, 0, 25, 50)];
        self.specificationsState.image = [UIImage imageNamed:@"icon_commodity_unselect"];
        self.specificationsState.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.specificationsState];

        self.lineView = [[UILabel alloc] initWithFrame:CGRectMake(15, 50-0.5, ScreenWidth-15, 0.5)];
        self.lineView.backgroundColor = lineGrayColor;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    NSLog(@"商品规格cell%@!!!!!!!",myDictionary);
    
    self.specificationsName.text = myDictionary[@"name"];
    self.specificationsPrice.text = [NSString stringWithFormat:@"￥%@", myDictionary[@"price"] ];
  
    
    if ([myDictionary[@"selectFlag"] isEqualToString:@"1"]) {
        self.specificationsState.image = [UIImage imageNamed:@"icon_commodity_selected"];
        self.specificationsName.textColor = kGreenColor;
    }else{
    self.specificationsState.image = [UIImage imageNamed:@"icon_commodity_unselect"];
        self.specificationsName.textColor = fontGrayColor;
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
