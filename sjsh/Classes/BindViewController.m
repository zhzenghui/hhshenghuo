//
//  LoginViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "BindViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "InputItemModel.h"
@interface BindViewController ()<inputModelDelegate>

@end

@implementation BindViewController
@synthesize infoDictionary;
@synthesize userNameTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"世纪生活";
    [super initNavBarItems:@"关联账号"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    
//    self.navigationController.navigationBarHidden = YES;
//    
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
//    
//    UIButton *closeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//    [closeButton setTintColor:[UIColor whiteColor]];
//    closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    [closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
//    [closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateHighlighted];
//    [closeButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
//    if (kSystemIsIOS7) {
//        closeButton.frame = CGRectMake(255.0f, 20.0f, 60,44);
//    }
//    else{
//        closeButton.frame = CGRectMake(255.0f, 0.0f, 60,44);
//    }
//    [self.view addSubview:closeButton];
//    [closeButton release];
//    
    // 用户名 登录密码
    for (int i = 0; i < 2; i++) {
//        UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35,top_H + i *59 + 41, 250, 44)];
//        inputImageView.image = INPUT_BG;
//        [self.view addSubview:inputImageView];
//        
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(35,top_H + i *59 + 41, 44, 44)];
//        icon.image = i==0?ACCOUNT_BG:PASSWORD_BG;
//        [self.view addSubview:icon];
//        
//        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(35 + 44, top_H + i *59 + 41, 211, 44)];
//        textField.font = [UIFont systemFontOfSize:14];
//        textField.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
//        // TODO 设置placeholder 颜色
//        
//        if (i == 0) {
//            textField.placeholder = @"手机号/邮箱";
//            self.userNameTextField = textField;
//            [self.view addSubview:self.userNameTextField ];
//        }
//        else
//        {
//            textField.placeholder = @"登录密码";
//            textField.keyboardType = UIKeyboardTypeEmailAddress;
//            self.passwordTextField = textField;
//            [self.view addSubview:self.passwordTextField ];
//        }
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
    
    
    passwordTextField.secureTextEntry = YES;
    
    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(35, 0 + 204 , 250, 44);
    [loginBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    loginBtn.tag = 1;
    [loginBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];

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
        
        NSMutableDictionary *transforDic = [NSMutableDictionary dictionary];
        [transforDic setObject:userNameString forKey:@"telephone"];
        [transforDic setObject:passwordString forKey:@"password"];
        NSString *type = [self.infoDictionary objectForKey:@"type"];
        if ([type isEqualToString:@"QQ"]) {
            //            @{@"type":@"QQ",@"nickName":name,@"openId":self.QQopenId,@"accessToken"
            [transforDic setObject:[infoDictionary objectForKey:@"accessToken"] forKey:@"qq_token"];
            [transforDic setObject:[infoDictionary objectForKey:@"openId"] forKey:@"qq_openid_id"];
            [transforDic setObject:[infoDictionary objectForKey:@"nickName"] forKey:@"qq_user_username"];
        }
        else {
            [transforDic setObject:[infoDictionary objectForKey:@"accessToken"] forKey:@"unionid"];
            [transforDic setObject:[infoDictionary objectForKey:@"openId"] forKey:@"openid"];
            [transforDic setObject:[infoDictionary objectForKey:@"nickName"] forKey:@"nickname"];
        }
        [super showGif];
        [commonModel requestthrid_bd:transforDic httpRequestSucceed:@selector(requestLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void)requestLoginSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"登陆接口返回数据dic：%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSLog(@"登陆成功！");
        //已登陆
        [[ConstObject instance] setIsLogin:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"1" forKey:@"isLogin"];
        [userDefaults synchronize];
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:[[ConstObject instance] vc]];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1009){
    
        [super showMessageBox:self title:@"" message:@"该账户不存在或密码错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1000){
        
        [super showMessageBox:self title:@"已登陆" message:@"已登陆！" cancel:nil confirm:@"确定"];
        return;
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSLog(@"登陆失败dic：%@",request);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"登陆失败dic：%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 1000) {
        
    }
}

-(void)toReturn{

    [self.navigationController popViewControllerAnimated:YES];
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
