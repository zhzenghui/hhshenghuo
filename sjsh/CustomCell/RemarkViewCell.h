//
//  RemarkViewCell.h
//  sjsh
//
//  Created by ce on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISBookStore_RatingView.h"
#import "RemarkData.h"

@interface RemarkViewCell : UITableViewCell

@property(nonatomic,retain) UILabel  *firstTitleLabel;
@property(nonatomic,retain) ISBookStoreRatingView *ratingView;
@property(nonatomic,retain) UILabel  *timeLabel;
@property(nonatomic,retain) UILabel  *remarkTextLabel;
@property(nonatomic,retain) UIScrollView *picScrollView;
@property(nonatomic,retain) NSDictionary *tempObject;
@property(nonatomic,retain) UIImageView  *lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andData:(NSDictionary *)remarkdata
;
@end
