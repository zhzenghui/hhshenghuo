//
//  MyStoredViewController.h
//  sjsh
//  我的收藏
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "MyStoredViewController.h"
#import "MoreCell.h"
#import "StoredCell.h"
#import "SINavigationMenuView.h"

@interface MyStoredViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,SINavigationMenuDelegate>
{
    UITableView *listTableView;
    int page;
    MoreCell *moreCell;
    BOOL reloading;
    BOOL moreAction;
    SINavigationMenuView *menu;
}

@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;

@end
