//
//  ThirdPartChoicePageViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ThirdPartChoicePageViewController.h"
#import "BindRegisterViewController.h"
#import "BindViewController.h"
@interface ThirdPartChoicePageViewController ()

@end

@implementation ThirdPartChoicePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"";
    switch (_type) {
        case WXLogin:
        {
            title = @"微信登录";
        }
            break;
        case QQ_LOGIN:
        {
            title = @"QQ登录";
        }
            break;
        default:
            break;
    }
    [super initNavBarItems:title];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    //设置标题
    int startY = 26;
    self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    // Do any additional setup after loading the view.
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MRScreenWidth-100)/2, startY, 100.0f, 100.0f)];
    [avatarImageView setImageWithURL:[NSURL URLWithString:[_transforDic objectForKey:@"headimgurl"]] placeholderImage:nil];
    avatarImageView.backgroundColor = [UIColor redColor];
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2.0;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    [self.view addSubview:avatarImageView];
    
    startY += 100+15;
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, startY, MRScreenWidth, 20.0f)];
    nickLabel.backgroundColor = [UIColor clearColor];
    nickLabel.font = [UIFont fontWithName:@"Arial" size:20.0f];
    [nickLabel setText:[NSString stringWithFormat:@"%@ 您好！",[_transforDic objectForKey:@"nickName"]]];
    [nickLabel adjustsFontSizeToFitWidth];
    //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
    nickLabel.textColor = COLOR(0x6d, 0x6d, 0x6d);
    nickLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nickLabel];
    [nickLabel release];
    
    startY += 20+11;
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, startY, MRScreenWidth, 12.0f)];
    Label1.backgroundColor = [UIColor clearColor];
    Label1.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [Label1 setText:@"为了更好地服务，请关联一个世纪生活账号"];
    [Label1 adjustsFontSizeToFitWidth];
    //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
    Label1.textColor = COLOR(0x6d, 0x6d, 0x6d);
    Label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Label1];
    [Label1 release];
    
    startY += 12+34;

    UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, startY, MRScreenWidth, 12.0f)];
    Label2.backgroundColor = [UIColor clearColor];
    Label2.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [Label2 setText:@"还没有账号？"];
    [Label2 adjustsFontSizeToFitWidth];
    //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
    Label2.textColor = COLOR(0x6d, 0x6d, 0x6d);
    Label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Label2];
    [Label2 release];
    
    startY += 12+11;
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(35, startY , 250, 44);
    [registerBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    registerBtn.tag = 1;
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    startY += 44+38;
    UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, startY, MRScreenWidth, 12.0f)];
    Label3.backgroundColor = [UIColor clearColor];
    Label3.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [Label3 setText:@"已有账号"];
    [Label3 adjustsFontSizeToFitWidth];
    //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
    Label3.textColor = COLOR(0x6d, 0x6d, 0x6d);
    Label3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Label3];
    [Label3 release];

    startY += 12+9;
    UIButton *relateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    relateBtn.frame = CGRectMake(35, startY , 250, 44);
    [relateBtn setBackgroundImage:[UIImage imageNamed:@"relate"] forState:UIControlStateNormal];
    [relateBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [relateBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    relateBtn.tag = 2;
    [relateBtn setTitle:@"立即关联" forState:UIControlStateNormal];
    [relateBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:relateBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        BindRegisterViewController *registViewController = [[BindRegisterViewController alloc] init];
        registViewController.infoDictionary = self.transforDic;
        [self.navigationController pushViewController:registViewController animated:YES];
    }
    else if (sender.tag == 2)
    {
        BindViewController *bindVc = [[BindViewController alloc] init];
        bindVc.infoDictionary = self.transforDic;
        [self.navigationController pushViewController:bindVc animated:YES];
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

@end
