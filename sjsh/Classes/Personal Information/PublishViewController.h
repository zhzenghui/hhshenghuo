//
//  PublishViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/11/23.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "ImageEditViewController.h"
@interface PublishViewController : UITempletViewController<UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,imageEditDelegate>
{
    UIButton *star1;
    UIButton *star2;
    UIButton *star3;
    UIButton *star4;
    UIButton *star5;
    UITextView *FBTextV;
    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
    UIButton *commitB;
    int starVal;
}
@property(nonatomic, retain) NSString *reviewID;
@property(nonatomic, retain) NSString *orderProductID;
@property(nonatomic, retain) NSMutableArray *imageList;
@property(nonatomic, retain) UIImageView *selectImageview;
@end
