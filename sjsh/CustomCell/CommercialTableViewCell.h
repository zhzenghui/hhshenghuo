//
//  CommercialTableViewCell.h
//  sjsh
//
//  Created by ce on 14-8-7.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISBookStore_RatingView.h"

@interface CommercialTableViewCell : UITableViewCell{

}

@property (nonatomic, retain)  UIButton *iconButton;
@property (nonatomic, retain)  UILabel *titleLabel;
@property (nonatomic, retain)  UILabel *distanceLabel;
@property (nonatomic, retain)  UIImageView *tuanImageView;
@property (nonatomic, retain)  UILabel *tuanContentLabel;
@property (nonatomic, retain)  UILabel *pricelabel;
@property (retain, nonatomic)  UIButton *callButton;
@property (retain, nonatomic)  UIImageView *lineImage;
@property (nonatomic, retain)  ISBookStoreRatingView *ratingView;


@end
