//
//  HHHomeController.m
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHHomeController.h"
#import "ErWeiMaViewController.h"
//#import "ZBarReaderViewController.h"
#import "OpenURLViewController.h"

#import "AppDelegate.h"
//#import "MobClick.h"
#import "HomeCategoryCell.h"
#import "HomeCommodityCell.h"
#import "MyOrderDetailViewController.h"
#import "QuickmarkViewController.h"
#import "HHHomeCell.h"
#import "ShoppingCartController.h"
#import "HHShopListController.h"
#import "MyWebViewController.h"

@interface HHHomeController (){
    float screenDistance ;//屏幕左右两边的边距
    int maxIndex;           //banner的最大数量
}

@property(nonatomic,strong)UIScrollView *homeScroll;


@property(nonatomic,strong)UIView *entryView;//入口区域
@property(nonatomic,strong)UILabel *entryTitleLabel;//入口标题
@property(nonatomic,strong)UIButton *registrationView;//预约挂号
@property(nonatomic,strong)UIImageView *registrationImageView;
@property(nonatomic,strong)UILabel *registrationLabel;
@property(nonatomic,strong)UIButton *shoppingView;//生活商城
@property(nonatomic,strong)UIImageView *shoppingImageView;
@property(nonatomic,strong)UILabel *shoppingLabel;
@property(nonatomic,strong)UIButton *welfareView;//公会福利
@property(nonatomic,strong)UIImageView *welfareImageView;
@property(nonatomic,strong)UILabel *welfareLabel;

@property(nonatomic,strong)UIView *recommendView;//推荐区域
@property(nonatomic,strong)UIButton *recommendOneView;//第一推荐
@property(nonatomic,strong)UIImageView *recommendOneImageView;
@property(nonatomic,strong)UIImageView *recommendOneIco;
@property(nonatomic,strong)UILabel *recommendOneLabel;
@property(nonatomic,strong)UIButton *recommendTwoView;//第二推荐
@property(nonatomic,strong)UIImageView *recommendTwoImageView;
@property(nonatomic,strong)UILabel *recommendTwoLabel;
@property(nonatomic,strong)UILabel *recommendTwoContent;
@property(nonatomic,strong)UIButton *recommendThreeView;//第三推荐
@property(nonatomic,strong)UIImageView *recommendThreeImageView;
@property(nonatomic,strong)UILabel *recommendThreeLabel;
@property(nonatomic,strong)UILabel *recommendThreeContent;

@property(nonatomic,strong)UIView *categoryView;//类别区域
@property(nonatomic,strong)UIButton *categoryOneLabel;
@property(nonatomic,strong)UIView *categoryOneBackage;
@property(nonatomic,strong)UIButton *categoryTwoLabel;
@property(nonatomic,strong)UIView *categoryTwoBackage;
@property(nonatomic,strong)UIButton *categoryThreeLabel;
@property(nonatomic,strong)UIView *categoryThreeBackage;
@property(nonatomic,strong)UIButton *categoryFourLabel;
@property(nonatomic,strong)UIView *categoryFourBackage;

@property(nonatomic,strong)NSMutableArray *categoryViewArray;
@property(nonatomic,strong)NSMutableArray *categoryBackageArray;

@property(nonatomic,strong) UITableView *homeTableView;//列表



@property(nonatomic, strong) NSMutableArray *topBannerArray;       //顶部广告banner数据

@property(nonatomic, strong) NSMutableArray *homeTableArray;       //商品数据
@end

@implementation HHHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"淮海生活"];
    
    leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTintColor:[UIColor whiteColor]];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [leftButton setImage:[UIImage imageNamed:@"hh_ico_badge"] forState:UIControlStateNormal];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -0, 0, 10);
    leftButton.frame = CGRectMake(0, 0, 100, 44);
    leftButton.tag = NAME_MAX;
    [leftButton setTitle:@"徐州总工会" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
     [super addRightButton:@"hh_ico_cart" lightedImage:@"hh_ico_cart" selector:@selector(gotoBuyingCarPage)];
    
    
    screenDistance=5.0;
    maxIndex=0;
    self.view.backgroundColor = dilutedGrayColor;
    self.categoryViewArray = [[NSMutableArray alloc]init];
    self.categoryBackageArray = [[NSMutableArray alloc]init];

    //页面布局*******************************
//    self.homeScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    self.homeScroll.contentSize=CGSizeMake(self.bannerScroll.bounds.size.width, 1000);
//    self.homeScroll.showsHorizontalScrollIndicator=NO;
//    self.homeScroll.showsVerticalScrollIndicator=NO;
//    self.homeScroll.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.homeScroll];
    
  
    
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.categoryView.frame.origin.y+self.categoryView.frame.size.height, ScreenWidth, ScreenHeight-44-64)];
    self.homeTableView.tag = 198811;
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.homeTableView.backgroundColor = [UIColor whiteColor];
     [self.homeTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.homeTableView];

    //测试数据
    self.homeTableArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"hh_home_ico01" forKey:@"ico"];
     [myDictionary setValue:@"家庭药房" forKey:@"title"];
     [myDictionary setValue:@"日常生活的常见病用药" forKey:@"content"];
     [myDictionary setValue:@"1282" forKey:@"count01"];
    [myDictionary setValue:@"282" forKey:@"count02"];
     [myDictionary setValue:@"0" forKey:@"flag"];
    [self.homeTableArray addObject:myDictionary];

    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"hh_home_ico02" forKey:@"ico"];
    [myDictionary setValue:@"感冒用药" forKey:@"title"];
    [myDictionary setValue:@"根据感冒症状来判断如何用药" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"count01"];
    [myDictionary setValue:@"0" forKey:@"count02"];
     [myDictionary setValue:@"1" forKey:@"flag"];
    [self.homeTableArray addObject:myDictionary];

    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"hh_home_ico03" forKey:@"ico"];
    [myDictionary setValue:@"维生素\钙" forKey:@"title"];
    [myDictionary setValue:@"如何判断身体缺少哪些维生素" forKey:@"content"];
    [myDictionary setValue:@"10" forKey:@"count01"];
    [myDictionary setValue:@"100" forKey:@"count02"];
     [myDictionary setValue:@"0" forKey:@"flag"];
    [self.homeTableArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"hh_home_ico04" forKey:@"ico"];
    [myDictionary setValue:@"慢性病药" forKey:@"title"];
    [myDictionary setValue:@"根据慢性病症状来判断如何用药" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"count01"];
    [myDictionary setValue:@"0" forKey:@"count02"];
    [myDictionary setValue:@"1" forKey:@"flag"];
    [self.homeTableArray addObject:myDictionary];

    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"hh_home_ico05" forKey:@"ico"];
    [myDictionary setValue:@"妇科病用药" forKey:@"title"];
    [myDictionary setValue:@"根据妇科病病症状来判断如何用药" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"count01"];
    [myDictionary setValue:@"0" forKey:@"count02"];
    [myDictionary setValue:@"0" forKey:@"flag"];
    [self.homeTableArray addObject:myDictionary];

    
    //设置表头部个人信息
    self.homeTableView.tableHeaderView = ({

     UIView *tableSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 700.0f)];
        tableSubView.backgroundColor = dilutedGrayColor;
        
        //banner*******************************
        self.bannerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*390/640)];
        self.bannerScroll.tag = 198811;
        self.bannerScroll.delegate=self;
        self.bannerScroll.pagingEnabled=YES;        //整页滚动
        self.bannerScroll.bounces=NO;
        self.bannerScroll.alwaysBounceVertical=NO;
        self.bannerScroll.alwaysBounceHorizontal=YES;
        self.bannerScroll.showsHorizontalScrollIndicator=NO;
        self.bannerScroll.showsVerticalScrollIndicator=NO;
        //    self.bannerScroll.backgroundColor=[UIColor redColor];
        [tableSubView addSubview:self.bannerScroll];
        
        
        self.myBannerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ScreenWidth*390/640-30, ScreenWidth, 20)];
        self.myBannerPageControl.tag=198812;
//        [self.myBannerPageControl setPageIndicatorTintColor:[UIColor whiteColor]];
//        [self.myBannerPageControl setCurrentPageIndicatorTintColor:backageBlueWithHH];
        [self.myBannerPageControl setValue:[UIImage imageNamed:@"hh_dot_biue_ico"] forKey:@"_currentPageImage"];
        [self.myBannerPageControl setValue:[UIImage imageNamed:@"hh_dot_white_ico"]  forKey:@"_pageImage"];

        [tableSubView addSubview:self.myBannerPageControl];
        
        
        //入口区域
        self.entryView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerScroll.frame.origin.y+self.bannerScroll.frame.size.height, ScreenWidth, 125)];
        self.entryView.backgroundColor = [UIColor whiteColor];
        [tableSubView addSubview:self.entryView];
        
        self.entryTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 15)];
        self.entryTitleLabel.text = @"爱工作，爱健康，爱生活";
        self.entryTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.entryTitleLabel.font = [UIFont systemFontOfSize:14];
        self.entryTitleLabel.textColor = fontDilutedGrayColor;
        [self.entryView addSubview:self.entryTitleLabel];
        
        //预约挂号
        self.registrationView = [[UIButton alloc]initWithFrame:CGRectMake(33, self.entryTitleLabel.frame.origin.y+self.entryTitleLabel.frame.size.height+15, 50, 70)];
        self.registrationView.tag = 198801;
        [self.registrationView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.entryView addSubview:self.registrationView];
        
        self.registrationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        self.registrationImageView.image = [UIImage imageNamed:@"hh_ico_registration"];
        self.registrationImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.registrationView addSubview:self.registrationImageView];
        
        self.registrationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 20)];
        self.registrationLabel.text = @"预约挂号";
        self.registrationLabel.font = [UIFont systemFontOfSize:12];
        self.registrationLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [self.registrationView addSubview:self.registrationLabel];
        
        
        //生活商城
        self.shoppingView = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.5-25, self.entryTitleLabel.frame.origin.y+self.entryTitleLabel.frame.size.height+15, 50, 70)];
         self.shoppingView.tag = 198802;
         [self.shoppingView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.entryView addSubview:self.shoppingView];
        
        self.shoppingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        self.shoppingImageView.image = [UIImage imageNamed:@"hh_ico_shopping"];
        self.shoppingImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.shoppingView addSubview:self.shoppingImageView];
        
        self.shoppingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 20)];
        self.shoppingLabel.text = @"生活商城";
        self.shoppingLabel.font = [UIFont systemFontOfSize:12];
        self.shoppingLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [self.shoppingView addSubview:self.shoppingLabel];
        
        //公会福利
        self.welfareView = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50-33, self.entryTitleLabel.frame.origin.y+self.entryTitleLabel.frame.size.height+15, 50, 70)];
         self.welfareView.tag = 198803;
         [self.welfareView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.entryView addSubview:self.welfareView];
        
        self.welfareImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        self.welfareImageView.image = [UIImage imageNamed:@"hh_ico_welfare"];
        self.welfareImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.welfareView addSubview:self.welfareImageView];
        
        self.welfareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 20)];
        self.welfareLabel.text = @"公会福利";
        self.welfareLabel.font = [UIFont systemFontOfSize:12];
        self.welfareLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [self.welfareView addSubview:self.welfareLabel];
        
        UIView *entryBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.entryView.frame.size.height, self.entryView.frame.size.width, 0.5)];
        entryBottomLine.backgroundColor=lineGrayColorWithHH;
        [self.entryView  addSubview:entryBottomLine];
        
        
        //推荐区域
        self.recommendView = [[UIView alloc]initWithFrame:CGRectMake(0, self.entryView.frame.origin.y+self.entryView.frame.size.height+10, ScreenWidth, 125)];
        self.recommendView.backgroundColor = [UIColor whiteColor];
        [tableSubView addSubview:self.recommendView];
        
        //第一推荐
        self.recommendOneView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.5, self.recommendView.frame.size.height)];
        self.recommendOneView.backgroundColor = [UIColor whiteColor];
          self.recommendOneView.tag = 198811;
        [self.recommendOneView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.recommendView addSubview:self.recommendOneView];
        
        self.recommendOneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, self.recommendOneView.frame.size.width-30, self.recommendOneView.frame.size.height-20)];
        self.recommendOneImageView.image = [UIImage imageNamed:@"test_hh_home01.jpg"];
            self.recommendOneImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.recommendOneView addSubview:self.recommendOneImageView];
        
        self.recommendOneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.recommendOneView.frame.size.width, 20)];
        self.recommendOneLabel.text = @"春节送温暖";
        self.recommendOneLabel.font = [UIFont boldSystemFontOfSize:15];
        self.recommendOneLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.recommendOneLabel.textAlignment = NSTextAlignmentCenter;
        [self.recommendOneView addSubview:self.recommendOneLabel];
        
        self.recommendOneIco = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 15, 22)];
        self.recommendOneIco.image = [UIImage imageNamed:@"hh_home_Ico_hot"];
        self.recommendOneIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.recommendOneView addSubview:self.recommendOneIco];
        
        UIView *recommendOneLine = [[UIView alloc]initWithFrame:CGRectMake(self.recommendOneView.frame.size.width-0.5, 0, 0.5, self.recommendOneView.frame.size.height)];
        recommendOneLine.backgroundColor=lineGrayColorWithHH;
        [self.recommendOneView  addSubview:recommendOneLine];
        
        //第二推荐
        self.recommendTwoView = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, 0, ScreenWidth*0.5, self.recommendView.frame.size.height*0.5)];
        self.recommendTwoView.backgroundColor = [UIColor whiteColor];
          self.recommendTwoView.tag = 198812;
        [self.recommendTwoView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.recommendView addSubview:self.recommendTwoView];
        
        self.recommendTwoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.recommendTwoView.frame.size.width-85, 0, 70, self.recommendTwoView.frame.size.height)];
        self.recommendTwoImageView.image = [UIImage imageNamed:@"test_hh_home02.jpg"];
        self.recommendTwoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.recommendTwoView addSubview:self.recommendTwoImageView];
        
        self.recommendTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 20)];
        self.recommendTwoLabel.text = @"粮油";
        self.recommendTwoLabel.font = [UIFont systemFontOfSize:15];
        self.recommendTwoLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:0.0/255.0 alpha:1.0];
        [self.recommendTwoView addSubview:self.recommendTwoLabel];
        
        self.recommendTwoContent = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 100, 20)];
        self.recommendTwoContent.text = @"福临门八折";
        self.recommendTwoContent.font = [UIFont systemFontOfSize:10];
        self.recommendTwoContent.textColor = fontDilutedGrayColor;
        [self.recommendTwoView addSubview:self.recommendTwoContent];
        
        
        UIView *recommendTwoLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.recommendTwoView.frame.size.height-0.5, self.recommendTwoView.frame.size.width, 0.5)];
        recommendTwoLine.backgroundColor=lineGrayColorWithHH;
        [self.recommendTwoView  addSubview:recommendTwoLine];
        
        
        //第三推荐
        self.recommendThreeView = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, self.recommendView.frame.size.height*0.5, ScreenWidth*0.5, self.recommendView.frame.size.height*0.5)];
        self.recommendThreeView.backgroundColor = [UIColor whiteColor];
          self.recommendThreeView.tag = 198813;
        [self.recommendThreeView addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.recommendView addSubview:self.recommendThreeView];
        
        self.recommendThreeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.recommendThreeView.frame.size.width-85, 0, 70, self.recommendThreeView.frame.size.height)];
        self.recommendThreeImageView.image = [UIImage imageNamed:@"test_hh_home03.jpg"];
        self.recommendThreeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.recommendThreeView addSubview:self.recommendThreeImageView];
        
        self.recommendThreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 20)];
        self.recommendThreeLabel.text = @"日用";
        self.recommendThreeLabel.font = [UIFont systemFontOfSize:15];
        self.recommendThreeLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self.recommendThreeView addSubview:self.recommendThreeLabel];
        
        self.recommendThreeContent = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 100, 20)];
        self.recommendThreeContent.text = @"蓝月亮五折";
        self.recommendThreeContent.font = [UIFont systemFontOfSize:10];
        self.recommendThreeContent.textColor = fontDilutedGrayColor;
        [self.recommendThreeView addSubview:self.recommendThreeContent];
        
        UIView *recommendTopLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.recommendView.frame.size.width, 0.5)];
        recommendTopLine.backgroundColor=lineGrayColorWithHH;
        [self.recommendView  addSubview:recommendTopLine];
        
        UIView *recommendBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.recommendView.frame.size.height, self.recommendView.frame.size.width, 0.5)];
        recommendBottomLine.backgroundColor=lineGrayColorWithHH;
        [self.recommendView  addSubview:recommendBottomLine];
        
        
        //列表区域
        self.categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, self.recommendView.frame.origin.y+self.recommendView.frame.size.height+10, ScreenWidth, 40)];
        self.categoryView.backgroundColor = [UIColor whiteColor];
        [tableSubView addSubview:self.categoryView];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, self.categoryView.frame.size.height-0.5, self.categoryView.frame.size.width, 0.5);
        bottomBorder.backgroundColor=lineGrayColorWithHH.CGColor;
        [self.categoryView.layer addSublayer:bottomBorder ];
        
        //类别1
        self.categoryOneLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*0, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryOneLabel.tag = 198820;
        [self.categoryOneLabel setTitle:@"药品知识" forState:UIControlStateNormal];
        self.categoryOneLabel.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.categoryOneLabel setTitleColor:fontDilutedGrayColor forState:UIControlStateNormal];
        [self.categoryOneLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryOneLabel];
        
        self.categoryOneBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryOneBackage.backgroundColor = backageBlueWithHH;
        [self.categoryOneLabel addSubview:self.categoryOneBackage];
        
        [self.categoryViewArray addObject:self.categoryOneLabel];
        [self.categoryBackageArray addObject:self.categoryOneBackage];
        
        //类别2
        self.categoryTwoLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*1, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryTwoLabel.tag = 198821;
        [self.categoryTwoLabel setTitle:@"疾病常识" forState:UIControlStateNormal];
        self.categoryTwoLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryTwoLabel setTitleColor:fontDilutedGrayColor forState:UIControlStateNormal];
        [self.categoryTwoLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryTwoLabel];
        
        self.categoryTwoBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryTwoBackage.backgroundColor = backageBlueWithHH;
        self.categoryTwoBackage.hidden = YES;
        [self.categoryTwoLabel addSubview:self.categoryTwoBackage];
        
        [self.categoryViewArray addObject:self.categoryTwoLabel];
        [self.categoryBackageArray addObject:self.categoryTwoBackage];
        
        //类别3
        self.categoryThreeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*2, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryThreeLabel.tag = 198822;
        [self.categoryThreeLabel setTitle:@"生活百科" forState:UIControlStateNormal];
        self.categoryThreeLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryThreeLabel setTitleColor:fontDilutedGrayColor forState:UIControlStateNormal];
        [self.categoryThreeLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryThreeLabel];
        
        self.categoryThreeBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryThreeBackage.backgroundColor = backageBlueWithHH;
        self.categoryThreeBackage.hidden = YES;
        [self.categoryThreeLabel addSubview:self.categoryThreeBackage];
        
        [self.categoryViewArray addObject:self.categoryThreeLabel];
        [self.categoryBackageArray addObject:self.categoryThreeBackage];
        
        //类别4
        self.categoryFourLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*3, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryFourLabel.tag = 198823;
        [self.categoryFourLabel setTitle:@"日常保健" forState:UIControlStateNormal];
        self.categoryFourLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryFourLabel setTitleColor:fontDilutedGrayColor forState:UIControlStateNormal];
        [self.categoryFourLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryFourLabel];
        
        self.categoryFourBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryFourBackage.backgroundColor = backageBlueWithHH;
        self.categoryFourBackage.hidden = YES;
        [self.categoryFourLabel addSubview:self.categoryFourBackage];
        
        [self.categoryViewArray addObject:self.categoryFourLabel];
        [self.categoryBackageArray addObject:self.categoryFourBackage];
        
        UIView *categoryTopLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.categoryView.frame.size.width, 0.5)];
        categoryTopLine.backgroundColor=lineGrayColorWithHH;
        [self.categoryView  addSubview:categoryTopLine];

        
        
        CGRect tableSubViewFrame =  tableSubView.frame;
        tableSubViewFrame.size.height = self.bannerScroll.frame.size.height+self.entryView.frame.size.height+self.recommendView.frame.size.height+self.categoryView.frame.size.height+10+10;
        tableSubView.frame = tableSubViewFrame;
        
        
        
        
        
        
        tableSubView;
    });
    

    [self initUI];
}







//调用接口显示页面主体
-(void)initUI{
    [super showGif];
    [commonModel getTopBanner:nil httpRequestSucceed:@selector(requestTopBannerSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

//获取首页顶部banner接口数据成功
-(void)requestTopBannerSuccess:(ASIHTTPRequest *)request{
        [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringBanner01];
    NSLog(@"requestTopBannerSuccess：%@！！！！",dic);
    
    self.topBannerArray = dic[@"result"];
    
    if(self.topBannerArray&&self.topBannerArray.count>0){
        maxIndex = self.topBannerArray.count;
        
        NSDictionary *myFirstDictionary = self.topBannerArray[0];
        NSDictionary *myEndDictionary = self.topBannerArray[maxIndex-1];
        self.bannerScroll.contentSize=CGSizeMake(self.bannerScroll.bounds.size.width*(maxIndex+2), 1);
//        self.myBannerPageControl.PointWidth = 15.0;
//        self.myBannerPageControl.PointHeight = 2.0;
//        self.myBannerPageControl.distanceOfPoint = 5.0;
        [self.myBannerPageControl setNumberOfPages:maxIndex];
        [self.myBannerPageControl setCurrentPage:0];
        //加载页面显示数据
        for(int i=0;i<maxIndex;i++){
            NSDictionary *myDictionary = self.topBannerArray[i];
            
            if (i==0) {
                UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.bannerScroll.frame.size.width+59, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
                [imageview setImageWithURL:[NSURL URLWithString:myEndDictionary[@"image"]]];
                imageview.tag = maxIndex-1;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
                [imageview addGestureRecognizer:singleTap1];
                [self.bannerScroll addSubview:imageview];
            }
            
            UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*self.bannerScroll.frame.size.width+59, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
            [imageview setImageWithURL:[NSURL URLWithString:myDictionary[@"image"]]];
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.tag = i;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
            [imageview addGestureRecognizer:singleTap1];
            
            [self.bannerScroll addSubview:imageview];
            
            if (i==(maxIndex-1)) {
                UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((maxIndex+1)*self.bannerScroll.frame.size.width+59, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
                [imageview setImageWithURL:[NSURL URLWithString:myFirstDictionary[@"image"]]];
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.tag = 0;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
                [imageview addGestureRecognizer:singleTap1];
                
                [self.bannerScroll addSubview:imageview];
            }
        }
        [self.bannerScroll scrollRectToVisible:CGRectMake(self.bannerScroll.bounds.size.width,0,self.bannerScroll.bounds.size.width,self.bannerScroll.bounds.size.height) animated:NO];
    }else{
        maxIndex = 0;
    }
    //调用商品类别接口
//    [commonModel getHomeCategory:nil httpRequestSucceed:@selector(getHomeCategorySuccess:) httpRequestFailed:@selector(requestFailed:)];
}


//类别点击事件
- (void)clickWithCategory:(UIButton *)myButton
{
    //    NSLog(@"点击了类别切换%ld,%lu",myButton.tag,(unsigned long)self.categoryBackageArray.count);
    
    
    for (int i=0; i<self.categoryBackageArray.count; i++) {
        UIView *myBackage =  self.categoryBackageArray[i];
        if (myButton.tag-198820 == i) {
            //            NSLog(@"修改为选中%ld",myButton.tag);
            myBackage.hidden = NO;
            UIButton *myLabel = self.categoryViewArray[i];
             myLabel.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        }else{
            //             NSLog(@"修改为未选中%ld",myButton.tag);
            UIButton *myLabel = self.categoryViewArray[i];
            myLabel.titleLabel.font = [UIFont systemFontOfSize:13];
            myBackage.hidden = YES;
        }
    }
    
    
}

//快捷入口点击事件
-(void)entryClick: (UIButton*)myButton{
    NSInteger mytag = myButton.tag;
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    switch (mytag) {
        case 198801:
            [self enterURLPage:@"https://www.hao123.com/?tn=90995709_hao_pg"];
            break;
        case 198802:
             [[AppDelegate shareDelegate] tabClickAction:[AppDelegate shareDelegate].formTab];
            break;
        case 198803:
            [alert show];
            break;
        case 198811:
            [self goPageByURL:@"sjsh://category?id=582"];
            break;
        case 198812:
            [self goPageByURL:@"sjsh://category?id=587"];
            break;
        case 198813:
            [self goPageByURL:@"sjsh://category?id=580"];
            break;
        default:
            break;
    }
}


//进入购物车页面
- (void)gotoBuyingCarPage
{
    ShoppingCartController *shoppingCart = [[ShoppingCartController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//顶部banner图片点击事件
- (void)clickBannerImageView:(UIGestureRecognizer *)tapGesture
{
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag;
    //    [self enterURLPage:self.topBannerArray[index][@"url"]];
    [self enterURLPage:self.topBannerArray[index][@"url"]];
}



//根据网址跳转到不同页面
- (void)goPageByURL:(NSString *)urlStr{
    
    NSLog(@"即将跳转到url:%@!!!!!!",urlStr);
    if ([urlStr hasPrefix:@"sjsh://orders/?order_id="]) {//跳转到订单详情
        NSLog(@"跳转到订单详情!!!!!!");
        //进入订单页
        //        [super pushToOrderPage];
        NSString *orderId = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://orders/?order_id=" withString:@""];
        MyOrderDetailViewController *detailVc = [[MyOrderDetailViewController alloc] init];
        detailVc.orderID = orderId;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else if ([urlStr hasPrefix:@"sjsh://product?id="]){//跳转到商品详情
        NSLog(@"跳转到商品详情!!!!!!");
        NSString *productID = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://product?id=" withString:@""];
        CommodityDetailController *myController = [[CommodityDetailController alloc] init];
        myController.productID = productID;
        [self.navigationController pushViewController:myController animated:YES];
    }else if ([urlStr hasPrefix:@"sjsh://category?id="]){//跳转到商品列表
        NSLog(@"跳转到商品列表!!!!!!");
        NSString *categoryID = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://category?id=" withString:@""];
     
        HHShopListController *myController = [[HHShopListController alloc]init];
        myController.theCategoryId = categoryID;
         [[ConstObject instance] setCategoryId:categoryID];
        [self.navigationController pushViewController:myController animated:YES];
        
//        [[ConstObject instance] setCategoryId:categoryID];
//        [[AppDelegate shareDelegate] tabClickAction:[AppDelegate shareDelegate].shangpinTab];
    }else{
        NSLog(@"跳转到网页!!!!!!");
        [self enterURLPage:urlStr];//跳转网页
    }
    
}


//根据点击的url跳转页面
- (void)enterURLPage:(NSString *)url
{
    NSLog(@"即将跳转到网页url%@!!!!!!!!!!!!!!",url);
    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
    [detailViewController initWithUrl:url andTitle:@""];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)jumpToWebViewWithUrlStr:(NSString *)urlStr
{
    //跳web页面
    MyWebViewController *myWebViewController = [[MyWebViewController alloc] init];
    myWebViewController.myUrl =  (urlStr==nil)?@"https://www.hao123.com":urlStr;
    
    [self.navigationController pushViewController:myWebViewController animated:YES];
    //    [detailViewController release];
}

#pragma mark UIScrollViewDelegate
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    //    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

//滚动结束触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    NSLog(@"scrollView  当前页数为 %d",current);
    
    //根据scrollView 的位置对page 的当前页赋值（scrollView数量比指示器多2）
    
    if (scrollView.tag==198811) {
        //        int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        
        YHR_PageControl *page = (YHR_PageControl *)[self.view viewWithTag:198812];
        int currentPage=0;
        //    int myMmaxIndex=maxIndex-1;//从0开始
        
        if(current==0){
            currentPage = maxIndex-1;
        }else if(current==maxIndex+1){
            currentPage = 0;
        }else{
            currentPage = current-1;
        }
        page.currentPage = currentPage;
        
        if (scrollView.contentOffset.x == 0) {
            // 用户滑动到1号位置，此时必须跳转到倒2的位置
            [scrollView scrollRectToVisible:CGRectMake(scrollView.contentSize.width - 2 * scrollView.bounds.size.width,0,scrollView.bounds.size.width,scrollView.bounds.size.height) animated:NO];
        }
        else if (scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width) {
            // 用户滑动到最后的位置，此时必须跳转到2号位置
            [scrollView scrollRectToVisible:CGRectMake(scrollView.bounds.size.width,0,scrollView.bounds.size.width,scrollView.bounds.size.height) animated:NO];
        }
    }else{
        
        
        UIPageControl *page = (UIPageControl *)[self.view viewWithTag:198814];
        page.currentPage = current;
        
    }
    
    
    
}






#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *ShowAddressIdentifier = @"HHHomeCell";
    HHHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowAddressIdentifier];
    NSDictionary *inforDic = [self.homeTableArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[HHHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShowAddressIdentifier];
        //无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setCellInfo:inforDic];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        NSDictionary *dataDic = (NSDictionary *)[self.homeTableArray objectAtIndex:indexPath.row];
    [self jumpToWebViewWithUrlStr:nil];
    
}


@end
