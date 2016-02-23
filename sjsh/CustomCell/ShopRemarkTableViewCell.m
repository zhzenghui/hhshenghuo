//
//  ShopRemarkTableViewCell.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/22.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ShopRemarkTableViewCell.h"

@implementation ShopRemarkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 18)];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+110, 10, MRScreenWidth - 40-110, 18)];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:1];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.timeLabel];
        
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, MRScreenWidth - 40, 40)];
        self.valueLabel.font = [UIFont systemFontOfSize:14];
        self.valueLabel.textColor = [UIColor colorWithRed:0x78 / 255.0 green:0x78 / 255.0 blue:0x78 / 255.0 alpha:1];
        self.valueLabel.numberOfLines = 2;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.valueLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
