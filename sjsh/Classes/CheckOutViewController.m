//
//  CheckOutViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-10-16.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CheckOutViewController.h"
#import "DEFINE.h"

@interface CheckOutViewController (){

 UIProgressView  *webProgress;
}
@property (nonatomic, retain) WKWebView *webview;
@end

@implementation CheckOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    self.webview.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sjsh8.cn/index.php?route=mobile/checkout"]]];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    webProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:webProgress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma WebKit delegate

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        webProgress.hidden = self.webview.estimatedProgress == 1;
        [webProgress setProgress:self.webview.estimatedProgress animated:true];
    }
}

@end
