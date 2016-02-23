//
//  LoginViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "BindRegisterViewController.h"
#import "ThirdPartChoicePageViewController.h"
#import "ForgetPWViewController.h"
#import "AppDelegate.h"
#import "InputItemModel.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    
}
@property (nonatomic, strong) NSDictionary *tempThirdDic;
@property (nonatomic, strong) NSString *versionType;
@end

@implementation LoginViewController
@synthesize infoDictionary;
@synthesize userNameTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        [[ConstObject instance] setVc:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"世纪生活";
    [super initNavBarItems:@"登录"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    //设置标题
    
    self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    [ASIHTTPRequest setSessionCookies:nil];
    
    
    //版本：1为世纪生活  2为淮海生活
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 
   self.versionType = [userDefaults objectForKey:@"version"];
    
//    if ([self.versionType isEqualToString:@"1"]) {
//         self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
//    }else{
//     self.view.backgroundColor = backageBlueWithHH;
//    }
    
    
    
//    self.navigationController.navigationBarHidden = YES;
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    bgImageView.image = IPHONE5?LOGIN_BG_568h:LOGIN_BG;
//    [self.view addSubview:bgImageView];
//    [bgImageView release];
    
    /********隐藏导航栏，自己定做标题及按钮，下面加一条白线，以达到效果图所示效果***********/
//    UILabel *aTitleLabel = nil;
//    
//    if (kSystemIsIOS7) {
//        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 20.0f, 200.0f, 43.0f)];
//    }
//    else{
//        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 200.0f, 43.0f)];
//    }
//    aTitleLabel.text = @"世纪生活";
//    aTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
//    aTitleLabel.textAlignment = NSTextAlignmentCenter;
//    aTitleLabel.backgroundColor = [UIColor clearColor];
//    aTitleLabel.adjustsFontSizeToFitWidth = YES;
//    aTitleLabel.textColor = COLOR(255, 255, 255);
//    [self.view addSubview:aTitleLabel];
//    [aTitleLabel release];
//    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"世纪生活_white"]];
//    if (IOS7_OR_LATER) {
//        titleView.frame = CGRectMake(60.0f, 20.0f, 200.0f, 43.0f);
//    }
//    else {
//        titleView.frame = CGRectMake(60.0f, 0.0f, 200.0f, 43.0f);
//    }
//    titleView.backgroundColor = [UIColor clearColor];
//    titleView.contentMode = UIViewContentModeCenter;
//    [self.view addSubview:titleView];
//    [titleView release];
//    
//    UIView *lineView = nil;
//    if (IOS7_OR_LATER) {
//        lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 63.0f, 320.0f, 0.5f)];
//    }
//    else {
//       lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, 320.0f, 0.5f)];
//    }
//    
//    lineView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
//    [self.view addSubview:lineView];
//    [lineView release];
//    if (_noShowReturn== NO) {
//        UIButton *closeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//        [closeButton setTintColor:[UIColor whiteColor]];
//        closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//        [closeButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateNormal];
//        [closeButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateHighlighted];
//        [closeButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
//        if (kSystemIsIOS7) {
//            closeButton.frame = CGRectMake(0.0f, 20.0f, 60,44);
//        }
//        else{
//            closeButton.frame = CGRectMake(0.0f, 0.0f, 60,44);
//        }
//        [self.view addSubview:closeButton];
//        [closeButton release];
//    }
    
    /******************/
//    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    oneBtn.frame = CGRectMake(35, 0 +152 , 250, 44);
//    [oneBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
//    [oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [oneBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//    [oneBtn setTitle:@"一键输入" forState:UIControlStateNormal];
//    [oneBtn addTarget:self action:@selector(oneBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:oneBtn];
    
    // 用户名 登录密码
    for (int i = 0; i < 2; i++) {
//        UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35,0 + i *59 + 48, 254, 45)];
//        inputImageView.backgroundColor = [UIColor clearColor];
//        inputImageView.image = INPUT_BG;
//        [self.view addSubview:inputImageView];
//
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(35+12,0 + i *59 + 48+10, 24, 24)];
//        icon.image = i==0?ACCOUNT_BG:PASSWORD_BG;
//        [self.view addSubview:icon];
//        
//        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(35 + 44, 0 + i *59 + 48, 211, 44)];
//        textField.font = [UIFont systemFontOfSize:14];
//        textField.textColor = [UIColor orangeColor];
//        textField.delegate = self;
        // TODO 设置placeholder 颜色
        
        InputItemModel *input = [[InputItemModel alloc] initWithFrame:CGRectMake(33,0 + i *59 + 48, 254, 45) iconImage:i==0?@"account":@"password" text:@"" placeHolderText:i==0?@"手机号/邮箱":@"登录密码"];
        
        [self.view addSubview:input];
        if (i == 0) {
//            textField.placeholder = @"手机号/邮箱";
            self.userNameTextField = input.textField;
//            [self.view addSubview:self.userNameTextField ];
        }
        else
        {
//            textField.placeholder = @"登录密码";
            
            self.passwordTextField = input.textField;
            self.passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
//            [self.view addSubview:self.passwordTextField ];
        }
    }
//    self.userNameTextField.text = @"15810524230";
//    self.passwordTextField.text = @"123456";
    passwordTextField.secureTextEntry = YES;
    
    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(35, 0 + 204 , 250, 44);
//    [loginBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
    if ([self.versionType isEqualToString:@"1"]) {
        loginBtn.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    }else{
        loginBtn.backgroundColor = backageBlueWithHH;
    }
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    //设置圆角边框
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.tag = 1;
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    // TODO 效果图没有标注 3.5的忘记密码和注册账号的 位置  现在暂时 自己定的
    NSInteger forget_B = MRScreenHeight>480?188+top_H:128+top_H; // 按钮中心距离底部的距离
    //    忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(35, self.view.frame.size.height - forget_B - 20 , 60, 20);
    [forgetBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateNormal];
    [forgetBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateHighlighted];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    forgetBtn.tag = 2;
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    //注册账号
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(MRScreenWidth - 60 - 35, self.view.bounds.size.height - forget_B - 20 , 60, 20);
    [registBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateNormal];
    [registBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    registBtn.tag = 3;
    [registBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    BOOL wxInstall = [WXApi isWXAppInstalled];
    BOOL qqInstall = [TencentOAuth iphoneQQInstalled];
    if(wxInstall && qqInstall){
        // 微信 qq
        UIButton *weinxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weinxinBtn.frame = CGRectMake(90, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
        weinxinBtn.tag = 4;
        [weinxinBtn setBackgroundImage:WINXIN_LOGIN_BG forState:UIControlStateNormal];
        [weinxinBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weinxinBtn];
        
        UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QQBtn.frame = CGRectMake(MRScreenWidth - 48 - 90, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
        QQBtn.tag = 5;
        [QQBtn setBackgroundImage:QQ_LOGIN_BG forState:UIControlStateNormal];
        [QQBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:QQBtn];
    }
    else if (wxInstall && !qqInstall){
        UIButton *weinxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weinxinBtn.frame = CGRectMake((MRScreenWidth-48)/2, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
        weinxinBtn.tag = 4;
        [weinxinBtn setBackgroundImage:WINXIN_LOGIN_BG forState:UIControlStateNormal];
        [weinxinBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weinxinBtn];
    }
    else if (!wxInstall && qqInstall){
        UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QQBtn.frame = CGRectMake((MRScreenWidth-48)/2, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
        QQBtn.tag = 5;
        [QQBtn setBackgroundImage:QQ_LOGIN_BG forState:UIControlStateNormal];
        [QQBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:QQBtn];
    }
    
//    UIImageView *bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-top_H -3 , MRScreenWidth, 3)];
//    bottomLineImageView.backgroundColor = [UIColor clearColor];
//    bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
//    [self.view addSubview:bottomLineImageView];

    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)oneBtnAction{

    self.userNameTextField.text = @"15810524230";//@"xrxxiaohui";
    self.passwordTextField.text = @"123456";//@"lixiaohui";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 按钮方法们

- (void)buttonAction:(UIButton *)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    if (sender.tag == 1) {
        // 登录
        NSString *userNameString = self.userNameTextField.text;
        NSString *passwordString = self.passwordTextField.text;
        
        NSString *tempUserName = [userNameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([tempUserName isEqualToString:@""]||[userNameString isEqualToString:@""]){
            //用户名为空
            [super showMessageBox:self title:@"用户名不能为空" message:@"请输入正确的用户名！" cancel:nil confirm:@"确定"];
            return;
        }else{
            //密码为空
            NSString *tempPassword = [passwordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if([tempPassword isEqualToString:@""]||[passwordString isEqualToString:@""]){
                //用户名为空
                [super showMessageBox:self title:@"密码不能为空" message:@"密码不能为空！" cancel:nil confirm:@"确定"];
                return;
            }
        }
        self.infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
        [infoDictionary setValue:userNameString forKey:@"username"];
        [infoDictionary setValue:passwordString forKey:@"passwd"];
        
        [super showGif];
        [commonModel requestLogin:infoDictionary httpRequestSucceed:@selector(requestLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    else if (sender.tag == 2)
    {
        // forgetPawwword
        ForgetPWViewController *forgetVC = [[[ForgetPWViewController alloc] init] autorelease];
        forgetVC.page = forgetPage1;
        [self.navigationController pushViewController:forgetVC animated:YES];
    }
    else if (sender.tag == 3)
    {
        //regiest
        RegisterViewController *registViewController = [[[RegisterViewController alloc] init] autorelease];
        registViewController.type = getVerificationCode;
        [self.navigationController pushViewController:registViewController animated:YES];
    }
    else if (sender.tag == 4)
    {
//        ThirdPartChoicePageViewController *registViewController = [[ThirdPartChoicePageViewController alloc] init];
//        registViewController.transforDic = self.tempThirdDic;
//        [self.navigationController pushViewController:registViewController animated:YES];
//        return;
          if ([self.versionType isEqualToString:@"1"]) {
        //weixin login
        [[AppDelegate shareDelegate] weixinLogin:self];
           }else{
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show]; }
    }
    else if (sender.tag == 5)
    {
            if ([self.versionType isEqualToString:@"1"]) {
        //qq login
        [[AppDelegate shareDelegate] tencentLogin:self];
            }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
                 }
    }
    
}

- (void)pushToBindRegisterVc:(NSDictionary *)info
{
    self.tempThirdDic = info;
    if ([[info objectForKey:@"type"] isEqualToString:@"QQ"]) {
        NSDictionary *dic = @{@"qq_token":[info objectForKey:@"accessToken"],@"qq_openid_id":[info objectForKey:@"openId"],@"qq_user_username":[info objectForKey:@"nickName"]};
        [self showGif];
        [commonModel requestCheckQQ_registrt:dic httpRequestSucceed:@selector(requestCheckSussess:) httpRequestFailed:@selector(requestCheckFail:)];
    }
    else {
        NSDictionary *dic = @{@"unionid":[info objectForKey:@"accessToken"],@"openid":[info objectForKey:@"openId"],@"nickname":[info objectForKey:@"nickName"]};
        [self showGif];
        [commonModel requestCheckWX_registrt:dic httpRequestSucceed:@selector(requestCheckSussess:) httpRequestFailed:@selector(requestCheckFail:)];
    }
    
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)requestCheckSussess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200||[[dic objectForKey:@"code"] intValue] == 1000) {
        NSLog(@"登陆成功！");
        //已登陆
        [[ConstObject instance] setIsLogin:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"1" forKey:@"isLogin"];
        [userDefaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 5566){
        
        ThirdPartChoicePageViewController *registViewController = [[ThirdPartChoicePageViewController alloc] init];
        registViewController.transforDic = self.tempThirdDic;
        [self.navigationController pushViewController:registViewController animated:YES];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1000){
        
        [super showMessageBox:self title:@"已登陆" message:@"已登陆！" cancel:nil confirm:@"确定"];
        return;
    }
}

-(void)requestCheckFail:(ASIHTTPRequest *)request{
    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
}

-(void)requestLoginSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200||[[dic objectForKey:@"code"] intValue] == 1000) {
        NSLog(@"登陆成功！");
        //已登陆
        [[ConstObject instance] setIsLogin:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"1" forKey:@"isLogin"];
        [userDefaults synchronize];
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:[[ConstObject instance] vc]];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];

        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1003){
    
        [super showMessageBox:self title:nil message:[dic objectForKey:@"msg"] cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1004){
        
        [super showMessageBox:self title:nil message:[dic objectForKey:@"msg"] cancel:nil confirm:@"确定"];
        return;
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

-(void)toReturn{
    // 自定义动画
    
    CATransition *transition = [CATransition animation];
 
    // 动画时间
    
    transition.duration = 0.5f;
  
    
    // 动画时间控制
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 动画类型
    
    transition.type = kCATransitionPush;
    
    // 动画进入方式
    
    transition.subtype = kCATransitionFromBottom;
    
     // 动画事件
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    if (self.noShowReturn == YES) {
        [self.navigationController popViewControllerAnimated:NO];
        [[AppDelegate shareDelegate] tabClickAction:[AppDelegate shareDelegate].homeTab];
    }
    else {
        [self.navigationController popViewControllerAnimated:NO];
    }
   
   
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
