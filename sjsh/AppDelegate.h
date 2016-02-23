//
//  AppDelegate.h
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopListViewController.h"
//#import "BMapKit.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "MainPageViewController.h"
#import "PersonalInfoViewController.h"
#import "ServiceViewController.h"
#import "DEFINE.h"
#import "HHHomeController.h"
#import "HHHealthController.h"
#import  "HHShoppingController.h"
#import "HHUserCenterController.h"
@import HealthKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate,TencentSessionDelegate, WXApiDelegate,UITabBarControllerDelegate>//BMKGeneralDelegate
{
//    BMKMapManager* _mapManager;
    TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;
    UIViewController *tempViewController;

}
@property (strong, nonatomic) UIWindow *window;
@property (retain ,nonatomic) NSString *WXcode;
@property (retain ,nonatomic) NSString *WXopenId;
@property (retain ,nonatomic) NSString *WXaccesstoken;
@property (retain ,nonatomic) NSString *QQopenId;
@property (retain ,nonatomic) NSString *QQaccesstoken;
@property (retain ,nonatomic) NSString *WXName;
@property (retain ,nonatomic) NSString *QQName;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (retain, nonatomic) UIButton *homeTab;
@property (retain, nonatomic) UIButton *shangpinTab;
@property (retain, nonatomic) UIButton *formTab;
@property (retain, nonatomic) UIButton *mineTab;

@property (retain, nonatomic) ShopListViewController *shopListViewController;

@property (nonatomic) HKHealthStore *healthStore;


+ (AppDelegate *)shareDelegate;
- (IBAction)weixinLogin:(UIViewController *)sender;
- (void)tencentLogin:(UIViewController *)sender;
- (void)tabClickAction:(id)sender;
@end
