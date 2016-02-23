//
//  memberInfoViewController.m
//  sjsh
//
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberPayViewController.h"

@interface MemberViewController ()

//@property(nonatomic,strong) UIScrollView *pageScroll;
//@property(nonatomic,strong) UIImageView *infoImageView;
@property(nonatomic,strong) UIButton *openButton;
@property(nonatomic,strong) WKWebView   *memberWebView;//浏览器视图;
@property(nonatomic,strong)  UIProgressView  *memberWebProgress;

@end

@implementation MemberViewController

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
    
    [super initNavBarItems:@"会员卡"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;

    
    //页面滚动视图
//    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    self.pageScroll.translatesAutoresizingMaskIntoConstraints = NO;
//    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, ScreenWidth*2.87+50+64);
//    self.pageScroll.showsHorizontalScrollIndicator=NO;
//    self.pageScroll.showsVerticalScrollIndicator=NO;
//    self.pageScroll.backgroundColor = dilutedGrayColor;
//    [self.view addSubview:self.pageScroll];
//    
//    self.infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*2.87)];
//    self.infoImageView.image = [UIImage imageNamed:@"backage_member_info"];
//    self.infoImageView.contentMode = UIViewContentModeScaleToFill;
//    [self.pageScroll addSubview:self.infoImageView];
    
    NSURL *urlS = [[NSURL alloc] initWithString:@"http://www.sjsh8.cn/?route=mobile/home_new/vip_index"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlS];
    [req setTimeoutInterval:300];
    
    self.memberWebView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
     self.memberWebView.backgroundColor = [UIColor clearColor];
     self.memberWebView.navigationDelegate = self;
    //        m_webView.delegate = self;
     self.memberWebView.tag = 1000000;
    [ self.memberWebView setFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width,kScreenBounds.size.height-44)];
    [ self.memberWebView loadRequest:req];
    //        [m_webView setScalesPageToFit:YES];
    [self.view addSubview:  self.memberWebView];
    
    self.memberWebProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview: self.memberWebProgress];
    
    //进度条追踪监听
    [self.memberWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.openButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.openButton setTitle:@"立即办理" forState:UIControlStateNormal];
    [self.openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.openButton.backgroundColor = kRedColor;
    self.openButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.openButton addTarget:self action:@selector(openMember) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openButton];
    
}

//开通会员
-(void)openMember{
    NSLog(@"开通会员！！！！");
    MemberPayViewController *myViewController = [[MemberPayViewController alloc]init];
    [self.navigationController pushViewController:myViewController animated:YES];
}

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}



# pragma WebKit delegate

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        self.memberWebProgress.hidden = self.memberWebView.estimatedProgress == 1;
        [self.memberWebProgress setProgress:self.memberWebView.estimatedProgress animated:true];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end