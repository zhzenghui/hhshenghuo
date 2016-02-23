//
//  RemarkViewController.h
//  sjsh
//
//  Created by ce on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "RemarkData.h"
#import "MoreCell.h"

@interface RemarkViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *listTableView;
    int page;
    BOOL moreAction;
    MoreCell *moreCell;
    BOOL reloading;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (retain, nonatomic) NSString *productID;

@end
