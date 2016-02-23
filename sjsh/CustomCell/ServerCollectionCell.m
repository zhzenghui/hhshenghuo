//
//  ServerCollectionCell.m
//  sjsh
//
//  Created by savvy on 15/11/5.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "ServerCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation ServerCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //图标
        self.icoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.icoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.icoImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.icoImageView.image = [UIImage imageNamed:@"myStore"];
        [self.contentView addSubview:self.icoImageView];
        
        //名称
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,65,50,15)];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.nameLabel];
        
        //标签
        self.markImageView = [[UIImageView alloc]init];
        [self.markImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.markImageView.contentMode = UIViewContentModeScaleAspectFit;
         self.markImageView.image = [UIImage imageNamed:@"onceReview"];
        [self.contentView addSubview:self.markImageView];
   
        [self initAutoLayout];
    }
    return self;
}




- (void)setCellInfo:(NSDictionary *)dic
{
//    url
    NSLog(@"%@!!!!!!!!!!!!",dic[@"image"]);
  
     [self.icoImageView setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
//      UIImage *img = [UIImage imageNamed:[dic objectForKey:@"img"]];
//    if (img == nil) {
//        img = [UIImage imageNamed:@"icon_default"];
//    }
//    self.icoImageView.image = img;
    self.nameLabel.text = [dic objectForKey:@"title"];
    
    
    if ([dic[@"flag"] integerValue]==0) {//隐藏会员价
        self.markImageView.hidden = YES;
    }
    
}


- (void)initAutoLayout{
    [self.contentView addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.icoImageView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.contentView
                               attribute:NSLayoutAttributeCenterX
                               multiplier:1
                               constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.icoImageView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                     constant:-5]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.icoImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0
                                     constant:40]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.icoImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0
                                     constant:40]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.icoImageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:5]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.icoImageView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0
                                     constant:15]];


}


@end
