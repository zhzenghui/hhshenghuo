//
//  RegisterViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "RegisterViewController.h"
#import "PublicClassMethod.h"
#import "ConstObject.h"
#import "InputItemModel.h"

@interface RegisterViewController ()<inputModelDelegate>

@end

@implementation RegisterViewController
@synthesize inputTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super initNavBarItems:@"注册"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    // Do any additional setup after loading the view.
//    self.title = @"世纪生活";
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    bgImageView.image = IPHONE5?LOGIN_BG_568h:LOGIN_BG;
//    [self.view addSubview:bgImageView];
    
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
//        lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 63.0f, 320.0f, 1.0f)];
//    }
//    else {
//        lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, 320.0f, 1.0f)];
//    }
//    
//    lineView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
//    [self.view addSubview:lineView];
//    [lineView release];
//    
//    UIButton *closeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//    [closeButton setTintColor:[UIColor whiteColor]];
//    closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    [closeButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateNormal];
//    [closeButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateHighlighted];
//    [closeButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
//    if (kSystemIsIOS7) {
//        closeButton.frame = CGRectMake(0.0f, 20.0f, 60,44);
//    }
//    else{
//        closeButton.frame = CGRectMake(0.0f, 0.0f, 60,44);
//    }
//    [self.view addSubview:closeButton];
//    [closeButton release];
    /******************/
    
    UIImageView *jinduImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-60)/2,self.view.frame.size.height-top_H-61, 60, 24)];
        [self.view addSubview:jinduImageView];
    
    if (self.type == getVerificationCode) {
        jinduImageView.image = [UIImage imageNamed:@"jindu2-1"];
        UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-90)/2,30, 90, 77)];
        inputImageView.image = [UIImage imageNamed:@"dingbutu"];
        [self.view addSubview:inputImageView];

        InputItemModel *input = [[InputItemModel alloc] initWithFrame:CGRectMake(33,107, 254, 45) iconImage:@"shouji" text:@"" placeHolderText:@"输入手机号"];
        //  输入框
        [self.view addSubview:input];
        self.inputTextField = input.textField;

        // 按钮
        UIButton *competeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        competeBtn.frame = CGRectMake(35, 182 , 250, 44);
        [competeBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
        [competeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [competeBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        
        [competeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:competeBtn];
        competeBtn.tag = 1;
        [competeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.navigationItem.hidesBackButton = YES;
    }
    else if(self.type == regist)
    {
        jinduImageView.image = [UIImage imageNamed:@"jindu2-2"];
        
        int startY = 17;
        if (MRScreenHeight>480) {
            UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-90)/2,30, 90, 77)];
            inputImageView.image = [UIImage imageNamed:@"dingbutu"];
            [self.view addSubview:inputImageView];
            startY = 108;
        }
        for (int i = 0; i<5; i++) {
            //  输入框
            CGRect rect = CGRectMake(35,startY+60*i, 250, 44);
//            UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35,top_H + 90 - 44+60*i, 250, 44)];
//            inputImageView.image = INPUT_BG;
//            [self.view addSubview:inputImageView];
//            
//            
//            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, top_H + 90 - 44+60*i, 220, 44)];
//            textField.font = [UIFont systemFontOfSize:14];
//            textField.text = @"";
//            textField.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
//            // TODO 设置placeholder 颜色
            switch (i) {
                case 0:
                {
                    InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"yanzhengma" text:@"" placeHolderText: @"输入验证码"];
                    //  输入框
                    input.delegate = self;
                    [self.view addSubview:input];
                    self.inputTextField = input.textField;
                }
                    break;
                case 1:
                {
                    InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"nicheng" text:@"" placeHolderText: @"您的昵称"];
                    //  输入框
                    input.delegate = self;
                    [self.view addSubview:input];
                    self.nickNameTextField = input.textField;
                    
                }
                    break;
                case 2:
                {
                    InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"password" text:@"" placeHolderText: @"输入密码"];
                    //  输入框
                    input.delegate = self;
                    [self.view addSubview:input];
                    self.passWTextField = input.textField;
                    self.passWTextField.secureTextEntry = YES;
                    self.passWTextField.keyboardType = UIKeyboardTypeEmailAddress;
                }
                    break;
                case 3:
                {
                    InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"password" text:@"" placeHolderText: @"再次输入密码"];
                    //  输入框
                    input.delegate = self;
                    [self.view addSubview:input];
                    self.repeatPassTextField = input.textField;
                    self.repeatPassTextField.secureTextEntry = YES;
                    self.repeatPassTextField.keyboardType = UIKeyboardTypeEmailAddress;
                }
                    break;
                case 4:
                {
                    InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"shouji" text:@"" placeHolderText: @"请输入推荐人手机号"];
                    //  输入框
                    input.delegate = self;
                    [self.view addSubview:input];
                    self.recommendedTextField = input.textField;
                    self.recommendedTextField.secureTextEntry = YES;
                    self.recommendedTextField.keyboardType = UIKeyboardTypeEmailAddress;
                }
                    break;
                default:
                    break;
            }
        }
        
        
        
        // 按钮
        UIButton *competeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        competeBtn.frame = CGRectMake(35, startY+60*5+20 , 250, 44);
        [competeBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
        [competeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [competeBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        
        [competeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:competeBtn];
        competeBtn.tag = 2;
        [competeBtn setTitle:@"开始体验吧" forState:UIControlStateNormal];
//        self.navigationItem.leftBarButtonItem = [PublicClassMethod imageButtonSetImageAndTarget:self andSel:@selector(back) andImage:BACK_IMAGE];
    }
    
//    self.navigationItem.rightBarButtonItem = [PublicClassMethod imageButtonSetImageAndTarget:self andSel:@selector(cancle) andImage:CANCLE_IMAGE];
//    self.inputTextField.delegate = self;
//    self.nickNameTextField.delegate = self;
//    self.passWTextField.delegate = self;
//    self.repeatPassTextField.delegate = self;
    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.passWTextField || textField == self.repeatPassTextField|| textField == self.recommendedTextField) {
        self.view.frame = CGRectMake(0, MRScreenHeight>480? -90:-20, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        self.view.frame = CGRectMake(0, top_H, self.view.frame.size.width, self.view.frame.size.height);

    }
}


-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - nav 方法们
- (void)cancle
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark - 按钮方法们

- (void)buttonAction:(UIButton *)sender
{
    [self.inputTextField resignFirstResponder];
    if (sender.tag == 1) {
        // 获取验证码
//        RegisterViewController *registViewController = [[RegisterViewController alloc] init];
//        registViewController.type = regist;
//        [self.navigationController pushViewController:registViewController animated:YES];

        [self getVerificationCode];
    }
    else if (sender.tag == 2)
    {
        // 完成注册
        [self completeRegist];
    }
    
}
// 获取验证码
- (void)getVerificationCode
{
    // TODO 判断 填写的手机号 是否为空 是否符合规则
    NSString *tempString = [self.inputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL isTelephone = [self validatePhoneNumber:tempString];
    if (isTelephone) {
        // 手机号合法
        [[ConstObject instance] setTelephoneNumber:tempString];
        [super showGif];
        [commonModel requestRegister:[NSDictionary dictionaryWithObject:tempString forKey:@"phone"] httpRequestSucceed:@selector(requestRegisterSuccess:) httpRequestFailed:@selector(requestFailed:)];

    }else{
        
        [super showMessageBox:self title:@"手机号不合法" message:@"请输入正确的手机号" cancel:nil confirm:@"确定"];
    }
}

-(BOOL)validatePhoneNumber:(NSString *)phoneNumber
{
//    if ([[_codeDic objectForKey:@"code"] isEqualToString:CHINA_ZONE_ID]) {
        NSString *phoneNumberRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$";
        NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
        return [phoneNumberTest evaluateWithObject:phoneNumber];
//    }
//    return YES;
}

//完成注册
- (void)completeRegist
{
    if (self.inputTextField.text.length==0 || self.nickNameTextField.text.length ==0 || self.passWTextField.text ==0 || self.repeatPassTextField.text == 0) {
        [super showMessageBox:self title:@"" message:@"请将信息补充完整" cancel:nil confirm:@"确定"];
        return;
    }
    else if([self.passWTextField.text isEqualToString:self.repeatPassTextField.text] == NO){
        [super showMessageBox:self title:@"" message:@"两次输入的密码不一致" cancel:nil confirm:@"确定"];
        return;
    }
    // TODO
    NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:[[ConstObject instance] telephoneNumber],@"phone",inputTextField.text,@"key",self.passWTextField.text,@"passwd",self.repeatPassTextField.text,@"cpasswd",self.nickNameTextField.text,@"firstname",[NSNumber numberWithInt:5],@"ftype",self.recommendedTextField.text,@"rmtel", nil];
    [super showGif];
    [commonModel requestCompleteRegister:dataDic httpRequestSucceed:@selector(requestRegisterCompleteSuccess:) httpRequestFailed:@selector(requestRegisterFailed:)];
//    [self.navigationController popViewControllerAnimated:YES];
}

//验证手机短信验证码
-(void)requestRegisterCompleteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSLog(@"注册成功！");
        [[ConstObject instance] setIsLogin:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"1" forKey:@"isLogin"];
        [userDefaults synchronize];
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:[[ConstObject instance] vc]];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];

    }else{
    
        if ([[dic objectForKey:@"code"] intValue] == 1000) {
            [super showMessageBox:self title:@"已登录" message:@"已登录" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1107) {
            NSLog(@"验证码错误！");
            [super showMessageBox:self title:@"验证码错误" message:@"请输入正确的验证码" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1101) {
            [super showMessageBox:self title:@"账号输入格式有误" message:@"请输入正确的账号" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1102) {
            [super showMessageBox:self title:@"密码错误" message:@"密码必须在4到20字符之间" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1103) {
            [super showMessageBox:self title:@"密码不一致" message:@"确认密码与输入密码不一致" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1104) {
            [super showMessageBox:self title:@"" message:@"此手机号已注册" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1108) {
            [super showMessageBox:self title:@"参数错误" message:@"参数不正确（手机号为空）" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1109) {
            [super showMessageBox:self title:@"" message:@"昵称被占用" cancel:nil confirm:@"确定"];
        }
        else if ([[dic objectForKey:@"code"] intValue] == 1110) {
            [super showMessageBox:self title:@"" message:@"注册失败" cancel:nil confirm:@"确定"];
        }
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [super hideGif];
}

//发送手机短信验证码
-(void)requestRegisterSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"验证码获取成功dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        RegisterViewController *registViewController = [[RegisterViewController alloc] init];
        registViewController.type = regist;
        [self.navigationController pushViewController:registViewController animated:YES];
    }else{
        
        if ([[dic objectForKey:@"code"] intValue] == 1104) {
            NSLog(@"此手机号已注册！");
            [super showMessageBox:self title:@"此手机号已注册" message:@"请输入新的手机号码" cancel:nil confirm:@"确定"];
        }else if ([[dic objectForKey:@"code"] intValue] == 1005){
            NSLog(@"短信验证码发送频繁，一分后再次发送！");
            [super showMessageBox:self title:@"短信验证码发送频繁" message:@"短信验证码发送频繁，一分后再次发送" cancel:nil confirm:@"确定"];
            
        }
    }
}

-(void)requestRegisterFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 1000) {
        
    }
}

#pragma mark - 手势
- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    if (self.type == regist) {
        self.view.frame = CGRectMake(0, top_H, self.view.frame.size.width, self.view.frame.size.height);
        [self.nickNameTextField resignFirstResponder];
        [self.passWTextField resignFirstResponder];
        [self.repeatPassTextField resignFirstResponder];
        [self.recommendedTextField resignFirstResponder];
    }
    [self.inputTextField resignFirstResponder];
    
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
