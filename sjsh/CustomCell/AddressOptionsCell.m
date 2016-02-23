//
//  AddressOptionsCell.m
//  sjsh
//
//  Created by savvy on 15/11/24.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AddressOptionsCell.h"

@implementation AddressOptionsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        //名称
        self.nameLabel = [[UILabel alloc]init];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.text = @"暂无";
        [self.contentView addSubview:self.nameLabel];
        
               
        [self initAutoLayout];
    }
    return self;
}




- (void)setCellInfo:(NSDictionary *)dic
{
    //    url
    NSLog(@"%@!!!!!!!!!!!!",dic[@"image"]);
    
        self.nameLabel.text = [dic objectForKey:@"name"];
}

- (void)initAutoLayout{
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                     constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1.0
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:1.0
                                     constant:0]];
}
@end
