//
//  PersonalInfoViewController.m
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//


#import "PersonalInfoViewController.h"
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

@interface PersonalInfoViewController ()
@property (nonatomic, assign) BOOL getSuccess;
@property (nonatomic, retain) NSDictionary *personDic;
//@property (nonatomic, assign) UIView *overView;//遮盖层

@property(nonatomic, strong) UIButton *loginOutButton;
@property(nonatomic, strong) UILabel *infoLabel;

@property(nonatomic, strong) NSMutableArray *userDataArray;//列表数据

@property(nonatomic, assign) BOOL *isMember;//是否会员
@property(nonatomic, strong) NSString *memberRemainder;//会员余额

@property (nonatomic, strong) NSString *stringDetail;
@end

@implementation PersonalInfoViewController

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
    [super initNavBarItems:@"个人中心"];
    [super addRightButton:@"mail" lightedImage:@"mail" selector:@selector(msgPage:)];
    
    self.stringDetail = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"address\":\"\u53f7\u697c\u5355\u5143\",\"allpoints\":\"500\",\"avatar\":\"http:\/\/www.sjsh8.cn\/image\/avatar\/14490496189705_src.jpg\",\"user_name\":\"15810906759\",\"firstname\":\"sj765_\u4f50\u624b\",\"sex\":\"\u7537\",\"lastname\":\"\",\"telephone\":\"15810906759\",\"is_member\":1,\"marry\":\"\u4fdd\u5bc6\",\"member_price\":\"700.70\"}}";
    
    self.isMember = NO;//默认是否为会员
    
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
    
    
    
    profileTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f-140) style:UITableViewStylePlain];
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
    
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, profileTableView.frame.origin.y+profileTableView.frame.size.height+10 , ScreenWidth-20, 15)];
    self.infoLabel.font = [UIFont systemFontOfSize:12];
    self.infoLabel.text = @"如遇问题请拨打电话：400-010-6000";
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.infoLabel setTextColor:kGrayColor];
    [self.view addSubview:self.infoLabel];
    
    
    //    //添加上拉刷新
    //    if (refreshHeaderView == nil) {
    //        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - profileTableView.bounds.size.height, self.view.frame.size.width, profileTableView.bounds.size.height)];
    //        refreshHeaderView.delegate = self;
    //        [profileTableView addSubview:refreshHeaderView];
    //        [refreshHeaderView release];
    //    }
    
    
    //设置表头部个人信息
    profileTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 113.0f)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapGesture.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tapGesture];
        //        view.backgroundColor = COLOR(250, 250, 250);
        //        view.backgroundColor = [UIColor blackColor];
        // 头像
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, 19.0f, 74.0f, 74.0f)];
        avatarImageView.backgroundColor = [UIColor clearColor];
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2.0;
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.userInteractionEnabled = YES;
        [view addSubview:avatarImageView];
        
        //        //修改头像相机提示logo
        //        UIButton *cameraTipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        cameraTipButton.frame = CGRectMake(180.0f, 50.0f, 25.0f, 25.0f);
        //        [cameraTipButton setImage:[UIImage imageNamed:@"cameraTip.png"] forState:UIControlStateNormal];
        //        [cameraTipButton addTarget:self action:@selector(startCameraAndPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
        //        [view addSubview:cameraTipButton];
        
        //昵称
        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(114.0f, avatarImageView.frame.origin.y+10, 170.0f, 22.0f)];
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.font = [UIFont systemFontOfSize:18];
        [nickLabel setText:@""];
        [nickLabel adjustsFontSizeToFitWidth];
        //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
        nickLabel.textColor = COLOR(250, 99, 56);
        nickLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:nickLabel];
        [nickLabel release];
        
        
        UIImageView *addrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(114.0f, 56.0f, 13.0f, 13.0f)];
        addrImageView.backgroundColor = [UIColor clearColor];
        addrImageView.image = [UIImage imageNamed:@"zuobiao"];
        [view addSubview:addrImageView];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(114.0f+16.0f, 56, 170.0f, 15.0f)];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [addressLabel setText:@""];
        [addressLabel adjustsFontSizeToFitWidth];
        //        addressLabel.textColor = [UIColor colorWithRed:0x8c/255. green:0x8c/255. blue:0x8c/255. alpha:1];
        addressLabel.textColor = COLOR(20, 20, 20);
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:addressLabel];
        [addressLabel release];
        
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
        [view addSubview:arrowImageView];
        
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
}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    if (self.userInfo) {
        MyInfoViewController *infoVC = [[MyInfoViewController alloc] init];
        infoVC.personalDic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
        [self.navigationController pushViewController:infoVC animated:YES];
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
        addressLabel.text = [info objectForKey:@"address"];
        nickLabel.text = [info objectForKey:@"firstname"];
        
        
        self.isMember = ([info[@"is_member"] integerValue]==1);
        self.memberRemainder = info[@"member_price"];
        [self initTableViewData];//初始化列表数据
        
        id allP = [info objectForKey:@"allpoints"];
        if (allP) {
            if ([allP isKindOfClass:[NSString class]]) {
                moneyNum.text = allP;
            }
            else if([allP isKindOfClass:[NSNumber class]]){
                moneyNum.text = [allP stringValue];
            }
        }
        else {
            moneyNum.text = @"0";
        }
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
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的会员卡";
    NSString *memberRemainderTitle =  [NSString stringWithFormat:@"余额  ￥%@元",self.memberRemainder];
    userDictionary[@"content"] = self.isMember? memberRemainderTitle:@"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_member"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的订单";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_order"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的优惠劵";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_coupon"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的收藏";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_collect"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"设置";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_setting"];
    [self.userDataArray addObject:userDictionary];
    
    [profileTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    //    [MobClick beginLogPageView:@"PageFour"];
    //    self.navigationController.navigationBarHidden = NO;
    
    NSLog(@"获取用户登陆状态！！！！！！")
    if ([[ConstObject instance] isLogin]) {
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
    MyMessageViewController *msgVc = [[[MyMessageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:msgVc animated:YES];
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
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            if (self.isMember) {//是会员
                myViewController = [[MemberAccountViewController alloc]init];
            }else{//不是会员
                myViewController = [[MemberViewController alloc]init];
            }
            [self.navigationController pushViewController:myViewController animated:YES];
            break;
        case 1:
            myViewController = [[MyOrderListViewController alloc]init];
            [self.navigationController pushViewController:myViewController animated:YES];
            break;
        case 2:
            myViewController = [[CouponViewController alloc]init];
            [self.navigationController pushViewController:myViewController animated:YES];
            break;
        case 3:
            //            myViewController = [[AddressViewController alloc]init];
            //            [self.navigationController pushViewController:myViewController animated:YES];
            myViewController = [[MyStoredViewController alloc] init];
            [self.navigationController pushViewController:myViewController animated:YES];
            break;
        case 4:
            //            settingViewController.delegate = self;
            [self.navigationController pushViewController:settingViewController animated:YES];
            break;
        default:
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
