//
//  UITempletViewController.h
//  ChuanDaZhi
//
//  Created by hers on 13-6-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import <UIKit/UIKit.h>
#import "ConstObject.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "CommonModel.h"
#import "SCGIFImageView.h"
#import "UIImageView+WebCache.h"

@interface UITempletViewController : UIViewController<UIAlertViewDelegate>{
    UIButton     *leftButton;//左导航按钮
    UIButton     *rightButton;//右导航按钮
    UIButton     *hintButton;
    CommonModel  *commonModel;
    SCGIFImageView* _gifImageView;
    
}

@property (nonatomic,retain) UIButton *leftButton;
@property (nonatomic,retain) UIButton *rightButton;
@property (nonatomic,retain) CommonModel *commonModel;
@property (nonatomic,retain) UIImageView *loadingImageView;

@property (nonatomic,retain) UIActivityIndicatorView *loadIndicator;
@property (nonatomic,retain) UIView *backageView;
@property (nonatomic,retain) UIView *backageTopView;


-(void)initNavBar:(NSString *)title;

//NavBar设置
- (void)initNavBarItems:(NSString *)titlename;

//NavBar左右按钮
- (void)addButtonReturn:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked;

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView;
- (void)addRightTitle:(NSString *)title   selector:(SEL)pushPastView;

- (void)setHintNum:(NSInteger)num;
- (void)getCartNum;

//解析数据
- (NSDictionary *)parseJsonRequest:(ASIHTTPRequest *) request;
//解析数据（测试环境下）
- (NSDictionary *)parseJsonRequestByTest:(NSString *) response;

//显示文字加载提示
- (void)showMBProgressHUD:(NSString *)title;

//隐藏加载提示
- (void)hideMBProgressHUD;


//检查登录状态
- (BOOL)checkLoginStatus:(NSDictionary *)aDict;

//提示网络状态
- (BOOL)checkNetworkStatus;

//显示UIAlert提示框
- (void)showMessageBox:(id)aDelegate title:(NSString *)aTitle  message:(NSString *)aMessage cancel:(NSString *)aCancel confirm:(NSString *)aConfirm;

//
- (NSString *)fileTextPath:(NSString *)fileName;

//保存当前cookie
- (void)saveCookies;

//重载cookie
- (void)reloadStoredCookies;

//清除当前cookie
- (void)deleteCookies;
-(void)pushToLoginVC:(BOOL)nonPop animation:(BOOL)animation;
- (void)pushToOrderPage;
-(void)showGif;
-(void)hideGif;
- (void)call400;

- (void)requestFailed:(ASIHTTPRequest *)request;//接口调用失败
@end
