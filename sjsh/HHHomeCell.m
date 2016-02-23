//
//  HHHomeCell.m
//  sjsh
//  淮海生活，首页列表cell
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHHomeCell.h"
#import "Define.h"

@implementation HHHomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.homeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 35, 75)];
        self.homeIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.homeIcon];
 
        self.homeTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 20,150, 15)];
        self.homeTitle.font = [UIFont systemFontOfSize:14];
        self.homeTitle.textColor = fontGrayColor;
        [self.contentView addSubview:self.homeTitle];
        
        self.homeContent = [[UILabel alloc] initWithFrame:CGRectMake(80, 70-30, 250, 15)];
        self.homeContent.font = [UIFont systemFontOfSize:12];
        self.homeContent.textColor = fontDilutedGrayColor;
        [self.contentView addSubview:self.homeContent];
 
        
        self.homeFlagView = [[UIView alloc] init];
        self.homeFlagView.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
        //设置圆角边框
        self.homeFlagView.layer.cornerRadius = 3.5;
        self.homeFlagView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.homeFlagView];
        
        
        
        self.homeLookCountLabel = [[UILabel alloc] init];
        self.homeLookCountLabel.font = [UIFont systemFontOfSize:14];
        self.homeLookCountLabel.textColor = fontDilutedGrayColor;
        self.homeLookCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.homeLookCountLabel];
        
        self.homeApproveCountLabel = [[UILabel alloc] init];
        self.homeApproveCountLabel.font = [UIFont systemFontOfSize:14];
        self.homeApproveCountLabel.textColor = fontDilutedGrayColor;
        self.homeApproveCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.homeApproveCountLabel];
        
        
        self.homeLookImageView = [[UIImageView alloc] init];
        self.homeLookImageView.image = [UIImage imageNamed:@"hh_ico_home_look"];
        self.homeLookImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.homeLookImageView];
        
        self.homeApproveImageView = [[UIImageView alloc] init];
        self.homeApproveImageView.image = [UIImage imageNamed:@"hh_ico_home_approve"];
        self.homeApproveImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.homeApproveImageView];
        
        
        self.homeLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75-0.5, ScreenWidth, 0.5)];
        self.homeLine.image = [UIImage imageNamed:@"backage_line"];
//        self.homeLookImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.homeLine];
        
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"首页列表%@!!!!!!!",myDictionary);
    
    
     self.homeIcon.image = [UIImage imageNamed:[myDictionary objectForKey:@"ico"]];
    self.homeTitle.text= [myDictionary objectForKey:@"title"];
     self.homeContent.text= [myDictionary objectForKey:@"content"];
     self.homeLookCountLabel.text= [myDictionary objectForKey:@"count01"];
    self.homeApproveCountLabel.text= [myDictionary objectForKey:@"count02"];
    
    NSUInteger homeApproveCountLength = ((NSString *)[myDictionary objectForKey:@"count02"]).length;
     NSUInteger homeLookCountLength = ((NSString *)[myDictionary objectForKey:@"count01"]).length;
     NSUInteger homeTitleLength = ((NSString *)[myDictionary objectForKey:@"title"]).length;
    
    NSLog(@"长度为%lu和%lu和%lu!!!!!!!!",(unsigned long)homeTitleLength,(unsigned long)homeApproveCountLength,(unsigned long)homeLookCountLength);
    
    
    int stringUnit = 9;
    int stringUnitWithText = 15;
    float orginY = 20.0;
    self.homeApproveCountLabel.frame = CGRectMake(ScreenWidth-homeApproveCountLength*stringUnit-20, orginY, homeApproveCountLength*stringUnit, 15);
    self.homeApproveImageView.frame = CGRectMake(self.homeApproveCountLabel.frame.origin.x-15, orginY, 15, 15);
    
    
     self.homeLookCountLabel.frame = CGRectMake(self.homeApproveImageView.frame.origin.x-homeLookCountLength*stringUnit-15, orginY, homeLookCountLength*stringUnit, 15);
    self.homeLookImageView.frame = CGRectMake(self.homeLookCountLabel.frame.origin.x-15, orginY, 15, 15);
    
    if ([[myDictionary objectForKey:@"flag"] integerValue]==1) {
        self.contentView.backgroundColor = dilutedGrayColor;
    }
    
    
     self.homeFlagView.frame = CGRectMake(80+stringUnitWithText*homeTitleLength, self.homeTitle.frame.origin.y+(self.homeTitle.frame.size.height-7)*0.5, 7, 7);
    
    
//    NSString *imageUrl = [productDic objectForKey:@"thumb"];
//    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [self.cartImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    
    
}


@end
