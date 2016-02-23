//
//  OpenURLViewController.h
//  BeautyMakeup
//
//  Created by nuohuan on 14-1-16.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import "UITempletViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "UPPayPluginDelegate.h"
#import "AddOrderViewController.h"


#define failURlStr [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]

//
//测试商品信息封装在Product中,外部商户可以根据自己商品实际情况定义
//
@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
    NSString *_returnUrl;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *returnUrl;

@end

@interface WXProduct : NSObject{
@private
    int     _total_fee;
    NSString *_outTradNo;
    NSString *_body;
    NSString *_traceId;
    NSString *_returnUrl;
}

@property (nonatomic, assign) int total_fee;
@property (nonatomic, copy) NSString *outTradNo;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, copy) NSString *returnUrl;

@end

@interface OpenURLViewController : UITempletViewController<UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,EGORefreshTableHeaderDelegate,UPPayPluginDelegate>{
    UIWebView                  *m_webView;//浏览器视图
    UIView                     *toolBar;//底部栏
    UIButton                   *backButton;//回退
    UIButton                   *forwardButton;//前进
    UIButton                   *refreshButton;//刷新
    NSString                   *title;//标题
    
    UIActivityIndicatorView    *activityView;//加载等待
    BOOL                       needHiddenTopBar;//标志是否需要隐藏上导航
    
    
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    //刷新标识，是否正在刷新过程中
    BOOL _reloading;
    
}

@property(nonatomic,assign)BOOL needHiddenTopBar;
@property (nonatomic, retain) NSString                   *addrUrl;//地址
@property (nonatomic, retain) Product                   *alipayProduct;//付款产品
@property (nonatomic, retain) WXProduct *WXPayProduct;
@property (nonatomic, assign) BOOL hide400;
@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, retain) NSString                   *upTN;//地址
@property (nonatomic, retain) NSString                   *upOrderId;//地址
@property (nonatomic, retain) NSString                   *upReturnUrl;//地址
//初始化webView
-(void)initWithUrl:(NSString *)addressUrl andTitle:(NSString *)titles;
- (void)roadPayResultWithCode:(NSString *)code;
@end
