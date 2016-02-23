//
//  MyMessageViewController.h
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "MoreCell.h"
#import "SINavigationMenuView.h"
@interface MyMessageViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,SINavigationMenuDelegate>
{
    UITableView *listTableView;
    int page;
    MoreCell *moreCell;
    SINavigationMenuView *menu;
    BOOL reloading;
    BOOL moreAction;
}
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;

@end
