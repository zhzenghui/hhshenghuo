//
//  MyInfoViewController.h
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
@interface MyInfoViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableDictionary *personalDic;
@property (retain, nonatomic) UIImage *image;
@end
