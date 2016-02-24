//
//  UITempletViewController.m
//  ChuanDaZhi
//
//  Created by hers on 13-6-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#include "QuartzCore/QuartzCore.h"
#import "UITempletViewController.h"
#import "LoginViewController.h"
#import "MyOrderListViewController.h"
#import "DXAlertView.h"
#import "Message.h"

@interface UITempletViewController ()<UIActionSheetDelegate>

@end

@implementation UITempletViewController
@synthesize commonModel;
@synthesize leftButton,rightButton;
@synthesize loadingImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        commonModel = [[CommonModel alloc] initWithTarget:self];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    if (self.navigationItem.hidesBackButton == NO) {
//        [self.navigationItem setHidesBackButton:YES animated:NO];
//    }
//    [self.navigationItem  setHidesBackButton:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *versionType = [userDefaults objectForKey:@"version"];
     if ([versionType isEqualToString:@"1"]) {
    [self.navigationController.navigationBar setBarTintColor:COLOR(250, 99, 56)];//设置navigationbar的颜色
     }else if ([versionType isEqualToString:@"2"]){
     [self.navigationController.navigationBar setBarTintColor:backageBlueWithHH];
     }
    //设置导航背景图片
//    if (kSystemIsIOS7) {
////        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBarBg.png"] forBarMetrics:UIBarMetricsDefault];
////        [[UINavigationBar appearance] setBackgroundColor:COLOR(250, 250, 250)];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    }
//    else{
////        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBarBg6.png"] forBarMetrics:UIBarMetricsDefault];
////        [[UINavigationBar appearance] setBackgroundColor:COLOR(250, 250, 250)];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    }
    
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
//    // 首先要判断版本号，否则在iOS 6 以下的版本会闪退  为了个人中心上部分一体 去除掉上导航毛边效果
//       self.navigationController.navigationBar.shadowImage = [[[UIImage alloc] init] autorelease];
//    }
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    
    self.loadIndicator =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadIndicator.center = CGPointMake(ScreenWidth*0.5, ScreenHeight*0.5-30);//只能设置中心，不能设置大小
//    [self.loadIndicator setFrame = CGRectMack(100, 100, 100, 100)];//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [self.view addSubview:self.loadIndicator];
    self.loadIndicator.color = kRedColor; // 改变圈圈的颜色为红色； iOS5引入
    
    //提交弹出层
    self.backageTopView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    self.backageTopView.backgroundColor = [UIColor blackColor];
    self.backageTopView.alpha = 0.4;
    self.backageTopView.hidden = YES;
    UIWindow *myWindow  = [[UIApplication sharedApplication].delegate window];
    [myWindow addSubview:self.backageTopView];
    
    self.backageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.backageView.backgroundColor = [UIColor blackColor];
    self.backageView.alpha = 0.4;
    self.backageView.hidden = YES;
    [self.view addSubview:self.backageView];
}

-(void)initNavBar:(NSString *)title{

    [self initNavBarItems:title];
//    if (kSystemIsIOS7) {
//        //        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBarBg.png"] forBarMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setBackgroundColor:COLOR(0, 250, 250)];
//    }
//    else{
//        //        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBarBg6.png"] forBarMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setBackgroundColor:COLOR(0, 250, 250)];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    }
//    [[UINavigationBar appearance] setTintColor:COLOR(250, 99, 56)];
}

#pragma --mark Functions
- (void)hideNavBarItems{
    self.navigationController.navigationBarHidden = YES;
}

- (void)noHideNavBarItems{
    self.navigationController.navigationBarHidden = NO;
}

- (void)initNavBarItems:(NSString *)titlename{
//    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    //修改背景图
//    UIView *backgroundView = nil;
//    
//    if (kSystemIsIOS7) {
//        backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 220.0f, 64.0f)];
//        backgroundView.backgroundColor = [UIColor clearColor];
//    }
//    else{
//        backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 220.0f, 44.0f)];
//        backgroundView.backgroundColor = [UIColor clearColor];
//    }
//    
//    backgroundView.tag = 1011;
    
    //设置标题
    UILabel *aTitleLabel = nil;
    
    if (kSystemIsIOS7) {
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    }
    else{
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    }
    aTitleLabel.text = titlename;
    aTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    aTitleLabel.textAlignment = NSTextAlignmentCenter;
    aTitleLabel.backgroundColor = [UIColor clearColor];
    aTitleLabel.adjustsFontSizeToFitWidth = YES;
    aTitleLabel.textColor = [UIColor whiteColor];
    aTitleLabel.userInteractionEnabled = YES;
//    [backgroundView addSubview:aTitleLabel];
//    [aTitleLabel release];
//    self.navigationItem.title = titlename;
    [self.navigationItem setTitleView:aTitleLabel];
//    [backgroundView release];
}


- (void)addButtonReturn:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked{
    leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTintColor:[UIColor whiteColor]];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [leftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:buttonClicked forControlEvents:UIControlEventTouchUpInside];
    
//    if (kSystemIsIOS7) {
//        leftButton.frame = CGRectMake(-8.0f, 9.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
//    }
//    else{
//        leftButton.frame = CGRectMake(-5.0f, 2.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
//    }
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    leftButton.tag = NAME_MAX;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView{
    rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [rightButton setTintColor:[UIColor whiteColor]];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:pushPastView forControlEvents:UIControlEventTouchUpInside];
//    if (kSystemIsIOS7) {
//        rightButton.frame = CGRectMake(0.0f, 9.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
//    }
//    else{
//        rightButton.frame = CGRectMake(0.0f, 2.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
//    }
     rightButton.frame = CGRectMake(0.0f, 0.0f, 60,44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    rightButton.tag = 10009;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [self.navigationItem.titleView addSubview:rightButton];
}

- (void)addRightTitle:(NSString *)title   selector:(SEL)pushPastView{
    rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [rightButton setTintColor:[UIColor whiteColor]];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton addTarget:self action:pushPastView forControlEvents:UIControlEventTouchUpInside];
    //    if (kSystemIsIOS7) {
    //        rightButton.frame = CGRectMake(0.0f, 9.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
    //    }
    //    else{
    //        rightButton.frame = CGRectMake(0.0f, 2.0f, [UIImage imageNamed:image].size.width,[UIImage imageNamed:image].size.height);
    //    }
    rightButton.frame = CGRectMake(20.0f, 0.0f, 40,44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    rightButton.tag = 10009;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //    [self.navigationItem.titleView addSubview:rightButton];
}



- (void)setHintNum:(NSInteger)num
{
    if (hintButton == nil) {
        hintButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        [hintButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        hintButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        hintButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [hintButton setBackgroundImage:[UIImage imageNamed:@"hint"] forState:UIControlStateNormal];
        [hintButton setBackgroundImage:[UIImage imageNamed:@"hint"] forState:UIControlStateHighlighted];
        hintButton.frame = CGRectMake(42, 5.0f, 15,15);
        [rightButton addSubview:hintButton];
    }
    [hintButton setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
    if (num>0) {
        hintButton.hidden = NO;
    }
    else {
        hintButton.hidden = YES;
    }
}

//获取购物车数量接口
- (void)getCartNum
{
    [commonModel requestgetcount:nil httpRequestSucceed:@selector(requestgetcountSuccess:) httpRequestFailed:nil];
}

- (void)requestgetcountSuccess:(ASIHTTPRequest *)request
{
    NSDictionary *dic = [self parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSInteger num = [[dic objectForKey:@"msg"] integerValue];
        [[ConstObject instance] setCartNum:num];
        [self setHintNum:num];
    }
}

#pragma parseJsonRequest

- (NSDictionary *)parseJsonRequest:(ASIHTTPRequest *) request{
//    [self saveCookies];
    NSArray *cookies = [request responseCookies];
    if ([cookies count]>0) {
        [commonModel updateCookieWithObject:cookies];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSData *data = [request responseData];
    NSString *response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    //打印请求返回的原串   JSONKit解析
//    NSLog(@"response string=%@",response);
    NSDictionary *message = [response objectFromJSONString];
    return message;
}

- (NSDictionary *)parseJsonRequestByTest:(NSString *) response{
   
    //打印请求返回的原串   JSONKit解析
    //    NSLog(@"response string=%@",response);
    NSDictionary *message = [response objectFromJSONString];
    return message;
}

- (void)showMBProgressHUD:(NSString *)title{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = title;
}


- (void)hideMBProgressHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showMBProgressHUDOnlyForAskAndAnswer:(NSString *)title offsetY:(float)anOffsetY{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CGRect tRect = HUD.frame;
    tRect.origin.y -= anOffsetY;
    HUD.frame = tRect;
    HUD.labelText = title;
}


- (BOOL)checkLoginStatus:(NSDictionary *)aDict{
    if ([[NSString stringWithFormat:@"%@",[aDict objectForKey:@"status"]] intValue] == 1 && [[aDict objectForKey:@"nologin"] intValue] == 1) {
        [self showMessageBox:self
                       title:@"温馨提示"
                     message:[aDict objectForKey:@"error"]
                      cancel:nil
                     confirm:@"去登录"];
        
        return NO;
    }
    else{
        return YES;
    }
}

- (BOOL)checkNetworkStatus{
    if (![CheckNetwork isExistenceNetwork]){
        [self showMessageBox:nil
                       title:@"温馨提示"
                     message:@"网络不给力,请稍后再试"
                      cancel:nil
                     confirm:@"确定"];
        [self hideMBProgressHUD];
        return NO;
    }
    else{
        return YES;
    }
}

- (void)showMessageBox:(id)aDelegate title:(NSString *)aTitle  message:(NSString *)aMessage cancel:(NSString *)aCancel confirm:(NSString *)aConfirm{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
//                                                    message:aMessage
//                                                   delegate:aDelegate
//                                          cancelButtonTitle:aCancel
//                                          otherButtonTitles:aConfirm, nil];
    
     [Message messageDXAlert:aMessage leftTitle:aCancel rightTitle:aConfirm];
//    [alert show];
//    [alert release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [self hideMBProgressHUD];
    NSError *error = [request error];
    if ([error code] == ASIRequestTimedOutErrorType) {
        NSLog(@"time Out!!!");
//        [[LoadingView sharedManager] showView:self.view message:@"请求超时,请重试..." originX:100.0f originY:150.0f delay:1.5f];
    }
}

#pragma mark-  文件操作函数

- (NSString *)fileTextPath:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirctory = [paths objectAtIndex:0];
    return [docDirctory stringByAppendingPathComponent:fileName];
}

- (void)saveCookies{
    NSData *cookies = [NSKeyedArchiver archivedDataWithRootObject:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"savedCookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reloadStoredCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage setCookie:cookie];
    }
}

- (void)deleteCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

-(void)showGif{

    self.backageTopView.hidden = NO;
    self.backageView.hidden = NO;
    [self.view bringSubviewToFront:self.backageView];
    
[self.loadIndicator startAnimating]; // 开始旋转
//    self.view.userInteractionEnabled = NO;
}

-(void)hideGif{
    [self.loadIndicator stopAnimating]; // 结束旋转
    [self.loadIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    self.backageTopView.hidden = YES;
    self.backageView.hidden = YES;
    [self.view sendSubviewToBack:self.backageView];
    
//    self.view.userInteractionEnabled = YES;
}

//动画判断暂时作废，改为统一动画
-(void)pushToLoginVC:(BOOL)nonPop animation:(BOOL)animation {
    if (nonPop) {
        [self.navigationController popToRootViewControllerAnimated:animation];
    }
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.noShowReturn = nonPop;
    
    CATransition *transition = [CATransition animation];
 
    // 动画时间
    transition.duration = 0.3f;
    // 动画时间控制
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 
    // 是否代理
    
//    transition.delegate = self;
  
    
    // 是否在当前层完成动画
    
    // transition.removedOnCompletion = NO;
    // kCATransitionFade:   Core Animation 交叉淡化过渡，新视图渐显示，旧视图渐淡出视野
    
    
    
    // kCATransitionPush:   Core Animation过渡，新视图将旧视图推出去。有4种方式 kCATransitionFromTop | kCATransitionFromLeft ｜ kCATransitionFromBottom | kCATransitionFromRight
    
    
    
    // kCATransitionMoveIn: Core Animation过渡，新视图移到旧视图上面。同上有4种方式
    
    
    
    // kCATransitionReveal: Core Animation过渡，将旧视图移开显示出下面的新视图。同上有4种方式
    
    
    
    // 动画类型
    
    transition.type = kCATransitionPush;
    
    // 动画进入方式
    
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController pushViewController:loginViewController animated:NO];
    
    
    // 动画事件
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
   
}

- (void)pushToOrderPage
{
    MyOrderListViewController *myOrderListViewController = [[MyOrderListViewController alloc] init];
    [self.navigationController pushViewController:myOrderListViewController animated:YES];
    [myOrderListViewController release];
}



- (void)call400
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"通过世纪生活客服电话下单" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-010-6000", nil];
    [sheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"4000106000"];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)dealloc
{
    [commonModel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
