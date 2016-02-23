//
//  MyShoppingCartViewController.h
//  sjsh
//
//  Created by 杜 计生 on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "ShoppingCartTableViewCell.h"

@interface MyShoppingCartViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,ShoppingCartCellDelegate>
{
    
}

@property(nonatomic, strong) UITableView *listTableView;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableArray *selectArray;
@property (nonatomic, retain) IBOutlet ShoppingCartTableViewCell *myCell;
@property (nonatomic, retain) UILabel *totoaPricelabel;
@property (nonatomic, retain) UIButton *payButton;
@end
