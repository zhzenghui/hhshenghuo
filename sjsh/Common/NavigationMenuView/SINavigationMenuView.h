//
//  SINavigationMenuView.h
//  NavigationMenu
//  第三方控件，下拉菜单
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMenuTable.h"

@protocol SINavigationMenuDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;
- (void)onHandleMenuTap;
-(void)onShowMenu;
-(void)onHideMenuTap;
@end

@interface SINavigationMenuView : UIView <SIMenuDelegate>{

}

@property (nonatomic, retain) id <SINavigationMenuDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *categoryIdArray;
@property (nonatomic, retain) NSMutableArray *ptotalArray;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)displayMenuInView:(UIView *)view;


@end
