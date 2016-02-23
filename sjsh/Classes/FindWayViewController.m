//
//  FindWayViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "FindWayViewController.h"

@interface FindWayViewController ()
@property (nonatomic, retain) UITextField *textF1;
@property (nonatomic, retain) UITextField *textF2;
@property (nonatomic, retain) UITextField *textF3;
@property (nonatomic, retain) UIButton *okButton;

@end

@implementation FindWayViewController
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
//    self.navigationController.navigationBarHidden = NO;
    self.textF1 = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    self.textF1.delegate = self;
    self.textF2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    self.textF2.delegate = self;
    self.textF3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    self.textF3.delegate = self;

    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.okButton setBackgroundImage:[[UIImage imageNamed:@"button_green"] stretchableImageWithLeftCapWidth:7
                                                                                                topCapHeight:7] forState:UIControlStateNormal];
    self.okButton.frame = CGRectMake(10, 30, 300, 40);
    [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    NSString *title = @"";
    switch (_pStytl) {
        case Phone:
        {
            title = @"手机找回";
            self.textF1.placeholder = @"输入手机号";
            [self.okButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
            break;
        case Email:
        {
            self.textF1.placeholder = @"输入邮箱";
            title = @"邮箱找回";
            [self.okButton setTitle:@"发送验证邮件" forState:UIControlStateNormal];
        }
            break;
        case VCode:
        {
            self.textF1.placeholder = @"输入验证码";
            title = @"手机找回";
            [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        }
            break;
        case SetPW:
        {
            self.textF1.placeholder = @"输入新密码";
            self.textF1.secureTextEntry = YES;
            self.textF2.placeholder = @"再次输入";
            self.textF2.secureTextEntry = YES;
            title = @"设置新密码";
            [self.okButton setTitle:@"提交" forState:UIControlStateNormal];
        }
            break;
        case Input_old_pw:
        {
            title = @"修改密码";
            self.textF1.placeholder = @"输入旧密码";
            [self.okButton setTitle:@"下一步" forState:UIControlStateNormal];
        }
            break;
        case Modify_PW:
        {
            self.textF1.placeholder = @"输入原密码";
            self.textF2.placeholder = @"输入新密码";
            self.textF3.placeholder = @"再次输入新密码";
            self.textF1.secureTextEntry = YES;
            self.textF2.secureTextEntry = YES;
            self.textF3.secureTextEntry = YES;
            title = @"修改密码";
            [self.okButton setTitle:@"提交" forState:UIControlStateNormal];
        }
            break;
        case InputPW_phone:
        {
            self.textF1.placeholder = @"输入登录密码";
            title = @"绑定手机";
            [self.okButton setTitle:@"下一步" forState:UIControlStateNormal];
        }
            break;
        case InputPW_email:
        {
            self.textF1.placeholder = @"输入登录密码";
            title = @"绑定邮箱";
            [self.okButton setTitle:@"下一步" forState:UIControlStateNormal];
        }
            break;
        case InPutPhone_bd:
        {
            title = @"绑定手机";
            self.textF1.placeholder = @"输入手机号";
            [self.okButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
            break;
        case InputEmail_bd:
        {
            self.textF1.placeholder = @"输入邮箱";
            title = @"绑定邮箱";
            [self.okButton setTitle:@"发送验证邮件" forState:UIControlStateNormal];
        }
            break;
        case InputVcode_p_bd:
        {
            self.textF1.placeholder = @"输入验证码";
            title = @"绑定手机";
            [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        }
            break;
        case InputVcode_E_bd:
        {
            self.textF1.placeholder = @"输入验证码";
            title = @"绑定邮箱";
            [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    [super initNavBarItems:title];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(255, 255, 255);
    
    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    //    listTableView.backgroundColor = [UIColor clearColor];
    settingTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:settingTableView];
    [settingTableView release];
    
    settingTableView.contentSize = CGSizeMake(MRScreenWidth, MRScreenHeight+100);
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.textF3) {
        settingTableView.contentOffset = CGPointMake(0, 100);
    }
    else if (textField == self.textF2)
    {
        settingTableView.contentOffset = CGPointMake(0, 50);
    }
    else {
        settingTableView.contentOffset = CGPointMake(0, 0);
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark --- UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_pStytl == SetPW) {
        return 2;
    }
    else if(_pStytl == Modify_PW){
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    //   if(sectionIndex == 0)
    return 1;
    //    else
    //        return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_pStytl == SetPW) {
        if (section == 1) {
            return 30;
        }
    }
    else if(_pStytl == Modify_PW){
        if (section == 2) {
            return 30;
        }
    }
    else{
        if (section== 0) {
            return 30;
        }
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_pStytl == SetPW) {
        if (section== 1) {
            return 70;
        }
        return 0.001;
    }
    else if(_pStytl == Modify_PW){
        if (section == 2) {
            return 70;
        }
        return 0.01;
    }
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_pStytl == SetPW) {
        if (section== 1) {
            UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
            [footV addSubview:self.okButton];
            footV.backgroundColor = [UIColor clearColor];
            return footV;
        }
        return nil;
    }
    else if(_pStytl == Modify_PW){
        if (section== 2) {
            UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
            [footV addSubview:self.okButton];
            footV.backgroundColor = [UIColor clearColor];
            return footV;
        }
        return nil;
    }
    UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    [footV addSubview:self.okButton];
    footV.backgroundColor = [UIColor clearColor];
    return footV;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //        cell.backgroundColor = COLOR(255, 255, 255);
        cell.backgroundColor = [UIColor whiteColor];
    }
    switch (_pStytl) {
        case Modify_PW:
        {
            if (indexPath.section == 0) {
                [cell.contentView addSubview:self.textF1];
            }
            else if (indexPath.section == 1) {
                [cell.contentView addSubview:self.textF2];
            }
            else if (indexPath.section == 2) {
                [cell.contentView addSubview:self.textF3];
            }
    }
            break;
        case SetPW:
        {
            if (indexPath.section == 0) {
                [cell.contentView addSubview:self.textF1];
            }
            else if (indexPath.section == 1) {
                [cell.contentView addSubview:self.textF2];
            }
        }
            break;
        default:
        {
            if (indexPath.section == 0) {
                [cell.contentView addSubview:self.textF1];
            }
        }
            break;
    }
    return cell;
}

- (void)buttonTapped
{
    [super showGif];
    switch (_pStytl) {
        case Phone:
        case Email:
        {
            [commonModel requestgetpassword:@{@"phorem":self.textF1.text}httpRequestSucceed:@selector(requestgetpasswordSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case VCode:
        {
            [commonModel requestgetpassgetyz:@{@"phorem":[_params objectAtIndex:0],@"phoremyz":self.textF1.text} httpRequestSucceed:@selector(requestgetpassgetyzSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case SetPW:
        {
            [commonModel requestupdatepassword:@{@"phorem":[_params objectAtIndex:0],@"password":self.textF1.text,@"fpassword":self.textF2.text} httpRequestSucceed:@selector(requestupdatepasswordSuccess:) httpRequestFailed:@selector(requestFailed:)];
            
        }
            break;
        case Modify_PW:
        {
            [commonModel requestchangepasswd:@{@"opasswd":self.textF1.text,@"npasswd":self.textF2.text,@"cpasswd":self.textF3.text} httpRequestSucceed:@selector(requestchangepasswdSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case InPutPhone_bd:
        {
            [commonModel requestRegister:[NSDictionary dictionaryWithObject:self.textF1.text forKey:@"phone"] httpRequestSucceed:@selector(requestRegisterSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case InputVcode_p_bd:
        {
            [commonModel requestchekey:@{@"phone":[_params objectAtIndex:0],@"send_phone_key":self.textF1.text} httpRequestSucceed:@selector(requestchekeySuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        default:
            break;
    }
}

- (void)requestgetpasswordSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        FindWayViewController *findVc = [[FindWayViewController alloc] init];
        findVc.params = @[self.textF1.text];
        findVc.pStytl = VCode;
        [self.navigationController pushViewController:findVc animated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 2410){
        
        [super showMessageBox:self title:@"账号不存在" message:@"该账号尚未注册" cancel:nil confirm:@"确定"];
        return;
    }
}

- (void)requestgetpassgetyzSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        FindWayViewController *findVc = [[FindWayViewController alloc] init];
        findVc.pStytl = SetPW;
        findVc.params = self.params;
        [self.navigationController pushViewController:findVc animated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 2001){
        
        [super showMessageBox:self title:@"" message:@"验证失败" cancel:nil confirm:@"确定"];
        return;
    }
}

- (void)requestupdatepasswordSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self.navigationController popToViewController :[[ConstObject instance] vc] animated:YES];
        [super showMessageBox:self title:@"" message:@"新密码设置成功" cancel:nil confirm:@"确定"];
    }else if ([[dic objectForKey:@"code"] intValue] == 2001){
        
        [super showMessageBox:self title:@"" message:@"修改失败" cancel:nil confirm:@"确定"];
        return;
    }
}

- (void)requestchangepasswdSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [super showMessageBox:self title:@"" message:@"修改成功" cancel:nil confirm:@"确定"];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 1301){
        
        [super showMessageBox:self title:@"" message:@"旧密码错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 400){
        
        [super showMessageBox:self title:@"" message:@"修改失败" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"" message:@"未登录" cancel:nil confirm:@"确定"];
        return;
    }
    NSLog(@"%@",[dic objectForKey:@"msg"]);
}

//发送手机短信验证码
-(void)requestRegisterSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        FindWayViewController *findVc = [[FindWayViewController alloc] init];
        findVc.pStytl = InputVcode_p_bd;
        findVc.params = @[self.textF1.text];
        [self.navigationController pushViewController:findVc animated:YES];
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

- (void)requestchekeySuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        [[ConstObject instance] setTelephoneNumber:[_params objectAtIndex:0]];
    }else{
        
        if ([[dic objectForKey:@"code"] intValue] == 1106) {
            [super showMessageBox:self title:@"" message:@"参数不正确" cancel:nil confirm:@"确定"];
        }else if ([[dic objectForKey:@"code"] intValue] == 1107){
            [super showMessageBox:self title:@"" message:@"验证码错误" cancel:nil confirm:@"确定"];
            
        }
    }
}

//switch (_pStytl) {
//    case Phone:
//    {
//        
//    }
//        break;
//    case Email:
//    {
//        
//    }
//        break;
//    case VCode:
//    {
//        
//    }
//        break;
//    case SetPW:
//    {
//        
//    }
//        break;
//    default:
//        break;
//}

@end
