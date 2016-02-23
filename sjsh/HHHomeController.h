//
//  HHHomeController.h
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
//#import "ZBarSDK.h"
#import "EGORefreshTableHeaderView.h"
#import "CustomPageControl.h"
//#import "YHR_PageControl.h"

@interface HHHomeController : UITempletViewController<UIScrollViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UIScrollView *bannerScroll;          //广告横幅
@property(nonatomic,strong)CustomPageControl *bannerPageControl;    //广告横幅的指示器

@property(nonatomic, strong) UICollectionView *categoryCollection;//商品类别集合视图

//@property(nonatomic, strong) UIImageView *preferentialImageView;       //本周特惠商品
@property(nonatomic,strong)UIScrollView *preferentialScroll;          //本周特惠商品
@property(nonatomic,strong)UIPageControl *preferentialPageControl;    //广告横幅的指示器

@property(nonatomic, strong) UICollectionView *commodityCollection;//商品集合视图

@property(nonatomic,strong)UIPageControl *myBannerPageControl;

@end
