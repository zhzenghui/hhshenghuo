//
//  MemberPayViewController.m
//  sjsh
//
//  Created by savvy on 15/11/25.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MemberPayViewController.h"
#import "CouponCell.h"
#import "MemberWayCell.h"
#import "SVProgressHUD.h"

#import "OrderUnit.h"
#import "WXPayUtil.h"
#import "Order.h"
#import "SVProgressHUD.h"
#import "UPPayPlugin.h"
#import "WXApi.h"
#import "NSString+MD5Addition.h"
#import "OpenURLViewController.h"

#define BASE_URL @"https://api.weixin.qq.com"

@interface MemberPayViewController ()
{
    UITextField *currentTextField;
}

@property(nonatomic, strong) UIScrollView *pageScroll;//页面滚动视图



@property(nonatomic, strong) UILabel *memberInfoLable;//会员卡信息
@property(nonatomic, strong) UIView *memberInfoView;
@property(nonatomic, strong) UIView *nameView;//姓名
@property(nonatomic, strong) UIView *phoneView;//手机号
@property(nonatomic, strong) UIView *remainderView;//余额
@property(nonatomic, strong) UIView *moneyView;//充值金额

@property(nonatomic, strong) UIView *lineView01;//分割线
@property(nonatomic, strong) UIView *lineView02;
@property(nonatomic, strong) UIView *lineView03;


@property(nonatomic, strong) UILabel *payWayLable;//支付方式
@property(nonatomic, strong) UITableView *payWayTableView;//支付方式列表
@property(nonatomic, strong) UIView *agreeView;//同意

@property(nonatomic, strong) UIButton *payButton;//支付

@property(nonatomic, strong) UILabel *nameLabe;
@property(nonatomic, strong) UITextField *nameText;         //姓名
@property(nonatomic, strong) UILabel *phoneLabe;
@property(nonatomic, strong) UITextField *phoneText;        //手机号
@property(nonatomic, strong) UILabel *remainderLabe;
@property(nonatomic, strong) UILabel *remainderContentLabel;
@property(nonatomic, strong) UILabel *moneyLabe;
@property(nonatomic, strong) UILabel *moneyText;        //充值金额

@property(nonatomic, strong) UIImageView *agreeImageView;
@property(nonatomic, strong) UIButton *agreeButton;
@property(nonatomic, strong) UILabel *agreeLabel;
@property(nonatomic, strong) UIButton *clauseButton;

@property(nonatomic, strong) NSMutableArray *payWayArray;//支付方式数据

@property (nonatomic, retain) WXProduct *WXPayProduct;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, strong) NSString *nonceStr;
@property (nonatomic, strong) NSString *traceId;

@property (nonatomic, assign) float rechargeMoney;//充值金额
//@property(nonatomic, assign) NSInteger  payWayID;//所选支付方式
@end

@implementation MemberPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"会员卡"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;
    
    if(self.remainderValue!=nil&&![self.remainderValue isEqualToString:@""]){
    }else{
        self.remainderValue = @"0.00";
    }
    
    
    self.payButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    //    self.payButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.payButton.backgroundColor = kRedColor;
    [self.payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payButton addTarget:self action:@selector(startPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
    
    
    //页面滚动视图
    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.payButton.frame.size.height-64)];
    //    self.pageScroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 500);
    self.pageScroll.showsHorizontalScrollIndicator=NO;
    self.pageScroll.showsVerticalScrollIndicator=NO;
    self.pageScroll.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.pageScroll];
    
    self.memberInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 15)];
    //    self.memberInfoLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.memberInfoLable.text = @"会员卡信息";
    self.memberInfoLable.font = [UIFont systemFontOfSize:12];
    self.memberInfoLable.textColor = fontDilutedGrayColor;
    [self.pageScroll addSubview:self.memberInfoLable];
    
    
    self.memberInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.memberInfoLable.frame.origin.y+self.memberInfoLable.frame.size.height+10, ScreenWidth, 160)];
    //    self.memberInfoLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.memberInfoView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.memberInfoView];
    
    
    self.nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    //    self.nameView.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameView.backgroundColor = [UIColor whiteColor];
    [self.memberInfoView addSubview:self.nameView];
    
    self.lineView01 = [[UIView alloc] initWithFrame:CGRectMake(15, self.nameView.frame.origin.y+self.nameView.frame.size.height+0, ScreenWidth, 0.5)];
    //    self.lineView01.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView01.backgroundColor = lineGrayColor;
    [self.memberInfoView addSubview:self.lineView01];
    
    self.phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView01.frame.origin.y+self.lineView01.frame.size.height+0, ScreenWidth, 40)];
    //    self.phoneView.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.phoneView];
    
    self.lineView02 = [[UIView alloc] initWithFrame:CGRectMake(15, self.phoneView.frame.origin.y+self.phoneView.frame.size.height+0, ScreenWidth, 0.5)];
    self.lineView02.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView02.backgroundColor = lineGrayColor;
    [self.memberInfoView addSubview:self.lineView02];
    
    self.remainderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView02.frame.origin.y+self.lineView02.frame.size.height+0, ScreenWidth, 40)];
    //    self.remainderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.remainderView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.remainderView];
    
    self.lineView03 = [[UIView alloc] initWithFrame:CGRectMake(15, self.remainderView.frame.origin.y+self.remainderView.frame.size.height+0, ScreenWidth, 0.5)];
    //    self.lineView03.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView03.backgroundColor = lineGrayColor;
    [self.memberInfoView addSubview:self.lineView03];
    
    self.moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView03.frame.origin.y+self.lineView03.frame.size.height+0, ScreenWidth, 40)];
    //    self.moneyView.translatesAutoresizingMaskIntoConstraints = NO;
    self.moneyView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.moneyView];
    
    self.payWayLable = [[UILabel alloc] initWithFrame:CGRectMake(15, self.memberInfoView.frame.origin.y+self.memberInfoView.frame.size.height+20, ScreenWidth, 15)];
    //    self.payWayLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.payWayLable.text = @"支付方式";
    self.payWayLable.font = [UIFont systemFontOfSize:12];
    self.payWayLable.textColor = fontDilutedGrayColor;
    [self.pageScroll addSubview:self.payWayLable];
    
    self.payWayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.payWayLable.frame.origin.y+self.payWayLable.frame.size.height+10, ScreenWidth, 180)];
    self.payWayTableView.delegate = self;
    self.payWayTableView.dataSource = self;
    self.payWayTableView.allowsMultipleSelectionDuringEditing = YES;
    self.payWayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.payWayTableView.backgroundColor = dilutedGrayColor;
    [self.pageScroll addSubview:self.payWayTableView];
    
    self.agreeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.payWayTableView.frame.origin.y+self.payWayTableView.frame.size.height+10, ScreenWidth, 30)];
    //    self.agreeView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.agreeView.backgroundColor =  [UIColor whiteColor];
    [self.pageScroll addSubview:self.agreeView];
    
    //控件内部布局
    //姓名
    self.nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.nameView.frame.size.height)];
    self.nameLabe.text = @"真实姓名";
    self.nameLabe.font = [UIFont systemFontOfSize:14];
    self.nameLabe.textColor = fontGrayColor;
    [self.nameView addSubview:self.nameLabe];
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.nameView.frame.size.height)];
    self.nameText.delegate = self;
    self.nameText.placeholder = @"持卡人真实姓名";
    self.nameText.font = [UIFont systemFontOfSize:14];
    self.nameText.textColor = fontGrayColor;
    self.nameText.returnKeyType=UIReturnKeyNext;
    [self.nameView addSubview:self.nameText];
    
    //手机号
    self.phoneLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.phoneView.frame.size.height)];
    self.phoneLabe.text = @"手机号";
    self.phoneLabe.font = [UIFont systemFontOfSize:14];
    self.phoneLabe.textColor = fontGrayColor;
    [self.phoneView addSubview:self.phoneLabe];
    
    self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.phoneView.frame.size.height)];
    self.phoneText.delegate = self;
    self.phoneText.placeholder = @"请输入手机号";
    self.phoneText.font = [UIFont systemFontOfSize:14];
    self.phoneText.textColor = fontGrayColor;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.returnKeyType=UIReturnKeyNext;
    [self.phoneView addSubview:self.phoneText];
    
    //会员余额
    self.remainderLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.remainderView.frame.size.height)];
    self.remainderLabe.text = @"会员余额";
    self.remainderLabe.font = [UIFont systemFontOfSize:14];
    self.remainderLabe.textColor = fontGrayColor;
    [self.remainderView addSubview:self.remainderLabe];
    
    self.remainderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.remainderView.frame.size.height)];
    
    self.remainderContentLabel.text = self.remainderValue;
    
    self.remainderContentLabel.font = [UIFont systemFontOfSize:14];
    self.remainderContentLabel.textColor = fontGrayColor;
    [self.remainderView addSubview:self.remainderContentLabel];
    
    //充值金额
    self.moneyLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.moneyView.frame.size.height)];
    self.moneyLabe.text = @"充值金额";
    self.moneyLabe.font = [UIFont systemFontOfSize:14];
    self.moneyLabe.textColor = fontGrayColor;
    [self.moneyView addSubview:self.moneyLabe];
    
    self.moneyText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.moneyView.frame.size.height)];
    //     self.moneyText.delegate = self;
    //    self.moneyText.placeholder = @"请输入金额";
    self.moneyText.font = [UIFont systemFontOfSize:14];
    self.moneyText.textColor = fontGrayColor;
    //    self.moneyText.keyboardType = UIKeyboardTypeNumberPad;
    //    self.moneyText.returnKeyType=UIReturnKeyDone;
    [self.moneyView addSubview:self.moneyText];
    
    //同意条款
    self.agreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 15, self.agreeView.frame.size.height)];
    self.agreeImageView.image = [UIImage imageNamed:@"ico_member_unselect"];
    self.agreeImageView.contentMode = UIViewContentModeScaleAspectFit;
    //     self.agreeImageView.userInteractionEnabled = YES;
    [self.agreeView addSubview:self.agreeImageView];
    //    UITapGestureRecognizer *agreeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateAgreeState:)];
    //    [self.agreeImageView addGestureRecognizer:agreeTapGesture];
    
    self.agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.agreeView.frame.size.height)];
    self.agreeButton.tag = 198801;
    [self.agreeButton addTarget:self action:@selector(updateAgreeState:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeView addSubview:self.agreeButton];
    
    
    self.agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.agreeImageView.frame.origin.x+self.agreeImageView.frame.size.width+5, 0, 60, self.agreeView.frame.size.height)];
    self.agreeLabel.text = @"阅读并同意";
    self.agreeLabel.font = [UIFont systemFontOfSize:12];
    [self.agreeView addSubview:self.agreeLabel];
    
    self.clauseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.agreeLabel.frame.origin.x+self.agreeLabel.frame.size.width+5, 0, 120, self.agreeView.frame.size.height)];
    [self.clauseButton setTitle:@"《世纪生活会员协议》" forState:UIControlStateNormal];
    [self.clauseButton setTitleColor:kRedColor forState:UIControlStateNormal];
    self.clauseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    //    self.agreeButton.backgroundColor = TEST_COLOR;
    [self.agreeView addSubview:self.clauseButton];
    
    [self initPayWayData];//加入支付方式数据
    
    //支付回调
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(payAlipaySuccessBack)
     name:@"payAlipaySuccessBack"
     object:nil];
    
    //微信支付完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
    
    
}

//加入测试数据
-(void)initPayWayData{
    //测试数据
    self.payWayArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *payWayDictionary = nil;
    
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_wechat" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"微信支付" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"推荐安装微信版本5.0以上版本使用" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"2" forKey:@"payWayState"];
    [payWayDictionary setValue:@"wxpay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_alipay" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"支付宝" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"配送人员上门现金支付" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
    [payWayDictionary setValue:@"Alipay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_unionpay" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"银联支付" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"立即开通，专享优惠" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
    [payWayDictionary setValue:@"unionpay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    [self.payWayTableView reloadData];
    [self.payWayTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];//默认选中第一行
    
    [self loadMemberInfo];//加载会员支付信息
    
}

-(void)updateAgreeState: (UIButton *)myButton{
    NSLog(@"点击了同意按钮!!!")
    
    if (myButton.tag==198801) {
        myButton.tag=198802;
        self.agreeImageView.image = [UIImage imageNamed:@"ico_member_select"];
    }else{
        myButton.tag=198801;
        self.agreeImageView.image = [UIImage imageNamed:@"ico_member_unselect"];
    }
    
}

//加载会员支付信息
-(void) loadMemberInfo{
    [super showGif];
    [commonModel requestproductview:@"6917" httpRequestSucceed:@selector(loadMemberInfoSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

//加载会员支付信息成功
- (void)loadMemberInfoSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"加载会员支付信息dic%@！！！！！！",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    //    NSString *msg = nil;
    if ([code integerValue]==200) {
        
        self.rechargeMoney = [completeDic[@"result"][@"product"][@"price"] floatValue];
        
        NSString *price = [NSString stringWithFormat:@"%.2f", self.rechargeMoney];
        self.moneyText.text = price;
        
    }else{
        NSLog(@"会员信息添加失败！!!!");
        self.moneyText.text = @"0.0";
    }
    
}


#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payWayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"MemberWayCell";
    
    MemberWayCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[MemberWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.payWayArray[indexPath.row]];
    if (indexPath.row==self.payWayArray.count-1) {
        [cell updateShow];//隐藏分割线
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择商品%@!!!!!!!!",indexPath);
    //    self.payWayID = indexPath.row;
    
    for (int i=0; i<self.payWayArray.count;i++) {
        if(![self.payWayArray[i][@"payWayState"] isEqual:@"0"]){
            if (i==indexPath.row) {
                self.payWayArray[i][@"payWayState"]=@"2";
            }else{
                self.payWayArray[i][@"payWayState"]=@"1";
            }
            
        }
    }
    
    
    [self.payWayTableView reloadData];
    
    [self.payWayTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
}


//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark 支付逻辑**************
-(void)startPay{
    //    if (self.payWayID) {
    
    //测试
    //    self.nameText.text = @"测试";
    //    self.phoneText.text = @"15888888888";
    
  
    MBProgressHUD *myProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    myProgress.mode = MBProgressHUDModeText;
    myProgress.margin = 10.f;
    myProgress.yOffset = 150.f;
    myProgress.removeFromSuperViewOnHide = YES;
 
    
    if(self.agreeButton.tag == 198802){
        
        if(self.nameText.text!=nil&&![self.nameText.text isEqualToString:@""]){
            if(self.phoneText.text!=nil&&![self.phoneText.text isEqualToString:@""]){
                
                
                self.rechargeMoney = [self.moneyText.text floatValue];
                [super showGif];
                
                NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
                NSString *payWay =  self.payWayArray[payWayID][@"payID"];
                
                NSLog(@"支付方式为dic%@！！！！！！",payWay);
                
                [commonModel  getRechargeMember:self.nameText.text phone:self.phoneText.text payWay:payWay httpRequestSucceed:@selector(getRechargeMemberSuccess:) httpRequestFailed:@selector(requestFailed:)];
                
                
            }else{
                myProgress.labelText = @"请填写手机号！";
                [myProgress hide:YES afterDelay:1];
            }
        }else{
            myProgress.labelText = @"请填写姓名！";
            [myProgress hide:YES afterDelay:1];
        }
    }else{
        myProgress.detailsLabelText = @"请同意协议后支付！";
        //是否有庶罩
        myProgress.dimBackground = YES;
        [myProgress hide:YES afterDelay:1];
    }
    
}

//提交订单成功
- (void)getRechargeMemberSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"提交订单成功dic%@！！！！！！",dic);
    NSString *code = [dic objectForKey:@"code"];
    //    NSString *msg = nil;
    if ([code integerValue]==200) {
        
        NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
        NSString *payWay =  self.payWayArray[payWayID][@"payID"];
        
        
        NSDictionary *dataDictionary = dic[@"result"][@"data"];
        NSArray *orderArray = dataDictionary[@"orders"];
        NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
        NSLog(@"支付方式为dic%@！！！！！！",payWay);
        
        if ([payWay isEqual:@"member"]) {
            
            
            
        }else  if ([payWay isEqual:@"wxpay"]) {
            [self payOrderByWX:dic];
        }else  if ([payWay isEqual:@"Alipay"]) {
            [self payOrderByAlipay:dic];
        }else  if ([payWay isEqual:@"cod"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"下单成功！";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            [self toReturn];
        }else  if ([payWay isEqual:@"unionpay"]){
            
            //调用下单接口
            //        [commonModel getUPNumber:orderDictionary[@"order_num"] total:[NSString stringWithFormat:@"%.0f",(self.orderCount+self.commodityTransportationExpenses-self.preferentialMoney)*100] desc:@"世纪生活商品消费" httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
            
            NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
            myDictionary[@"order_num"] = orderDictionary[@"order_num"];
            myDictionary[@"order_desc"] = @"充值会员卡";
            
            [commonModel getUnionpay:orderDictionary[@"order_num"]  desc:@"世纪生活商品消费" httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestFailed:)];
            
            //         [commonModel getUnionpay:myDictionary httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
            
        }
        
    }
    
}



//- (void)AddtoCartSuccess:(ASIHTTPRequest *)request{
//    [super hideGif];
//    NSDictionary *completeDic = [super parseJsonRequest:request];
//    NSLog(@"添加购物车成功dic%@！！！！！！",completeDic);
//    NSString *code = [completeDic objectForKey:@"code"];
////    NSString *msg = nil;
//    if ([code integerValue]==200) {
//
//             NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
//        NSString *payWay =  self.payWayArray[payWayID][@"payID"];
//
//        NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//        myDictionary[@"address_id"] = @"6836";
//        myDictionary[@"payment_cod"] = payWay;
//
//        NSLog(@"提交订单的参数为：%@!!!!!!!!!!!!!!",myDictionary);
//        //调用下单接口
//        [commonModel postSubmitOrder:myDictionary httpRequestSucceed:@selector(requestSubmitOrderSuccess:) httpRequestFailed:@selector(requestFailed:)];
//
//
//    }else{
//        NSLog(@"会员信息添加失败！!!!");
//    }
//
//}

//提交购物订单接口成功
- (void)requestSubmitOrderSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"提交订单接口：%@!!!!!!!!!!!",dic );
    
    NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
    NSString *payWay =  self.payWayArray[payWayID][@"payID"];
    
    NSLog(@"所选支付方式：%@!!!!!!!!!!!",payWay );
    
    NSDictionary *dataDictionary = dic[@"result"][@"data"];
    NSArray *orderArray = dataDictionary[@"orders"];
    NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
    
    
    if ([payWay isEqual:@"member"]) {
        
        
        
    }else  if ([payWay isEqual:@"wxpay"]) {
        [self payOrderByWX:dic];
    }else  if ([payWay isEqual:@"Alipay"]) {
        [self payOrderByAlipay:dic];
    }else  if ([payWay isEqual:@"cod"]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"下单成功！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        [self toReturn];
    }else  if ([payWay isEqual:@"unionpay"]){
        
        //调用下单接口
        //        [commonModel getUPNumber:orderDictionary[@"order_num"] total:[NSString stringWithFormat:@"%.0f",(self.orderCount+self.commodityTransportationExpenses-self.preferentialMoney)*100] desc:@"世纪生活商品消费" httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
        
        NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
        myDictionary[@"order_num"] = orderDictionary[@"order_num"];
        myDictionary[@"order_desc"] = @"世纪生活商品消费";
        
        [commonModel getUnionpay:orderDictionary[@"order_num"]  desc:@"世纪生活商品消费" httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
        //         [commonModel getUnionpay:myDictionary httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
        
    }
}

//获取银联流水接口成功
- (void)requestGetUPNumberSuccess:(ASIHTTPRequest *)request{
    NSLog(@"银联返回接口：%@!!!!!!!!!!!",[request responseString] );
    
    //    NSString *string =[request responseString];
    //    NSRange range = [string rangeOfString:@"{"];//匹配得到的下标
    //    NSLog(@"rang:%lu",(unsigned long)range.location);
    //    string = [string substringFromIndex:range.location];//截取范围类的字符串
    //    NSLog(@"截取的值为：%@！！！！",string);
    //
    //    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"获取银联流水接口：%@!!!!!!!!!!!",dic );
    
    //     NSString *tn = dic[@"validResp"][@"tn"];
    NSString *tn = dic[@"tn"];
    [self payOrderByUP:tn];
    
}


//跳转到支付宝支付
- (void)payOrderByAlipay:(NSDictionary *)myDictionary{
    [super hideGif];
    NSDictionary *dataDictionary = myDictionary[@"result"][@"data"];
    NSArray *orderArray = dataDictionary[@"orders"];
    NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
    
    
    Order *myOrder = [[Order alloc] init];
    myOrder.tradeNO = orderDictionary[@"order_num"];  // [self generateTradeNO]; //订单ID（由商家自行制定）
    myOrder.productName = dataDictionary[@"order_name"];  //商品标题
    myOrder.productDescription =
    @"订单支付";  // DesignerData[@"orderName"]; //商品描述
    myOrder.amount = [NSString stringWithFormat:@"%f",self.rechargeMoney];  //商品价格
    myOrder.notifyURL = @"http://www.sjsh8.cn/Notify_message_alipay_mobile.php";  //回调URL
    
    OrderUnit *oUnit = [[OrderUnit alloc] init];
    [oUnit payOrder:myOrder];
}






//跳转到银联支付
- (void)payOrderByUP:(NSString *)tn{
    [super hideGif];
    NSLog(@"交易流水信息tn=%@",tn);
    //生产环境
    NSString *tnMode=nil;
    tnMode = @"00";//正式版本
    //    tnMode = @"01";//测试版本
    
    [UPPayPlugin startPay:tn mode:tnMode viewController:self delegate:self];
    
}

//跳转到微信支付
- (void)payOrderByWX:(NSDictionary *)myDictionary{
    
    NSLog(@"所选支付方式为微信!!!!!!!!");
    
    NSDictionary *dataDictionary = myDictionary[@"result"][@"data"];
    NSArray *orderArray = dataDictionary[@"orders"];
    NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
    
    //    NSMutableDictionary *payDictionary = [[NSMutableDictionary alloc] init];
    //    payDictionary[@"order_no"] =  orderDictionary[@"order_num"];
    //     payDictionary[@"product_name"] =  dataDictionary[@"order_name"];
    //    payDictionary[@"order_price"] =  [NSString stringWithFormat:@"%.2f",self.orderCount+self.commodityTransportationExpenses-self.preferentialMoney];
    //
    //
    //    WXPayUtil *oUnit = [[WXPayUtil alloc] init];
    //    [oUnit payOrderByWX:payDictionary];
    //
    //    WXProduct *product = [[WXProduct alloc] init];
    ////    product.traceId = [[coms objectAtIndex:0] stringByReplacingOccurrencesOfString:@"traceId=" withString:@""];
    //    product.outTradNo = orderDictionary[@"order_num"];  // [self generateTradeNO]; //订单ID（由商家自行制定）
    //
    //    product.total_fee = self.orderCount+self.commodityTransportationExpenses-self.preferentialMoney;
    ////    product.body = [[coms objectAtIndex:3] stringByReplacingOccurrencesOfString:@"body=" withString:@""];
    ////    product.returnUrl = [[coms objectAtIndex:4] stringByReplacingOccurrencesOfString:@"return=" withString:@""];
    //    [self pay:product];
    
    NSMutableDictionary *weChatPayDictionary = [[NSMutableDictionary alloc]init];
    weChatPayDictionary[@"body"] = dataDictionary[@"order_name"];
    weChatPayDictionary[@"out_trade_no"] = orderDictionary[@"order_num"];
    weChatPayDictionary[@"total_fee"] = [NSString stringWithFormat:@"%.0f",self.rechargeMoney*100];
    
    NSLog(@"参数为%@！！！！！！！！",weChatPayDictionary);
    
    //老方法（app签名）
    WXProduct *product = [[WXProduct alloc] init];
    product.traceId = orderDictionary[@"order_num"];
    product.outTradNo = orderDictionary[@"order_num"];
    product.total_fee = self.rechargeMoney*100;//总价
    product.body = dataDictionary[@"order_name"];
    product.returnUrl = @"http://www.sjsh8.cn/index.php?route=mobile/order/orderpay";
    [self pay:product];
    
    //新方法，后台获取预支付订单
    //调用下单接口
    //    [commonModel postWeChatPay:weChatPayDictionary httpRequestSucceed:@selector(requestPostWeChatPaySuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
    
}

- (void)requestPostWeChatPaySuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"获取微信预支付订单接口：%@!!!!!!!!!!!",dic );
    
    if([dic[@"status"] isEqualToString:@"true"]&&[dic[@"order"][@"return_msg"] isEqualToString:@"OK"]){
        NSLog(@"获取微信预支付订单接口成功!!!!!!!!!!!");
        
        NSDictionary *dict = dic[@"order"];
        time_t now;
        time(&now);
        NSString *time_stamp  = [NSString stringWithFormat:@"%ld", now];
        
        //调起微信支付
        PayReq* req             = [[[PayReq alloc] init]autorelease];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"mch_id"];
        req.prepayId            = [dict objectForKey:@"prepay_id"];
        req.nonceStr            = [dict objectForKey:@"nonce_str"];
        req.timeStamp           = time_stamp.intValue;
        req.package             = @"Sign=WXPay";
        req.sign                = [dict objectForKey:@"sign"];
        [WXApi sendReq:req];
        //日志输出
        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        
    }else{
        
        NSLog(@"获取微信预支付订单接口失败!!!!!!!!!!!");
    }
    
}

- (void)pay:(WXProduct *)product
{
    [self getAccessToken:product];//获取access_token
}

#pragma mark - 主体流程
// 获取token
- (void)getAccessToken:(WXProduct *)product
{
    NSString *tokenUrl = @"cgi-bin/token";
    NSDictionary *param = @{@"grant_type":@"client_credential", @"appid":kWXAPP_ID, @"secret":kWXAPP_SECRET};
    [CommonModel doGetWithUrl:BASE_URL
                         path:tokenUrl
                       params:param
                     callback:^(BOOL isSuccessed, NSDictionary *result){
                         
                         NSString *accessToken = result[@"AccessTokenKey"];
                         [self getPrepayId:accessToken product:product];
                     }];
}

// 生成预支付订单
- (void)getPrepayId:(NSString *)accessToken product:(WXProduct *)product
{
    NSString *prepayIdUrl = [NSString stringWithFormat:@"pay/genprepay?access_token=%@", accessToken];
    
    // 拼接详细的订单数据
    NSDictionary *postDict = [self getProductArgsWithproduct:product];
    
    [CommonModel doPostWithUrl:BASE_URL
                          path:prepayIdUrl
                        params:postDict
                      callback:^(BOOL isSuccessed, NSDictionary *result){
                          
                          NSString *prePayId = result[@"prepayid"];
                          
                          // 获取预支付订单id，调用微信支付sdk
                          if (prePayId)
                          {
                              NSLog(@"--- PrePayId: %@", prePayId);
                              self.WXPayProduct = product;
                              // 调起微信支付
                              PayReq *request   = [[PayReq alloc] init];
                              request.partnerId = WXPartnerId;
                              request.prepayId  = prePayId;
                              request.package   = @"Sign=WXPay";
                              request.nonceStr  = self.nonceStr;
                              request.timeStamp = [self.timeStamp intValue];
                              
                              // 构造参数列表
                              NSMutableDictionary *params = [NSMutableDictionary dictionary];
                              [params setObject:kWXAPP_ID forKey:@"appid"];
                              [params setObject:WXAPPKey forKey:@"appkey"];
                              [params setObject:request.nonceStr forKey:@"noncestr"];
                              [params setObject:request.package forKey:@"package"];
                              [params setObject:request.partnerId forKey:@"partnerid"];
                              [params setObject:request.prepayId forKey:@"prepayid"];
                              [params setObject:self.timeStamp forKey:@"timestamp"];
                              request.sign = [self genSign:params];
                              
                              // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
                              [WXApi sendReq:request];//发送一个安全请求
                          }
                      }];
}

#pragma mark - 生成各种参数
// 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 *  获取32位内的随机串, 防重发
 *
 *  注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [NSString md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}


// 订单详情
- (NSString *)genPackageWithproduct:(WXProduct *)product
{
    // 构造订单参数列表
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"WX" forKey:@"bank_type"];
    [params setObject:product.body forKey:@"body"];
    [params setObject:@"1" forKey:@"fee_type"];
    [params setObject:@"UTF-8" forKey:@"input_charset"];
    [params setObject:@"http://weixin.qq.com" forKey:@"notify_url"];
    [params setObject:product.outTradNo forKey:@"out_trade_no"];
    [params setObject:WXPartnerId forKey:@"partner"];
    [params setObject:[NSString getIPAddress:YES] forKey:@"spbill_create_ip"];
    [params setObject:[NSString stringWithFormat:@"%d",product.total_fee] forKey:@"total_fee"];    // 1 =＝ ¥0.01
    
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成 packageSign
    NSMutableString *package = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [package appendString:key];
        [package appendString:@"="];
        [package appendString:[params objectForKey:key]];
        [package appendString:@"&"];
    }
    
    [package appendString:@"key="];
    [package appendString:WXPartnerKey]; // 注意:不能hardcode在客户端,建议genPackage这个过程都由服务器端完成
    
    // 进行md5摘要前,params内容为原始内容,未经过url encode处理
    NSString *packageSign = [[NSString md5:[package copy]] uppercaseString];
    package = nil;
    
    // 生成 packageParamsString
    NSString *value = nil;
    package = [NSMutableString string];
    for (NSString *key in sortedKeys)
    {
        [package appendString:key];
        [package appendString:@"="];
        value = [params objectForKey:key];
        
        // 对所有键值对中的 value 进行 urlencode 转码
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)value, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
        
        [package appendString:value];
        [package appendString:@"&"];
    }
    NSString *packageParamsString = [package substringWithRange:NSMakeRange(0, package.length - 1)];
    
    NSString *result = [NSString stringWithFormat:@"%@&sign=%@", packageParamsString, packageSign];
    
    NSLog(@"--- Package: %@", result);
    
    return result;
}

// 签名
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    NSString *result = [NSString sha1:signString];
    NSLog(@"--- Gen sign: %@", result);
    return result;
}

// 构造订单参数列表
- (NSDictionary *)getProductArgsWithproduct:(WXProduct *)product
{
    self.timeStamp = [self genTimeStamp];   // 获取时间戳
    self.nonceStr = [self genNonceStr];     // 获取32位内的随机串, 防重发
    self.traceId = product.traceId;       // 获取商家对用户的唯一标识
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kWXAPP_ID forKey:@"appid"];
    [params setObject:WXAPPKey forKey:@"appkey"];
    [params setObject:self.nonceStr forKey:@"noncestr"];
    [params setObject:self.timeStamp forKey:@"timestamp"];
    [params setObject:self.traceId forKey:@"traceid"];
    [params setObject:[self genPackageWithproduct:product] forKey:@"package"];
    [params setObject:[self genSign:params] forKey:@"app_signature"];
    [params setObject:@"sha1" forKey:@"sign_method"];
    
    return params;
}

//  支付成功后的回调
- (void)payAlipaySuccessBack {
    NSLog(@"支付成功！！！！！！！");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"订单支付成功！";
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    [self toReturn];//返回上一页
}

#pragma mark UPPayPluginResult 银联代理方法，支付完成的回调
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:@"银联支付结果：%@", result];
    NSLog(@"%@!!!!!!!!",msg);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

#pragma mark - 微信支付结果
- (void)getOrderPayResult:(NSNotification *)notification
{
    
    [super hideGif];
    
    if ([[notification.object objectForKey:@"result"] isEqualToString:@"success"])
    {
        NSLog(@"微信success: 支付成功！！！！！！！");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付成功"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"微信fail: 支付失败！！！！！！");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
    //    [self roadWXPayResultWithCode:[notification.object objectForKey:@"code"]];
    self.WXPayProduct = nil;
}



#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [currentTextField resignFirstResponder];
    return YES;
}

@end
