//
//  CouponViewController.m
//  sjsh
//
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponCell.h"

@interface CouponViewController ()

@property(nonatomic, strong) UITableView *couponTableView;//优惠券列表

@property (nonatomic, strong)  NSMutableArray *couponArray;//列表的内容数组

@property (nonatomic, strong) NSString *stringList;

@end

@implementation CouponViewController

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
   
    [super initNavBarItems:@"我的优惠券"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;
    
    
    self.stringList = @"{\"code\":200,\"status\":\"true\",\"result\":[{\"coupon_id\":\"2721\",\"name\":\"\u6d4b\u8bd5APP\",\"code\":\"XXCCS\",\"type\":1,\"discount\":5,\"logged\":\"1\",\"shipping\":\"1\",\"total\":20,\"date_start\":\"2015-10-20\",\"date_end\":\"2016-09-30\",\"uses_total\":\"99\",\"uses_customer\":\"99\",\"for_customer\":\"244\",\"status\":\"1\",\"date_added\":\"2015-10-20 18:35:19\",\"store_type\":\"0\"},{\"coupon_id\":\"2722\",\"name\":\"\u6d4b\u8bd5APP2\",\"code\":\"XXCCS1\",\"type\":0,\"discount\":5,\"logged\":\"1\",\"shipping\":\"1\",\"total\":20,\"date_start\":\"2015-10-22\",\"date_end\":\"2015-10-31\",\"uses_total\":\"1\",\"uses_customer\":\"1\",\"for_customer\":\"244\",\"status\":\"1\",\"date_added\":\"2015-10-22 16:56:31\",\"store_type\":\"0\"},{\"coupon_id\":\"2732\",\"name\":\"4\u5143\u4f18\u60e0\u5238\u5fae\u5e97\u6d4b\u8bd5\",\"code\":\"89982x22\",\"type\":0,\"discount\":4,\"logged\":\"0\",\"shipping\":\"0\",\"total\":20,\"date_start\":\"2015-11-26\",\"date_end\":\"2015-11-29\",\"uses_total\":\"1\",\"uses_customer\":\"1\",\"for_customer\":\"244\",\"status\":\"1\",\"date_added\":\"2015-11-26 14:41:42\",\"store_type\":\"0\"},{\"coupon_id\":\"2733\",\"name\":\"8\u5143\u4f18\u60e0\u5238\u5fae\u5e97\u6d4b\u8bd5\",\"code\":\"8922\",\"type\":0,\"discount\":8,\"logged\":\"0\",\"shipping\":\"0\",\"total\":20,\"date_start\":\"2015-11-26\",\"date_end\":\"2015-11-28\",\"uses_total\":\"1\",\"uses_customer\":\"1\",\"for_customer\":\"244\",\"status\":\"1\",\"date_added\":\"2015-11-26 20:05:46\",\"store_type\":\"0\"}]}";

    
    self.couponTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.couponTableView.delegate = self;
    self.couponTableView.dataSource = self;
    //    self.addressTableView.showsVerticalScrollIndicator =
    //    NO;
//    self.couponTableView.allowsMultipleSelectionDuringEditing = YES;
    self.couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.couponTableView.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.couponTableView];
    
    //测试数据
    self.couponArray = [[NSMutableArray alloc]init];
//    NSMutableDictionary *couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"0";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
//    couponDictionary = [[NSMutableDictionary alloc] init];
//    couponDictionary[@"flag"] = @"1";
//    [self.couponArray addObject:couponDictionary];
    
    
    
    [self loadCouponData];//调用接口
}

//加载优惠券接口数据
-(void) loadCouponData{
        [commonModel getCouponData:nil httpRequestSucceed:@selector(requestCouponSuccess:) httpRequestFailed:@selector(requestFailed:)];

}

//提交地址信息成功
- (void)requestCouponSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
     NSLog(@"获取优惠券信息：responseString%@！！！！",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
//    dic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"获取优惠券信息：%@！！！！",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.couponArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
        [self.couponTableView reloadData];
    }
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
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couponArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"AddressCell";
    
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[CouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.couponArray[indexPath.row]];
    
    return cell;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
