//
//  CommercialTableViewCell.m
//  sjsh
//
//  Created by ce on 14-8-7.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CommercialTableViewCell.h"
#import "Define.h"

@implementation CommercialTableViewCell

@synthesize iconButton;
@synthesize distanceLabel;
@synthesize titleLabel;
@synthesize tuanImageView;
@synthesize pricelabel;
@synthesize tuanContentLabel;
@synthesize callButton;
@synthesize ratingView;
@synthesize lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        iconButton = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 12.0f, 64.0f, 64.0f)];
////        [smallImageView setImage:[UIImage imageNamed:@"cellBackground"]];
//        iconView.backgroundColor = [UIColor clearColor];
//        [self addSubview:iconView];
//        [iconView release];
        [self setBackgroundColor:[UIColor colorWithRed:240./255. green:240./255. blue:240./255. alpha:1]];
        self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [iconButton setFrame:CGRectMake(15.0f, 12.0f, 64.0f, 64.0f)];
//        [iconButton setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
//        iconButton.showsTouchWhenHighlighted = YES;
        iconButton.backgroundColor = [UIColor clearColor];
        [self addSubview:iconButton];
        
        self.titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setFrame:CGRectMake(94, 16, 139, 18)];
        [titleLabel setFont:kFontArial14];
        [titleLabel setTextColor:COLOR(64, 64, 64)];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        self.ratingView = [[ISBookStoreRatingView alloc] init];
        [ratingView setFrame:CGRectMake(94, 38, 139, 12)];
        [ratingView setBackgroundColor:[UIColor clearColor]];
        [ratingView setImagesDeselected:@"" partlySelected:nil fullSelected:@"star" andDelegate:nil];
        ratingView.userInteractionEnabled = NO;

        [self addSubview:ratingView];
//        [ratingView release];
        
        self.distanceLabel = [[UILabel alloc] init];
        distanceLabel.backgroundColor = [UIColor clearColor];
        [distanceLabel setFrame:CGRectMake(94, 56, 139, 16)];
        [distanceLabel setFont:kFontArial10];
        [distanceLabel setTextColor:[UIColor colorWithRed:0xa0/255. green:0xa0/255. blue:0xa0/255. alpha:1]];
        [self addSubview:distanceLabel];
        [distanceLabel release];
        
        self.callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [callButton setFrame:CGRectMake(251, 19, 50, 50)];
        [callButton setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
        callButton.showsTouchWhenHighlighted = YES;
        callButton.backgroundColor = [UIColor clearColor];
        [self addSubview:callButton];
        
        self.tuanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 85.0f, 290.0f, 28.0f)];
        tuanImageView.backgroundColor = [UIColor clearColor];
        [tuanImageView setImage:[UIImage imageNamed:@"tuanBack"]];
        [self addSubview:tuanImageView];
        [tuanImageView release];
        
        self.tuanContentLabel = [[UILabel alloc] init];
        tuanContentLabel.backgroundColor = [UIColor clearColor];
        [tuanContentLabel setFrame:CGRectMake(35, 7, 200, 15)];
        [tuanContentLabel setFont:kFontArial14];
        [tuanContentLabel setTextColor:[UIColor whiteColor]];
        [tuanImageView addSubview:tuanContentLabel];
        [tuanContentLabel release];

        self.pricelabel = [[UILabel alloc] init];
        pricelabel.backgroundColor = [UIColor clearColor];
        [pricelabel setFrame:CGRectMake(230, 7, 55, 15)];
        [pricelabel setFont:kFontArial14];
         pricelabel.adjustsFontSizeToFitWidth = YES;
        [pricelabel setTextColor:[UIColor whiteColor]];
        [tuanImageView addSubview:pricelabel];
        [pricelabel release];

         self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 124, 290, 1)];
        [lineImage setBackgroundColor:[UIColor colorWithRed:0xdc/255. green:0xdc/255. blue:0xdc/255. alpha:1]];
        [self addSubview:lineImage];
        [lineImage release];
//        itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.0f, 8.0f, 60.0f, 60.0f)];
//        itemImageView.backgroundColor = [UIColor clearColor];
//        [self addSubview:itemImageView];
//        [itemImageView release];
//
//        mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 20.0f, 130.0f, 15.0f)];
//        mainTitleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
//        mainTitleLabel.textAlignment = NSTextAlignmentLeft;
//        mainTitleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
//        mainTitleLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:mainTitleLabel];
//        [mainTitleLabel release];
//        
//        secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 40.0f, 164.0f, 13.0f)];
//        secondTitleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//        secondTitleLabel.textAlignment = NSTextAlignmentLeft;
//        secondTitleLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1.0f];
//        secondTitleLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:secondTitleLabel];
//        [secondTitleLabel release];
//        
//        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [addButton setFrame:CGRectMake(320-69, 11, 50, 50)];
//        [self addSubview:addButton];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
