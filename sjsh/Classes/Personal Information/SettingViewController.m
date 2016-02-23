//
//  SettingViewController.m
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "SettingViewController.h"
#import "loginViewController.h"
#import "AboutUSViewController.h"
#import "FindWayViewController.h"
#import "FeedbackViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

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
    [super initNavBarItems:@"设置"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(255, 255, 255);
    
    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.scrollEnabled = NO;
    //    listTableView.backgroundColor = [UIColor clearColor];
    settingTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:settingTableView];
    [settingTableView release];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [logoutButton setFrame:CGRectMake(8, 350, 304, 44)];
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    

}

-(void)logout{

    [commonModel requestlogout:nil httpRequestSucceed:@selector(logoutSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

-(void)logoutSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    //由于接口返回内容错误，所以不管什么情况，都判断为登出成功！！！！
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"0" forKey:@"isLogin"];
    [userDefaults synchronize];
    [[ConstObject instance] setIsLogin:NO];
     NSLog(@"登陆标记为%@!!!!!!!",[userDefaults stringForKey:@"isLogin"]);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
        [self pushToLoginVC:YES animation:NO];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
//        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self pushToLoginVC:YES animation:NO];
        return;
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

#pragma mark --- UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
   if(sectionIndex == 0)
       return 2;
    else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    SettingViewCell *cell = (SettingViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[SettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //        cell.backgroundColor = COLOR(255, 255, 255);
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.section == 0) {
        if(indexPath.row ==0){
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"修改密码"]];
//            [cell.productNameLabel setText:[NSString stringWithFormat:@"%@",name]];
        }else if (indexPath.row ==1){
        
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"绑定手机"]];
            [cell.textsLabel setText:[[ConstObject instance] telephoneNumber]];
        }else if (indexPath.row ==2){
            
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"绑定邮箱"]];
        }
       
    }else if (indexPath.section == 1) {
        if(indexPath.row ==0){
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"清除缓存"]];
        }else if (indexPath.row ==1){
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"反馈建议"]];
        }else if (indexPath.row ==2){
            [cell.nameLabel setText:[NSString stringWithFormat:@"%@",@"关于我们"]];
        }
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int rowNum = indexPath.row;
    int sections = indexPath.section;
    if(sections == 0){
        FindWayViewController *findVC = [[FindWayViewController alloc] init];
        if(rowNum ==0){
            findVC.pStytl = Modify_PW;
        }
        else if (rowNum == 1){
            //绑定手机号
            findVC.pStytl = InPutPhone_bd;
        }
        else if (rowNum==2) {
//            绑定邮箱
             findVC.pStytl = InputEmail_bd;
        }
        [self.navigationController pushViewController:findVC animated:YES];
    }else if(sections == 1){
        
        if(rowNum ==0){
            
            backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-1, self.view.bounds.size.width, 1)];
            backImageView.backgroundColor = [UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:0.8];
            [self.navigationController.view addSubview:backImageView];
            [backImageView release];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.03];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            CGRect tempFrame = backImageView.frame;
            tempFrame.origin.y = self.view.bounds.origin.y;
            tempFrame.size.height = self.view.bounds.size.height+64;
            backImageView.frame = tempFrame;
            
            [UIView commitAnimations];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您确定清除图片缓存和浏览记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
           
        }
        else if (rowNum == 1){
            //反馈建议
            FeedbackViewController *aboutVC = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        else if (rowNum==2){
            //关于我们
            AboutUSViewController *aboutVC = [[AboutUSViewController alloc] init];
            aboutVC.type = aboutUS;
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(backImageView ){
        [backImageView removeFromSuperview];
        backImageView = nil;
    }

    if (buttonIndex == 1)
    {
        [self clearCache];
    }
}

-(void)clearCache{

    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%d",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
  }
-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
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
