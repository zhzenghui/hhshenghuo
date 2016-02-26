//
//  HHUserCenterController.m
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHUserCenterController.h"
#import "ProfileCell.h"

#import "MyOrderListViewController.h"
#import "MyMessageViewController.h"
#import "MyCardViewController.h"
#import "MyStoredViewController.h"
#import "MyJiFenViewController.h"
#import "MyDuiHuanViewController.h"
#import "SettingViewController.h"
#import "MyRemarkViewController.h"
//#import "CustomNavigationBar.h"
#import "LoginViewController.h"
#import "UIButton+WebCache.h"
#import "MyInfoViewController.h"
#import "AboutUSViewController.h"
#import "AddressViewController.h"
#import "CouponViewController.h"
#import "MemberViewController.h"
#import "MemberAccountViewController.h"
#import "SettingViewController.h"
#import "HKHealthStore+AAPLExtensions.h"

@interface HHUserCenterController ()

@property (nonatomic, assign) BOOL getSuccess;
@property (nonatomic, retain) NSDictionary *personDic;
//@property (nonatomic, assign) UIView *overView;//遮盖层
@property(nonatomic,strong) UILabel *companyLabel;//公司

@property(nonatomic, strong) UIButton *loginOutButton;
@property(nonatomic, strong) UILabel *infoLabel;

@property(nonatomic, strong) NSMutableArray *userDataArray;//列表数据

@property(nonatomic, assign) BOOL *isMember;//是否会员
@property(nonatomic, strong) NSString *memberRemainder;//会员余额

@property (nonatomic, strong) NSString *stringDetail;

 
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

@property(nonatomic,strong)UIView *timeView;//时间区域
@property(nonatomic,strong)UIButton *timeOneLabel;
@property(nonatomic,strong)UIView *timeOneBackage;
@property(nonatomic,strong)UIButton *timeTwoLabel;
@property(nonatomic,strong)UIView *timeTwoBackage;
@property(nonatomic,strong)UIButton *timeThreeLabel;
@property(nonatomic,strong)UIView *timeThreeBackage;
@property(nonatomic,strong)UIButton *timeFourLabel;
@property(nonatomic,strong)UIView *timeFourBackage;
@property(nonatomic,strong)NSMutableArray *timeViewArray;
@property(nonatomic,strong)NSMutableArray *timeBackageArray;

@property(nonatomic,strong)UIView *infoView;//数值区域
@property(nonatomic,strong)UIButton *nowIco;
@property(nonatomic,strong)UIButton *tableIco;
@property(nonatomic,strong)UILabel *infoTitle;//标题
@property(nonatomic,strong)UILabel *infoLabel01;//标题
@property(nonatomic,strong)UILabel *infoLabel02;//标题
@property(nonatomic,strong)UIView *infoLine01;//分割线，上面
@property(nonatomic,strong)UIView *infoLine02;//分割线，中间
@property(nonatomic,strong)UIView *infoLine03;//分割线，下面
@end

@implementation HHUserCenterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.view.backgroundColor=[UIColor blackColor];
    [super initNavBarItems:@"淮海生活"];
    [super addRightButton:@"hh_user_setting" lightedImage:@"hh_user_setting" selector:@selector(msgPage:)];
    
//    self.stringDetail = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"address\":\"\u53f7\u697c\u5355\u5143\",\"allpoints\":\"500\",\"avatar\":\"http:\/\/www.sjsh8.cn\/image\/avatar\/14490496189705_src.jpg\",\"user_name\":\"15810906759\",\"firstname\":\"sj765_\u4f50\u624b\",\"sex\":\"\u7537\",\"lastname\":\"\",\"telephone\":\"15810906759\",\"is_member\":1,\"marry\":\"\u4fdd\u5bc6\",\"member_price\":\"700.70\"}}";
    
//    self.isMember = NO;//默认是否为会员
    self.categoryViewArray = [[NSMutableArray alloc]init];
    self.categoryBackageArray = [[NSMutableArray alloc]init];
    self.timeViewArray = [[NSMutableArray alloc]init];
    self.timeBackageArray = [[NSMutableArray alloc]init];
    
    //    [super addRightButton:@"return" lightedImage:@"returnLighted" selector:@selector(toReturn)];
    //    self.view.backgroundColor = COLOR(250, 250, 250);
    
    //    self.navigationController.navigationBar.alpha = 0;
    //    self.navigationController.navigationBar.opaque = YES;
    //    [self.navigationItem setHidesBackButton:YES animated:NO];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //    self.navigationController.navigationBar.translucent = NO;
    
    
    //    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    bgImageView.image = IPHONE5?LOGIN_BG_568h:LOGIN_BG;
    //    [self.view addSubview:bgImageView];
    //    [bgImageView release];
    //
    //    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 1)];
    //    [lineImageView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.2]];
    //    [self.view addSubview:lineImageView];
    //    [lineImageView release];
    //    [self createHeadView];
    
    
    
    profileTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 64.0f-30) style:UITableViewStylePlain];
    profileTableView.delegate = self;
    profileTableView.dataSource = self;
    profileTableView.backgroundColor = [UIColor clearColor];
    [profileTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:profileTableView];
    //    profileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    if(kSystemIsIOS7)
    //     [profileTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    //    profileTableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.6];
    //        [profileTableView release];
    
    //    self.loginOutButton = [[UIButton alloc]initWithFrame:CGRectMake(10, profileTableView.frame.origin.y+profileTableView.frame.size.height+10, ScreenWidth-20, 50)];
    //    self.loginOutButton.backgroundColor = kRedColor;
    //    [self.loginOutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    //    //    self.loginOutButton.layer.borderWidth = 1;
    //    //    self.loginOutButton.layer.borderColor = [kGreenColor CGColor];
    //    self.loginOutButton.clipsToBounds = YES;
    //    self.loginOutButton.layer.cornerRadius = 5;
    //    [self.loginOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    self.loginOutButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    //    [self.view addSubview:self.loginOutButton];
    
    
//    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, profileTableView.frame.origin.y+profileTableView.frame.size.height+10 , ScreenWidth-20, 15)];
//    self.infoLabel.font = [UIFont systemFontOfSize:12];
//    self.infoLabel.text = @"如遇问题请拨打电话：400-010-6000";
//    self.infoLabel.textAlignment = NSTextAlignmentCenter;
//    [self.infoLabel setTextColor:kGrayColor];
//    [self.view addSubview:self.infoLabel];
    
    
    //    //添加上拉刷新
    //    if (refreshHeaderView == nil) {
    //        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - profileTableView.bounds.size.height, self.view.frame.size.width, profileTableView.bounds.size.height)];
    //        refreshHeaderView.delegate = self;
    //        [profileTableView addSubview:refreshHeaderView];
    //        [refreshHeaderView release];
    //    }
    
    
    //设置表头部个人信息
    profileTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 300.0f)];
        
        //        view.backgroundColor = COLOR(250, 250, 250);
        //        view.backgroundColor = [UIColor blackColor];
        
         UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 19+74+20)];
         [view addSubview:headView];
        
        // 头像
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 19.0f, 74.0f, 74.0f)];
        avatarImageView.backgroundColor = [UIColor clearColor];
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2.0;
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.userInteractionEnabled = YES;
        [headView addSubview:avatarImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapGesture.numberOfTapsRequired = 1;
        [headView addGestureRecognizer:tapGesture];
        
        //        //修改头像相机提示logo
        //        UIButton *cameraTipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        cameraTipButton.frame = CGRectMake(180.0f, 50.0f, 25.0f, 25.0f);
        //        [cameraTipButton setImage:[UIImage imageNamed:@"cameraTip.png"] forState:UIControlStateNormal];
        //        [cameraTipButton addTarget:self action:@selector(startCameraAndPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
        //        [view addSubview:cameraTipButton];
        
        //所属公司
        self.companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.frame.origin.x+avatarImageView.frame.size.width+20, avatarImageView.frame.origin.y+10, 170.0f, 15)];
        self.companyLabel.font = [UIFont systemFontOfSize:12];
         self.companyLabel.textColor = fontDilutedGrayColor;
        self.companyLabel.text = @"徐州总工会";
         [headView addSubview:self.companyLabel];
        
        //昵称
        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.companyLabel.frame.origin.x, self.companyLabel.frame.origin.y+12, 170.0f, 22.0f)];
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.font = [UIFont systemFontOfSize:15];
        [nickLabel setText:@""];
        [nickLabel adjustsFontSizeToFitWidth];
        //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
        nickLabel.textColor = [UIColor blackColor];
        nickLabel.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:nickLabel];
       
        
        
//        UIImageView *addrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(114.0f, 56.0f, 13.0f, 13.0f)];
//        addrImageView.backgroundColor = [UIColor clearColor];
//        addrImageView.image = [UIImage imageNamed:@"zuobiao"];
//        [view addSubview:addrImageView];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.companyLabel.frame.origin.x, nickLabel.frame.origin.y+23, 170.0f, 15.0f)];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [addressLabel setText:@""];
        [addressLabel adjustsFontSizeToFitWidth];
        //        addressLabel.textColor = [UIColor colorWithRed:0x8c/255. green:0x8c/255. blue:0x8c/255. alpha:1];
        addressLabel.textColor = fontBlueWithHH;
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:addressLabel];
        
        
        //        UIImageView *moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(114.0f, 77.0f, 13.0f, 13.0f)];
        //        moneyImageView.backgroundColor = [UIColor clearColor];
        //        moneyImageView.image = [UIImage imageNamed:@"jifen"];
        //        [view addSubview:moneyImageView];
        //
        //        UILabel *moneyString = [[UILabel alloc] initWithFrame:CGRectMake(114.0f+16.0f, 77, 60.0f, 13.0f)];
        //        moneyString.backgroundColor = [UIColor clearColor];
        //        moneyString.font = [UIFont fontWithName:@"Arial" size:12.0f];
        //        [moneyString setText:@"积分 "];
        //        [moneyString adjustsFontSizeToFitWidth];
        //        moneyString.textColor = COLOR(20, 20, 20);
        //        moneyString.textAlignment = NSTextAlignmentLeft;
        //        [view addSubview:moneyString];
        //        [moneyString release];
        //
        //        moneyNum = [[UILabel alloc] initWithFrame:CGRectMake(152.0f+16.0f, 77, 170.0f, 15.0f)];
        //        moneyNum.backgroundColor = [UIColor clearColor];
        //        moneyNum.font = [UIFont fontWithName:@"Arial" size:12.0f];
        //        [moneyNum setText:@"0.00"];
        //        [moneyNum adjustsFontSizeToFitWidth];
        //        moneyNum.textColor = COLOR(250, 99, 56);
        //        moneyNum.textAlignment = NSTextAlignmentLeft;
        //        [view addSubview:moneyNum];
        //        [moneyNum release];
        //        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        //        tapGesture.numberOfTapsRequired = 1;
        //        [view addGestureRecognizer:tapGesture];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(299.0f, 50.0f, 6.0f, 13.0f)];
        arrowImageView.backgroundColor = [UIColor clearColor];
        arrowImageView.image = [UIImage imageNamed:@"jiantou"];
        [headView addSubview:arrowImageView];
        
        
        //列表区域
        self.categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, avatarImageView.frame.origin.y+avatarImageView.frame.size.height+20, ScreenWidth, 40)];
        self.categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hh_user_backage_top"]];
        [view addSubview:self.categoryView];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, self.categoryView.frame.size.height-0.5, self.categoryView.frame.size.width, 0.5);
        bottomBorder.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:246.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        [self.categoryView.layer addSublayer:bottomBorder ];
        
        //类别1
        self.categoryOneLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*0, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryOneLabel.tag = 198820;
        [self.categoryOneLabel setTitle:@"步数" forState:UIControlStateNormal];
        self.categoryOneLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.categoryOneLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.categoryOneLabel addTarget:self action:@selector(clickWithSort:) forControlEvents:UIControlEventTouchUpInside];
//        self.categoryOneLabel.textAlignment = NSTextAlignmentCenter;
        [self.categoryView addSubview:self.categoryOneLabel];
        
//        UITapGestureRecognizer *categoryOneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithSort:)];
//        categoryOneTapGesture.numberOfTapsRequired = 1;
//        [self.categoryOneLabel addGestureRecognizer:categoryOneTapGesture];
        
        self.categoryOneBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, self.categoryView.frame.size.height-1, 30, 1)];
        self.categoryOneBackage.backgroundColor = [UIColor whiteColor];
        [self.categoryOneLabel addSubview:self.categoryOneBackage];
        
        [self.categoryViewArray addObject:self.categoryOneLabel];
        [self.categoryBackageArray addObject:self.categoryOneBackage];
        
        
        //类别2
        self.categoryTwoLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*1, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryTwoLabel.tag = 198821;
        [self.categoryTwoLabel setTitle:@"血压" forState:UIControlStateNormal];
        self.categoryTwoLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.categoryTwoLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.categoryTwoLabel addTarget:self action:@selector(clickWithSort:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryTwoLabel];
        
//        UITapGestureRecognizer *categoryTwoTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithSort:)];
//        categoryTwoTapGesture.numberOfTapsRequired = 1;
//        [self.categoryTwoLabel addGestureRecognizer:categoryTwoTapGesture];
        
        self.categoryTwoBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, self.categoryView.frame.size.height-1, 30, 1)];
        self.categoryTwoBackage.backgroundColor = [UIColor whiteColor];
        self.categoryTwoBackage.hidden = YES;
        [self.categoryTwoLabel addSubview:self.categoryTwoBackage];
        
        [self.categoryViewArray addObject:self.categoryTwoLabel];
        [self.categoryBackageArray addObject:self.categoryTwoBackage];
        
        //类别3
        self.categoryThreeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*2, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryThreeLabel.tag = 198822;
        [self.categoryThreeLabel setTitle:@"血糖" forState:UIControlStateNormal];
        self.categoryThreeLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.categoryThreeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.categoryThreeLabel addTarget:self action:@selector(clickWithSort:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryThreeLabel];
        
//        UITapGestureRecognizer *categoryThreeTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithSort:)];
//        categoryThreeTapGesture.numberOfTapsRequired = 1;
//        [self.categoryThreeLabel addGestureRecognizer:categoryThreeTapGesture];
        
        self.categoryThreeBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, self.categoryView.frame.size.height-1, 30, 1)];
        self.categoryThreeBackage.backgroundColor = [UIColor whiteColor];
        self.categoryThreeBackage.hidden = YES;
        [self.categoryThreeLabel addSubview:self.categoryThreeBackage];
        
        [self.categoryViewArray addObject:self.categoryThreeLabel];
        [self.categoryBackageArray addObject:self.categoryThreeBackage];
        
        //类别4
        self.categoryFourLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*3, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryFourLabel.tag = 198823;
        [self.categoryFourLabel setTitle:@"体脂" forState:UIControlStateNormal];
        self.categoryFourLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.categoryFourLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.categoryFourLabel addTarget:self action:@selector(clickWithSort:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryFourLabel];
        
//        UITapGestureRecognizer *categoryFourTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithSort:)];
//        categoryFourTapGesture.numberOfTapsRequired = 1;
//        [self.categoryFourLabel addGestureRecognizer:categoryFourTapGesture];
        
        self.categoryFourBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, self.categoryView.frame.size.height-1, 30, 1)];
        self.categoryFourBackage.backgroundColor = [UIColor whiteColor];
        self.categoryFourBackage.hidden = YES;
        [self.categoryFourLabel addSubview:self.categoryFourBackage];
        
        [self.categoryViewArray addObject:self.categoryFourLabel];
        [self.categoryBackageArray addObject:self.categoryFourBackage];
        
        //信息区域，中间
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0,self.categoryView.frame.origin.y+self.categoryView.frame.size.height, ScreenWidth, 110)];
        self.infoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hh_user_backage_middle"]];
        [view addSubview:self.infoView];
        
        
        self.nowIco = [[UIButton alloc]initWithFrame:CGRectMake(15,20, 20, 20)];
        [self.nowIco setImage:[UIImage imageNamed:@"hh_user_now_unselect"] forState:UIControlStateNormal];
        [self.infoView addSubview:self.nowIco];
        
        self.tableIco = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-20-15,15, 20, 20)];
        [self.tableIco setImage:[UIImage imageNamed:@"hh_user_chart_unselect"] forState:UIControlStateNormal];
        [self.infoView addSubview:self.tableIco];
        
        
        self.infoTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,20, ScreenWidth, 15)];
        self.infoTitle.text = @"当前数值";
        self.infoTitle.font = [UIFont systemFontOfSize:12];
        self.infoTitle.textColor = [UIColor whiteColor];
        self.infoTitle.textAlignment = NSTextAlignmentCenter;
        [self.infoView addSubview:self.infoTitle];
        
        
        self.infoLabel01 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.5-100-10,50, 100, 30)];
        self.infoLabel01.text = @"0";
        self.infoLabel01.font = [UIFont systemFontOfSize:33];
        self.infoLabel01.textColor = [UIColor whiteColor];
        self.infoLabel01.textAlignment = NSTextAlignmentRight;
        [self.infoView addSubview:self.infoLabel01];

        self.infoLabel02 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.5+10,50, 100, 30)];
        self.infoLabel02.text = @"100";
        self.infoLabel02.font = [UIFont systemFontOfSize:33];
        self.infoLabel02.textColor = [UIColor whiteColor];
        self.infoLabel02.textAlignment = NSTextAlignmentLeft;
        [self.infoView addSubview:self.infoLabel02];
        
        self.infoLine02 = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5-1,50+2.5, 2, 25)];
        self.infoLine02.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:self.infoLine02];
        

        
        //时间区域
        self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.infoView.frame.origin.y+self.infoView.frame.size.height, ScreenWidth, 40)];
        self.timeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hh_user_backage_down"]];
        [view addSubview:self.timeView];
        
        CALayer *timeTopBorder=[[CALayer alloc]init];
        timeTopBorder.frame=CGRectMake(0, 0, self.categoryView.frame.size.width, 0.5);
        timeTopBorder.backgroundColor=[UIColor colorWithRed:64.0/255.0 green:236.0/255.0 blue:208.0/255.0 alpha:1.0].CGColor;
        [self.timeView.layer addSublayer:timeTopBorder ];
        
        //类别1
        self.timeOneLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*0, 0, ScreenWidth/4, self.timeView.frame.size.height)];
        self.timeOneLabel.tag = 198830;
        [self.timeOneLabel setTitle:@"日" forState:UIControlStateNormal];
        self.timeOneLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.timeOneLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.timeOneLabel addTarget:self action:@selector(clickWithTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.timeView addSubview:self.timeOneLabel];
        
//        UITapGestureRecognizer *timeOneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithTime:)];
//        timeOneTapGesture.numberOfTapsRequired = 1;
//        [self.timeOneLabel addGestureRecognizer:timeOneTapGesture];
        
        self.timeOneBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, 0, 30, 1)];
        self.timeOneBackage.backgroundColor = [UIColor whiteColor];
        self.timeOneBackage.hidden = YES;
        [self.timeOneLabel addSubview:self.timeOneBackage];
        
        [self.timeViewArray addObject:self.timeOneLabel];
        [self.timeBackageArray addObject:self.timeOneBackage];
        
        //类别2
        self.timeTwoLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*1, 0, ScreenWidth/4, self.timeView.frame.size.height)];
        self.timeTwoLabel.tag = 198831;
        [self.timeTwoLabel setTitle:@"周" forState:UIControlStateNormal];
        self.timeTwoLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.timeTwoLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.timeTwoLabel addTarget:self action:@selector(clickWithTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.timeView addSubview:self.timeTwoLabel];
        
//        UITapGestureRecognizer *timeTwoTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithTime:)];
//        timeTwoTapGesture.numberOfTapsRequired = 1;
//        [self.timeTwoLabel addGestureRecognizer:timeTwoTapGesture];
        
        self.timeTwoBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, 0, 30, 1)];
        self.timeTwoBackage.backgroundColor = [UIColor whiteColor];
        self.timeTwoBackage.hidden = YES;
        [self.timeTwoLabel addSubview:self.timeTwoBackage];
        
        [self.timeViewArray addObject:self.timeTwoLabel];
        [self.timeBackageArray addObject:self.timeTwoBackage];

        
        //类别3
        self.timeThreeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*2, 0, ScreenWidth/4, self.timeView.frame.size.height)];
        self.timeThreeLabel.tag = 198832;
        [self.timeThreeLabel setTitle:@"月" forState:UIControlStateNormal];
        self.timeThreeLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.timeThreeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.timeThreeLabel addTarget:self action:@selector(clickWithTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.timeView addSubview:self.timeThreeLabel];
        
//        UITapGestureRecognizer *timeThreeTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithTime:)];
//        timeThreeTapGesture.numberOfTapsRequired = 1;
//        [self.timeThreeLabel addGestureRecognizer:timeThreeTapGesture];
        
        self.timeThreeBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, 0, 30, 1)];
        self.timeThreeBackage.backgroundColor = [UIColor whiteColor];
        self.timeThreeBackage.hidden = YES;
        [self.timeThreeLabel addSubview:self.timeThreeBackage];
        
        [self.timeViewArray addObject:self.timeThreeLabel];
        [self.timeBackageArray addObject:self.timeThreeBackage];

        
        //类别4
        self.timeFourLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*3, 0, ScreenWidth/4, self.timeView.frame.size.height)];
        self.timeFourLabel.tag = 198833;
        [self.timeFourLabel setTitle:@"年" forState:UIControlStateNormal];
        self.timeFourLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.timeFourLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.timeFourLabel addTarget:self action:@selector(clickWithTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.timeView addSubview:self.timeFourLabel];
        
//        UITapGestureRecognizer *timeFourTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWithTime:)];
//        timeFourTapGesture.numberOfTapsRequired = 1;
//        [self.timeFourLabel addGestureRecognizer:timeFourTapGesture];
        
        self.timeFourBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-30)/2, 0, 30, 1)];
        self.timeFourBackage.backgroundColor = [UIColor whiteColor];
        self.timeFourBackage.hidden = YES;
        [self.timeFourLabel addSubview:self.timeFourBackage];
        
        [self.timeViewArray addObject:self.timeFourLabel];
        [self.timeBackageArray addObject:self.timeFourBackage];


        view;
    });
    
    
    if(![[ConstObject instance] isLogin]){
        //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setObject:@"0" forKey:@"isLogin"];
        //        NSString *loginStatus = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"isLogin"]];
        //        if([loginStatus isEqualToString:@"0"]){
        [self logoutToLoginVC];
    }
    else {
        //        [self reloadStoredCookies];
        [commonModel requestUserinfo:nil
                  httpRequestSucceed:@selector(requestUserInfoSuccess:)
                   httpRequestFailed:@selector(requestFailed:)];
    }
    
    
    //开启健康功能
    if ([HKHealthStore isHealthDataAvailable]) {
//        NSSet *writeDataTypes = [self dataTypesToWrite];//写入数据
        NSSet *readDataTypes = [self dataTypesToRead];      //读取数据
        
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the user interface based on the current user's health information.
                [self getHealthInfo];
                
            });
        }];
    }

}

//头像点击事件
- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    if (self.userInfo) {
        MyInfoViewController *infoVC = [[MyInfoViewController alloc] init];
        infoVC.personalDic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}


//类别点击事件
- (void)clickWithSort:(UIButton *)myButton
{
//    NSLog(@"点击了类别切换%ld,%lu",myButton.tag,(unsigned long)self.categoryBackageArray.count);
    
 
    for (int i=0; i<self.categoryBackageArray.count; i++) {
      UIView *myBackage =  self.categoryBackageArray[i];
        if (myButton.tag-198820 == i) {
//            NSLog(@"修改为选中%ld",myButton.tag);
             myBackage.hidden = NO;
        }else{
//             NSLog(@"修改为未选中%ld",myButton.tag);
        myBackage.hidden = YES;
        }
    }
    
    
}

//时间点击事件
- (void)clickWithTime:(UIButton *)myButton
{
    NSLog(@"点击了时间切换%ld",myButton.tag);
    for (int i=0; i<self.timeBackageArray.count; i++) {
        UIView *myBackage =  self.timeBackageArray[i];
        if (myButton.tag-198830 == i) {
            //            NSLog(@"修改为选中%ld",myButton.tag);
            myBackage.hidden = NO;
        }else{
            //             NSLog(@"修改为未选中%ld",myButton.tag);
            myBackage.hidden = YES;
        }
    }

    
}



-(void)requestUserInfoSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    //      NSLog(@"获取用户信息接口成功：%@！！！！！",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringDetail];
    NSLog(@"获取用户信息dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        //        self.overView.hidden=YES;
        self.getSuccess = YES;
        NSDictionary *info = [dic objectForKey:@"result"];
        self.userInfo = info;
        addressLabel.text = [NSString stringWithFormat:@"账户余额：￥%@",[info objectForKey:@"member_price"]];
        nickLabel.text = [info objectForKey:@"firstname"];
 
        
        [self initTableViewData];//初始化列表数据
 
        [[ConstObject instance] setTelephoneNumber:[info objectForKey:@"telephone"]];
        NSString *imageUrl = [info objectForKey:@"avatar"];
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [avatarImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        //        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self logoutToLoginVC];
        return;
    }
    
}
-(void)logoutToLoginVC {
    //    [self.navigationController popToRootViewControllerAnimated:NO];
    //    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //    loginViewController.noShowReturn = YES;
    //    [self.navigationController pushViewController:loginViewController animated:NO];
    
    [self pushToLoginVC:YES animation:NO];
    
}


//初始化列表数据
-(void)initTableViewData{
    self.userDataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *userDictionary = nil;
    
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的订单";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_order"];
    [self.userDataArray addObject:userDictionary];
    
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的收藏";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_collect"];
    [self.userDataArray addObject:userDictionary];
    
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的预约";
    NSString *memberRemainderTitle =  [NSString stringWithFormat:@"余额  ￥%@元",self.memberRemainder];
    userDictionary[@"content"] = self.isMember? memberRemainderTitle:@"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_appointment"];
    [self.userDataArray addObject:userDictionary];
   
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的积分";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_ integral"];
    [self.userDataArray addObject:userDictionary];
    
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的福利";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_welfare"];
    [self.userDataArray addObject:userDictionary];
    
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"用药提醒";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"hh_user_remind"];
    [self.userDataArray addObject:userDictionary];
   
    
    [profileTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
   
    
    [super viewWillAppear:NO];
    //    [MobClick beginLogPageView:@"PageFour"];
    //    self.navigationController.navigationBarHidden = NO;
    
    NSLog(@"获取用户登陆状态！！！！！！")
    if ([[ConstObject instance] isLogin]) {
         [super showGif];
        NSLog(@"获取用户登陆状态为已登录")
        [commonModel requestUserinfo:nil
                  httpRequestSucceed:@selector(requestUserInfoSuccess:)
                   httpRequestFailed:@selector(requestFailed:)];
        
    }
    else {
        NSLog(@"获取用户登陆状态为未登录")
        [self logoutToLoginVC];
    }
}

-(void)createHeadView{
    
    //    UIButton *returnButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    //    returnButton.backgroundColor = [UIColor clearColor];
    //    [returnButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateNormal];
    //    //    [returnButton setImage:[UIImage imageNamed:@"returnLight"] forState:UIControlStateHighlighted];
    //    [returnButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
    //    returnButton.showsTouchWhenHighlighted = YES;
    //    if (kSystemIsIOS7) {
    //        returnButton.frame = CGRectMake(-5.0f, 22.0f, 60,40);
    //    }
    //    else{
    //        returnButton.frame = CGRectMake(-5.0f, 22.0f, [UIImage imageNamed:@"leftReturn"].size.width,[UIImage imageNamed:@"leftReturn"].size.height);
    //    }
    //    [self.view addSubview:returnButton];
    
    UILabel *me = [[UILabel alloc] initWithFrame:CGRectMake(150.0f, 36.0f, 27,18)];
    me.backgroundColor = [UIColor clearColor];
    [me setText:@"我"];
    [me setTextColor:[UIColor whiteColor]];
    [self.view addSubview:me];
    [me release];
    
    UIButton *mailButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    mailButton.backgroundColor = [UIColor clearColor];
    [mailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
    [mailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateHighlighted];
    mailButton.showsTouchWhenHighlighted = YES;
    [mailButton addTarget:self action:@selector(msgPage:) forControlEvents:UIControlEventTouchUpInside];
    
    if (kSystemIsIOS7) {
        mailButton.frame = CGRectMake(252.0f, 24.0f, [UIImage imageNamed:@"mail"].size.width,[UIImage imageNamed:@"mail"].size.height);
    }
    else{
        mailButton.frame = CGRectMake(252.0f, 25.0f, [UIImage imageNamed:@"mail"].size.width,[UIImage imageNamed:@"mail"].size.height);
    }
    mailButton.tag = 10000;
    [self.view addSubview:mailButton];
    
}


- (void)msgPage:(UIButton *)sender
{
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
}


#pragma mark --- UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.userDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //        cell.backgroundColor = COLOR(255, 255, 255);
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell.userImageView setImage:self.userDataArray[indexPath.row][@"image"]];
    [cell.userNameLabel setText:self.userDataArray[indexPath.row][@"name"]];
    [cell.userContentLabel setText:self.userDataArray[indexPath.row][@"content"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}


#pragma mark
#pragma mark--- UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    if (![super checkNetworkStatus]) {
    //        return;
    //    }
    
    UIViewController *myViewController;
 
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    switch (indexPath.row) {
        case 0:
            myViewController = [[MyOrderListViewController alloc]init];
            [self.navigationController pushViewController:myViewController animated:YES];
            
            break;
        case 1:
            myViewController = [[MyStoredViewController alloc] init];
            [self.navigationController pushViewController:myViewController animated:YES];
            break;
        case 2:
            [alert show];
            break;
        case 3:
          
           [alert show];
            break;
        case 4:
           
          [alert show];
            break;
        case 5:
          [alert show];
            break;
        default:
             [alert show];
            break;
    }
    
    
    
    //    if(indexPath.section == 0){
    //
    //        if(indexPath.row == 0){
    //
    //            MyOrderListViewController *myOrderListViewController = [[MyOrderListViewController alloc] init];
    //            [self.navigationController pushViewController:myOrderListViewController animated:YES];
    //            [myOrderListViewController release];
    //        }else if(indexPath.row == 1){
    //
    //            MyRemarkViewController *myDiscountViewController = [[MyRemarkViewController alloc] init];
    //            [self.navigationController pushViewController:myDiscountViewController animated:YES];
    //            [myDiscountViewController release];
    //        }else if(indexPath.row == 2){
    //
    //            MyStoredViewController *myCardViewController = [[MyStoredViewController alloc] init];
    //            [self.navigationController pushViewController:myCardViewController animated:YES];
    //            [myCardViewController release];
    //        }else if(indexPath.row == 3){
    //
    //            MyJiFenViewController *myStoredViewController = [[MyJiFenViewController alloc] init];
    //            [self.navigationController pushViewController:myStoredViewController animated:YES];
    //            [myStoredViewController release];
    //        }
    //    }else if (indexPath.section ==1){
    //
    //        if(indexPath.row == 0){
    //
    //            MyDuiHuanViewController *myPublishViewController = [[MyDuiHuanViewController alloc] init];
    //            [self.navigationController pushViewController:myPublishViewController animated:YES];
    //            [myPublishViewController release];
    //        }else if(indexPath.row == 1){
    //
    //            AboutUSViewController *aboutViewController = [[AboutUSViewController alloc] init];
    //            aboutViewController.type = compon;
    //            [self.navigationController pushViewController:aboutViewController animated:YES];
    //            [aboutViewController release];
    //        }
    //    }else if (indexPath.section ==2){
    //
    //        if(indexPath.row == 0){
    //
    //            SettingViewController *settingViewController = [[SettingViewController alloc] init];
    //            settingViewController.delegate = self;
    //            [self.navigationController pushViewController:settingViewController animated:YES];
    //            [settingViewController release];
    //        }
    //    }
}


#pragma mark 健康功能
- (NSSet *)dataTypesToRead {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];//步数
    
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType,stepCount, nil];
}

- (void)getHealthInfo {
    
    
    
    NSMutableString *infoMutableString = [[NSMutableString alloc]init];
    
    //步数
    HKQuantityType *stepCountType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDate* startDate = [self getTime:1];
    NSDate*  endDate = [NSDate date];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    // Query to get the user's latest height, if it exists.
    [self.healthStore aapl_mostRecentQuantitySampleOfTypeByAll:stepCountType predicate:predicate completion:^(NSArray *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [infoMutableString appendString:NSLocalizedString(@"Not available", nil)];
            });
        }
        else {
            
            double myData = 0;
            for (int i=0; i<mostRecentQuantity.count; i++) {
                HKQuantitySample *quantitySample = mostRecentQuantity[i];
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *myUnit = [HKUnit countUnit];
                myData += [quantity doubleValueForUnit:myUnit];
            }
            
            // Update the user interface.
            dispatch_async(dispatch_get_main_queue(), ^{
                [infoMutableString appendString:[NSNumberFormatter localizedStringFromNumber:@(myData) numberStyle:NSNumberFormatterNoStyle]];
                self.infoLabel01.text = infoMutableString;
            });
        }
    }];
    
}



//获取指定时间
-(NSDate *)getTime:(int)type{
    
    int updateTime = 0;
    switch (type) {
        case 0://当时
            updateTime = 0;
            break;
        case 1://当天
            updateTime = 24*3600;
            break;
        case 2://当周
            updateTime = 24*3600*7;
            break;
        case 3://当月
            updateTime = 24*3600*30;
            break;
        case 4://当年
            updateTime = 24*3600*365;
            break;
        default:
            break;
    }
    
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [NSDate date];
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([nowDate timeIntervalSinceReferenceDate] - updateTime)];
    
    return  newDate;
    
}





-(void)toReturn{
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [MobClick endLogPageView:@"PageFour"];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
