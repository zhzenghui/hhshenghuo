//
//  HHHealthController.h
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "YHR_PageControl.h"

@interface HHHealthController : UITempletViewController<UIScrollViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>



@property(nonatomic,strong)UIScrollView *preferentialScroll;          //本周特惠商品
@property(nonatomic,strong)UIPageControl *preferentialPageControl;    //广告横幅的指示器

@property(nonatomic, strong) UICollectionView *commodityCollection;//商品集合视图

@end
