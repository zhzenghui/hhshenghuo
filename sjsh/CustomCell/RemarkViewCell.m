//
//  RemarkViewCell.m
//  sjsh
//
//  Created by ce on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "RemarkViewCell.h"

@implementation RemarkViewCell
@synthesize firstTitleLabel;
@synthesize ratingView;
@synthesize timeLabel;
@synthesize remarkTextLabel;
@synthesize picScrollView;
@synthesize tempObject;
@synthesize lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (tempObject) {
            [tempObject release];
            tempObject = nil;
        }
        
//        tempObject = [remarkdata retain];
        
//        if([[tempObject objectForKey:@"images"] count]>0){
//        if([[tempObject objectForKey:@"images"] isEqualToString:@""]){
//            //有图
//            
//            
//        }else{
        
                //没有图
            
                self.firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 14.0f, 140.0f, 15.0f)];
                firstTitleLabel.textAlignment = NSTextAlignmentLeft;
                firstTitleLabel.backgroundColor = [UIColor clearColor];
                firstTitleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
                firstTitleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
                [self addSubview:firstTitleLabel];
                [firstTitleLabel release];
                
                self.ratingView = [[ISBookStoreRatingView alloc] init];
                [ratingView setFrame:CGRectMake(20, 38, 139, 12)];
                [ratingView setBackgroundColor:[UIColor clearColor]];
                [ratingView setImagesDeselected:@"" partlySelected:@"" fullSelected:@"star" andDelegate:nil];
                ratingView.userInteractionEnabled = NO;
            
                [self addSubview:ratingView];
                [ratingView release];
            
                self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0f, 14.0f, 90.0f, 15.0f)];
                timeLabel.textAlignment = NSTextAlignmentLeft;
                timeLabel.backgroundColor = [UIColor clearColor];
                timeLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
                timeLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
                [self addSubview:timeLabel];
                [timeLabel release];


            self.remarkTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 50.0f, 270.0f, 40.0f)];
            remarkTextLabel.textAlignment = NSTextAlignmentLeft;
            remarkTextLabel.numberOfLines = 0;
            remarkTextLabel.backgroundColor = [UIColor clearColor];
            remarkTextLabel.textColor = [UIColor colorWithRed:78./255.0f green:78./255.0f blue:78./255.0f alpha:1];
            remarkTextLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
            [self addSubview:remarkTextLabel];
            [remarkTextLabel release];

            self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 89, 290, 1)];
            [lineImage setBackgroundColor:[UIColor colorWithRed:0xdc/255. green:0xdc/255. blue:0xdc/255. alpha:1]];
            [self addSubview:lineImage];
            [lineImage release];
//        }
        
        
    }
    return self;
}


@end
