//
//  AppDelegate.m
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "AppDelegate.h"

//#import "HomeViewController.h"
#import "LoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OpenURLViewController.h"
#import "OrderUnit.h"



#define KTCappid @"1102010052"
#define APPKEY  @"xtl9HoeMeSd21XYe"


//URL schema：
//sjsh2014004
//Boundle ID：
//cn.sjsh8.m
//AppStore ID：
//931198864

@implementation AppDelegate
@synthesize tabBarController;
@synthesize homeTab;
@synthesize shangpinTab;
@synthesize formTab;
@synthesize mineTab;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //版本：1为世纪生活  2为淮海生活
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"2" forKey:@"version"];
    [userDefaults synchronize];
    
    NSString *versionType = [userDefaults objectForKey:@"version"];
    
    if ([versionType isEqualToString:@"2"]) {
        self.healthStore = [[HKHealthStore alloc] init];//开启健康数据

    }
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    //	_mapManager = [[BMKMapManager alloc]init];
    //	BOOL ret = [_mapManager start:@"ReLp9RYixA4OHfR4SMXEv6WE" generalDelegate:self];
    //	if (!ret) {
    //		NSLog(@"manager start failed!");
    //	}
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    application.statusBarHidden = NO;
    [self initTabControllerViews];
    
    //    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    //    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    //    self.window.rootViewController = homeNavigationController;
    //    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = tabBarController;
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:[@"showGuidence" stringByAppendingString:IosAppVersion]] == nil) {
//        CGFloat width = self.window.frame.size.width;
//        CGFloat height = self.window.frame.size.height;
//        
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.window.bounds];
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height);
//        scrollView.bounces = NO;
//        scrollView.showsHorizontalScrollIndicator = NO;
//        scrollView.showsVerticalScrollIndicator = NO;
//        scrollView.pagingEnabled = YES;
//        
//        NSString *title = @"";
//        if (height == 480) {
//            title = @"640×960";
//        }
//        else if (height == 568) {
//            title = @"640×1136";
//        }
//        else if (height == 1334/2) {
//            title = @"750×1334";
//        }
//        else if (height == 1920/2) {
//            title = @"1080×1920";
//        }
//        
//        
//        for (int i =0; i<3; i++) {
//            
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
//            NSString *name = [NSString stringWithFormat:@"%@-%d",title,i+1];
//            imgView.image = [UIImage imageNamed:name];
//            imgView.userInteractionEnabled = YES;
//            [scrollView addSubview:imgView];
//            if (i==2) {
//                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.frame = CGRectMake((width-120)/2, height-90, 120, 60);
//                [button addTarget:self action:@selector(removeHelpPage:) forControlEvents:UIControlEventTouchUpInside];
//                button.backgroundColor = [UIColor clearColor];
//                [imgView addSubview:button];
//            }
//        }
//        [self.window.rootViewController.view addSubview:scrollView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"show" forKey:[@"showGuidence" stringByAppendingString:IosAppVersion]];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    
    //    tabBarController.selectedIndex = 1;
    [self.window makeKeyAndVisible];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //        [self createCategoryPlist];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"0" forKey:@"isLogin"];
    }
    else {
        NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
        if (login && [login isEqualToString:@"1"]) {
            [[ConstObject instance] setIsLogin:YES];
        }
        else {
            [[ConstObject instance] setIsLogin:NO];
        }
    }
    BOOL success = [WXApi registerApp:kWXAPP_ID withDescription:@"weixin"];
    if (success) {
        NSLog(@"注册微信成功");
    }
    return YES;
}

- (void)removeHelpPage:(UIButton *)button
{
    [button.superview.superview removeFromSuperview];
}

- (void)initTabControllerViews{
  
    
    UINavigationController *homeNav = nil;
    UINavigationController *forumNav = nil;
    UINavigationController *serviceNav = nil;
    UINavigationController *mineNav = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *versionType = [userDefaults objectForKey:@"version"];
 
    if ([versionType isEqualToString:@"1"]) {
     
    self.shopListViewController = [[ShopListViewController alloc] init];
    
    homeNav = [[[UINavigationController alloc]initWithRootViewController:[[MainPageViewController alloc] init]] autorelease];
    homeNav.tabBarItem.title = @"";
    
     forumNav = [[UINavigationController alloc]initWithRootViewController:self.shopListViewController];
    forumNav.tabBarItem.title = @"";
    //  [[ConstObject instance]setAccountNavigationController:forumNav];
    
     serviceNav = [[UINavigationController alloc]initWithRootViewController:[[ServiceViewController alloc] init]];
    serviceNav.tabBarItem.title = @"";
    
     mineNav = [[[UINavigationController alloc]initWithRootViewController:[[PersonalInfoViewController alloc] init]] autorelease];
    mineNav.tabBarItem.title = @"";
        
        
    }else if ([versionType isEqualToString:@"2"]){
    
        homeNav = [[[UINavigationController alloc]initWithRootViewController:[[HHHomeController alloc] init]] autorelease];
        homeNav.tabBarItem.title = @"";
        
        forumNav = [[[UINavigationController alloc]initWithRootViewController:[[HHHealthController alloc] init]] autorelease];
        forumNav.tabBarItem.title = @"";
        
        serviceNav = [[UINavigationController alloc]initWithRootViewController:[[HHShoppingController alloc] init]];
        serviceNav.tabBarItem.title = @"";
        HHUserCenterController *hhUserCenterController = [[HHUserCenterController alloc] init];
        if ([hhUserCenterController respondsToSelector:@selector(setHealthStore:)]) {
            [hhUserCenterController setHealthStore:self.healthStore];
        }
        mineNav = [[UINavigationController alloc]initWithRootViewController:hhUserCenterController];
        mineNav.tabBarItem.title = @"";

        
    }
    
    tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:homeNav,forumNav,serviceNav,mineNav,nil]];
    tabBarController.delegate = self;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    imgView.userInteractionEnabled = YES;
    imgView.multipleTouchEnabled = YES;
    imgView.frame = CGRectMake(0,0, 320,50);
    
    
    self.homeTab = [UIButton buttonWithType:UIButtonTypeCustom];
    homeTab.adjustsImageWhenHighlighted = NO;
    homeTab.frame = CGRectMake(0.0f, 0.0f, 80.0f, 50.0f);
    homeTab.backgroundColor = [UIColor clearColor];
   
    [homeTab addTarget:self action:@selector(tabClickAction:) forControlEvents:UIControlEventTouchUpInside];
    homeTab.tag = 0;
    [imgView addSubview:homeTab];
    
    self.shangpinTab = [UIButton buttonWithType:UIButtonTypeCustom];
    shangpinTab.adjustsImageWhenHighlighted = NO;
    shangpinTab.frame = CGRectMake(80.0f, 0.0f, 80.0f, 50.0f);
    shangpinTab.backgroundColor = [UIColor clearColor];
    
    [shangpinTab addTarget:self action:@selector(tabClickAction:) forControlEvents:UIControlEventTouchUpInside];
    shangpinTab.tag = 1;
    [imgView addSubview:shangpinTab];
    
    
    self.formTab = [UIButton buttonWithType:UIButtonTypeCustom];
    formTab.adjustsImageWhenHighlighted = NO;
    formTab.frame = CGRectMake(160.0f, 0.0f, 80.0f, 50.0f);
    formTab.backgroundColor = [UIColor clearColor];
   
    [formTab addTarget:self action:@selector(tabClickAction:) forControlEvents:UIControlEventTouchUpInside];
    formTab.tag = 2;
    [imgView addSubview:formTab];
    
    
    self.mineTab = [UIButton buttonWithType:UIButtonTypeCustom];
    mineTab.adjustsImageWhenHighlighted = NO;
    mineTab.frame = CGRectMake(240.0f, 0.0f, 80.0f, 50.0f);
    mineTab.backgroundColor = [UIColor clearColor];
  
    [mineTab addTarget:self action:@selector(tabClickAction:) forControlEvents:UIControlEventTouchUpInside];
    mineTab.tag = 3;
    [imgView addSubview:mineTab];
    [self.tabBarController.tabBar addSubview:imgView];
    [imgView release];
 
    if ([versionType isEqualToString:@"1"]) {
         [homeTab setImage:[UIImage imageNamed:@"homeSelected.png"] forState:UIControlStateNormal];
        [shangpinTab setImage:[UIImage imageNamed:@"shangpin"] forState:UIControlStateNormal];
         [formTab setImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
          [mineTab setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
    }else{
        [homeTab setImage:[UIImage imageNamed:@"hh_home_Ico_select"] forState:UIControlStateNormal];
        [shangpinTab setImage:[UIImage imageNamed:@"hh_health_Ico_unselect"] forState:UIControlStateNormal];
        [formTab setImage:[UIImage imageNamed:@"hh_life_Ico_unselect"] forState:UIControlStateNormal];
        [mineTab setImage:[UIImage imageNamed:@"hh_user_Ico_unselect"] forState:UIControlStateNormal];
    }
    
    for (UIView * v in [self.tabBarController.tabBar subviews]) {
        if(v && [NSStringFromClass([v class]) isEqualToString:@"UITabBarButton"])
            [v removeFromSuperview];
    }
    
    
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if ([tabBarController.viewControllers indexOfObject:viewController]==2 && ![[ConstObject instance] isLogin]) {
//        return NO;
//    }
//    else {
//        return YES;
//    }
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//
//}



#pragma -mark Functions;

- (void)tabClickAction:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *versionType = [userDefaults objectForKey:@"version"];
    
   
    
    switch (btn.tag) {
        case 0:
              self.tabBarController.selectedIndex = btn.tag;
             if ([versionType isEqualToString:@"1"]) {
            [homeTab setImage:[UIImage imageNamed:@"homeSelected.png"] forState:UIControlStateNormal];
            [shangpinTab setImage:[UIImage imageNamed:@"shangpin.png"] forState:UIControlStateNormal];
            [formTab setImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
            [mineTab setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
             }else{
                 [homeTab setImage:[UIImage imageNamed:@"hh_home_Ico_select"] forState:UIControlStateNormal];
                 [shangpinTab setImage:[UIImage imageNamed:@"hh_health_Ico_unselect"] forState:UIControlStateNormal];
                 [formTab setImage:[UIImage imageNamed:@"hh_life_Ico_unselect"] forState:UIControlStateNormal];
                 [mineTab setImage:[UIImage imageNamed:@"hh_user_Ico_unselect"] forState:UIControlStateNormal];
             }
            
            break;
        case 1:
              self.shopListViewController.isFirst = YES;//第一次进入
              self.tabBarController.selectedIndex = btn.tag;
             if ([versionType isEqualToString:@"1"]) {
            [homeTab setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            [shangpinTab setImage:[UIImage imageNamed:@"shangpinSelected.png"] forState:UIControlStateNormal];
            [formTab setImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
            [mineTab setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
             }else{
                 [homeTab setImage:[UIImage imageNamed:@"hh_home_Ico_unselect"] forState:UIControlStateNormal];
                 [shangpinTab setImage:[UIImage imageNamed:@"hh_health_Ico_select"] forState:UIControlStateNormal];
                 [formTab setImage:[UIImage imageNamed:@"hh_life_Ico_unselect"] forState:UIControlStateNormal];
                 [mineTab setImage:[UIImage imageNamed:@"hh_user_Ico_unselect"] forState:UIControlStateNormal];
             }

            break;
        case 2:
              self.tabBarController.selectedIndex = btn.tag;
                  if ([versionType isEqualToString:@"1"]) {
            [homeTab setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            [shangpinTab setImage:[UIImage imageNamed:@"shangpin.png"] forState:UIControlStateNormal];
            [formTab setImage:[UIImage imageNamed:@"formSelected.png"] forState:UIControlStateNormal];
            [mineTab setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
                  }else{
                      [homeTab setImage:[UIImage imageNamed:@"hh_home_Ico_unselect"] forState:UIControlStateNormal];
                      [shangpinTab setImage:[UIImage imageNamed:@"hh_health_Ico_unselect"] forState:UIControlStateNormal];
                      [formTab setImage:[UIImage imageNamed:@"hh_life_Ico_select"] forState:UIControlStateNormal];
                      [mineTab setImage:[UIImage imageNamed:@"hh_user_Ico_unselect"] forState:UIControlStateNormal];
                  }

            break;
        case 3:
              self.tabBarController.selectedIndex = btn.tag;
                       if ([versionType isEqualToString:@"1"]) {
            [homeTab setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            [shangpinTab setImage:[UIImage imageNamed:@"shangpin.png"] forState:UIControlStateNormal];
            [formTab setImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
            [mineTab setImage:[UIImage imageNamed:@"mineSelected.png"] forState:UIControlStateNormal];
                       }else{
                           [homeTab setImage:[UIImage imageNamed:@"hh_home_Ico_unselect"] forState:UIControlStateNormal];
                           [shangpinTab setImage:[UIImage imageNamed:@"hh_health_Ico_unselect"] forState:UIControlStateNormal];
                           [formTab setImage:[UIImage imageNamed:@"hh_life_Ico_unselect"] forState:UIControlStateNormal];
                           [mineTab setImage:[UIImage imageNamed:@"hh_user_Ico_select"] forState:UIControlStateNormal];
                       }

            break;
            
       default://只修改样式
//            self.shopListViewController.theCategoryId = [NSString stringWithFormat:@"%ld", (long)btn.tag];
//            self.shopListViewController.isFirst = YES;//第一次进入
//             self.tabBarController.selectedIndex = 1;
//            [homeTab setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//            [shangpinTab setImage:[UIImage imageNamed:@"shangpinSelected.png"] forState:UIControlStateNormal];
//            [formTab setImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
//            [mineTab setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
            break;

    }
    
}

-(void)createCategoryPlist
{
    //    NSMutableArray *buttonImageArray = [NSMutableArray arrayWithObjects:@"家装",@"婚庆",@"鲜花绿植",@"教育",@"亲子",@"便民服务",@"电影",@"酒店",@"艺术摄影",@"休闲娱乐",@"运动健身",@"家政保洁",@"汽车养护",@"电脑维修",@"租车",@"代驾",@"医疗健康",@"旅游",@"公共服务",@"女人",@"商务服务",@"美食餐馆",@"保险理财",@"送水",@"食品宅配",@"搬家",@"维修",@"洗衣",nil];
    //
    //    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:@"家装",@"婚庆",@"鲜花绿植",@"教育",@"亲子",@"便民服务",@"电影",@"酒店",@"",@"咖啡厅、茶馆、ktv、酒吧、台球、网吧/游乐园、棋牌、密室、足疗按摩、洗浴",@"",@"家政保洁",@"汽车养护",@"电脑维修",@"",@"代驾",@"医疗健康",@"旅游",@"公共服务",@"女人",@"商务服务",@"美食餐馆",@"保险理财",@"送水",@"食品宅配",@"搬家",@"维修",@"洗衣",nil];
    //
    //    NSMutableArray *categoryIdArray = [NSMutableArray arrayWithObjects:@"家装",@"婚庆",@"鲜花绿植",@"教育",@"亲子",@"便民服务",@"电影",@"酒店",@"455",@"423",@"468",@"家政保洁",@"汽车养护",@"电脑维修",@"436",@"代驾",@"医疗健康",@"旅游",@"公共服务",@"女人",@"商务服务",@"美食餐馆",@"保险理财",@"送水",@"食品宅配",@"搬家",@"维修",@"洗衣",nil];
    
    
    //    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"艺术、语言、学科、体育",@"亲子益智、亲子游乐...",@"修表、药店、修鞋...",@"",@"",@"",@"咖啡厅、茶馆、ktv、酒吧...",@"",@"保洁、保姆、陪护、月嫂...",@"洗车、维修、4S店、驾校",@"手机维修、家电维修",@"",@"",@"医院、体检、中医、口腔",@"采摘/农家乐、港澳台、境外游",@"银行、邮政通讯、快递...",@"美发、美甲、美容/spa...",@"公司注册、律师、会计...",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"正餐、快餐、饮料、桶装水...",@"水果、蔬菜、粮油副食...",@"",@"门窗、开锁换锁、水管、电路",@"洗鞋", nil];
    //
    //     NSMutableArray *categoryIdArray = [NSMutableArray arrayWithObjects:@"431",@"432",@"428",@"375",@"438",@"458",@"456",@"495",@"455",@"423",@"468",@"388",@"411",@"469",@"436",@"437",@"407",@"472",@"476",@"402",@"490",@"414",@"496",@"420",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=5",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=3",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=2",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=1",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=6",@"http://www.sjsh8.cn/ask/?/m/explore/?feature_id=4",@"http://www.sjsh8.cn/index.php?route=shbj/shenghuo",@"59",@"430",@"392",@"417", nil];
    //
    
    
    
    NSArray *dataArray = [NSMutableArray arrayWithCapacity:1];
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"category.plist"];
    
    //    for(int i=0; i<[buttonImageArray count]; i++){
    //
    //        NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    //        [plugin1 setObject:[NSString stringWithFormat:@"%@",[buttonImageArray objectAtIndex:i]] forKey:@"mainTitle"];
    //        [plugin1 setObject:[NSString stringWithFormat:@"%@",[stringArray objectAtIndex:i]] forKey:@"secondTitle"];
    //        NSMutableString *tempString = [NSMutableString stringWithFormat:@"%@",[buttonImageArray objectAtIndex:i]];
    //        [tempString appendString:[NSString stringWithFormat:@"%d",1]];
    //        [plugin1 setObject:tempString forKey:@"categoryImage"];
    //        if(i<[buttonImageArray count] && i>29)
    //            [plugin1 setObject:@"2" forKey:@"categorySelected"];
    //        else if(i<9)
    //            [plugin1 setObject:@"1" forKey:@"categorySelected"];
    //        else
    //            [plugin1 setObject:@"0" forKey:@"categorySelected"];
    //
    //        [plugin1 setObject:[NSString stringWithFormat:@"%@",[categoryIdArray objectAtIndex:i]] forKey:@"categoryId"];
    //
    //        [dataArray addObject:plugin1];
    //    }
    dataArray = @[
                  @{@"mainTitle":@"租车", @"secondTitle":@"", @"categoryImage":@"租车1",@"categorySelected":@"0",@"categoryId":@"436"},
                  @{@"mainTitle":@"休闲娱乐", @"secondTitle":@"咖啡厅、茶馆、ktv、酒吧、台球、网吧/游乐园、棋牌、密室、足疗按摩、洗浴", @"categoryImage":@"休闲娱乐1",@"categorySelected":@"0",@"categoryId":@"423"},
                  @{@"mainTitle":@"运动健身", @"secondTitle":@"", @"categoryImage":@"运动健身1",@"categorySelected":@"0",@"categoryId":@"468"},
                  @{@"mainTitle":@"艺术摄影", @"secondTitle":@"",@"categoryImage":@"艺术摄影1",@"categorySelected":@"0",@"categoryId":@"455"},
                  @{@"mainTitle":@"美食餐馆", @"secondTitle":@"",@"categoryImage":@"美食餐馆1",@"categorySelected":@"0",@"categoryId":@"496"},
                  @{@"mainTitle":@"便民服务", @"secondTitle":@"修表、药店、修鞋、快照打印、买药、挂号、火车票、机票、超市", @"categoryImage":@"便民服务1",@"categorySelected":@"0",@"categoryId":@"458"},
                  @{@"mainTitle":@"电影", @"secondTitle":@"",@"categoryImage":@"电影1",@"categorySelected":@"0",@"categoryId":@"456"},
                  @{@"mainTitle":@"搬家", @"secondTitle":@"",@"categoryImage":@"搬家1",@"categorySelected":@"0",@"categoryId":@"430"},
                  @{@"mainTitle":@"家居维修", @"secondTitle":@"门窗、开锁换锁、水管、电路",@"categoryImage":@"家居维修1",@"categorySelected":@"0",@"categoryId":@"392"},
                  @{@"mainTitle":@"家装", @"secondTitle":@"",@"categoryImage":@"家装1",@"categorySelected":@"0",@"categoryId":@"431"},
                  @{@"mainTitle":@"婚庆", @"secondTitle":@"", @"categoryImage":@"婚庆1",@"categorySelected":@"0",@"categoryId":@"432"},
                  @{@"mainTitle":@"鲜花绿植", @"secondTitle":@"",@"categoryImage":@"鲜花绿植1",@"categorySelected":@"0",@"categoryId":@"428"},
                  @{@"mainTitle":@"酒店", @"secondTitle":@"",@"categoryImage":@"酒店1",@"categorySelected":@"0",@"categoryId":@"495"},
                  @{@"mainTitle":@"电脑维修", @"secondTitle":@"手机维修、家电维修",@"categoryImage":@"电脑维修1",@"categorySelected":@"0",@"categoryId":@"469"},
                  @{@"mainTitle":@"代驾", @"secondTitle":@"",@"categoryImage":@"代驾1",@"categorySelected":@"0",@"categoryId":@"437"},
                  @{@"mainTitle":@"医疗健康", @"secondTitle":@"医院、体检、中医、口腔",@"categoryImage":@"医疗健康1",@"categorySelected":@"0",@"categoryId":@"407"},
                  @{@"mainTitle":@"旅游", @"secondTitle":@"采摘/农家乐、港澳台、境外游",@"categoryImage":@"旅游1",@"categorySelected":@"0",@"categoryId":@"472"},
                  @{@"mainTitle":@"公共服务", @"secondTitle":@"银行、邮政通讯、快递、加油站、停车场", @"categoryImage":@"公共服务1",@"categorySelected":@"0",@"categoryId":@"476"},
                  @{@"mainTitle":@"商务服务", @"secondTitle":@"公司注册、律师、会计、基金证劵", @"categoryImage":@"商务服务1",@"categorySelected":@"0",@"categoryId":@"490"},
                  @{@"mainTitle":@"保险理财", @"secondTitle":@"", @"categoryImage":@"保险理财1",@"categorySelected":@"0",@"categoryId":@"420"},
                  //		@{@"mainTitle":@"房产中介", "", R.drawable.fangwuzhongjie, true, 0, 29, 414"},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_linlihuodong, "邻里活动", "", R.drawable.linlihuodong, true, 0, 30, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=5""},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_pinche, "拼车", "", R.drawable.pinche, true, 0, 31, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=3""},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_chongwu, "宠物", "", R.drawable.chongwu, true, 0, 32, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=2""},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_tiaozaoshichang, "跳蚤市场", "", R.drawable.tiaozaoshichang, true, 0, 33, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=1""},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_laowushichang, "劳务市场", "", R.drawable.laowushichang, true, 0, 34, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=6""},
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_banshizhinan, "办事指南", "", R.drawable.banshizhinan, true, 0, 35, "http://www.sjsh8.cn/ask/?/m/explore/?feature_id=4""},
                  
                  
                  //		viewListTemp.add(new IndexListItem(R.drawable.item_songsuidingcan, "送水订餐", "正餐、快餐、饮料、桶装水、瓶装水", R.drawable.songsuidingcan, false, 14, 1, "http://www.sjsh8.cn/index.php?route=shbj/shenghuo""},
                  
                  
                  
                  
                  @{@"mainTitle":@"亲子", @"secondTitle":@"亲子益智、亲子游乐、亲子摄影、亲子购物", @"categoryImage":@"亲子1",@"categorySelected":@"1",@"categoryId":@"438"},
                  @{@"mainTitle":@"女人", @"secondTitle":@"美发、美甲、美容/spa、瑜伽瘦身、产后恢复、服装鞋帽、珠宝首饰、化妆品",@"categoryImage":@"女人1",@"categorySelected":@"1",@"categoryId":@"402"},
                  @{@"mainTitle":@"汽车养护", @"secondTitle":@"洗车、维修、4S店、驾校", @"categoryImage":@"汽车养护1",@"categorySelected":@"1",@"categoryId":@"411"},
                  @{@"mainTitle":@"洗衣", @"secondTitle":@"洗鞋",@"categoryImage":@"洗衣1",@"categorySelected":@"1",@"categoryId":@"417"},
                  @{@"mainTitle":@"教育", @"secondTitle":@"艺术、语言、学科、体育",@"categoryImage":@"教育1",@"categorySelected":@"1",@"categoryId":@"375"},
                  @{@"mainTitle":@"食品宅配", @"secondTitle":@"水果、蔬菜、粮油副食、肉禽奶蛋、休闲食品", @"categoryImage":@"食品宅配1",@"categorySelected":@"2",@"categoryId":@"59"},
                  @{@"mainTitle":@"送水", @"secondTitle":@"正餐、快餐、饮料、桶装水、瓶装水", @"categoryImage":@"送水1",@"categorySelected":@"2",@"categoryId":@"511"},
                  @{@"mainTitle":@"家政保洁", @"secondTitle":@"保洁、保姆、陪护、月嫂、育儿嫂 ",@"categoryImage":@"家政保洁1",@"categorySelected":@"2",@"categoryId":@"388"},
                  
                  ];
    
    [dataArray writeToFile:plistPath atomically:YES];
}

+ (AppDelegate *)shareDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (IBAction)weixinLogin:(UIViewController *)sender
{
    tempViewController = sender;
    [self sendAuthRequest];
}

-(void)sendAuthRequest
{
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";// snsapi_userinfo
    req.state = @"0744" ;
    [WXApi sendReq:req];
}

//授权后回调 <span style="font-family: Arial;">WXApiDelegate</span>
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    
    NSLog(@"微信回调！！！！！！！！！！");
    if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            self.WXcode = aresp.code;
            [self getAccess_token];
        }
    }
    else if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        
        //        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        //        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", response.errCode];
        
        switch (response.errCode) {
            case WXSuccess: {
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@{@"result":@"success",@"code":[NSNumber numberWithInt:response.errCode]}];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
                
            default: {
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@{@"result":@"fail",@"code":[NSNumber numberWithInt:response.errCode]}];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

-(void)getAccess_token
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,self.WXcode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                self.WXaccesstoken = [dic objectForKey:@"access_token"];
                self.WXopenId = [dic objectForKey:@"openid"];
                [self getUserInfo];
            }
        });
    });
}

-(void)getUserInfo
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.WXaccesstoken,self.WXopenId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
                NSString *name = [dic objectForKey:@"nickname"];
                NSString *unionid = [dic objectForKey:@"unionid"];
                NSString *headUrl = [dic objectForKey:@"headimgurl"];
                //                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                if (tempViewController &&[tempViewController isKindOfClass:[LoginViewController class]]) {
                    LoginViewController *loginVc = (LoginViewController *)tempViewController;
                    [loginVc pushToBindRegisterVc:@{@"type":@"WX",@"nickName":name,@"headimgurl":headUrl,@"openId":self.WXopenId,@"accessToken":unionid}];
                }
                
            }
        });
        
    });
}

- (void)tencentLogin:(UIViewController *)sender
{
    tempViewController = sender;
    _permissions = [NSMutableArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:KTCappid
                                            andDelegate:self];
    [_tencentOAuth authorize:_permissions inSafari:NO]; //授权
}

- (void)tencentDidLogin
{
    
    NSLog(@"登录完成");
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
        //        _labelAccessToken.text = _tencentOAuth.accessToken;
        self.QQaccesstoken = _tencentOAuth.accessToken;
        self.QQopenId = _tencentOAuth.openId;
        [_tencentOAuth getUserInfo];
        
    }else{
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled){
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}

-(void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    //   NSLog(@"respons:%@",response.jsonResponse);
    
    NSString *name = [response.jsonResponse objectForKey:@"nickname"];
    NSString *headUrl = [response.jsonResponse objectForKey:@"figureurl"];
    if (tempViewController &&[tempViewController isKindOfClass:[LoginViewController class]]) {
        LoginViewController *loginVc = (LoginViewController *)tempViewController;
        [loginVc pushToBindRegisterVc:@{@"type":@"QQ",@"nickName":name,@"headimgurl":headUrl,@"openId":self.QQopenId,@"accessToken":self.QQaccesstoken}];
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             int rStauts = [resultDic[@"resultStatus"] intValue];
             NSString *s = resultDic[@"memo"];
             switch (rStauts) {
                 case 9000: {
                     s = @"支付成功";
                     
                     [OrderUnit depositPaySucessCallBack:resultDic];
                     break;
                 }
                 case 8000: {
                     break;
                 }
                 case 4000: {
                     break;
                 }
                 case 6001: {
                     NSLog(@"取消支付！！！！！！");
                     [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"resultByAlipay"
                      object:nil];
                     break;
                 }
                 case 6002: {
                     break;
                 }
                 default:
                     break;
             }
         }];
        return YES;
    }
    else
        
        return [TencentOAuth HandleOpenURL:url] ||[WXApi handleOpenURL:url delegate:self];
    //
    //    [WeiboSDK handleOpenURL:url delegate:self] ||
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url] ||[WXApi handleOpenURL:url delegate:self];
    //
    //    [WeiboSDK handleOpenURL:url delegate:self] ||
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
