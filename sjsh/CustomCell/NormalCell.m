//
//  NormalCell.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "NormalCell.h"
#import "Define.h"
@implementation NormalCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, MRScreenWidth - 150, 50)];
        self.valueLabel.font = [UIFont systemFontOfSize:14];
        self.valueLabel.textColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:1];
        self.valueLabel.textAlignment = NSTextAlignmentRight;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.valueLabel];
        
    }
    return self;
}
@end
