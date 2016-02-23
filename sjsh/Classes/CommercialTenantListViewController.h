//
//  CommercialTenantListViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14-8-3.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommercialTableViewCell.h"
#import "UITempletViewController.h"
//#import "AnnotationDemoViewController.h"
#import "FKRSearchBarTableViewController.h"
#import "SINavigationMenuView.h"
#import "MoreCell.h"

@interface CommercialTenantListViewController : UITempletViewController<UISearchBarDelegate,UISearchDisplayDelegate,RatingViewDelegate>//AnnotationDefineDelegate
{

//    UIButton *rightButtons;
    UITableView *listTableView;
    SINavigationMenuView *menu;
    BOOL reloading;
    BOOL moreAction;
    MoreCell *moreCell;
    int page;
    UIImageView *backImageView;
    UIButton *returnButton;
    NSString *allCount;
}

@property (nonatomic, retain) NSString *theCategoryId;
@property(nonatomic, retain) UISearchBar *searchBar;
@property(nonatomic, retain) UISearchDisplayController *strongSearchDisplayController;
@property(nonatomic, retain) NSMutableArray *shopListArray;
@property(nonatomic, retain) NSMutableArray *categoryListArray;
@property (nonatomic, retain) NSString *allCount;

@end
