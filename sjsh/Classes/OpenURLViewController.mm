//
//  OpenURLViewController.m
//  BeautyMakeup
//
//  Created by nuohuan on 14-1-16.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import "OpenURLViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "MyOrderDetailViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MyShoppingCartViewController.h"
#import "WXApi.h"
#import "NSString+MD5Addition.h"
#import "CommonModel.h"
#import "UPPayPlugin.h"
#import "RSADataSigner.h"

#define BASE_URL @"https://api.weixin.qq.com"


@interface OpenURLViewController ()

//初始化底部工具条
- (void)initToolBar;

//开启加载等待
- (void)startActivityView;

//停止加载等待
- (void)stopActivityView;

//返回上一页
-(void)backHomePage;

@end

@implementation OpenURLViewController
@synthesize needHiddenTopBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //    [super initNavBarItems:nil];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    if (self.hide400 == NO) {
        [super addRightButton:@"400" lightedImage:@"400" selector:@selector(call400)];
    }
    //设置返回上一级的手势
    //    [self setupGestureRecognizers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
}

- (void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
}

-(void)toReturn
{
    if (m_webView.canGoBack) {
        [m_webView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma --mark
#pragma --mark Functions

- (void)initToolBar{
    if (iPhone5) {
        toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height - 44-42 , 320, 43)];
    }else{
        toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height - 44-20-22 , 320, 43)];
    }
    
    [toolBar setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomViewBackground.png"]];
    image.backgroundColor = [UIColor clearColor];
    [image setFrame:CGRectMake(0,0,toolBar.frame.size.width,toolBar.frame.size.height)];
    [toolBar addSubview:image];
    [image release];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setImage:[UIImage imageNamed:@"webUp.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"webUpLighted.png"] forState:UIControlStateHighlighted];
    [backButton setFrame:CGRectMake(20, 6, 30, 30)];
    [backButton addTarget:self action:@selector(browserBack) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:backButton];
    
    forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.backgroundColor = [UIColor clearColor];
    forwardButton.adjustsImageWhenHighlighted = NO;
    [forwardButton setImage:[UIImage imageNamed:@"webNext.png"] forState:UIControlStateNormal];
    [forwardButton setImage:[UIImage imageNamed:@"webNextLighted.png"] forState:UIControlStateHighlighted];
    [forwardButton setFrame:CGRectMake(100, 6, 30, 30)];
    [forwardButton addTarget:self action:@selector(browserForward) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:forwardButton];
    
    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.backgroundColor = [UIColor clearColor];
    refreshButton.adjustsImageWhenHighlighted = NO;
    [refreshButton setImage:[UIImage imageNamed:@"webRefresh.png"] forState:UIControlStateNormal];
    [refreshButton setImage:[UIImage imageNamed:@"webRefreshLighted.png"] forState:UIControlStateHighlighted];
    [refreshButton setFrame:CGRectMake(260, 6, 30, 30)];
    [refreshButton addTarget:self action:@selector(browserRefresh) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:refreshButton];
    
    [self.view addSubview:toolBar];
    [toolBar release];
}

- (void)initWithUrl:(NSString *)addressUrl andTitle:(NSString *)titles
{
    NSLog(@"addre=%@",addressUrl);
    
    self.addrUrl = addressUrl;
    title = titles;
    if(title == nil)
        title = @"";
    
    [super initNavBarItems:title];
    NSURL *url = [[NSURL alloc] initWithString:addressUrl];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:300];
    
    m_webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    m_webView.backgroundColor = [UIColor clearColor];
    m_webView.delegate = self;
    m_webView.scrollView.delegate = self;
    m_webView.tag = 1000000;
    m_webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [m_webView setFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width,kScreenBounds.size.height-44)];
    
    [m_webView loadRequest:req];
    [m_webView setScalesPageToFit:NO];
    [self.view addSubview: m_webView];
    [m_webView release];
    [url release];
    
    //初始化refreshView，添加到webview 的 scrollView子视图中
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-m_webView.scrollView.bounds.size.height, m_webView.scrollView.frame.size.width, m_webView.scrollView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [m_webView.scrollView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    //初始化底部工具栏
    //    [self initToolBar];
    
    //启动加载等待
    //    [self startActivityView];
}

//返回上一页
-(void)backHomePage{
    if(self.needHiddenTopBar){
        //        self.navigationController.navigationBarHidden = YES;
    }
    [self.navigationController popViewControllerAnimated:YES];
    //重载cookie,以免部分值域丢失
    [super reloadStoredCookies];
}

//回退
-(void)browserBack{
    if (m_webView.canGoBack == YES) {
        [m_webView goBack];
    }
}

//前进
-(void)browserForward{
    if (m_webView.canGoForward == YES) {
        [m_webView goForward];
    }
}

//刷新
-(void)browserRefresh{
    
    if ([m_webView.request.URL.absoluteString hasSuffix:failURlStr]) {
        
        if ([m_webView canGoBack]) {
            [m_webView goBack];
        }
        else{
            [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.addrUrl]]];
        }
    }
    else
        [m_webView reload];
}

- (void)startActivityView{
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.backgroundColor = [UIColor clearColor];
    activityView.frame = CGRectMake(130.0f, 250.0f, 45.0f, 45.0f);
    [activityView startAnimating];
    [self.view addSubview:activityView];
    [activityView release];
}

- (void)stopActivityView{
    [activityView stopAnimating];
}

#pragma --mark - 手势处理 返回上一级
-(void)setupGestureRecognizers{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
    [pan setDelegate:self];
    [self.view addGestureRecognizer:pan];
    [pan release];
}

-(void)panGestureCallback:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    //只是向右的50偏移，防止一碰触就返回的不良体验
    if (point.x > 50.0f) {
        [self backHomePage];
    }
}
#pragma --mark
#pragma --mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _reloading = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super hideGif];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:m_webView.scrollView];
    //    [m_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    //    for (id subView in [webView subviews]) {
    //        if ([subView respondsToSelector:@selector(flashScrollIndicators)]) {
    //            [subView flashScrollIndicators];
    //        }
    //    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    if (m_webView.canGoBack == YES) {
    //        [backButton setImage:[UIImage imageNamed:@"webUpLighted.png"] forState:UIControlStateNormal];
    //    }
    //    else {
    //        [backButton setImage:[UIImage imageNamed:@"webUp.png"] forState:UIControlStateNormal];
    //    }
    //
    //    if (m_webView.canGoForward == YES) {
    //        [forwardButton setImage:[UIImage imageNamed:@"webNextLighted.png"] forState:UIControlStateNormal];
    //    }
    //    else {
    //        [forwardButton setImage:[UIImage imageNamed:@"webNext.png"] forState:UIControlStateNormal];
    //    }
    NSString *urlStr = request.URL.absoluteString;
    NSString *failStr = failURlStr;
    if ([urlStr hasPrefix:@"sjsh://unionpay/?"]) {
        NSString *str = [[urlStr stringByReplacingOccurrencesOfString:@"sjsh://unionpay/?" withString:@""]  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *coms = [str componentsSeparatedByString:@"&"];
        
        self.upTN = [[coms objectAtIndex:0] stringByReplacingOccurrencesOfString:@"tn=" withString:@""];
        self.upOrderId = [[coms objectAtIndex:1] stringByReplacingOccurrencesOfString:@"order_id=" withString:@""];
        self.upReturnUrl = [[coms objectAtIndex:2] stringByReplacingOccurrencesOfString:@"return=" withString:@""];
        //        NSString *tn = @"201503242151400043562";//交易流水号信息，银联后台生成，通过商户后台返回到客户端并传入支付控件；
        NSString *tnMode = @"00";//@"00":代表接入生产环境（正式版本需要）；  @"01"：代表接入开发测试环境（测试版本需要）
        [UPPayPlugin startPay:self.upTN mode:tnMode viewController:self delegate:self];
        return NO;
    }
    if ([urlStr hasPrefix:@"sjsh://login/?submit="]) {
        [super pushToLoginVC:NO];
        return NO;
    }
    if ([urlStr hasPrefix:@"sjsh://orders/?order_id="]) {
        //进入订单页
        //        [super pushToOrderPage];
        NSString *orderId = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://orders/?order_id=" withString:@""];
        MyOrderDetailViewController *detailVc = [[MyOrderDetailViewController alloc] init];
        detailVc.orderID = orderId;
        [self.navigationController pushViewController:detailVc animated:YES];
        return NO;
    }
    if ([urlStr hasPrefix:@"sjsh://service/?url=home"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    if ([urlStr hasPrefix:@"sjsh://cart"])
    {
        MyShoppingCartViewController *shoppingCart = [[MyShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingCart animated:YES];
        return NO;
    }
    //sjsh://alipay/?order_id=&price=&title=&desc=&return=
    //    参数分别：订单号 价钱 标题  描述  返回网页地址（需要将支付宝返回给你的code  加在链接上）
    if ([urlStr hasPrefix:@"sjsh://alipay/?order_id="])
    {
        NSString *str = [[urlStr stringByReplacingOccurrencesOfString:@"sjsh://alipay/?" withString:@""]  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *coms = [str componentsSeparatedByString:@"&"];
        
        Product *product = [[Product alloc] init];
        product.orderId = [[coms objectAtIndex:0] stringByReplacingOccurrencesOfString:@"order_id=" withString:@""];
        product.price = [[[coms objectAtIndex:1] stringByReplacingOccurrencesOfString:@"price=" withString:@""] floatValue];
        product.subject = [[coms objectAtIndex:2] stringByReplacingOccurrencesOfString:@"title=" withString:@""];
        product.body = [[coms objectAtIndex:3] stringByReplacingOccurrencesOfString:@"desc=" withString:@""];
        product.returnUrl = [[coms objectAtIndex:4] stringByReplacingOccurrencesOfString:@"return=" withString:@""];
        [self gotoAlipayWithorderInfo:product];
        return NO;
    }
    
    if ([urlStr hasPrefix:@"sjsh://wxpay/?"]) {
        NSString *str = [[urlStr stringByReplacingOccurrencesOfString:@"sjsh://wxpay/?" withString:@""]  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *coms = [str componentsSeparatedByString:@"&"];
        
        WXProduct *product = [[WXProduct alloc] init];
        product.traceId = [[coms objectAtIndex:0] stringByReplacingOccurrencesOfString:@"traceId=" withString:@""];
        product.outTradNo = [[coms objectAtIndex:1] stringByReplacingOccurrencesOfString:@"outTradNo=" withString:@""];
        product.total_fee = [[[coms objectAtIndex:2] stringByReplacingOccurrencesOfString:@"total_fee=" withString:@""] intValue];
        product.body = [[coms objectAtIndex:3] stringByReplacingOccurrencesOfString:@"body=" withString:@""];
        product.returnUrl = [[coms objectAtIndex:4] stringByReplacingOccurrencesOfString:@"return=" withString:@""];
        [self pay:product];
        return NO;
    }
    
    if ([urlStr hasSuffix:failStr]==NO) {
        self.addrUrl = urlStr;
    }
    if ([urlStr hasPrefix:@"tel:"] == NO) {
        [super showGif];
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"load page error:%@", [error description]);
    [super hideGif];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:m_webView.scrollView];
    if ([m_webView.request.URL.absoluteString hasSuffix:failURlStr]== NO) {
        [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:failURlStr]]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self browserRefresh];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}


- (void)gotoAlipayWithorderInfo:(Product *)product
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088311228128442";
    NSString *seller = @"shijishenghuo@qq.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJxVJUvS3uA59+D6nNF/RF5EoH+WKhTPETBhvIhnwGFgGbIHsFPCdFH7V/TBTRG0tKHe3ZjJfLSG2jDKjtfeFCRc12iRpcXLm/ARdBeZUtrIA0uQImV2/1WlrrY35Pf5coVQqb8B4ucUoOzXEHnesDRt/xhK35Exbws1X6HatDeDAgMBAAECgYBGuP42Xx8UsSTCUp2+6KQ1QTaagYRoBYTxLkXsL4OIicEWGQRb4AxfSiVwREJpUCanU/tLs1sHEDqE+B3G6mCRnasPieL0x26gIbvH0Rn9p/TbiGYcQ6wXc18GqzHwhqKXJTrH61iBuYgcs5OwnUX4hD+FILebzEH4nzG31DMCAQJBAMoMDTVBj/95yJfD5S9K1UfLAJpN2u3GMwEg3FOIQQ5hKV1yaW6Xf6Ojoj1W++N7Wo0ppEdP+xtDlVE9419bOtECQQDGFAzYtXTYH5oj7gHy7TrzJIGxbf2IvI/tcZS6Azo6nihZ2SM7+jHR44p3C2GmvL62Nn6mVbrNYbaJjSrhw7oTAkEAt4fo+4ZZklyCjPFiHupgAH3zRzcPdktCi3TZDnvHdJNnqr3B7bZqOC/ssMFxv3qOj4nS8wBA/cwPN6P7BORu8QJAMopXJMxX/fVCTTyjfqqNShDcjrsz37nNN5atjjDYoLBON26yENGr+JQIdouO5Q5v0upgsmxZd6IhA0Pj1ysrxQJACc4OSncoVBTgpB4Eu+OVoIxqH4rhH7E3q4boJUd5yXkZhzHAQLyMmtpbG4FejaEhOJd5pwtQWWRFmt77MA1eDA==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *Aliorder = [[Order alloc] init];
    Aliorder.partner = partner;
    Aliorder.seller = seller;
    Aliorder.tradeNO = product.orderId; //订单ID（由商家自行制定）
    Aliorder.productName = product.subject; //商品标题
    Aliorder.productDescription = product.body; //商品描述
    Aliorder.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    Aliorder.notifyURL =  @"http://www.sjsh8.cn/Notify_message_alipay_mobile.php"; //回调URL
    
    //    order.service = @"mobile.securitypay.pay";
    //    order.paymentType = @"1";
    //    order.inputCharset = @"utf-8";
    //    order.itBPay = @"30m";
    //    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"sjshAlipay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [Aliorder description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = [[RSADataSigner alloc] initWithPrivateKey:privateKey];//CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[ConstObject instance] setVc:self];
        self.alipayProduct = product;
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}


- (void)roadPayResultWithCode:(NSString *)code
{
    NSString *urlStr = [self.alipayProduct.returnUrl stringByAppendingFormat:@"&order_id=%@&price=%f&title=%@&desc=%@&code=%@&from=alipay",self.alipayProduct.orderId,self.alipayProduct.price,self.alipayProduct.subject,self.alipayProduct.body,code];
    NSURL *url = [[NSURL alloc] initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:300];
    [m_webView loadRequest:req];
    [[ConstObject instance] setVc:nil];
    self.alipayProduct = nil;
}

- (void)pay:(WXProduct *)product
{
    [self getAccessToken:product];//获取access_token
}

#pragma mark - 主体流程
// 获取token
- (void)getAccessToken:(WXProduct *)product
{
    NSString *tokenUrl = @"cgi-bin/token";
    NSDictionary *param = @{@"grant_type":@"client_credential", @"appid":kWXAPP_ID, @"secret":kWXAPP_SECRET};
    [CommonModel doGetWithUrl:BASE_URL
                         path:tokenUrl
                       params:param
                     callback:^(BOOL isSuccessed, NSDictionary *result){
                         
                         NSString *accessToken = result[@"AccessTokenKey"];
                         [self getPrepayId:accessToken product:product];
                     }];
}

// 生成预支付订单
- (void)getPrepayId:(NSString *)accessToken product:(WXProduct *)product
{
    NSString *prepayIdUrl = [NSString stringWithFormat:@"pay/genprepay?access_token=%@", accessToken];
    
    // 拼接详细的订单数据
    NSDictionary *postDict = [self getProductArgsWithproduct:product];
    
    [CommonModel doPostWithUrl:BASE_URL
                          path:prepayIdUrl
                        params:postDict
                      callback:^(BOOL isSuccessed, NSDictionary *result){
                          
                          NSString *prePayId = result[@"prepayid"];
                          
                          // 获取预支付订单id，调用微信支付sdk
                          if (prePayId)
                          {
                              NSLog(@"--- PrePayId: %@", prePayId);
                              self.WXPayProduct = product;
                              // 调起微信支付
                              PayReq *request   = [[PayReq alloc] init];
                              request.partnerId = WXPartnerId;
                              request.prepayId  = prePayId;
                              request.package   = @"Sign=WXPay";
                              request.nonceStr  = self.nonceStr;
                              request.timeStamp = [self.timeStamp intValue];
                              
                              // 构造参数列表
                              NSMutableDictionary *params = [NSMutableDictionary dictionary];
                              [params setObject:kWXAPP_ID forKey:@"appid"];
                              [params setObject:WXAPPKey forKey:@"appkey"];
                              [params setObject:request.nonceStr forKey:@"noncestr"];
                              [params setObject:request.package forKey:@"package"];
                              [params setObject:request.partnerId forKey:@"partnerid"];
                              [params setObject:request.prepayId forKey:@"prepayid"];
                              [params setObject:self.timeStamp forKey:@"timestamp"];
                              request.sign = [self genSign:params];
                              
                              // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
                              [WXApi sendReq:request];//发送一个安全请求
                          }
                      }];
}

#pragma mark - 生成各种参数
// 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 *  获取32位内的随机串, 防重发
 *
 *  注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [NSString md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}


// 订单详情
- (NSString *)genPackageWithproduct:(WXProduct *)product
{
    // 构造订单参数列表
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"WX" forKey:@"bank_type"];
    [params setObject:product.body forKey:@"body"];
    [params setObject:@"1" forKey:@"fee_type"];
    [params setObject:@"UTF-8" forKey:@"input_charset"];
    [params setObject:@"http://weixin.qq.com" forKey:@"notify_url"];
    [params setObject:product.outTradNo forKey:@"out_trade_no"];
    [params setObject:WXPartnerId forKey:@"partner"];
    [params setObject:[NSString getIPAddress:YES] forKey:@"spbill_create_ip"];
    [params setObject:[NSString stringWithFormat:@"%d",product.total_fee] forKey:@"total_fee"];    // 1 =＝ ¥0.01
    
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成 packageSign
    NSMutableString *package = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [package appendString:key];
        [package appendString:@"="];
        [package appendString:[params objectForKey:key]];
        [package appendString:@"&"];
    }
    
    [package appendString:@"key="];
    [package appendString:WXPartnerKey]; // 注意:不能hardcode在客户端,建议genPackage这个过程都由服务器端完成
    
    // 进行md5摘要前,params内容为原始内容,未经过url encode处理
    NSString *packageSign = [[NSString md5:[package copy]] uppercaseString];
    package = nil;
    
    // 生成 packageParamsString
    NSString *value = nil;
    package = [NSMutableString string];
    for (NSString *key in sortedKeys)
    {
        [package appendString:key];
        [package appendString:@"="];
        value = [params objectForKey:key];
        
        // 对所有键值对中的 value 进行 urlencode 转码
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)value, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
        
        [package appendString:value];
        [package appendString:@"&"];
    }
    NSString *packageParamsString = [package substringWithRange:NSMakeRange(0, package.length - 1)];
    
    NSString *result = [NSString stringWithFormat:@"%@&sign=%@", packageParamsString, packageSign];
    
    NSLog(@"--- Package: %@", result);
    
    return result;
}

// 签名
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    NSString *result = [NSString sha1:signString];
    NSLog(@"--- Gen sign: %@", result);
    return result;
}

// 构造订单参数列表
- (NSDictionary *)getProductArgsWithproduct:(WXProduct *)product
{
    self.timeStamp = [self genTimeStamp];   // 获取时间戳
    self.nonceStr = [self genNonceStr];     // 获取32位内的随机串, 防重发
    self.traceId = product.traceId;       // 获取商家对用户的唯一标识
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kWXAPP_ID forKey:@"appid"];
    [params setObject:WXAPPKey forKey:@"appkey"];
    [params setObject:self.nonceStr forKey:@"noncestr"];
    [params setObject:self.timeStamp forKey:@"timestamp"];
    [params setObject:self.traceId forKey:@"traceid"];
    [params setObject:[self genPackageWithproduct:product] forKey:@"package"];
    [params setObject:[self genSign:params] forKey:@"app_signature"];
    [params setObject:@"sha1" forKey:@"sign_method"];
    
    return params;
}

#pragma mark - 支付结果
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([[notification.object objectForKey:@"result"] isEqualToString:@"success"])
    {
        NSLog(@"success: 支付成功");
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
        //                                                        message:@"支付成功"
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil, nil];
        //        [alert show];
    }
    else
    {
        NSLog(@"fail: 支付失败");
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
        //                                                        message:@"支付失败"
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil, nil];
        //        [alert show];
    }
    [self roadWXPayResultWithCode:[notification.object objectForKey:@"code"]];
}

- (void)roadWXPayResultWithCode:(NSString *)code
{
    NSString *urlStr = [self.WXPayProduct.returnUrl stringByAppendingFormat:@"&traceId=%@&outTradNo=%@&total_fee=%d&body=%@&code=%@&from=wxpay",self.WXPayProduct.traceId,self.WXPayProduct.outTradNo,self.WXPayProduct.total_fee,self.WXPayProduct.body,code];
    NSURL *url = [[NSURL alloc] initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:300];
    [m_webView loadRequest:req];
    self.WXPayProduct = nil;
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:@"支付结果：%@", result];
    NSLog(@"%@",msg);
    NSString *urlStr = [self.upReturnUrl stringByAppendingFormat:@"&tn=%@&order_id=%@&code=%@&from=unionpay",self.upTN,self.upOrderId,result];
    NSURL *url = [[NSURL alloc] initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:300];
    [m_webView loadRequest:req];
    self.upTN = nil;
    self.upReturnUrl = nil;
}
@end
