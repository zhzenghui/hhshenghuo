//
//  MyOrderDetailViewController.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "PublishViewController.h"
#import "AppraiseViewController.h"
#import "AddOrderViewController.h"


@interface MyOrderDetailViewController ()
@property (nonatomic, assign) BOOL haveCode;


@property(nonatomic,strong)UIScrollView *pageScroll;  //页面滚动视图


@property(nonatomic,strong)UIView *infoView;  //订单信息区域
@property(nonatomic,strong)UILabel *orderStateLabel;//订单状态
@property(nonatomic,strong)UILabel *orderNumberLabel;//订单号
@property(nonatomic,strong)UILabel *orderDateLabel;//下单时间


@property(nonatomic,strong)UIView *locationView;  //地址信息区域
//@property(nonatomic,strong)UIView *locationBackage;  //订单背景
@property(nonatomic,strong)UIImageView *nameIco;//姓名图标
@property(nonatomic,strong)UILabel *nameLabel;//姓名
@property(nonatomic,strong)UIImageView *mobileIco;//手机图标
@property(nonatomic,strong)UILabel *mobileLabel;//手机
@property(nonatomic,strong)UILabel *addressLabel;//地址


//@property(nonatomic,strong)UITableView *listTableView;//商品列表
@property(nonatomic,strong)UIView *commodityView;  //商品区域
@property(nonatomic,strong)UILabel *businessNameLabel;//商家名称
@property(nonatomic,strong)UILabel *businessNumberLabel;//所购商家商品数量
@property(nonatomic,strong)UIView *commodityLine;//商品分割线
@property(nonatomic,strong)UIView *commodityList;  //商品区域
//@property(nonatomic,strong)UIImageView *commodityImageView;//订单图片
//@property(nonatomic,strong)UILabel *commodityNameLabel;//商品名称
//@property(nonatomic,strong)UILabel *commodityPriceLabel;//价钱
//@property(nonatomic,strong)UILabel *commodityNumberLabel;//数量


@property(nonatomic,strong)UIView *wayView;  //方式区域
@property(nonatomic,strong)UIView *payIco;//支付方式图标
@property(nonatomic,strong)UILabel *payLabel;//支付方式
@property(nonatomic,strong)UIView *deliverIco;//送货图标
@property(nonatomic,strong)UILabel *deliverLabel;//送货
@property(nonatomic,strong)UILabel *deliverInfoLabel;//送货说明

@property(nonatomic,strong)UIView *remarksView;  //备注区域
@property(nonatomic,strong)UILabel *remarksLabel;//备注内容


@property(nonatomic,strong)UIView *moneyView;  //价钱区域
@property(nonatomic,strong)UILabel *sumLabel;//总额
@property(nonatomic,strong)UILabel *carriageLabel;//运费
//@property(nonatomic,strong)UILabel *integralLabel;//积分
@property(nonatomic,strong)UILabel *couponLabel;//优惠券
@property(nonatomic,strong)UILabel *sumNumberLabel;//总额
@property(nonatomic,strong)UILabel *carriageNumberLabel;//运费
//@property(nonatomic,strong)UILabel *integralNumberLabel;//积分
@property(nonatomic,strong)UILabel *couponNumberLabel;//优惠券
@property(nonatomic,strong)UIView *moneyLineView;  //分割线
@property(nonatomic,strong)UILabel *disbursementsLabel;//最终支付
//@property(nonatomic,strong)UILabel *disbursementsNumberLabel;//最终支付

@property(nonatomic,strong)UIView *buttonView;  //按钮区域
@property(nonatomic,strong)UIButton *button01;
@property(nonatomic,strong)UIButton *button02;
@property(nonatomic,strong)UIButton *button03;
@property(nonatomic,strong)UIButton *button04;



@end

@implementation MyOrderDetailViewController

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
    self.navigationController.navigationBar.alpha = 1;
    [super initNavBarItems:@"订单详情"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;
    self.haveCode = NO;
    
    
    //页面滚动视图
    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.pageScroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 900);
    self.pageScroll.showsHorizontalScrollIndicator=NO;
    self.pageScroll.showsVerticalScrollIndicator=NO;
    self.pageScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pageScroll];
    
    
    //订单信息区域
    self.infoView = [[UIView alloc]init];
    self.infoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.infoView];
    
    self.orderStateLabel = [[UILabel alloc]init];
    self.orderStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //     self.orderStateLabel.text=@"暂无";
    [self.orderStateLabel setTextColor:kRedColor];
    self.orderStateLabel.font = [UIFont systemFontOfSize:20];
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString:@"订单状态：暂无"];
    [orderStateAttributedString addAttribute:NSForegroundColorAttributeName value:fontGrayColor range:NSMakeRange(0,5)];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    self.orderStateLabel.attributedText = orderStateAttributedString;
    [self.infoView addSubview:self.orderStateLabel];
    
    self.orderNumberLabel = [[UILabel alloc]init];
    self.orderNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.orderNumberLabel.text=@"暂无";
    self.orderNumberLabel.font = [UIFont systemFontOfSize:14];
    [self.orderNumberLabel setTextColor:fontGrayColor];
    [self.infoView addSubview:self.orderNumberLabel];
    
    self.orderDateLabel = [[UILabel alloc]init];
    self.orderDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.orderDateLabel.text=@"暂无";
    self.orderDateLabel.font = [UIFont systemFontOfSize:14];
    [self.orderDateLabel setTextColor:fontGrayColor];
    [self.infoView addSubview:self.orderDateLabel];
    
    
    
    //地址信息区域
    self.locationView = [[UIView alloc]init];
    self.locationView.translatesAutoresizingMaskIntoConstraints = NO;
    self.locationView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:239.0/255.0 blue:233.0/255.0 alpha:1.0];
    self.locationView.layer.borderWidth = 1.5;
    self.locationView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.locationView.clipsToBounds = YES;
    self.locationView.layer.cornerRadius = 10;
    [self.pageScroll addSubview:self.locationView];
    
    self.nameIco = [[UIImageView alloc]init];
    self.nameIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameIco.image = [UIImage imageNamed:@"ico_order_detail_user"];
    self.nameIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.locationView addSubview:self.nameIco];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.text=@"暂无";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.nameLabel setTextColor:fontGrayColor];
    [self.locationView addSubview:self.nameLabel];
    
    self.mobileIco = [[UIImageView alloc]init];
    self.mobileIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.mobileIco.image = [UIImage imageNamed:@"ico_order_detail_phone"];
    self.mobileIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.locationView addSubview:self.mobileIco];
    
    self.mobileLabel = [[UILabel alloc]init];
    self.mobileLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.mobileLabel.text=@"暂无";
    self.mobileLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.mobileLabel setTextColor:fontGrayColor];
    [self.locationView addSubview:self.mobileLabel];
    
    self.addressLabel = [[UILabel alloc]init];
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressLabel.text=@"暂无";
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    [self.addressLabel setTextColor:fontGrayColor];
    [self.locationView addSubview:self.addressLabel];
    
    //商品区域
    self.commodityView = [[UIView alloc]init];
    self.commodityView.translatesAutoresizingMaskIntoConstraints = NO;
    self.commodityView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.commodityView];
    
    self.businessNameLabel = [[UILabel alloc]init];
    self.businessNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.businessNameLabel.text=@"暂无";
    self.businessNameLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.businessNameLabel setTextColor:fontGrayColor];
    [self.commodityView addSubview:self.businessNameLabel];
    
    self.businessNumberLabel = [[UILabel alloc]init];
    self.businessNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.businessNumberLabel.text=@"暂无";
    self.businessNumberLabel.font = [UIFont systemFontOfSize:12];
    [self.businessNumberLabel setTextColor:fontDilutedGrayColor];
    self.businessNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.commodityView addSubview:self.businessNumberLabel];
    
    self.commodityLine = [[UIView alloc]init];//可变高度的商品列表页
    self.commodityLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.commodityLine.backgroundColor = kRedColor;
    [self.commodityView addSubview:self.commodityLine];
    
    self.commodityList = [[UIView alloc]init];//可变高度的商品列表页
    self.commodityList.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.commodityList.backgroundColor = [UIColor greenColor];
    [self.commodityView addSubview:self.commodityList];
    
    
    //方式区域
    self.wayView = [[UIView alloc]init];
    self.wayView.translatesAutoresizingMaskIntoConstraints = NO;
    self.wayView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.wayView];
    
    self.payIco = [[UIView alloc]init];
    self.payIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.payIco.layer.cornerRadius = 2.5;
    self.payIco.layer.masksToBounds = YES;
    self.payIco.backgroundColor = kRedColor;
    [self.wayView addSubview:self.payIco];
    
    self.payLabel = [[UILabel alloc]init];
    self.payLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.payLabel.text=@"暂无";
    self.payLabel.font = [UIFont systemFontOfSize:14];
    [self.payLabel setTextColor:fontGrayColor];
    [self.wayView addSubview:self.payLabel];
    
    self.deliverIco = [[UIView alloc]init];
    self.deliverIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.deliverIco.layer.cornerRadius = 2.5;
    self.deliverIco.layer.masksToBounds = YES;
    self.deliverIco.backgroundColor = kRedColor;
    [self.wayView addSubview:self.deliverIco];
    
    self.deliverLabel = [[UILabel alloc]init];
    self.deliverLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.deliverLabel.text=@"暂无";
    self.deliverLabel.font = [UIFont systemFontOfSize:14];
    [self.deliverLabel setTextColor:fontGrayColor];
    [self.wayView addSubview:self.deliverLabel];
    
    self.deliverInfoLabel = [[UILabel alloc]init];
    self.deliverInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.deliverInfoLabel.text=@"暂无";
    self.deliverInfoLabel.font = [UIFont systemFontOfSize:14];
    self.deliverInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.deliverInfoLabel.numberOfLines = 0;//上面两行设置多行显示
    [self.deliverInfoLabel setTextColor:fontDilutedGrayColor];
    [self.wayView addSubview:self.deliverInfoLabel];
    
    //备注区域
    self.remarksView = [[UIView alloc]init];
    self.remarksView.translatesAutoresizingMaskIntoConstraints = NO;
    self.remarksView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.remarksView];
    
    self.remarksLabel = [[UILabel alloc]init];
    self.remarksLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.remarksLabel.text=@"备注：无";
    self.remarksLabel.font = [UIFont systemFontOfSize:14];
    self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarksLabel.numberOfLines = 0;//上面两行设置多行显示
    [self.remarksLabel setTextColor:fontGrayColor];
    [self.remarksView addSubview:self.remarksLabel];
    
    
    //价钱区域
    self.moneyView = [[UIView alloc]init];
    self.moneyView.translatesAutoresizingMaskIntoConstraints = NO;
    self.moneyView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.moneyView];
    
    self.sumLabel = [[UILabel alloc]init];
    self.sumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sumLabel.text=@"商品总价";
    self.sumLabel.font = [UIFont systemFontOfSize:14];
    [self.sumLabel setTextColor:fontGrayColor];
    [self.moneyView addSubview:self.sumLabel];
    
    self.carriageLabel = [[UILabel alloc]init];
    self.carriageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.carriageLabel.text=@"运费";
    self.carriageLabel.font = [UIFont systemFontOfSize:14];
    [self.carriageLabel setTextColor:fontGrayColor];
    [self.moneyView addSubview:self.carriageLabel];
    
    //    self.integralLabel = [[UILabel alloc]init];
    //    self.integralLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.integralLabel.text=@"积分抵现";
    //    self.integralLabel.font = [UIFont systemFontOfSize:14];
    //    [self.integralLabel setTextColor:fontGrayColor];
    //    [self.moneyView addSubview:self.integralLabel];
    
    self.couponLabel = [[UILabel alloc]init];
    self.couponLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.couponLabel.text=@"优惠劵抵现";
    self.couponLabel.font = [UIFont systemFontOfSize:14];
    [self.couponLabel setTextColor:[UIColor colorWithRed:83.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1.0]];
    [self.moneyView addSubview:self.couponLabel];
    
    self.sumNumberLabel = [[UILabel alloc]init];
    self.sumNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sumNumberLabel.text=@"暂无";
    [self.sumNumberLabel setTextColor:kRedColor];
    self.sumNumberLabel.font = [UIFont systemFontOfSize:14];
    self.sumNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.moneyView addSubview:self.sumNumberLabel];
    
    self.carriageNumberLabel = [[UILabel alloc]init];
    self.carriageNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.carriageNumberLabel.text=@"暂无";
    [self.carriageNumberLabel setTextColor:kRedColor];
    self.carriageNumberLabel.font = [UIFont systemFontOfSize:14];
    self.carriageNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.moneyView addSubview:self.carriageNumberLabel];
    
    //    self.integralNumberLabel = [[UILabel alloc]init];
    //    self.integralNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.integralNumberLabel.text=@"暂无";
    //     [self.integralNumberLabel setTextColor:kRedColor];
    //    self.integralNumberLabel.font = [UIFont systemFontOfSize:14];
    //    self.integralNumberLabel.textAlignment = NSTextAlignmentRight;
    //    [self.moneyView addSubview:self.integralNumberLabel];
    
    self.couponNumberLabel = [[UILabel alloc]init];
    self.couponNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.couponNumberLabel.text=@"暂无";
    [self.couponNumberLabel setTextColor:kRedColor];
    self.couponNumberLabel.font = [UIFont systemFontOfSize:14];
    self.couponNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.moneyView addSubview:self.couponNumberLabel];
    
    self.moneyLineView = [[UIView alloc]init];
    self.moneyLineView.translatesAutoresizingMaskIntoConstraints = NO;
    self.moneyLineView.backgroundColor = kGrayColor;
    [self.moneyView addSubview:self.moneyLineView];
    
    self.disbursementsLabel = [[UILabel alloc]init];
    self.disbursementsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.disbursementsLabel.textAlignment = NSTextAlignmentRight;
    [self.disbursementsLabel setTextColor:kRedColor];
    self.disbursementsLabel.text=@"0.0";
    NSMutableAttributedString *disbursementsAttributedString = [[NSMutableAttributedString alloc] initWithString:@"实付款：￥0元"];
    [disbursementsAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    //     [disbursementsAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2,2)];
    self.disbursementsLabel.attributedText = disbursementsAttributedString;
    [self.moneyView addSubview:self.disbursementsLabel];
    
    //    self.disbursementsNumberLabel = [[UILabel alloc]init];
    //    self.disbursementsNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.disbursementsNumberLabel.text=@"暂无";
    //    [self.moneyView addSubview:self.disbursementsNumberLabel];
    
    
    
    
    
    //商品列表
    //    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f-50) style:UITableViewStylePlain];
    //    self.listTableView.delegate = self;
    //    self.listTableView.dataSource = self;
    //    //    listTableView.backgroundColor = [UIColor clearColor];
    //    self.listTableView.separatorColor = COLOR(178, 178, 178);
    //    [self.view addSubview:self.listTableView];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    self.buttonView.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.buttonView];
    
    [self initButtonView];//创建底部按钮区域
    
    
    //    self.dataArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    //调用订单详情接口
    [commonModel requestOrderInfo:[NSDictionary dictionaryWithObject:self.orderID forKey:@"order_id"] httpRequestSucceed:@selector(OrderInfoSuccess:) httpRequestFailed:@selector(requestFailed:)];
    [super showGif];
}

//调用订单详情接口成功
- (void)OrderInfoSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"订单详情接口数据dic：%@！！！！！！！！！！！！！！！！！！",completeDic);
    if (completeDic) {
        if ([[completeDic objectForKey:@"code"] integerValue]==200) {
            self.infoDic = [completeDic objectForKey:@"result"];
            self.dataArray = [self.infoDic objectForKey:@"products"];
            NSNumber *vcode = [self.infoDic objectForKey:@"vcode"];
            if ([vcode integerValue]==1) {
                _haveCode = YES;
            }
            //            [self.listTableView reloadData];
            [self updateData];
        }
        else {
            [super showMessageBox:nil title:nil message:[completeDic objectForKey:@"msg"] cancel:@"确定" confirm:nil];
        }
    }
    [self initPageView];//自动布局页面
    
}

//- (void)OrderInfoFail:(ASIHTTPRequest *)request{
//    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
//    NSLog(@"dic%@",dic);
//}

//修改页面显示数据
- (void)updateData{
    
    
    
    //订单信息
    
    //    @property(nonatomic,strong)UILabel *orderNumberLabel;//订单号
    //    @property(nonatomic,strong)UILabel *orderDateLabel;//下单时间
    //
    //    @property(nonatomic,strong)UIView *locationView;  //订单信息区域
    //    //@property(nonatomic,strong)UIView *locationBackage;  //订单背景
    //    @property(nonatomic,strong)UIImage *nameIco;//姓名图标
    //    @property(nonatomic,strong)UILabel *nameLabel;//姓名
    //    @property(nonatomic,strong)UIImage *mobileIco;//手机图标
    //    @property(nonatomic,strong)UILabel *mobileLabel;//手机
    //    @property(nonatomic,strong)UILabel *addressLabel;//地址
    
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@",[self.infoDic objectForKey:@"order_num"]];
    self.orderDateLabel.text = [NSString stringWithFormat:@"订单时间：%@",[self.infoDic objectForKey:@"date_added"]];
    NSString *orderState = [NSString stringWithFormat:@"订单状态：%@",[self.infoDic objectForKey:@"status"]];
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString:orderState];
    [orderStateAttributedString addAttribute:NSForegroundColorAttributeName value:fontGrayColor range:NSMakeRange(0,5)];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    self.orderStateLabel.attributedText = orderStateAttributedString;
    
    //地址信息
    self.nameLabel.text = [self.infoDic objectForKey:@"payment_firstname"];
    self.mobileLabel.text = [self.infoDic objectForKey:@"telephone"];
    self.addressLabel.text = [self.infoDic objectForKey:@"payment_address"];
    self.remarksLabel.text = [NSString stringWithFormat:@"备注：%@",[self.infoDic objectForKey:@"comment"]];
 
    //商品列表的标题
    self.businessNameLabel.text = [self.infoDic objectForKey:@"shop_name"];
    self.businessNumberLabel.text = [NSString stringWithFormat:@"共%lu件商品",(unsigned long)self.dataArray.count];
    
    //支付信息
    self.payLabel.text = [self.infoDic objectForKey:@"payment_method"];
    self.deliverLabel.text = [self.infoDic objectForKey:@"pei_type"];
    self.deliverInfoLabel.text = [self.infoDic objectForKey:@"pei_time"];
    
    
    self.sumNumberLabel.text = [NSString stringWithFormat:@"%.2f",[[self.infoDic objectForKey:@"sub_total"] floatValue]];
    self.carriageNumberLabel.text = [NSString stringWithFormat:@"%.2f",[[self.infoDic objectForKey:@"low_order_fee"] floatValue]];
    //    self.integralNumberLabel.text = [NSString stringWithFormat:@"%.2f",[[self.infoDic objectForKey:@"coupon"] floatValue]];
    self.couponNumberLabel.text = [NSString stringWithFormat:@"%.2f",[[self.infoDic objectForKey:@"coupon"] floatValue]];
    
    //最终付款
    NSString *disbursementsValue =  [NSString stringWithFormat:@"实付款：￥%.2f元",[[self.infoDic objectForKey:@"sub_total"] floatValue]+[[self.infoDic objectForKey:@"low_order_fee"] floatValue]-[[self.infoDic objectForKey:@"coupon"] floatValue]];
    NSMutableAttributedString *disbursementsAttributedString = [[NSMutableAttributedString alloc] initWithString:disbursementsValue];
    [disbursementsAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    //     [disbursementsAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2,2)];
    self.disbursementsLabel.attributedText = disbursementsAttributedString;
    
    //商品信息  dataArray
    
}


-(void)goProductDetail:(UITapGestureRecognizer *)sender{
    
    NSLog(@"点击了第%ld个!!!!!!",(long)(sender.view.tag-19880));
    
}

//初始化页面
- (void) initPageView{
    
    NSUInteger productsCount = self.dataArray.count;//商品的数量
    float productHeight = 70.0;
    
    
    
    NSDictionary *wholeMap = @{ @"pageScroll" : self.pageScroll,
                                @"infoView" : self.infoView,
                                @"locationView" : self.locationView,
                                @"commodityView" : self.commodityView,
                                @"wayView" : self.wayView,
                                @"remarksView" : self.remarksView,
                                @"moneyView" : self.moneyView
                                };
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"H:|-0-[pageScroll]-0-|"
                               options:0
                               metrics:nil
                               views:wholeMap]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"V:|-0-[pageScroll]-0-|"
                               options:0
                               metrics:nil
                               views:wholeMap]];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:|-0-[infoView(==105)]-10-[locationView(==90)]-10-[commodityView]-10-[wayView(==150)]-10-[remarksView(==100)]-10-[moneyView(==200)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[infoView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    NSString *locationViewWidth = [NSString stringWithFormat:@"H:|-10-[locationView(==%f)]",ScreenWidth-20.0];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     locationViewWidth
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[commodityView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[wayView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[remarksView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[moneyView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:wholeMap]];
    
    [self.pageScroll addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.commodityView
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.pageScroll
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0.0
                                    constant:40+productsCount*productHeight]];
    
    NSDictionary *infoMap = @{
                              @"orderStateLabel" : self.orderStateLabel,
                              @"orderNumberLabel" : self.orderNumberLabel,
                              @"orderDateLabel" : self.orderDateLabel
                              };
    [self.infoView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-20-[orderStateLabel(==20)]-7-[orderNumberLabel(==20)]-5-[orderDateLabel(==20)]"
                                   options:0
                                   metrics:nil
                                   views:infoMap]];
    [self.infoView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-15-[orderStateLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:infoMap]];
    [self.infoView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-15-[orderNumberLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:infoMap]];
    [self.infoView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-15-[orderDateLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:infoMap]];
    
    //    NSDictionary *locationMap = @{
    //                              @"nameIco" : self.nameIco,
    //                              @"nameLabel" : self.nameLabel,
    //                              @"mobileIco" : self.mobileIco,
    //                              @"mobileLabel" : self.mobileLabel,
    //                              @"addressLabel" : self.addressLabel
    //                              };
    
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameIco
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1.0
                                      constant:-15]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameIco
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeLeft
                                      multiplier:1.0
                                      constant:15]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameIco
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:0.0
                                      constant:20]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameIco
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0.0
                                      constant:15]];
    
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameLabel
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.nameIco
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1.0
                                      constant:0.0]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameLabel
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.nameIco
                                      attribute:NSLayoutAttributeRight
                                      multiplier:1.0
                                      constant:5]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameLabel
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:0.0
                                      constant:70]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.nameLabel
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0.0
                                      constant:15]];
    
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileIco
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.nameIco
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1.0
                                      constant:0.0]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileIco
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.nameLabel
                                      attribute:NSLayoutAttributeRight
                                      multiplier:1.0
                                      constant:0]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileIco
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:0.0
                                      constant:20]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileIco
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0.0
                                      constant:15]];
    
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileLabel
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.nameIco
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1.0
                                      constant:0.0]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileLabel
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.mobileIco
                                      attribute:NSLayoutAttributeRight
                                      multiplier:1.0
                                      constant:5]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileLabel
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:0.0
                                      constant:150]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.mobileLabel
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0.0
                                      constant:15]];
    
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.addressLabel
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1.0
                                      constant:15.0]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.addressLabel
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeLeft
                                      multiplier:1.0
                                      constant:15]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.addressLabel
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeWidth
                                      multiplier:0.0
                                      constant:300]];
    [self.locationView addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.addressLabel
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.locationView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0.0
                                      constant:15]];
    
    
    NSDictionary *commodityMap = @{
                                   @"businessNameLabel" : self.businessNameLabel,
                                   @"businessNumberLabel" : self.businessNumberLabel,
                                   @"commodityLine" : self.commodityLine,
                                   @"commodityList" : self.commodityList
                                   };
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"H:|-15-[businessNameLabel(==200)]"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"V:|-0-[businessNameLabel(==40)]-0-[commodityLine(==1)]-0-[commodityList]-0-|"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"H:[businessNumberLabel(==150)]-15-|"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"V:|-0-[businessNumberLabel(==40)]"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"H:|-0-[commodityLine]-0-|"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    [self.commodityView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"H:|-0-[commodityList]-0-|"
                                        options:0
                                        metrics:nil
                                        views:commodityMap]];
    
    
    NSDictionary *wayMap = @{
                             @"payIco" : self.payIco,
                             @"payLabel" : self.payLabel,
                             @"deliverIco" : self.deliverIco,
                             @"deliverLabel" : self.deliverLabel,
                             @"deliverInfoLabel" : self.deliverInfoLabel
                             };
    [self.wayView addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:
                                  @"H:|-15-[payIco(==5)]-5-[payLabel]-1-|"
                                  options:0
                                  metrics:nil
                                  views:wayMap]];
    [self.wayView addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:
                                  @"V:|-20-[payLabel(==15)]-10-[deliverLabel(==15)]-20-[deliverInfoLabel]-0-|"
                                  options:0
                                  metrics:nil
                                  views:wayMap]];
    [self.wayView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.payIco
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.payLabel
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                 constant:0.0]];
    [self.wayView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.payIco
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.wayView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:0.0
                                 constant:5.0]];
    [self.wayView addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:
                                  @"H:|-15-[deliverIco(==5)]-5-[deliverLabel]-1-|"
                                  options:0
                                  metrics:nil
                                  views:wayMap]];
    [self.wayView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.deliverIco
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.deliverLabel
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                 constant:0.0]];
    [self.wayView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.deliverIco
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.wayView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:0.0
                                 constant:5.0]];
    [self.wayView addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:
                                  @"H:|-15-[deliverInfoLabel]-15-|"
                                  options:0
                                  metrics:nil
                                  views:wayMap]];
    
    //备注区域
    [self.remarksView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.remarksLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.remarksView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0
                                     constant:15]];
    [self.remarksView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.remarksLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.remarksView
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.0
                                     constant:15]];
    [self.remarksView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.remarksLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.remarksView
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1.0
                                     constant:-30]];
    [self.remarksView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.remarksLabel
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.remarksView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:1.0
                                     constant:-30]];
    
    NSDictionary *moneyMap = @{
                               @"sumLabel" : self.sumLabel,
                               @"carriageLabel" : self.carriageLabel,
                               //                             @"integralLabel" : self.integralLabel,
                               @"couponLabel" : self.couponLabel,
                               @"sumNumberLabel" : self.sumNumberLabel,
                               @"carriageNumberLabel" : self.carriageNumberLabel,
                               //                             @"integralNumberLabel" : self.integralNumberLabel,
                               @"couponNumberLabel" : self.couponNumberLabel,
                               @"moneyLineView" : self.moneyLineView,
                               @"disbursementsLabel" : self.disbursementsLabel
                               };
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-20-[sumLabel(==20)]-5-[carriageLabel(==20)]-5-[couponLabel(==20)]"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-20-[sumNumberLabel(==20)]-5-[carriageNumberLabel(==20)]-5-[couponNumberLabel(==20)]-7-[moneyLineView(==1)]-7-[disbursementsLabel(==15)]"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-15-[sumLabel(==100)]"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-15-[carriageLabel(==100)]"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    //    [self.moneyView addConstraints:[NSLayoutConstraint
    //                                    constraintsWithVisualFormat:
    //                                    @"H:|-15-[integralLabel(==100)]"
    //                                    options:0
    //                                    metrics:nil
    //                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-15-[couponLabel(==100)]"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:[sumNumberLabel(==100)]-15-|"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:[carriageNumberLabel(==100)]-15-|"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    //    [self.moneyView addConstraints:[NSLayoutConstraint
    //                                    constraintsWithVisualFormat:
    //                                    @"H:[integralNumberLabel(==100)]-15-|"
    //                                    options:0
    //                                    metrics:nil
    //                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:[couponNumberLabel(==100)]-15-|"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-0-[moneyLineView]-0-|"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    [self.moneyView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:[disbursementsLabel(==200)]-15-|"
                                    options:0
                                    metrics:nil
                                    views:moneyMap]];
    
    
    //动态创建中间的商品列表
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 800+productsCount*productHeight);
    for (int i=0; i<productsCount; i++) {
        
        NSDictionary *productDictionary =  self.dataArray[i];
        
        UIView *productView = [[UIView alloc]init];
        productView.translatesAutoresizingMaskIntoConstraints = NO;
        productView.tag = 19880+i;
        [self.commodityList addSubview:productView];
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goProductDetail:)];
        [productView addGestureRecognizer:tapGesture];
        
        UIView *productLine = [[UIView alloc]init];
        productLine.translatesAutoresizingMaskIntoConstraints = NO;
        productLine.backgroundColor = lineGrayColor;
        [self.commodityList addSubview:productLine];
        
        
        UIImageView *productImageView = [[UIImageView alloc]init];
        productImageView.translatesAutoresizingMaskIntoConstraints = NO;
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageUrl = [productDictionary objectForKey:@"image"];
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [productImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        [productView addSubview:productImageView];
        
        UILabel *productNameLabel = [[UILabel alloc]init];
        productNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        productNameLabel.text = [productDictionary objectForKey:@"name"];
        productNameLabel.textColor = fontGrayColor;
        productNameLabel.font = [UIFont systemFontOfSize:12];
        //自动折行设置
        productNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        productNameLabel.numberOfLines = 0;
        [productView addSubview:productNameLabel];
        
        UILabel *productPriceLabel = [[UILabel alloc]init];
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        productPriceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)[[productDictionary objectForKey:@"price"] integerValue] ];
        productPriceLabel.textAlignment = NSTextAlignmentRight;
        productPriceLabel.textColor = kRedColor;
        productPriceLabel.font = [UIFont systemFontOfSize:12];
        [productView addSubview:productPriceLabel];
        
        
        UILabel *productNumberLabel = [[UILabel alloc]init];
        productNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        productNumberLabel.text = [NSString stringWithFormat:@"×%ld",(long)[[productDictionary objectForKey:@"quantity"] integerValue] ];
        productNumberLabel.textAlignment = NSTextAlignmentRight;
        productNumberLabel.textColor = fontDilutedGrayColor;
        productNumberLabel.font = [UIFont systemFontOfSize:12];
        [productView addSubview:productNumberLabel];
        
        if (i==0) {
            productLine.hidden = YES;
            
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeTop
                                               multiplier:1
                                               constant:0]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                               constant:0]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeWidth
                                               multiplier:1
                                               constant:0]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeHeight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeHeight
                                               multiplier:0.0
                                               constant:productHeight]];
        }else{
            
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeTop
                                               multiplier:1
                                               constant:i*productHeight]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                               constant:0]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeWidth
                                               multiplier:1
                                               constant:0]];
            [self.commodityList addConstraint:[NSLayoutConstraint
                                               constraintWithItem:productView
                                               attribute:NSLayoutAttributeHeight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.commodityList
                                               attribute:NSLayoutAttributeHeight
                                               multiplier:0.0
                                               constant:productHeight]];
        }
        
        //productView内部布局
        //商品图片
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productImageView
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                    constant:0.0]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productImageView
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:15]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productImageView
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.0
                                    constant:50]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productImageView
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                    constant:0.0]];
        //商品名
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNameLabel
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                    constant:0.0]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNameLabel
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productImageView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:5]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNameLabel
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.0
                                    constant:200]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNameLabel
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                    constant:0.0]];
        //价钱
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productPriceLabel
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                    constant:-7.0]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productPriceLabel
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:-15]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productPriceLabel
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.0
                                    constant:100]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productPriceLabel
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0.0
                                    constant:15.0]];
        //数量
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNumberLabel
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                    constant:7.0]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNumberLabel
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:-15]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNumberLabel
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.0
                                    constant:100]];
        [productView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:productNumberLabel
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:productView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0.0
                                    constant:15.0]];
        
        
        
    }
    
}








//初始化底部按钮区域
- (void) initButtonView{
    
    NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];
    buttonTitleArray[0] = @"删除订单";
    //    buttonTitleArray[1] = @"退货/返修";
    buttonTitleArray[1] = @"评价晒单";
    buttonTitleArray[2] = @"再次购买";
    
    
    for(int i=0;i<buttonTitleArray.count;i++){
        UIButton *myButton = [[UIButton alloc]initWithFrame:CGRectMake(i*(ScreenWidth-2)/buttonTitleArray.count+1*i, 0, (ScreenWidth-2)/buttonTitleArray.count, self.buttonView.frame.size.height)];
        myButton.tag = 198800+i;
        myButton.backgroundColor = [UIColor blackColor];
        myButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [myButton setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [myButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(mybuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==buttonTitleArray.count-1) {
            myButton.backgroundColor = kRedColor;
        }
        [self.buttonView addSubview:myButton];
        
    }
    
    
    
    
}


//底部按钮操作方法
-(void)mybuttonClick:(UIButton *)myButton{
    if (myButton.tag==198800) {//删除订单
        NSLog(@"删除订单！");
        
        NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
        infoDictionary[@"order_id"] = self.orderID;
        [super showGif];
        [commonModel deleteOrderById:infoDictionary httpRequestSucceed:@selector(deleteOrderSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else  if (myButton.tag==198801) {//评价晒单
        AppraiseViewController * appraiseViewController = [[AppraiseViewController alloc] init];
        NSLog(@"评价晒单！");
        
        //为评价页加入冗余数据
        NSMutableArray *myArray = [self.dataArray mutableCopy];
        
        for (int i=0; i<myArray.count; i++) {
            NSMutableDictionary *myDictionary = [myArray[i] mutableCopy];
            NSMutableArray *imageArray = [[NSMutableArray alloc]init];
            [myDictionary setValue:imageArray forKey:@"imageArray"];
            myArray[i] = myDictionary;
        }
        appraiseViewController.orderID = self.orderID;
        appraiseViewController.appraiseArray = myArray;
        [self.navigationController pushViewController:appraiseViewController animated:YES];
        
    }else  if (myButton.tag==198802) {//再次购买
        NSLog(@"再次购买！");
        [commonModel payOrderSecond:self.orderID httpRequestSucceed:@selector(payOrderSecondSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}

//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误！！！！！！%@",request);
}

//删除订单
- (void)deleteOrderSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSLog(@"删除订单接口返回数据：%@！！！！",request);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"删除订单接口返回数据：%@！！！！",dic);
    if ([[dic objectForKey:@"result"] intValue] == 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单删除成功！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        [self toReturn];//返回上一页
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"订单删除失败！" ];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单暂时成功！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}

//订单再次购买成功
- (void)payOrderSecondSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"再次支付列表接口：%@!!!!!!!!!!!",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        AddOrderViewController *myViewController = [[AddOrderViewController alloc] init];
        myViewController.isFirst = YES;
        myViewController.isAll = NO;
        [self.navigationController pushViewController:myViewController animated:YES];
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单再次购买失败！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//返回
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}





@end
