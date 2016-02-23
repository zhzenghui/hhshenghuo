//
//  ShopDetailViewController.h
//  sjsh
//
//  Created by ce on 14-8-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "MoreCell.h"
#import "ShopDetailCell.h"
#import <WebKit/WebKit.h>

@interface ShopDetailViewController : UITempletViewController<WKNavigationDelegate,UITableViewDelegate,UIActionSheetDelegate>{

    UITableView *listTableView;
    int page;
    BOOL moreAction;
    MoreCell *moreCell;
    UIButton *avatarButton;
    UILabel *nickLabel;
    UILabel *picLabel;
    UILabel *teleLabel;
    UILabel *addressLabel;
    BOOL reloading;
    UIImageView *backImageView;

}
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSString *manufacturer_id;
@property (nonatomic, retain) WKWebView *webview;
@property (nonatomic ,retain) NSDictionary *infoDic;
@property (nonatomic, strong) NSMutableArray *imageURLs;

@property (retain, nonatomic) UIProgressView  *webProgress;//浏览器加载条
@end
