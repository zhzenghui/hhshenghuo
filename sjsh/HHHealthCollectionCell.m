//
//  HHHealthCollectionCell.m
//  sjsh
//
//  Created by savvy on 16/1/20.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHHealthCollectionCell.h"
#import "Define.h"

@implementation HHHealthCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor =[ lineGrayColorWithHH CGColor];
        
        //图标
        self.icoImageView = [[UIImageView alloc]init];
        [self.icoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.icoImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.icoImageView.image = [UIImage imageNamed:@"myStore"];
        [self.contentView addSubview:self.icoImageView];
        
        //名称
        self.nameLabel = [[UILabel alloc]init];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        //分割线
        self.lineView = [[UIView alloc]init];
        [self.lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.lineView.backgroundColor = lineGrayColorWithHH;
        [self.contentView addSubview:self.lineView];
        
        //标签
        self.tagView = [[UIView alloc]init];
        [self.tagView setTranslatesAutoresizingMaskIntoConstraints:NO];
        //        self.tagView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.tagView];
        
        [self initAutoLayout];
    }
    return self;
}




- (void)setCellInfo:(NSDictionary *)dic
{
    //    url
    //    NSLog(@"%@!!!!!!!!!!!!",dic[@"image"]);
    
    //    [self.icoImageView setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
    self.icoImageView.image = [UIImage imageNamed:dic[@"ico"]];
    //      UIImage *img = [UIImage imageNamed:[dic objectForKey:@"img"]];
    //    if (img == nil) {
    //        img = [UIImage imageNamed:@"icon_default"];
    //    }
    //    self.icoImageView.image = img;
    self.nameLabel.text = [dic objectForKey:@"title"];
    
    
    NSMutableArray *colorArray = [[NSMutableArray alloc]init];
    [colorArray addObject:[UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:0.0/255.0 alpha:1.0]];
    [colorArray addObject:[UIColor colorWithRed:243.0/255.0 green:149.0/255.0 blue:186.0/255.0 alpha:1.0]];
    [colorArray addObject:[UIColor colorWithRed:84.0/255.0 green:176.0/255.0 blue:224.0/255.0 alpha:1.0]];
    
    [colorArray addObject:[UIColor colorWithRed:192.0/255.0 green:211.0/255.0 blue:60.0/255.0 alpha:1.0]];
    [colorArray addObject:[UIColor colorWithRed:51.0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0]];
    [colorArray addObject:[UIColor colorWithRed:250/255.0 green:79/255.0 blue:45/255.0 alpha:1.0]];
    [colorArray addObject:[UIColor colorWithRed:246/255.0 green:192/255.0 blue:75/255.0 alpha:1.0]];
    
    NSMutableArray *labelArray = [dic objectForKey:@"labelArray"];
    NSArray *tagViewArray = [self.tagView subviews];
    for (int i=0; i<tagViewArray.count; i++) {
        [tagViewArray[i] removeFromSuperview];
    }
    for(int i=0;i<labelArray.count;i++){
        int x = arc4random() % 7;
        UILabel *tagLabel = [[UILabel alloc]init];
        [tagLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        tagLabel.textColor = colorArray[x];
        tagLabel.font = [UIFont systemFontOfSize:10];
        tagLabel.text = labelArray[i];
        tagLabel.textAlignment = (i%2==0)?NSTextAlignmentRight:NSTextAlignmentLeft;
        [self.tagView addSubview:tagLabel];
        if (i%2==0&&(i!=labelArray.count-1)) {//偶数且不为最后一个
            [self.tagView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:tagLabel
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.tagView
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1
                                         constant:-45]];
        }else if(i%2==0&&(i==labelArray.count-1)){//偶数且为最后一个
            [self.tagView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:tagLabel
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.tagView
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1
                                         constant:-17.5]];
        }else{
            [self.tagView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:tagLabel
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.tagView
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1
                                         constant:45]];
        }
        
        [self.tagView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:tagLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.tagView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:7.5+i/2*15]];//控制每行位置
        
        [self.tagView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:tagLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.tagView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:80]];
        [self.tagView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:tagLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.tagView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0
                                     constant:15]];
        
    }
    
    
    
}



- (void)initAutoLayout{
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.icoImageView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:12.5]];
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
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0
                                     constant:45]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.icoImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0
                                     constant:45]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.nameLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.icoImageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:8]];
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
    
    //分割线
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                     constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                     constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.8
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.lineView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0
                                     constant:0.5]];
    
    //标签区域
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.tagView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.lineView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:5.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.tagView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.tagView
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.tagView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:0]];
    
    
}

@end
