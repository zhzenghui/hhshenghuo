//
//  HHShoppingDetialController.h
//  sjsh
//  商品详情页面
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "SKUViewController.h"
#import <WebKit/WebKit.h>

@interface HHShoppingDetialController : UITempletViewController<UIScrollViewDelegate,SkuResultDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSDictionary *productDic;//商品信息
@property (nonatomic, strong) NSString *productID;//商品编号


@end
