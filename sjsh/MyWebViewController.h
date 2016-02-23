//
//  MyWebViewController.h
//  sjsh
//
//  Created by savvy on 16/2/4.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import <WebKit/WebKit.h>

@interface MyWebViewController : UITempletViewController<WKNavigationDelegate>

@property(nonatomic,strong) NSString      *myUrl;//浏览地址

@end
