//
//  CategoryViewController.h
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "CategoryCell.h"

@interface CategoryViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *categoryTableView;
    NSMutableArray *listArray;
    NSMutableArray *dataArray;
}
@property (nonatomic, retain)NSMutableArray *listArray;
@property (nonatomic, retain)NSMutableDictionary *dictplist;
@end
