//
//  MyOrderListViewController.h
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "orderGoodsCell.h"
#import "orderActionTableViewCell.h"
#import "MyOrderDetailViewController.h"
#import "MoreCell.h"
#import "SINavigationMenuView.h"
#import "OrderCell.h"

@interface MyOrderListViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,SINavigationMenuDelegate,OrderOperateDelegate>
{
    UITableView *listTableView;
    int page;
//    MoreCell *moreCell;
    SINavigationMenuView *menu;
    BOOL reloading;
    BOOL moreAction;
}

@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;

@end
