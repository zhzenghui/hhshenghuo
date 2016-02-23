//
//  ItemDetailViewController.h #discard！！！！！！！！！！！！！！！！！
//  XHPathCover
//
//  Created by 杜 计生 on 14-8-18.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "UITempletViewController.h"
#import "ISBookStore_RatingView.h"
#import "MyShoppingCartViewController.h"
#import "LPLabel.h"
#import <WebKit/WebKit.h>
#import "DEFINE.h"

typedef enum : NSUInteger {
    generalType,
    virtualType,
    changeType,
} productType;

@interface ItemDetailViewController : UITempletViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) productType pType;
@property (nonatomic, retain) NSDictionary *productDic;
@property (nonatomic, retain) IBOutlet UIScrollView *backScroll;
@property (nonatomic, retain) IBOutlet UIScrollView *upScroll;
@property (nonatomic, retain) UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIButton *buyButton;
@property (retain, nonatomic) IBOutlet UIButton *addCartButton;
@property (retain, nonatomic) IBOutlet UIButton *favButton;
@property (nonatomic, retain) UIWebView *webview;
@property (nonatomic, retain) IBOutlet UIImageView *lineView;
@property (nonatomic, retain) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIView *songView;
@property (retain, nonatomic) IBOutlet UIView *reviewView;
@property (retain, nonatomic) IBOutlet UILabel *product_name;
@property (retain, nonatomic) IBOutlet UILabel *product_special;
@property (retain, nonatomic) IBOutlet LPLabel *product_price;
@property (retain, nonatomic) IBOutlet UILabel *product_description;
@property (retain, nonatomic) IBOutlet UILabel *rateNum;
@property (retain, nonatomic) IBOutlet UILabel *reviewNum;
@property (retain, nonatomic) IBOutlet UILabel *peisongLabel;
@property (retain, nonatomic) IBOutlet UILabel *yunfeiLabel;
@property (retain, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (retain, nonatomic) IBOutlet UILabel *upPullLabel;
@property (retain, nonatomic) IBOutlet ISBookStoreRatingView *ratingView;
@property (retain, nonatomic)  UIProgressView  *webProgress;
//@property (retain, nonatomic)  UIViewController *
- (IBAction)collect:(UIButton *)sender;
- (IBAction)buyTapped:(UIButton*)sender;
@end
