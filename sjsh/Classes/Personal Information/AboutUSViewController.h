//
//  AboutUSViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/11/15.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import <WebKit/WebKit.h>
#import "DEFINE.h"

typedef enum : NSUInteger {
    aboutUS,
    compon,
    jifen,
} pType;

@interface AboutUSViewController : UITempletViewController<WKNavigationDelegate>
{
    WKWebView                  *m_webView;//浏览器视图
    UIActivityIndicatorView    *activityView;
     UIProgressView  *webProgress;
}
@property (nonatomic, assign) pType type;
@end
