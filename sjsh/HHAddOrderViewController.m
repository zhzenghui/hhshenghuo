//
//  HHAddOrderViewController.m
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHAddOrderViewController.h"
#import "OpenURLViewController.h"
#import "OrderUnit.h"
#import "WXPayUtil.h"
#import "Order.h"
#import "SVProgressHUD.h"
#import "UPPayPlugin.h"
#import "WXApi.h"
#import "NSString+MD5Addition.h"
#import "AddressViewController.h"


#define BASE_URL @"https://api.weixin.qq.com"


//@implementation Product
//
//
//@end
//
//@implementation WXProduct
//
//
//@end

@interface HHAddOrderViewController (){
    
    UITextView *currentTextField;
    
}

//滚动视图
@property(nonatomic,strong)UIScrollView *myScrollView;

//顶部信息提醒视图
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UIImageView *infoImageView;
@property(nonatomic,strong)UILabel *infoLabel;
@property(nonatomic,strong)UIImageView *infoLine;

//地址
@property(nonatomic,strong)UIView *addressView;
@property(nonatomic,strong)UIImageView *userIco;
@property(nonatomic,strong)UILabel *userLabel;
@property(nonatomic,strong)UIImageView *phoneIco;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIImageView *addressArrow;

//商品列表
@property(nonatomic,strong)UITableView *commodityTable;

//优惠劵
//@property(nonatomic,strong)UIView *couponView;
//@property(nonatomic,strong)UILabel *couponTitle;
//@property(nonatomic,strong)UILabel *couponContent;
//@property(nonatomic,strong)UIImageView *couponArrow;

//需支付
@property(nonatomic,strong)UIView *payTitleView;
@property(nonatomic,strong)UILabel *payTitleLabel;
@property(nonatomic,strong)UILabel *payTitleContent;
@property(nonatomic,strong)UIImageView *payWayLine;

//支付方式列表
@property(nonatomic,strong)UITableView *payWayTable;

//语音下单
@property(nonatomic,strong)UIView *voiceView;
@property(nonatomic,strong)UILabel *voiceTitle;
@property(nonatomic,strong)UIButton *voiceSubmit;
@property(nonatomic,strong)UIImageView *voiceIco;

//备注
@property(nonatomic,strong)UITextView *notesTextView;

//下单弹层
@property(nonatomic,strong)UIView *backageTopView;
@property(nonatomic,strong)UIView *submitAlertBackage;
@property(nonatomic,strong)UIView *submitAlertView;
@property(nonatomic,strong)UIView *submitInfoView;
@property(nonatomic,strong)UIView *submitButtonView;

@property(nonatomic,strong)UILabel *submitInfoTitle;
@property(nonatomic,strong)UILabel *submitInfoAmountTitle;
@property(nonatomic,strong)UILabel *submitInfoAmountContent;
@property(nonatomic,strong)UILabel *submitInfoTransportationTitle;
@property(nonatomic,strong)UILabel *submitInfoTransportationContent;
//@property(nonatomic,strong)UILabel *submitInfoPreferentialTitle;
//@property(nonatomic,strong)UILabel *submitInfoPreferentialContent;//优惠券抵现
@property(nonatomic,strong)UIView *submitInfoLine;
@property(nonatomic,strong)UILabel *submitInfoPayTitle;
@property(nonatomic,strong)UILabel *submitInfoPayContent;

@property(nonatomic,strong)UIButton *submitButtonConcel;
@property(nonatomic,strong)UIButton *submitButtonAffirm;

//@property(nonatomic,strong)SelectAlertView *selectAlertView;//优惠劵选择弹出框




@property(nonatomic, strong) NSMutableArray *commodityArray;//购物车商品
//@property(nonatomic, strong) NSMutableArray *commodityBusinessArray;//购物车商品
@property(nonatomic, strong) NSMutableArray *payWayArray;//支付方式数据
@property(nonatomic, strong) NSMutableArray *updateCommodityArray;//修改的商品数据

@property(nonatomic,assign)float orderCount;//订单总金额
@property(nonatomic,assign)float commodityTransportationExpenses;//商品运费
//@property(nonatomic,assign)float preferentialMoney;//优惠劵抵现

@property(nonatomic,assign)float commoditySectionHeight;//商品高度
@property(nonatomic,assign)float commodityHeight;//商品高度
@property(nonatomic,assign)float commodityTableHeight;//商品列表高度
@property(nonatomic,assign)NSInteger addressId;//所选的地址编号

@property(nonatomic, assign) BOOL *isMember;//是否会员
@property(nonatomic, assign) BOOL *isAddress;//是否存在默认地址
@property(nonatomic, strong) NSString *memberRemainder;//会员余额

@property(nonatomic,assign)int deleteSectionIndex;//删除的购物车商品section位置
@property(nonatomic,assign)int deleteRowIndex;//删除的购物车商品row位置
@property(nonatomic,assign)NSInteger selectPayWayIDPosition;//选择支付类型的方式ID的位置

@property (nonatomic, retain) WXProduct *WXPayProduct;
@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *traceId;

@property (nonatomic, strong) NSString *stringUser;
@property (nonatomic, strong) NSString *stringAddress;
@property (nonatomic, strong) NSString *stringCoupon;
@property (nonatomic, strong) NSString *stringCart;

@end

@implementation HHAddOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.updateCommodityArray = [[NSMutableArray alloc] init];
    self.commodityHeight = 70;//商品的tableView的cell的高度
    self.commoditySectionHeight = 50.0;
    self.orderCount = 0;
    self.commodityTransportationExpenses = 0;
//    self.preferentialMoney = 0;
    self.selectPayWayIDPosition = 1;//默认为微信
    self.isMember = NO;//默认不是会员
    self.isAddress = NO;//没有默认地址
    
    self.stringUser = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"address\":\"\u53f7\u697c\u5355\u5143\",\"allpoints\":\"500\",\"avatar\":\"http:\/\/www.sjsh8.cn\/image\/avatar\/14490496189705_src.jpg\",\"user_name\":\"15810906759\",\"firstname\":\"sj765_\u4f50\u624b\",\"sex\":\"\u7537\",\"lastname\":\"\",\"telephone\":\"15810906759\",\"is_member\":1,\"marry\":\"\u4fdd\u5bc6\",\"member_price\":\"700.70\"}}";
    
    self.stringAddress = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"address_id\":8266,\"firstname\":\"\u6d4b\u8bd5\uff0c\u52ff\u9001\uff01\",\"mobile_num\":\"8888\",\"xiaoqu\":\"\",\"louhao\":\"\u53f7\u697c\",\"danyuan\":\"\u5355\u5143\",\"room_number\":\"\",\"address_1\":\"\",\"default_id\":1},{\"address_id\":8246,\"firstname\":\"\u6d4b\u8bd5\",\"mobile_num\":\"15888888888\",\"xiaoqu\":\"\u4e94\u533a\",\"louhao\":\"8\u53f7\u697c\",\"danyuan\":\"\u8bf7\u9009\u62e9\u5355\u5143\",\"room_number\":\"\u8bf7\u9009\u62e9\",\"address_1\":\"\",\"default_id\":0}]}";
    
    self.stringCoupon = @"{\"code\":200,\"status\":\"true\",\"result\":{\"value\":[{\"coupon_id\":\"2723\",\"name\":\"\u6d4b\u8bd5APP\",\"code\":\"kloo1\",\"type\":\"F\",\"discount\":\"5.0000\",\"logged\":\"1\",\"shipping\":\"0\",\"total\":\"20.0000\",\"date_start\":\"2015-10-01\",\"date_end\":\"2015-12-31\",\"uses_total\":\"99\",\"uses_customer\":\"1\",\"for_customer\":\"9705\",\"status\":\"1\",\"date_added\":\"2015-10-28 16:08:50\",\"store_type\":\"0\"}],\"nums\":1}}";
    
    self.stringCart = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"manufacturer_id\":\"1932\",\"name\":\"\u793e\u533ae\u7ad9\",\"shipping_free_price\":\"0.0\",\"shipping_price\":\"0.0\",\"products\":[{\"key\":6963,\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151223\/1450885493946352-47x47.jpg\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"manufacturer_id\":\"1932\",\"delivery_speed\":\"0\",\"model\":\"\",\"option\":[],\"quantity\":1,\"stock\":true,\"reward\":\"\",\"price\":14.3,\"total\":14.3,\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=product\/product&amp;product_id=6963\",\"remove\":\"http:\/\/www.sjsh8.cn\/index.php?route=checkout\/cartcan&amp;remove=6963&amp;m_id=1932\"},{\"key\":7011,\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151215\/1450141840416216-47x47.jpg\",\"name\":\"\u793e\u533ae\u7ad9 \u4e1d\u74dc\u5c16 500g\",\"manufacturer_id\":\"1932\",\"delivery_speed\":\"0\",\"model\":\"\",\"option\":[],\"quantity\":2,\"stock\":true,\"reward\":\"\",\"price\":9.5,\"total\":19,\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=product\/product&amp;product_id=7011\",\"remove\":\"http:\/\/www.sjsh8.cn\/index.php?route=checkout\/cartcan&amp;remove=7011&amp;m_id=1932\"},{\"key\":\"6848:YToxOntpOjEyMTY7czo0OiIyMTM2Ijt9\",\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151013\/1444723326441545-47x47.jpg\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"manufacturer_id\":\"1932\",\"delivery_speed\":\"0\",\"model\":\"\",\"option\":[{\"name\":\"e\u7ad9\u7c73\",\"value\":\"5kg\"}],\"quantity\":1,\"stock\":true,\"reward\":\"\",\"price\":33,\"total\":33,\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=product\/product&amp;product_id=6848\",\"remove\":\"http:\/\/www.sjsh8.cn\/index.php?route=checkout\/cartcan&amp;remove=6848:YToxOntpOjEyMTY7czo0OiIyMTM2Ijt9&amp;m_id=1932\"}],\"sub_total\":66.3,\"yunfei\":\"0.0\",\"total\":66.3}]}";
    
    //测试数据
    self.payWayArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *payWayDictionary = nil;
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"hh_icon_order_cod" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"货到付款" forKey:@"payWayTitle"];
    [payWayDictionary setValue:@"配送人员上门现金支付" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"2" forKey:@"payWayState"];
    [payWayDictionary setValue:@"cod" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"hh_icon_order_vip" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"账户余额" forKey:@"payWayTitle"];
    [payWayDictionary setValue:@"立即开通，专享优惠" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"0" forKey:@"payWayState"];
    [payWayDictionary setValue:@"member" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    
//    payWayDictionary = [[NSMutableDictionary alloc] init];
//    [payWayDictionary setValue:@"icon_order_wechat" forKey:@"payWayIcon"];
//    [payWayDictionary setValue:@"微信支付" forKey:@"payWayTitle"];
//    [payWayDictionary setValue:@"推荐安装微信版本5.0以上版本使用" forKey:@"payWayContent"];
//    [payWayDictionary setValue:@"2" forKey:@"payWayState"];
//    [payWayDictionary setValue:@"wxpay" forKey:@"payID"];
//    [self.payWayArray addObject:payWayDictionary];
//    
//    payWayDictionary = [[NSMutableDictionary alloc] init];
//    [payWayDictionary setValue:@"icon_order_alipay" forKey:@"payWayIcon"];
//    [payWayDictionary setValue:@"支付宝" forKey:@"payWayTitle"];
//    [payWayDictionary setValue:@"配送人员上门现金支付" forKey:@"payWayContent"];
//    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
//    [payWayDictionary setValue:@"Alipay" forKey:@"payID"];
//    [self.payWayArray addObject:payWayDictionary];
    
  
    
//    payWayDictionary = [[NSMutableDictionary alloc] init];
//    [payWayDictionary setValue:@"icon_order_unionpay" forKey:@"payWayIcon"];
//    [payWayDictionary setValue:@"银联支付" forKey:@"payWayTitle"];
//    [payWayDictionary setValue:@"立即开通，专享优惠" forKey:@"payWayContent"];
//    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
//    [payWayDictionary setValue:@"unionpay" forKey:@"payID"];
//    [self.payWayArray addObject:payWayDictionary];
    
    
    [super initNavBarItems:@"提交订单"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    
//    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, ScreenWidth, 40)];
//    self.infoView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.infoView];
    
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.infoView.frame.size.height)];
    self.myScrollView.backgroundColor = [UIColor clearColor];
    self.myScrollView .contentSize = CGSizeMake(ScreenWidth, 1050);
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.myScrollView];
    
    
    self.addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    self.addressView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAddress:)];
    [self.addressView addGestureRecognizer:tapGesture];
    [self.myScrollView addSubview:self.addressView];
    
    self.commodityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.addressView.frame.origin.y+self.addressView.frame.size.height, ScreenWidth, 250)];
    self.commodityTable.tag = 198811;
    self.commodityTable.delegate = self;
    self.commodityTable.dataSource = self;
    self.commodityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commodityTable.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:self.commodityTable];
    
//    self.couponView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commodityTable.frame.origin.y+self.commodityTable.frame.size.height+10, ScreenWidth, 50)];
//    self.couponView.backgroundColor = [UIColor whiteColor];
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useCuponClick:)];
//    [self.couponView addGestureRecognizer:singleTap];
//    [self.myScrollView addSubview:self.couponView];
    
    self.payTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commodityTable.frame.origin.y+self.commodityTable.frame.size.height+10, ScreenWidth, 50)];
    self.payTitleView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:self.payTitleView];
    
    
    self.payWayTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.payTitleView.frame.origin.y+self.payTitleView.frame.size.height, ScreenWidth, 2*60)];
    self.payWayTable.tag = 198812;
    self.payWayTable.delegate = self;
    self.payWayTable.dataSource = self;
    self.payWayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.payWayTable.backgroundColor = [UIColor whiteColor];
    //    NSIndexPath *first = [NSIndexPath
    //                          indexPathForRow:1 inSection:0];
    //    [ self.payWayTable selectRowAtIndexPath:first
    //                           animated:YES
    //                     scrollPosition:UITableViewScrollPositionTop];
    [self.myScrollView addSubview:self.payWayTable];
    
    
    self.notesTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, self.payWayTable.frame.origin.y+self.payWayTable.frame.size.height, ScreenWidth-20, 100)];
    self.notesTextView.layer.borderWidth = 0.5;
    self.notesTextView.delegate = self;
    self.notesTextView.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] CGColor];
    self.notesTextView.text = @" 备注";
    self.notesTextView.textColor = fontDilutedGrayColor;
    [self.myScrollView addSubview:self.notesTextView];
    
    self.voiceView = [[UIView alloc] initWithFrame:CGRectMake(0, self.notesTextView.frame.origin.y+self.notesTextView.frame.size.height+30, ScreenWidth, 50)];
//    self.voiceView.backgroundColor = [UIColor colorWithRed:255.0/255.0  green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
    [self.myScrollView addSubview:self.voiceView];
    
    //提醒信息***********************
//    self.infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.infoView.frame.size.height-20)/2, 20, 20)];
//    self.infoImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.infoImageView.image = [UIImage imageNamed:@"icon_order_info"];
//    [self.infoView addSubview:self.infoImageView];
//    
//    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-50, self.infoView.frame.size.height)];
//    self.infoLabel.text=@"限时活动订单必须10分钟内支付，否则名额失效！";
//    self.infoLabel.font = [UIFont systemFontOfSize:11];
//    self.infoLabel.textAlignment = NSTextAlignmentLeft;
//    [self.infoView addSubview:self.infoLabel];
//    
//    self.infoLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.infoView.frame.size.height-1, ScreenWidth, 1)];
//    self.infoLine.contentMode = UIViewContentModeScaleToFill;
//    self.infoLine.image = [UIImage imageNamed:@"icon_order_line"];
//    [self.infoView addSubview:self.infoLine];
    
    
    //地址**************************
    self.userIco = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
    self.userIco.contentMode = UIViewContentModeScaleAspectFit;
    self.userIco.image = [UIImage imageNamed:@"hh_icon_order_user"];
    [self.addressView addSubview:self.userIco];
    
    self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userIco.frame.origin.x+self.userIco.frame.size.width+11, self.userIco.frame.origin.y, 50, 15)];
    self.userLabel.text=@"未知";
    self.userLabel.textAlignment = NSTextAlignmentLeft;
    self.userLabel.numberOfLines = 0;
     self.userLabel.font = [UIFont systemFontOfSize:14];
    [self.addressView addSubview:self.userLabel];
    
    
    self.phoneIco = [[UIImageView alloc] initWithFrame:CGRectMake(self.userLabel.frame.origin.x+self.userLabel.frame.size.width+10, self.userIco.frame.origin.y, 15, 15)];
    self.phoneIco.contentMode = UIViewContentModeScaleAspectFit;
    self.phoneIco.image = [UIImage imageNamed:@"hh_icon_order_phone"];
    [self.addressView addSubview:self.phoneIco];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.phoneIco.frame.origin.x+self.phoneIco.frame.size.width+10, self.userIco.frame.origin.y, 150, 15)];
    self.phoneLabel.text=@"88888888888";
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    self.phoneLabel.numberOfLines = 0;
     self.phoneLabel.font = [UIFont systemFontOfSize:14];
    [self.addressView addSubview:self.phoneLabel];
 
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.phoneIco.frame.origin.y+self.phoneIco.frame.size.height+10, 200, 35)];
    self.addressLabel.text=@"请选择地址";
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.addressLabel.numberOfLines = 0;//上面两行设置多行显示
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    [self.addressView addSubview:self.addressLabel];
    
    self.addressArrow = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-20-7, (self.addressView.frame.size.height-12)/2, 7, 12)];
    self.addressArrow.contentMode = UIViewContentModeScaleAspectFit;
    self.addressArrow.image = [UIImage imageNamed:@"icon_right_arrow"];
    [self.addressView addSubview:self.addressArrow];
    
    //优惠劵***********************
//    self.couponTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, self.couponView.frame.size.height)];
//    self.couponTitle.text=@"优惠劵";
//    //    self.couponTitle.textAlignment = NSTextAlignmentCenter;
//    [self.couponView addSubview:self.couponTitle];
//    
//    self.couponContent = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, ScreenWidth-120, self.couponView.frame.size.height)];
//    self.couponContent.text=@"有0张优惠劵可用";
//    self.couponContent.textColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0];
//    self.couponContent.textAlignment = NSTextAlignmentRight;
//    [self.couponView addSubview:self.couponContent];
//    
//    self.couponArrow = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-35, (self.couponView.frame.size.height-15)/2, 15, 15)];
//    self.couponArrow.image = [UIImage imageNamed:@"icon_right_arrow"];
//    self.couponArrow.contentMode = UIViewContentModeScaleAspectFit;
//    [self.couponView addSubview:self.couponArrow];
    
    
    //需支付***********************
    self.payTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, self.payTitleView.frame.size.height)];
    self.payTitleLabel.text=@"订单金额";
    //    self.payTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.payTitleView addSubview:self.payTitleLabel];
    
    self.payTitleContent = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-120, self.payTitleView.frame.size.height)];
    self.payTitleContent.text=@"￥0.0元";
    self.payTitleContent.font = [UIFont systemFontOfSize:22];
    self.payTitleContent.textColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
    //    self.payTitleContent.textAlignment = NSTextAlignmentRight;
    [self.payTitleView addSubview:self.payTitleContent];
    
    self.payWayLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.payTitleView.frame.size.height-1, ScreenWidth-20, 0.5)];
    self.payWayLine.backgroundColor = lineGrayColor;
    self.payWayLine.contentMode = UIViewContentModeScaleToFill;
    [self.payTitleView addSubview:self.payWayLine];
    
    //语音下单***********************
    self.voiceSubmit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.voiceView.frame.size.height)];
    self.voiceSubmit.backgroundColor = kRedColor;
    [self.voiceSubmit setTitle:@"立即下单" forState:UIControlStateNormal];
    [self.voiceSubmit addTarget:self action:@selector(showSubmitAlert:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.voiceView addSubview:self.voiceSubmit];
    
    
    //提交弹出层
    self.backageTopView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    self.backageTopView.backgroundColor = [UIColor blackColor];
    self.backageTopView.alpha = 0.4;
    self.backageTopView.hidden = YES;
    UIWindow *myWindow  = [[UIApplication sharedApplication].delegate window];
    [myWindow addSubview:self.backageTopView];
    
    self.submitAlertBackage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.submitAlertBackage.backgroundColor = [UIColor blackColor];
    self.submitAlertBackage.alpha = 0.4;
    self.submitAlertBackage.hidden = YES;
    [self.view addSubview:self.submitAlertBackage];
    
    self.submitAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-270, ScreenWidth, 270)];
    self.submitAlertView.hidden = YES;
    [self.view addSubview:self.submitAlertView];
    
    self.submitInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.submitInfoView.backgroundColor = [UIColor whiteColor];
    [self.submitAlertView addSubview:self.submitInfoView];
    
    self.submitButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 70)];
    self.submitButtonView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
    [self.submitAlertView addSubview:self.submitButtonView];
    
    float rowHeight = 20.0;
    float rowMargin = 5.0;
    //提交信息显示
    self.submitInfoTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, rowHeight)];
    self.submitInfoTitle.text = @"您确定下单吗？";
    [self.submitInfoTitle setTextColor:[UIColor blackColor]];
    self.submitInfoTitle.textAlignment = NSTextAlignmentCenter;
    [self.submitInfoView addSubview:self.submitInfoTitle];
    
    self.submitInfoAmountTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.submitInfoTitle.frame.origin.y+self.submitInfoTitle.frame.size.height+10, 100, rowHeight)];
    self.submitInfoAmountTitle.text = @"订单总额";
    [self.submitInfoAmountTitle setTextColor:[UIColor blackColor]];
    [self.submitInfoView addSubview:self.submitInfoAmountTitle];
    
    self.submitInfoAmountContent = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-110, self.submitInfoTitle.frame.origin.y+self.submitInfoTitle.frame.size.height+rowMargin, 100, rowHeight)];
    self.submitInfoAmountContent.text = @"￥0";
    [self.submitInfoAmountContent setTextColor:[UIColor blackColor]];
    self.submitInfoAmountContent.textAlignment = NSTextAlignmentRight;
    [self.submitInfoView addSubview:self.submitInfoAmountContent];
    
    self.submitInfoTransportationTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.submitInfoAmountTitle.frame.origin.y+self.submitInfoAmountTitle.frame.size.height+rowMargin, 100, rowHeight)];
    self.submitInfoTransportationTitle.text = @"运费";
    [self.submitInfoTransportationTitle setTextColor:[UIColor blackColor]];
    [self.submitInfoView addSubview:self.submitInfoTransportationTitle];
    
    
    self.submitInfoTransportationContent = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-110, self.submitInfoAmountTitle.frame.origin.y+self.submitInfoAmountTitle.frame.size.height+rowMargin, 100, rowHeight)];
    self.submitInfoTransportationContent.text = @"￥0";
    [self.submitInfoTransportationContent setTextColor:[UIColor blackColor]];
    self.submitInfoTransportationContent.textAlignment = NSTextAlignmentRight;
    [self.submitInfoView addSubview:self.submitInfoTransportationContent];
    
//    self.submitInfoPreferentialTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.submitInfoTransportationTitle.frame.origin.y+self.submitInfoTransportationTitle.frame.size.height+rowMargin, 100, rowHeight)];
//    self.submitInfoPreferentialTitle.text = @"优惠劵抵现";
//    [self.submitInfoPreferentialTitle setTextColor:[UIColor blackColor]];
//    [self.submitInfoView addSubview:self.submitInfoPreferentialTitle];
//    
//    self.submitInfoPreferentialContent = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-110, self.submitInfoTransportationTitle.frame.origin.y+self.submitInfoTransportationTitle.frame.size.height+rowMargin, 100, rowHeight)];
//    self.submitInfoPreferentialContent.text = @"￥0";
//    [self.submitInfoPreferentialContent setTextColor:[UIColor blackColor]];
//    self.submitInfoPreferentialContent.textAlignment = NSTextAlignmentRight;
//    [self.submitInfoView addSubview:self.submitInfoPreferentialContent];
    
    self.submitInfoLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.submitInfoTransportationTitle.frame.origin.y+self.submitInfoTransportationTitle.frame.size.height+rowMargin, ScreenWidth-20, 1)];
    self.submitInfoLine.backgroundColor = [UIColor grayColor];
    [self.submitInfoView addSubview:self.submitInfoLine];
    
    self.submitInfoPayTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.submitInfoTransportationTitle.frame.origin.y+self.submitInfoTransportationTitle.frame.size.height+10, 100, rowHeight)];
    self.submitInfoPayTitle.text = @"实付款";
    [self.submitInfoPayTitle setTextColor:[UIColor blackColor]];
    [self.submitInfoView addSubview:self.submitInfoPayTitle];
    
    self.submitInfoPayContent = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-110, self.submitInfoTransportationTitle.frame.origin.y+self.submitInfoTransportationTitle.frame.size.height+10, 100, rowHeight)];
    self.submitInfoPayContent.text = @"￥0";
    [self.submitInfoPayContent setTextColor:[UIColor blackColor]];
    self.submitInfoPayContent.textAlignment = NSTextAlignmentRight;
    [self.submitInfoView addSubview:self.submitInfoPayContent];
    
    
    
    //提交按钮区域
    self.submitButtonConcel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButtonConcel.frame = CGRectMake(10, 10, ScreenWidth*0.4, 50);
    self.submitButtonConcel.tag = 198851;
    [self.submitButtonConcel setTitle:@"取消" forState:UIControlStateNormal];
    self.submitButtonConcel.backgroundColor = [UIColor whiteColor];
    //    self.submitButtonConcel.titleLabel.font = [UIFont fontWithName:@"LuzSans-Book" size:15];
    self.submitButtonConcel.tintColor = [UIColor blackColor];
    [self.submitButtonConcel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.submitButtonConcel.layer.cornerRadius = 4;
    self.submitButtonConcel.layer.masksToBounds = YES;
    [self.submitButtonConcel addTarget:self action:@selector(submitOrder:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButtonView addSubview:self.submitButtonConcel];
    
    self.submitButtonAffirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButtonAffirm.frame = CGRectMake(ScreenWidth*0.6-10, 10, ScreenWidth*0.4, 50);
    self.submitButtonAffirm.tag = 198852;
    self.submitButtonAffirm.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:99.0/255.0 blue:57.0/255.0 alpha:1.0];
    [self.submitButtonAffirm setTitle:@"确认" forState:UIControlStateNormal];
    //    self.submitButtonAffirm.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    //    [self.submitButtonAffirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.submitButtonAffirm.layer.cornerRadius = 4;
    self.submitButtonAffirm.layer.masksToBounds = YES;
    [self.submitButtonAffirm addTarget:self action:@selector(submitOrder:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButtonView addSubview:self.submitButtonAffirm];
    
//    self.selectAlertView = [[SelectAlertView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    [self.selectAlertView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    self.selectAlertView.delegate = self;
//    [self.view addSubview:self.selectAlertView];
//    
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.selectAlertView
//                              attribute:NSLayoutAttributeTop
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeTop
//                              multiplier:1
//                              constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.selectAlertView
//                              attribute:NSLayoutAttributeLeft
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeLeft
//                              multiplier:1
//                              constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.selectAlertView
//                              attribute:NSLayoutAttributeWidth
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeWidth
//                              multiplier:1.0
//                              constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.selectAlertView
//                              attribute:NSLayoutAttributeHeight
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeHeight
//                              multiplier:1
//                              constant:0]];
    
    
    
    //    [self loadInterfaceData];//获取接口数据
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(payAlipaySuccessBack)
     name:@"payAlipaySuccessBack"
     object:nil];
    
    //微信支付完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
    
    //支付宝返回结果
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resultByAlipay:)
                                                 name:@"resultByAlipay"
                                               object:nil];
    
    
}



//获取接口数据
- (void)loadInterfaceData{
    [self showGif];
    
    //获取会员信息
    [commonModel requestUserinfo:nil
              httpRequestSucceed:@selector(requestMemberSuccess:)
               httpRequestFailed:@selector(requestFailed:)];
    
    
    
    
    
    
}

//获取会员信息成功
-(void)requestMemberSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    //      NSLog(@"获取用户信息接口成功：%@！！！！！",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"获取用户信息dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        //        self.overView.hidden=YES;
        
        NSDictionary *info = [dic objectForKey:@"result"];
        
        
        self.isMember = ([info[@"is_member"] integerValue]==1);
        self.memberRemainder = info[@"member_price"];
        
        if(self.isMember){//如果是会员卡
            
            NSMutableDictionary *payWayDictionary = [[NSMutableDictionary alloc] init];
            [payWayDictionary setValue:@"hh_icon_order_vip" forKey:@"payWayIcon"];
            [payWayDictionary setValue:@"账户余额" forKey:@"payWayTitle"];
            [payWayDictionary setValue:self.memberRemainder forKey:@"payWayContent"];
            [payWayDictionary setValue:@"1" forKey:@"payWayState"];
            [payWayDictionary setValue:@"member" forKey:@"payID"];
            self.payWayArray[1] = payWayDictionary;
            [self.payWayTable reloadData];
        }
        
    }
    
    //获取其他页面接口数据
    if(self.isFirst){
        [commonModel requestaddress:nil httpRequestSucceed:@selector(requestaddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
    }else{
        NSLog(@"再次支付！");
        [commonModel payOrderSecond:self.orderID httpRequestSucceed:@selector(payOrderSecondSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}


#pragma mark 首次支付
//获取地址信息
- (void)requestaddressSuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"地址列表接口：%@!!!!!!!!!!!",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSMutableArray  *addressArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
        //        [listTableView reloadData];
        for(int i=0;i<addressArray.count;i++){
            NSLog(@"是否默认：%@!!!!!!!!!!!",addressArray[i][@"default_id"]);
            if ([addressArray[i][@"default_id"] integerValue]==1) {
                self.isAddress = YES;
                NSString *addressString = [NSString stringWithFormat:@"%@  %@\n%@\n%@",addressArray[i][@"firstname"],addressArray[i][@"mobile_num"],addressArray[i][@"xiaoqu"],addressArray[i][@"louhao"]];
                self.addressLabel.text=addressString;
                self.addressId = [addressArray[i][@"address_id"] integerValue];
            }
        }
        
        
//        [commonModel getforcoupon:nil httpRequestSucceed:@selector(getforcouponSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
         [commonModel orderCartListByPost:nil httpRequestSucceed:@selector(cartListSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}



//获取个人优惠信息
//- (void)getforcouponSuccess:(ASIHTTPRequest *)request{
//    //    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
//    NSLog(@"优惠劵接口数据：%@!!!!!!!!!!!",dic);
//    NSLog(@"优惠劵接口：%@!!!!!!!!!!!",(NSString *)dic[@"status"]);
//    if([((NSString *)dic[@"status"]) isEqual:@"true"]){
//        //    NSLog(@"存在优惠劵!!!!!!!!!!!");
//        self.couponContent.text = [NSString stringWithFormat:@"有%@可用的优惠劵",dic[@"result"][@"nums"]];
//        self.couponContent.textColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
//        self.couponArrow.hidden  = NO;
//        NSMutableArray *couponArray = dic[@"result"][@"value"];
//        //        for (int i=0; i<couponArray.count; i++) {
//        //            [couponArray[i] setObject:@"0" forKey:@"selectState"];
//        //        }
//        
//        
//        [self.selectAlertView uploadData:couponArray];
//    }else{
//        self.couponContent.text = [NSString stringWithFormat:@"没有可用的优惠劵"];
//        self.couponArrow.hidden  = YES;
//        [self.couponView setUserInteractionEnabled:NO];//不可点击
//    }
//    
//    [commonModel orderCartListByPost:nil httpRequestSucceed:@selector(cartListSuccess:) httpRequestFailed:@selector(requestFailed:)];
//}


//获取购物车信息
- (void)cartListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSLog(@"购物车列表responseString%@",request.responseString);
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"购物车列表dic%@！！！！！！！！！！",completeDic);
    if (![completeDic[@"status"] isEqualToString:@"false"]) {
        self.commodityArray = [NSMutableArray arrayWithArray:[completeDic objectForKey:@"result"]];
        
        [self updateCartData:self.commodityArray];
        [self updateLayout];
        [self.commodityTable reloadData];
        [self updateTotoaPrice];
        
    }
    
    
    //    if (self.dataArray.count == 0) {
    //        self.bottomView.hidden = YES;
    //    }
    //    else {
    //        self.bottomView.hidden = NO;
    //    }
    
    
    
    
//    [self startInfoAnimation];//加载顶部信息动画
}



#pragma mark 再次支付
- (void)payOrderSecondSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"再次支付列表接口：%@!!!!!!!!!!!",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        //        NSMutableArray  *addressArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
        NSDictionary *resultDictionary = dic[@"result"];
        NSString *addressString = [NSString stringWithFormat:@"%@",resultDictionary[@"addstr"] ];
        self.addressLabel.text=addressString;
        //          NSLog(@"优惠券信息：%@!!!!!!!!!!!",resultDictionary[@"yg_val"]);
//        self.couponContent.text = resultDictionary[@"yg_val"][0][@"discount"];
        self.commodityArray = [NSMutableArray arrayWithArray:[resultDictionary objectForKey:@"shops"]];
        NSLog(@"商品列表数据：%@!!!!!!!!!!!", self.commodityArray);
        [self updateCartData:self.commodityArray];
        [self updateLayout];
        [self.commodityTable reloadData];
        [self updateTotoaPrice];
        
    }
}

//修改总金额
- (void)updateTotoaPrice
{
    float totalP = 0.0;
    //重新计算金额
    //    for (NSString *itemId in self.selectArray)
    for(NSDictionary *productDic in self.commodityArray) {
        NSArray *productArray = productDic[@"products"];
        NSLog(@"总金额%@!!!!",productArray);
        for (int i=0; i<productArray.count; i++) {
            NSInteger num = [[productArray[i] objectForKey:@"quantity"] integerValue];
            //            NSLog(@"商品的价格%ld!!!!",(long)num);
            float price = [[productArray[i] objectForKey:@"price"] floatValue];
            //            NSLog(@"商品的数量%ld!!!!",(long)price);
            totalP +=price*num;
        }
    }
    NSLog(@"计算的金额为%@!!!!!!",[NSString stringWithFormat:@"合计：%.2f",totalP]);
    self.payTitleContent.text = [NSString stringWithFormat:@"￥%.2f元",totalP];//修改订单总金额的显示
    
    //    self.totoaPricelabel.text = [NSString stringWithFormat:@"合计：%.2f",totalP];
}

//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误：%@！！！！！！",request.error);
}


//提交订单
- (void)showSubmitAlert:(UIButton *)myButton{
    
    //    NSDictionary *product = self.updateCommodityArray[0];
    
    if (self.isAddress) {//存在默认地址
        
        NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
        if (self.updateCommodityArray&&self.updateCommodityArray.count>0) {
            [super showGif];
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization
                                dataWithJSONObject:self.updateCommodityArray options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [addDic setObject:jsonString forKey:@"carlists"];
            NSLog(@"提交订单%@！！！！！", jsonString);
            
            [commonModel updateMultipleCartByPost:addDic httpRequestSucceed:@selector(requestupdateMultipleCartSuccess:) httpRequestFailed:@selector(payOrderFail:)];
        }else{//没有修改商品数据，直接显示弹出页面
            [self updateSubmitAlert:1];
        }
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择地址！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}

- (void)requestupdateMultipleCartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSLog(@"修改订单接口返回数据%@！！！！！",[request responseString]);
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"提交订单dic%@",completeDic);
    //    NSString *code = [completeDic objectForKey:@"code"];
    //    NSString *msg = nil;
    //    switch ([code integerValue]) {
    //        case 200:
    //            msg = @"修改成功";
    //            break;
    //        case 6002:
    //            //添加成功
    //            msg = @"参数错误";
    //            break;
    //        case 6003:
    //            //添加成功
    //            msg = @"请选择规格";
    //            break;
    //        default:
    //            msg = [completeDic objectForKey:@"msg"];
    //            break;
    //    }
    //    if (msg) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
    //    if([[request responseString]  isEqual: @"true"]){
    if([completeDic[@"code"] integerValue]==200){
        //        NSLog(@"修改成功!!!!！");
        [self updateSubmitAlert:1];
    }else{
        //         NSLog(@"修改失败!!!!！");
        [self updateSubmitAlert:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单提交失败，请重试！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}

- (void)requestupdatecartFail:(ASIHTTPRequest *)request{
    [super hideGif];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)payOrderFail:(ASIHTTPRequest *)request{
    [super hideGif];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"订单支付失败，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [self toReturn];
}


//顶部信息弹出动画
- (void)startInfoAnimation{
    
    [UIView animateWithDuration:0.5 animations:^
     {
         CGRect tempFrame = self.infoView.frame;
         tempFrame.origin.y += 40;
         self.infoView.frame = tempFrame;
         
         CGRect scrollFrame = self.myScrollView.frame;
         scrollFrame.origin.y += 40;
         self.myScrollView.frame = scrollFrame;
     }completion:^(BOOL finished){
     }];
    
}

//修改购物车数据
- (void)updateCartData:(NSArray *)myArray{
    //    self.commodityBusinessArray = [[NSMutableArray alloc] init];
    
    
    
    float totalP = 0.0;
    self.commodityTableHeight = 0.0;
    //重新计算订单总金额
    self.orderCount = 0;
    
    for(int i=0;i<myArray.count;i++){
        
        
        
        
        self.commodityTableHeight +=  self.commoditySectionHeight;
        
        NSArray *sonArray = myArray[i][@"products"];
        for(int y=0;y<sonArray.count;y++){
            self.commodityTableHeight +=  self.commodityHeight;
            
            //计算订单总金额
            NSInteger num = [sonArray[y][@"quantity"] integerValue];
            float price = [sonArray[y][@"price"] floatValue];
            self.orderCount+=price*num;
            NSLog(@"计算的金额为%@!!!!!!",[NSString stringWithFormat:@"合计：%.2f",totalP]);
        }
        
        
        //        //重新分类数据
        //        int flag = -1;
        //        for (int y=0;y<self.commodityBusinessArray.count;y++) {
        //            if (self.commodityBusinessArray[y][@"manufacturer_id"] == myArray[i][@"manufacturer_id"]) {
        //                flag = y;
        //            }
        //        }
        //        if(flag==-1){ //新创建item
        //            NSMutableDictionary *itemDictionary = [[NSMutableDictionary alloc] init];
        //            itemDictionary[@"manufacturer_id"] = myArray[i][@"manufacturer_id"];
        //            itemDictionary[@"manufacturer_name"] = myArray[i][@"name"];
        //            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        //            [itemArray addObject:myArray[i]];
        //            itemDictionary[@"myArray"] = itemArray;
        //        [self.commodityBusinessArray addObject:itemDictionary];
        //        self.commodityTableHeight +=  self.commoditySectionHeight;
        //            self.commodityTableHeight +=  self.commodityHeight;
        //        }else{//添加到已有的item里
        //            [self.commodityBusinessArray[flag][@"myArray"] addObject:myArray[i]];
        //            self.commodityTableHeight +=  self.commodityHeight;
        //        }
        //
    }
    self.payTitleContent.text = [NSString stringWithFormat:@"￥%.2f元",self.orderCount];//修改订单总金额的显示
    
    //    return self.commodityBusinessArray;
}


#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSUInteger count = 0;
    if (tableView.tag==198811) {
        count = [self.commodityArray count];
    }else{
        count = 1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (tableView.tag==198811) {
        height = self.commodityHeight;
    }else{
        height = 60;
    }
    return height;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    NSDictionary *myDictionary = self.commodityArray[section];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth-100, 50)];
    nameLabel.text = myDictionary[@"name"];
    [hView addSubview:nameLabel];
    
    
    UILabel *freightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, 0, 80, 50)];
    freightLabel.text = [NSString stringWithFormat:@"运费￥%@",myDictionary[@"yunfei"]];
    freightLabel.textAlignment = NSTextAlignmentRight;
    freightLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
    freightLabel.font = [UIFont systemFontOfSize:14];
    [hView addSubview:freightLabel];
    
    if (section>0) {
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 1)];
        lineView.backgroundColor = lineGrayColor;
        [hView addSubview:lineView];
    }
    return hView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (tableView.tag==198811) {
        height = 50;
    }else{
        height = 0;
    }
    return height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *myDictionary = self.commodityArray[section];
    NSUInteger count = 0;
    if (tableView.tag==198811) {
        count = ((NSArray *)(self.commodityArray[section][@"products"])).count;
    }else{
        count = self.payWayArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==198811) {
        static NSString *reusableIdentifier = @"HHOrderCommodityCell";
        
        HHOrderCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        
        if (!cell)
        {
            cell = [[HHOrderCommodityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.delegate = self;
        NSArray *myArray = self.commodityArray[indexPath.section][@"products"];
        [cell setCellInfo:myArray[indexPath.row]];
        
        return cell;
    }else{
        static NSString *reusableIdentifier = @"OrderWayCell";
        
        OrderWayCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        if (!cell)
        {
            cell = [[OrderWayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusableIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setCellInfo:self.payWayArray[indexPath.row]];
        
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择商品%@!!!!!!!!",indexPath);
    if (tableView.tag==198812) {//支付方式
        
        for (int i=0; i<self.payWayArray.count;i++) {
            if(![self.payWayArray[i][@"payWayState"] isEqual:@"0"]){
                if (i==indexPath.row) {
                    self.payWayArray[i][@"payWayState"]=@"2";
                }else{
                    self.payWayArray[i][@"payWayState"]=@"1";
                }
                
            }
        }
        self.selectPayWayIDPosition = indexPath.row;
        [self.payWayTable reloadData];
        
    }
    
}

//是否允许滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==198811) {
        return YES;
    }else{
        return NO;
    }
}

//滑动删除具体方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSLog(@"开始删除");
        NSArray *myArray = self.commodityArray[self.deleteSectionIndex][@"products"];
        NSDictionary *productDic = [myArray objectAtIndex:self.deleteRowIndex];
        [commonModel requestDelFromCart:[NSDictionary dictionaryWithObjectsAndKeys:[productDic objectForKey:@"key"],@"key",self.commodityArray[self.deleteSectionIndex][@"manufacturer_id"],@"manufacturer_id", nil] httpRequestSucceed:@selector(DelFromCartSuccess:) httpRequestFailed:@selector(requestFailed:)];
        [self showGif];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//UITableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag==198811) {
        CGFloat sectionHeaderHeight = 100; //这里是我的headerView和footerView的高度
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}







//删除商品成功
- (void)DelFromCartSuccess:(ASIHTTPRequest *)request
{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"商品删除成功dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            self.infoView.frame = CGRectMake(0, -40, ScreenWidth, 40);
            self.myScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.infoView.frame.size.height);
            //删除成功
            [commonModel requestCartList:nil httpRequestSucceed:@selector(cartListSuccess:) httpRequestFailed:@selector(requestFailed:)];
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


/**
 *  提交订单
 *
 *  @param myButton 确认和取消按钮
 */
- (void)submitOrder:(UIButton *)myButton{
    if (myButton.tag ==198851 ) {
        [self updateSubmitAlert:0];
    }else  if (myButton.tag ==198852 ){
        [self updateSubmitAlert:0];
        
        NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
        myDictionary[@"address_id"] = [NSString stringWithFormat:@"%ld",(long)self.addressId];
        myDictionary[@"payment_cod"] = self.payWayArray[self.selectPayWayIDPosition][@"payID"];
        myDictionary[@"comment"] = self.notesTextView.text;
        
        NSLog(@"提交订单的参数为：%@!!!!!!!!!!!!!!",myDictionary);
        [super showGif];
        //调用下单接口
        [commonModel submitOrderByPost:myDictionary httpRequestSucceed:@selector(requestSubmitOrderSuccess:) httpRequestFailed:@selector(payOrderFail:)];
    }
    
}


//使用优惠劵
//-(void)useCoupon:(NSString *)counum{
//    
//    [commonModel getUseCoupon:counum httpRequestSucceed:@selector(requestUseCouponSuccess:) httpRequestFailed:@selector(requestFailed:)];
//    
//}
//
////优惠劵试用成功
//- (void)requestUseCouponSuccess:(ASIHTTPRequest *)request
//{
//    [super hideGif];
//    NSDictionary *myResult = [super parseJsonRequest:request];
//    NSLog(@"优惠劵使用成功dic%@",myResult);
//    
//    if(([myResult[@"code"] integerValue] == 200)&&[myResult[@"status"] isEqualToString:@"true"]){
//        self.couponArrow.hidden  =  NO;
//        [self.couponView setUserInteractionEnabled:NO];
//    }
//    
//    
//}

/**
 *  显示提交订单弹出框
 *
 *  @param type 0为隐藏，1为显示
 */
- (void)updateSubmitAlert:(int) type{
    self.submitAlertBackage.hidden = (type==0);
    self.backageTopView.hidden = (type==0);
    self.submitAlertView.hidden = (type==0);
    if (type==1) {
        self.submitInfoAmountContent.text = [NSString stringWithFormat:@"%.2f",self.orderCount];
        self.submitInfoTransportationContent.text = [NSString stringWithFormat:@"%.2f",self.commodityTransportationExpenses];
//        self.submitInfoPreferentialContent.text = [NSString stringWithFormat:@"%.2f",self.preferentialMoney];
        self.submitInfoPayContent.text = [NSString stringWithFormat:@"%.2f",self.orderCount+self.commodityTransportationExpenses];
    }
}


//修改送货地址
- (void)updateAddress:(UIView *)myView{
    //跳web页面
    //    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
    //    detailViewController.hide400 = YES;
    //    [detailViewController initWithUrl:@"http://www.sjsh8.cn/index.php?route=mobile/fuwu/appforaddress" andTitle:@"地址管理"];
    
    AddressViewController *detailViewController = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//优惠劵点击事件
//-(void)useCuponClick:(UITapGestureRecognizer *)sender{
//    [self.selectAlertView showAlert];
//}





//重绘页面布局
-(void)updateLayout{
    
    self.commodityTable.frame = CGRectMake(0, self.addressView.frame.origin.y+self.addressView.frame.size.height, ScreenWidth, self.commodityTableHeight);
    
//    self.couponView.frame = CGRectMake(0, self.commodityTable.frame.origin.y+self.commodityTable.frame.size.height+10, ScreenWidth, 50);
    
    self.payTitleView.frame = CGRectMake(0, self.commodityTable.frame.origin.y+self.commodityTable.frame.size.height+10, ScreenWidth, 50);
    
    self.payWayTable.frame = CGRectMake(0, self.payTitleView.frame.origin.y+self.payTitleView.frame.size.height, ScreenWidth, 2*60);
    
    self.notesTextView.frame = CGRectMake(20, self.payWayTable.frame.origin.y+self.payWayTable.frame.size.height+10, ScreenWidth-40, 90);
    
    self.voiceView.frame = CGRectMake(0, self.notesTextView.frame.origin.y+self.notesTextView.frame.size.height+40, ScreenWidth, 60);
    
    self.myScrollView .contentSize = CGSizeMake(ScreenWidth, self.addressView.frame.size.height+self.commodityTable.frame.size.height+self.payTitleView.frame.size.height+self.payWayTable.frame.size.height+self.voiceView.frame.size.height+self.notesTextView.frame.size.height+10+10+10+40+50-6);
    
    
}


//提交购物订单接口成功
- (void)requestSubmitOrderSuccess:(ASIHTTPRequest *)request{
    
    NSLog(@"提交订单接口responseString：%@!!!!!!!!!!!",request.responseString );
    
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"提交订单接口：%@!!!!!!!!!!!",dic );
    
    //    if(dic.description){
    //    NSLog(@"优惠劵为空!!!!!!!!!!!");
    //    }
    NSString *payWay = [NSString stringWithFormat:@"%@",self.payWayArray[self.selectPayWayIDPosition][@"payID"]];
    
    NSLog(@"所选支付方式：%@!!!!!!!!!!!",payWay );
    if ([dic[@"code"] integerValue] == 2000) {
        
        
        NSDictionary *dataDictionary = dic[@"result"][@"data"];
        NSArray *orderArray = dataDictionary[@"orders"];
        NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
        
        
        if ([payWay isEqual:@"member"]) {//会员支付
            
            [commonModel payOrderByMember:dataDictionary[@"order_id"] httpRequestSucceed:@selector(payOrderByMemberSuccess:) httpRequestFailed:@selector(requestFailed:)];
            
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
            
            [commonModel getUnionpay:orderDictionary[@"order_num"]  desc:@"世纪生活商品消费" httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(payOrderFail:)];
            
            //         [commonModel getUnionpay:myDictionary httpRequestSucceed:@selector(requestGetUPNumberSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
            
        }
    }else{
        
        [super hideGif];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单提交失败，请重试！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        
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

//会员支付成功
-(void)payOrderByMemberSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    //      NSLog(@"获取用户信息接口成功：%@！！！！！",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"会员支付成功dic%@",dic);
    //    if ([[dic objectForKey:@"code"] intValue] == 200) {
    
    if ( [[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"] ] isEqualToString:@"true"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付成功"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self toReturn];//返回上一页
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
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
    myOrder.amount = [NSString stringWithFormat:@"%f",self.orderCount+self.commodityTransportationExpenses];  //商品价格
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
    
    NSLog(@"所选支付方式为微信：%@!!!!!!!!",myDictionary);
    
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
    weChatPayDictionary[@"total_fee"] = [NSString stringWithFormat:@"%.0f",(self.orderCount+self.commodityTransportationExpenses)*100];
    
    NSLog(@"参数为%@！！！！！！！！",weChatPayDictionary);
    
    //老方法（app签名）
    WXProduct *product = [[WXProduct alloc] init];
    product.traceId = orderDictionary[@"order_num"];
    product.outTradNo = orderDictionary[@"order_num"];
    product.total_fee = (self.orderCount+self.commodityTransportationExpenses)*100;
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

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//页面即将显示
- (void)viewWillAppear:(BOOL)animated{
    self.infoView.frame = CGRectMake(0, -40, ScreenWidth, 40);
    self.myScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.infoView.frame.size.height);
    
    [self loadInterfaceData];//重新调用接口
    
    
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
    [self toReturn];//返回上一页
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
        [self toReturn];
        
    }
    //    [self roadWXPayResultWithCode:[notification.object objectForKey:@"code"]];
    self.WXPayProduct = nil;
}

- (void) resultByAlipay:(NSNotification*) notification
{
    //    id obj = [notification object];//获取到传递的对象
    [self toReturn];
}

//- (void)roadWXPayResultWithCode:(NSString *)code
//{
//    NSString *urlStr = [self.WXPayProduct.returnUrl stringByAppendingFormat:@"&traceId=%@&outTradNo=%@&total_fee=%d&body=%@&code=%@&from=wxpay",self.WXPayProduct.traceId,self.WXPayProduct.outTradNo,self.WXPayProduct.total_fee,self.WXPayProduct.body,code];
//    NSURL *url = [[NSURL alloc] initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
//    [req setTimeoutInterval:300];
//    [m_webView loadRequest:req];
//    self.WXPayProduct = nil;
//}

#pragma marks 优惠劵选择列表代理
//- (void)getSelectItem:(NSDictionary *)myDictionary{
//    
//    NSLog(@"优惠劵已选择%@！！！！！！",myDictionary);
//    [self.selectAlertView closeAlert];
//    [self useCoupon:[NSString stringWithFormat:@"%@",myDictionary[@"code"]]];
//    self.preferentialMoney = [myDictionary[@"discount"] floatValue];//修改使用的优惠劵金额
//    self.couponContent.text = [NSString stringWithFormat:@"- ￥%.2f",self.preferentialMoney];
//    self.couponContent.textColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
//    
//}

#pragma mark cell代理方法
//修改商品信息
- (void)getDictionary:(NSDictionary *)currenDictionary {
    NSLog(@"修改商品%@！！！！！",currenDictionary);
    
    int index = -1;
    
    for (int i=0; i<self.updateCommodityArray.count; i++) {
        NSDictionary *myDictionary = self.updateCommodityArray[i];
        if (currenDictionary[@"product_id"]==myDictionary[@"product_id"]) {
            index = i;
        }
    }
    if (index==-1) {//将修改后的数据加入到数组里
        [self.updateCommodityArray addObject:currenDictionary];
    }else{
        self.updateCommodityArray[index] = currenDictionary;
    }
    if ([currenDictionary[@"state"] integerValue]==0) {
        self.orderCount -= [currenDictionary[@"price"] floatValue];
    }else{
        self.orderCount += [currenDictionary[@"price"] floatValue];
    }
    //重新计算总金额
    //    for (int i=0; i<self.commodityArray.count; i++) {
    //        NSDictionary *myDictionary = self.commodityArray[i];
    //        if (currenDictionary[@"product_id"]==myDictionary[@"product_id"]) {
    //            self.commodityArray[i] = currenDictionary;
    //        }
    //
    //    }
    self.payTitleContent.text = [NSString stringWithFormat:@"￥%.2f元",self.orderCount];
}

#pragma mark - textFile代理
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewShouldEndEditing:");
    currentTextField = textView;
    if ([textView.text isEqualToString:@" 备注"]) {
        textView.text = @"";
        textView.textColor = fontGrayColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textViewDidEndEditing:");
    currentTextField = nil;
    if (textView.text.length<1) {
        textView.text = @" 备注";
         textView.textColor = fontDilutedGrayColor;
    }
}

//因为多行输入，所以回车键有可能具有编写需要
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [currentTextField resignFirstResponder];
        return NO;
    }
    return YES;
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"touchesbegan:withevent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

@end
