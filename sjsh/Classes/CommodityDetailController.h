//
//  CommodityDetailController.h
//  sjsh
//  商品详情
//  Created by savvy on 15/11/18.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "SKUViewController.h"
#import <WebKit/WebKit.h>

@interface CommodityDetailController : UITempletViewController<UIScrollViewDelegate,SkuResultDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSDictionary *productDic;//商品信息
@property (nonatomic, strong) NSString *productID;//商品编号
@end
