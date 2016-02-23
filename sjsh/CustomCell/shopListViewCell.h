//
//  shopListViewCell.h
//  sjsh
//
//  Created by ce on 14-8-24.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopListViewCell : UITableViewCell

@property(nonatomic,retain) UILabel  *tipLabel;
@property(nonatomic,retain) UILabel  *decribeLabel;
@property(nonatomic,retain) UIImageView  *picImageView;
@property(nonatomic,retain) UIImageView  *lineImage;
@property(nonatomic,retain) UILabel  *smallLine;
@property(nonatomic,retain) UILabel  *originPriceLabel;
@property(nonatomic,retain) UILabel  *nowPriceLabel;
@property(nonatomic,retain) UILabel  *memberPriceLabel;
@end
