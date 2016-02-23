//
//  HHAdressViewController.h
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"

@interface HHAdressViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
}
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;

@end
