//
//  MemberAccountViewController.m
//  sjsh
//
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MemberAccountViewController.h"
#import "MemberAccountCell.h"
#import "MemberPayViewController.h"
#import "SVPullToRefresh.h"

@interface MemberAccountViewController ()


@property(nonatomic, strong) UILabel *memberTitleLabel;//标题
@property(nonatomic, strong) UILabel *memberPriceLabel;//余额
@property(nonatomic, strong) UIButton *payButton;//充值
@property(nonatomic, strong) UITableView *financeTableView;//收支列表
//@property (nonatomic, assign) int page;//列表当前页数

@property (nonatomic, strong)  NSMutableArray *financeArray;//列表的内容数组

@property (nonatomic, strong) NSString *stringList;

@end

@implementation MemberAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"会员卡"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;

    self.view.backgroundColor = kRedColor;
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"msg\":{\"member_price\":\"700.7000\",\"memebr_array\":[{\"id\":\"39\",\"customer_id\":\"9705\",\"order_id\":\"117529\",\"order_name\":\"\",\"type\":\"-\",\"sums\":\"14.30\",\"addtime\":\"2015-12-18 15:53:59\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"quantity\":\"1\"},{\"id\":\"40\",\"customer_id\":\"9705\",\"order_id\":\"117531\",\"order_name\":\"\",\"type\":\"-\",\"sums\":\"14.30\",\"addtime\":\"2015-12-18 15:57:11\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"quantity\":\"1\"},{\"id\":\"41\",\"customer_id\":\"9705\",\"order_id\":\"117532\",\"order_name\":\"\",\"type\":\"-\",\"sums\":\"14.30\",\"addtime\":\"2015-12-18 15:59:04\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"quantity\":\"1\"},{\"id\":\"42\",\"customer_id\":\"9705\",\"order_id\":\"117533\",\"order_name\":\"\",\"type\":\"-\",\"sums\":\"14.30\",\"addtime\":\"2015-12-18 16:00:32\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"quantity\":\"1\"},{\"id\":\"43\",\"customer_id\":\"9705\",\"order_id\":\"117534\",\"order_name\":\"\",\"type\":\"-\",\"sums\":\"14.30\",\"addtime\":\"2015-12-18 16:01:03\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"quantity\":\"1\"}]}}";
    
    self.memberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, ScreenWidth, 15)];
    self.memberTitleLabel.text = @"会员卡余额";
    self.memberTitleLabel.textColor = [UIColor whiteColor];
    self.memberTitleLabel.font = [UIFont systemFontOfSize:12];
    self.memberTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.memberTitleLabel];
    
    self.memberPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.memberTitleLabel.frame.origin.y+self.memberTitleLabel.frame.size.height+10, ScreenWidth, 30)];
    self.memberPriceLabel.text = @"￥0";
    self.memberPriceLabel.textColor = [UIColor whiteColor];
    self.memberPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.memberPriceLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:self.memberPriceLabel];
    
    self.financeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, ScreenHeight-190)];
    self.financeTableView.delegate = self;
    self.financeTableView.dataSource = self;
    self.financeTableView.allowsMultipleSelectionDuringEditing = YES;
    self.financeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.financeTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.financeTableView];
    
    float payButtonSize = 70.0;
    self.payButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-payButtonSize)/2,  self.financeTableView.frame.origin.y-payButtonSize/2, payButtonSize, payButtonSize)];
    self.memberPriceLabel.text = @"￥0";
    [self.payButton setTitleColor:kRedColor forState:UIControlStateNormal];
    [self.payButton setTitle:@"充值" forState:UIControlStateNormal];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.payButton.layer.cornerRadius = payButtonSize/2;
    self.payButton.layer.masksToBounds = YES;
    self.payButton.backgroundColor = [UIColor yellowColor];
    [self.payButton addTarget:self action:@selector(rechargeMember) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
 
    
    //调用接口
     [commonModel getMemberDetail:nil httpRequestSucceed:@selector(getMemberDetailSuccess:) httpRequestFailed:@selector(requestFailed:)];
 
}

//调用会员卡详细信息接口成功
- (void)getMemberDetailSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
     NSLog(@"调用会员卡详细信息接口成功：%@！！！！！",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
//    dic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"调用会员卡详细信息接口成功：%@！！！！！",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSDictionary *infoDictionary = [dic objectForKey:@"msg"];
       NSString *remainder = infoDictionary[@"member_price"];
        self.memberPriceLabel.text = remainder;
        
        self.financeArray = infoDictionary[@"memebr_array"];
        [self.financeTableView reloadData];
    }
}


//开通会员
-(void)rechargeMember{
    NSLog(@"充值会员！！！！");
    MemberPayViewController *myViewController = [[MemberPayViewController alloc]init];
    myViewController.remainderValue = self.memberPriceLabel.text;
    [self.navigationController pushViewController:myViewController animated:YES];
}


//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误！！！！！！");
}

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.financeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"MemberAccountCell";
    
    MemberAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[MemberAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.financeArray[indexPath.row]];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
