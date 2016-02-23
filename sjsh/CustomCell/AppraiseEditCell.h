//
//  AppraiseEditCell.h
//  sjsh
//
//  Created by savvy on 15/11/27.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"

@protocol AppraiseEditDelegate<NSObject>
- (void)doPhotograph:(NSMutableDictionary *)myDictionary;//拍照
- (void)deleteImage:(NSMutableDictionary *)myDictionary;//删除图片
- (void)updateGradeData:(NSMutableDictionary *)myDictionary;//更新评分数量
- (void)updateComment:(NSMutableDictionary *)myDictionary;//更新评论内容
@end


@interface AppraiseEditCell : UITableViewCell<UINavigationControllerDelegate,UIImagePickerControllerDelegate,DJQRateViewDelegate,UITextViewDelegate>


@property(nonatomic, assign) id<AppraiseEditDelegate> delegate;

@property(nonatomic, assign) NSInteger position;//待评价商品的位置

@property(nonatomic, strong) UIImageView *commodityImageView;
@property(nonatomic, strong) UITextView *appraiseContentText;
@property(nonatomic, strong) UILabel *appraiseContentLabel;//评论内容的提示信息
@property(nonatomic, strong) UIButton *photographButton;//拍照按钮
@property(nonatomic, strong) NSMutableArray *photographImageViewArray;
@property(nonatomic, strong) NSMutableArray *deleteImageButtonArray;
@property(nonatomic, strong) UIButton *deleteButton01;
@property(nonatomic, strong) UIButton *deleteButton02;
@property(nonatomic, strong) UIButton *deleteButton03;
@property(nonatomic, strong) UIButton *deleteButton04;


//@property(nonatomic, strong) UIImageView *photographImageView01;
//@property(nonatomic, strong) UIImageView *photographImageView02;
//@property(nonatomic, strong) UIImageView *photographImageView03;
//@property(nonatomic, strong) UIImageView *photographImageView04;

@property(nonatomic, strong) UIView *lineView01;

@property(nonatomic, strong) UILabel *gradeTitleLabel;//评价标题
@property(nonatomic, strong) DJQRateView *commodityGradeView;//商品评分控件

@property(nonatomic, strong) UIView *lineView02;

@property(nonatomic, assign) double imageSpacing;//图片间的间距
@property(nonatomic, assign) NSLayoutConstraint *photographButtonConstraint;//按钮左侧约束
@property(nonatomic,strong) NSString *lastChosenMediaType;//拍照方式
@property(nonatomic,strong) NSMutableDictionary *appraiseDictionary;//cell的数据字典

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
