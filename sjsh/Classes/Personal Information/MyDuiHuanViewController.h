//
//  MyDuiHuanViewController.h
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "orderGoodsCell.h"
#import "MoreCell.h"
@interface MyDuiHuanViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
    int page;
    MoreCell *moreCell;
    BOOL reloading;
    BOOL moreAction;
}
@property(nonatomic, retain) NSMutableArray *dataArray;

@end
