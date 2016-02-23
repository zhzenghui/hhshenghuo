//
//  AppraiseEditCell.m
//  sjsh
//  评价编辑页面
//  Created by savvy on 15/11/27.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AppraiseEditCell.h"
#import "Define.h"

@implementation AppraiseEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.imageSpacing = (ScreenWidth-15*2-50*4)/3;
        self.imageSpacing = 18;
        
        self.photographImageViewArray = [[NSMutableArray alloc]init];
        
        self.commodityImageView = [[UIImageView alloc] init];
        self.commodityImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.commodityImageView.contentMode =UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.commodityImageView];
        
        
        self.appraiseContentText = [[UITextView alloc] init];
        self.appraiseContentText.translatesAutoresizingMaskIntoConstraints = NO;
        self.appraiseContentText.delegate = self;
//        @"长度在10字-100字之间";
        self.appraiseContentText.textColor = fontGrayColor;
        self.appraiseContentText.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.appraiseContentText];
        
        
        //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
        self.appraiseContentLabel = [[UILabel alloc]init];
//        self.appraiseContentLabel.frame =CGRectMake(0, 0, 100, 15);
        self.appraiseContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.appraiseContentLabel.text = @"长度在10字-100字之间";
        self.appraiseContentLabel.font = [UIFont systemFontOfSize:14];
        self.appraiseContentLabel.textColor = fontDilutedGrayColor;
        self.appraiseContentLabel.enabled = NO;//lable必须设置为不可用
        self.appraiseContentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.appraiseContentLabel];
        
        self.photographButton = [[UIButton alloc] init];
        self.photographButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.photographButton.layer.cornerRadius = 5;
        self.photographButton.layer.masksToBounds = YES;
        //设置边框及边框颜色
        self.photographButton.layer.borderWidth = 1;
        self.photographButton.layer.borderColor =[ lineGrayColor CGColor];
        //        self.photographButton.backgroundColor = kRedColor;
        //        [self.photographButton setTitle:@"拍照" forState:UIControlStateNormal];
        [self.photographButton setImage:[UIImage imageNamed:@"ico_appraise_photograph"] forState:UIControlStateNormal];
        [self.photographButton addTarget:self action:@selector(doPhotograph) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.photographButton];
        
        self.deleteButton01 = [[UIButton alloc]init];
        self.deleteButton02 = [[UIButton alloc]init];
        self.deleteButton03 = [[UIButton alloc]init];
        self.deleteButton04 = [[UIButton alloc]init];
        
        UIButton *myButton = nil;
        for (int i=0; i<4; i++) {
            UIImageView *photographImageView = [[UIImageView alloc] init];
            photographImageView.translatesAutoresizingMaskIntoConstraints = NO;
            photographImageView.layer.cornerRadius = 5;
            photographImageView.layer.masksToBounds = YES;
            photographImageView.hidden = YES;
            //            photographImageView.backgroundColor = TEST_COLOR;
            //            photographImageView.contentMode =UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:photographImageView];
            [self.photographImageViewArray addObject:photographImageView];
            
            switch (i) {
                case 0:
                    myButton = self.deleteButton01;
                    break;
                case 1:
                    myButton = self.deleteButton02;
                    break;
                case 2:
                    myButton = self.deleteButton03;
                    break;
                case 3:
                    myButton = self.deleteButton04;
                    break;
                    
                default:
                    break;
            }
            myButton.tag = 198800+i;
            myButton.translatesAutoresizingMaskIntoConstraints = NO;
            myButton.hidden = YES;
            [myButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            [myButton setImage:[UIImage imageNamed:@"ico_appraise_delete"] forState:UIControlStateNormal];
            [self.contentView addSubview:myButton];
            
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1
                                             constant:-8]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1
                                             constant:8]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0
                                             constant:16]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:0
                                             constant:16]];
            
            
        }
        
        //        self.deleteButton01 = [[UIButton alloc]init];
        //        self.deleteButton01.translatesAutoresizingMaskIntoConstraints = NO;
        //        self.deleteButton01.hidden = YES;
        //        [self.deleteButton01 setImage:[UIImage imageNamed:@"ico_appraise_delete"] forState:UIControlStateNormal];
        //        [self.contentView addSubview:self.deleteButton01];
        
        
        //            self.deleteButton = [[UIButton alloc]init];
        //            self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
        ////            deleteButton.hidden = YES;
        //            [self.deleteButton setImage:[UIImage imageNamed:@"ico_appraise_delete"] forState:UIControlStateNormal];
        //            [self.contentView addSubview:self.deleteButton];
        //           [self.deleteImageButtonArray addObject:self.deleteButton];
        
        
        //        self.photographImageView02 = [[UIImageView alloc] init];
        //        self.photographImageView02.translatesAutoresizingMaskIntoConstraints = NO;
        //        self.photographImageView02.layer.cornerRadius = 5;
        //        self.photographImageView02.layer.masksToBounds = YES;
        //        self.photographImageView02.contentMode =UIViewContentModeScaleAspectFit;
        //        [self.contentView addSubview:self.photographImageView02];
        //
        //        self.photographImageView03 = [[UIImageView alloc] init];
        //        self.photographImageView03.translatesAutoresizingMaskIntoConstraints = NO;
        //        self.photographImageView03.layer.cornerRadius = 5;
        //        self.photographImageView03.layer.masksToBounds = YES;
        //        self.photographImageView03.contentMode =UIViewContentModeScaleAspectFit;
        //        [self.contentView addSubview:self.photographImageView03];
        //
        //        self.photographImageView04 = [[UIImageView alloc] init];
        //        self.photographImageView04.translatesAutoresizingMaskIntoConstraints = NO;
        //        self.photographImageView04.layer.cornerRadius = 5;
        //        self.photographImageView04.layer.masksToBounds = YES;
        //        self.photographImageView04.contentMode =UIViewContentModeScaleAspectFit;
        //        [self.contentView addSubview:self.photographImageView04];
        
        self.lineView01 = [[UIView alloc] init];
        self.lineView01.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineView01.backgroundColor = lineGrayColor;
        [self.contentView addSubview:self.lineView01];
        
        self.gradeTitleLabel = [[UILabel alloc] init];
        self.gradeTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.gradeTitleLabel.text = @"满意度";
        self.gradeTitleLabel.textColor = fontGrayColor;
        self.gradeTitleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.gradeTitleLabel];
        
        //评价的星星
        self.commodityGradeView = [[DJQRateView alloc] init];
        self.commodityGradeView.translatesAutoresizingMaskIntoConstraints = NO;
        self.commodityGradeView.rate = 5.0;
        self.commodityGradeView.delegate = self;
        [self.contentView addSubview:self.commodityGradeView];
        
        self.lineView02 = [[UIView alloc] init];
        self.lineView02.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineView02.backgroundColor = dilutedGrayColor;
        [self.contentView addSubview:self.lineView02];
        
        [self initAutoLayout];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    NSLog(@"评价cell%@!!!!!!!",myDictionary);
    
    self.appraiseDictionary = [myDictionary mutableCopy];
//    self.appraiseDictionary[@"appraiseComment"] = @"";
    
    [self.commodityImageView setImageWithURL:[NSURL URLWithString:myDictionary[@"image"]]];
    
    for (int i=0; i<self.photographImageViewArray.count; i++) {
        UIImageView *photographImageView = self.photographImageViewArray[i];
        photographImageView.hidden = YES;
    }
    self.deleteButton01.hidden = YES;
    self.deleteButton02.hidden = YES;
    self.deleteButton03.hidden = YES;
    self.deleteButton04.hidden = YES;
    
    NSArray *imageArray = myDictionary[@"imageArray"];
    if (imageArray.count>0) {
        
    
    for (int i=0; i<imageArray.count; i++) {
        UIImageView *photographImageView = self.photographImageViewArray[i];
        photographImageView.hidden = NO;
        UIImage *chosenImage =  imageArray[i][@"image"];
        photographImageView.image = chosenImage;
        
        
        //       [ ((UIButton *)self.deleteImageButtonArray[1])  setImage:[UIImage imageNamed:@"ico_appraise_photograph"] forState:UIControlStateNormal];
        if (i==0) {
            self.deleteButton01.hidden = NO;
            
        }else if(i==1){
            self.deleteButton02.hidden = NO;
        }else if(i==2){
            self.deleteButton03.hidden = NO;
        }else if(i==3){
            self.deleteButton04.hidden = NO;
        }
        
        if (i>=3) {//显示第四张图片
            self.photographButton.hidden = YES;
        }else{
            self.photographButton.hidden = NO;
            [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.contentView setNeedsLayout];
                [self.contentView layoutIfNeeded];
                [self.contentView removeConstraint:self.photographButtonConstraint];
                self.photographButtonConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.photographButton
                                                   attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:self.photographImageViewArray[i]
                                                   attribute:NSLayoutAttributeRight
                                                   multiplier:1
                                                   constant:self.imageSpacing];
                [self.contentView addConstraint:self.photographButtonConstraint];
            } completion:NULL];
            
        }
    }
    }else{
        self.photographButton.hidden = NO;
        [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.contentView setNeedsLayout];
            [self.contentView layoutIfNeeded];
            [self.contentView removeConstraint:self.photographButtonConstraint];
            self.photographButtonConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.photographButton
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.photographImageViewArray[0]
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                               constant:0];
            [self.contentView addConstraint:self.photographButtonConstraint];
        } completion:NULL];

    
    }
}

//初始化自动布局
- (void)initAutoLayout{
    
    NSDictionary *allMap = @{
                             @"commodityImageView" : self.commodityImageView,
                             @"appraiseContentText" : self.appraiseContentText,
                             @"photographButton" : self.photographButton,
                             @"photographImageView01" : self.photographImageViewArray[0],
                             //                                   @"photographImageView02" : self.photographImageViewArray[1],
                             //                                   @"photographImageView03" : self.photographImageViewArray[2],
                             //                                   @"photographImageView04" : self.photographImageViewArray[3],
                             @"lineView01" : self.lineView01,
                             @"gradeTitleLabel" : self.gradeTitleLabel,
                             @"commodityGradeView" : self.commodityGradeView,
                             @"lineView02" : self.lineView02
                             };
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:|-15-[commodityImageView(==50)]-30-[photographImageView01(==50)]-15-[lineView01(==0.5)]-0-[gradeTitleLabel(==60)]-0-[lineView02]-0-|"
                                      options:0
                                      metrics:nil
                                      views:allMap]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-15-[commodityImageView(==50)]"
                                      options:0
                                      metrics:nil
                                      views:allMap]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.commodityImageView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1
                                     constant:15]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1
                                     constant:-15]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.commodityImageView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.commodityImageView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:0]];
    
    //评论提示
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0
                                     constant:5.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.0
                                     constant:10.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0.0
                                     constant:250.0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.appraiseContentLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.appraiseContentText
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:0.0
                                     constant:15.0]];
    
    
    
    //拍照按钮
    self.photographButtonConstraint = [NSLayoutConstraint
                                       constraintWithItem:self.photographButton
                                       attribute:NSLayoutAttributeLeft
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.contentView
                                       attribute:NSLayoutAttributeLeft
                                       multiplier:1
                                       constant:15];
    [self.contentView addConstraint:self.photographButtonConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.photographButton
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.photographImageViewArray[0]
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.photographButton
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.photographImageViewArray[0]
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1
                                     constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.photographButton
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.photographImageViewArray[0]
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:0]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-0-[lineView01]-0-|"
                                      options:0
                                      metrics:nil
                                      views:allMap]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-15-[gradeTitleLabel(==70)]"
                                      options:0
                                      metrics:nil
                                      views:allMap]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.commodityGradeView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.photographImageViewArray[1]
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1
                                     constant:-5]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.commodityGradeView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:0
                                     constant:180]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.commodityGradeView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.gradeTitleLabel
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1
                                     constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.commodityGradeView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.gradeTitleLabel
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                     constant:-20]];
    
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-0-[lineView02]-0-|"
                                      options:0
                                      metrics:nil
                                      views:allMap]];
    
    
    
    
    //图片按钮
    for (int i=0; i<4; i++) {
        if(i>0) {
            
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i-1]
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1
                                             constant:self.imageSpacing]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i-1]
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1
                                             constant:0]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i-1]
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:1
                                             constant:0]];
            [self.contentView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.photographImageViewArray[i]
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.photographImageViewArray[i-1]
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1
                                             constant:0]];
            
        }else{
            //首个图片的约束
            NSString *imageConstraintsString = [NSString stringWithFormat:@"H:|-15-[photographImageView01(==50)]"];
            
            [self.contentView addConstraints:[NSLayoutConstraint
                                              constraintsWithVisualFormat:
                                              imageConstraintsString
                                              options:0
                                              metrics:nil
                                              views:allMap]];
        }
        
    }
    
    
}



//拍照
-(void)doPhotograph{
    NSLog(@"开始拍照%@!!!!!!!!!!!!",self.appraiseDictionary);
    
    if ([_delegate respondsToSelector:@selector(doPhotograph:)]) {
        [_delegate doPhotograph:self.appraiseDictionary];
    }
    
}




#pragma mark 控件代理方法
//评分控件代理
- (void)ratechanger:(int)reteNum {
    NSLog(@"评分控件代理%i", reteNum);
    //    scoreId = reteNum;
    //    self.evaluateLable.text = scoreList[scoreId - 1][@"scoreName"];
    self.appraiseDictionary[@"appraiseValue"] = [NSNumber numberWithInt:reteNum];
     self.appraiseDictionary[@"position"] = [NSNumber numberWithInteger:self.position];
   
    if ([_delegate respondsToSelector:@selector(updateGradeData:)]) {
        [_delegate updateGradeData:self.appraiseDictionary];
    }
}


//删除图片
-(void)deleteImage:(UIButton *)myButton{
    NSInteger imagePosition = myButton.tag-198800;
    
    NSLog(@"删除第%li张图片!!!!!!",(long)imagePosition);
    
    NSMutableDictionary *deleteDictionary = [[NSMutableDictionary alloc]init];
    deleteDictionary[@"cellPosition"] = self.appraiseDictionary[@"cellPosition"];
    deleteDictionary[@"imagePosition"] = [NSNumber numberWithInteger:imagePosition];
    
    if ([_delegate respondsToSelector:@selector(deleteImage:)]) {
        [_delegate deleteImage:deleteDictionary];
    }
}

#pragma mark UITextView代理
-(void)textViewDidChange:(UITextView *)textView
{
    NSString *examineText =  textView.text;
    if (textView.text.length == 0) {
        self.appraiseContentLabel.hidden = NO;
    }else{
        self.appraiseContentLabel.hidden = YES;
//        if ([_delegate respondsToSelector:@selector(updateComment:)]) {
//            self.appraiseDictionary[@"appraiseComment"] = textView.text;
//            self.appraiseDictionary[@"position"] = [NSNumber numberWithInteger:self.position];
//            [_delegate updateComment:self.appraiseDictionary];
//        }
    }
    
}


-(void)textViewDidEndEditing:(UITextView *)textView

{
    if ([_delegate respondsToSelector:@selector(updateComment:)]) {
        self.appraiseDictionary[@"appraiseComment"] = textView.text;
        self.appraiseDictionary[@"position"] = [NSNumber numberWithInteger:self.position];
        [_delegate updateComment:self.appraiseDictionary];
    }
    
}

//因为多行输入，所以回车键有可能具有编写需要
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
//    NSLog(@"touchesbegan:withevent:");
    [self endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
