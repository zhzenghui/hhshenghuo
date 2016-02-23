//
//  ShopListViewController.h
//  sjsh
//
//  Created by ce on 14-8-24.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "shopListViewCell.h"
#import "MoreCell.h"
#import "ItemDetailViewController.h"
#import "SINavigationMenuView.h"
#import "CommodityDetailController.h"


@interface ShopListViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,SINavigationMenuDelegate,UISearchBarDelegate>
{
    UIButton *blankButton;//无商品列表信息
    UITableView *listTableView;
    int page;
    MoreCell *moreCell;
    BOOL reloading;
    BOOL moreAction;
    SINavigationMenuView *menu;
}

@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSString *theCategoryId;
@property(nonatomic, retain) NSMutableArray *categoryListArray;
@property (nonatomic, retain) NSString *allCount;
@property (nonatomic, retain) UIScrollView *categoryScroll;

@property(nonatomic,assign) BOOL  isFirst;//是否首次打开页面
@end
