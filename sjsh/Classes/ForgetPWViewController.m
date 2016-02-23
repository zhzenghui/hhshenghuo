//
//  ForgetPWViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "FindWayViewController.h"
#import "InputItemModel.h"

@interface ForgetPWViewController ()<inputModelDelegate,UIGestureRecognizerDelegate>

@end

@implementation ForgetPWViewController

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
   
    NSString *title = @"";
    int startY = 30+97+15;
    UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-72)/2,30, 72, 97)];
    inputImageView.image = [UIImage imageNamed:@"toubutu"];
    [self.view addSubview:inputImageView];
    UIImageView *jinduImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-85)/2,self.view.frame.size.height-top_H-61, 85, 24)];
    [self.view addSubview:jinduImageView];
    switch (_page) {
        case forgetPage1:
        {
            title = @"找回密码";
            jinduImageView.image = [UIImage imageNamed:@"jindu3-1"];
            CGRect rect = CGRectMake(35,startY+60*0, 250, 44);
            InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"shouji" text:@"" placeHolderText: @"输入手机号"];
            //  输入框
            input.delegate = self;
            [self.view addSubview:input];
            self.TextField1 = input.textField;
            // 按钮
            UIButton *competeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            competeBtn.frame = CGRectMake(35, startY+60*1+20 , 250, 44);
            [competeBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
            [competeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [competeBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
            
            [competeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:competeBtn];
            competeBtn.tag = 2;
            [competeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
            break;
        case forgetPage2:
        {
            title = @"找回密码";
            jinduImageView.image = [UIImage imageNamed:@"jindu3-2"];
            CGRect rect = CGRectMake(35,startY+60*0, 250, 44);
            InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"yanzhengma" text:@"" placeHolderText: @"输入验证码"];
            //  输入框
            input.delegate = self;
            [self.view addSubview:input];
            self.TextField1 = input.textField;
            
            // 按钮
            UIButton *competeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            competeBtn.frame = CGRectMake(35, startY+60*1+20 , 250, 44);
            [competeBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
            [competeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [competeBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
            
            [competeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:competeBtn];
            competeBtn.tag = 2;
            [competeBtn setTitle:@"确定" forState:UIControlStateNormal];
        }
            break;
        case forgetPage3:
        {
            title = @"设置新密码";
            jinduImageView.image = [UIImage imageNamed:@"jindu3-3"];
            CGRect rect = CGRectMake(35,startY+60*0, 250, 44);
            InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"password" text:@"" placeHolderText: @"输入新密码"];
            //  输入框
            input.delegate = self;
            [self.view addSubview:input];
            self.TextField1 = input.textField;
            self.TextField1.secureTextEntry = YES;
            
            CGRect rect1 = CGRectMake(35,startY+60*1, 250, 44);
            InputItemModel *input1 = [[InputItemModel alloc] initWithFrame:rect1 iconImage:@"password" text:@"" placeHolderText: @"再次输入密码"];
            //  输入框
            input1.delegate = self;
            [self.view addSubview:input1];
            self.TextField2 = input1.textField;
            self.TextField2.secureTextEntry = YES;
            // 按钮
            UIButton *competeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            competeBtn.frame = CGRectMake(35, startY+60*2+20 , 250, 44);
            [competeBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
            [competeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [competeBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
            
            [competeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:competeBtn];
            competeBtn.tag = 2;
            [competeBtn setTitle:@"提交" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    [super initNavBarItems:title];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
     self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    
//    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];
//    settingTableView.delegate = self;
//    settingTableView.dataSource = self;
//    //    listTableView.backgroundColor = [UIColor clearColor];
//    settingTableView.separatorColor = COLOR(178, 178, 178);
//    [self.view addSubview:settingTableView];
//    [settingTableView release];
    
    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_page == forgetPage3) {
        self.view.frame = CGRectMake(0, MRScreenHeight>480? -90:-20, self.view.frame.size.width, self.view.frame.size.height);
    }
}

#pragma mark - 手势
- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    self.view.frame = CGRectMake(0, top_H, self.view.frame.size.width, self.view.frame.size.height);
    [self.TextField1 resignFirstResponder];
    [self.TextField2 resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonAction:(UIButton *)button
{
    [super showGif];
    switch (_page) {
        case forgetPage1:
        {
            [commonModel requestgetpassword:@{@"phorem":self.TextField1.text}httpRequestSucceed:@selector(requestgetpasswordSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case forgetPage2:
        {
            [commonModel requestgetpassgetyz:@{@"phorem":[_params objectAtIndex:0],@"phoremyz":self.TextField1.text} httpRequestSucceed:@selector(requestgetpassgetyzSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
            break;
        case forgetPage3:
        {
            [commonModel requestupdatepassword:@{@"phorem":[_params objectAtIndex:0],@"password":self.TextField1.text,@"fpassword":self.TextField2.text} httpRequestSucceed:@selector(requestupdatepasswordSuccess:) httpRequestFailed:@selector(requestFailed:)];
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
        ForgetPWViewController *forgetVC = [[[ForgetPWViewController alloc] init] autorelease];
        forgetVC.page = forgetPage2;
        forgetVC.params = @[self.TextField1.text];
        [self.navigationController pushViewController:forgetVC animated:YES];
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
        ForgetPWViewController *forgetVC = [[[ForgetPWViewController alloc] init] autorelease];
        forgetVC.page = forgetPage3;
        forgetVC.params = self.params;
        [self.navigationController pushViewController:forgetVC animated:YES];
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
        [super showMessageBox:nil title:@"" message:@"新密码设置成功" cancel:nil confirm:@"确定"];
    }else if ([[dic objectForKey:@"code"] intValue] == 2001){
        
        [super showMessageBox:self title:@"" message:@"修改失败" cancel:nil confirm:@"确定"];
        return;
    }
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
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50.0f;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
//    //   if(sectionIndex == 0)
//    return 1;
//    //    else
//    //        return 3;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.001;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellIdentifier = @"ProfileCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if(!cell){
//        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//        //        cell.backgroundColor = COLOR(255, 255, 255);
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.textLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1];
//        
//    }
//    if (indexPath.section == 0) {
//        [cell.textLabel setText:@"通过手机找回"];
//        
//    }else if (indexPath.section == 1) {
//        [cell.textLabel setText:@"通过邮箱找回"];
//        
//    }
//    return cell;
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    int sections = indexPath.section;
//     FindWayViewController *findVC = [[FindWayViewController alloc] init];
//    if(sections == 0){
//        //push 手机号
//        findVC.pStytl = Phone;
////        findVC.params = @[@"18003185799"];
//    }else if(sections == 1){
//        //push 邮箱
//        findVC.pStytl = Email;
//    }
//    [self.navigationController pushViewController:findVC animated:YES];
//}

@end
