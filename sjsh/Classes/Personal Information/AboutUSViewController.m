//
//  AboutUSViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/15.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *title  =@"";
    NSString *url = @"";
    switch (self.type) {
        case aboutUS:
        {
            title = @"关于我们";
            url = kaboutmy;
        }
            break;
         case compon:
        {
            title = @"我的优惠券";
            url = Kcoupon;
        }
            break;
            case jifen:
        {
            title = @"如何获得积分";
            url = Kgetjifen;
        }
        default:
            break;
    }
    [super initNavBarItems:title];
    
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    
    if (self.type == compon) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-120)/2, 135, 120, 150)];
        imageView.image = [UIImage imageNamed:@"youhuiquan"];
        [self.view addSubview:imageView];
        [imageView release];
    }
    else {
        NSURL *urlS = [[NSURL alloc] initWithString:url];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlS];
        [req setTimeoutInterval:300];
        
        m_webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        m_webView.backgroundColor = [UIColor clearColor];
        m_webView.navigationDelegate = self;
//        m_webView.delegate = self;
        m_webView.tag = 1000000;
        
        [m_webView setFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width,kScreenBounds.size.height-44)];
        
        [m_webView loadRequest:req];
//        [m_webView setScalesPageToFit:YES];
        [self.view addSubview: m_webView];
        [m_webView release];
        [url release];
        
         [m_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        webProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [self.view addSubview:webProgress];
        
        //启动加载等待
        [self startActivityView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma --mark
#pragma --mark UIWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self performSelector:@selector(stopActivityView) withObject:nil afterDelay:5];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    [m_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [m_webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    for (id subView in [webView subviews]) {
        if ([subView respondsToSelector:@selector(flashScrollIndicators)]) {
            [subView flashScrollIndicators];
        }
    }
}

# pragma WebKit delegate

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        webProgress.hidden = m_webView.estimatedProgress == 1;
        [webProgress setProgress:m_webView.estimatedProgress animated:true];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
