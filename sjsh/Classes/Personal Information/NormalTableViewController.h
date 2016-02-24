//
//  NormalTableViewController.h
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "MyInfoViewController.h"
enum TableViewType {
    Type_Nickname = 1,// 昵称
    Type_Address= 2,// 收货地址
    Type_Sex = 3, // 性别
    Type_TrueName = 4, // 真实姓名
    Type_Marriage = 5, // 婚姻状况
};

@interface NormalTableViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) enum TableViewType type;

@property (nonatomic, assign) UIButton *submitButton;

@property (retain, nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSString *nickNameStr;//昵称
@property (retain, nonatomic) NSString *trueNameStr;//
@property (retain, nonatomic) NSString *sexStr;//
@property (retain, nonatomic) NSString *marriageStr;//
@property (nonatomic, assign) NSMutableDictionary *infoDic;

@end
