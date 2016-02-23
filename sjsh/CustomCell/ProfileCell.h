//
//  ProfileCell.h
//  BeautyMakeup
//
//  Created by hers on 13-11-14.
//  Copyright (c) 2013年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell{
    UIImageView           *itemImageView;//图片
    UILabel               *nameLabel;//项目分类数量

}

@property(nonatomic,retain) UIImageView  *userImageView;
@property(nonatomic,retain) UILabel  *userNameLabel;
@property(nonatomic,retain) UILabel  *userContentLabel;


@end
