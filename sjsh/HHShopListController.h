//
//  HHShopListController.h
//  sjsh
//  淮海商品列表
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "UITempletViewController.h"
#import "HHShopCell.h"
#import "MoreCell.h"
#import "ItemDetailViewController.h"
#import "SINavigationMenuView.h"
#import "HHShoppingDetialController.h"

@interface HHShopListController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,SINavigationMenuDelegate,UITextFieldDelegate,HHShopCellDelegate>
{
    UIButton *blankButton;//无商品列表信息
    UITableView *listTableView;
    int page;
    MoreCell *moreCell;
    BOOL reloading;
    BOOL moreAction;
    SINavigationMenuView *menu;
    UITextField *currentTextField;
}

@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSString *theCategoryId;
@property(nonatomic, retain) NSMutableArray *categoryListArray;
@property (nonatomic, retain) NSString *allCount;
@property (nonatomic, retain) UIScrollView *categoryScroll;

@property(nonatomic,assign) BOOL  isFirst;//是否首次打开页面


@end
