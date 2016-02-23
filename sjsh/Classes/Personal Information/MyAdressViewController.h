//
//  MyAdressViewController.h
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

@interface MyAdressViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
}
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;

@end
