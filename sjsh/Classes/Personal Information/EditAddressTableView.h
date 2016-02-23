//
//  EditAddressTableView.h
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

@interface EditAddressTableView : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger selectIndex;
}
@property (retain, nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) NSMutableDictionary *dataDic;
@property (retain, nonatomic) NSArray *xiaoquList;
@property (retain, nonatomic) NSArray *louhaoList;
@property (retain, nonatomic) NSArray *danyuanList;
@property (retain, nonatomic) UITableView *tableView;
@property (nonatomic, retain) UIPickerView *pickView;
@end
