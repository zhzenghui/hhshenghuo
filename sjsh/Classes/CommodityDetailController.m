//
//  CommodityDetailController.m
//  sjsh
//
//  Created by savvy on 15/11/18.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CommodityDetailController.h"
#import "MyAlertView.h"
#import "ShoppingCartController.h"
#import "AppraiseCell.h"
#import "AddOrderViewController.h"
#import "SpecificationsCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface CommodityDetailController ()

@property (nonatomic, strong)  UIScrollView *pageScrollView;//页面滚动视图

@property (nonatomic, strong)  MyAlertView *promptAlert;//添加购物车信息提示
@property (nonatomic, strong)  UIButton *collectButton;//收藏
@property (nonatomic, strong)  UIButton *addCartButton;//加入购物车
@property (nonatomic, strong)  UIButton *patButton;//购买
@property (nonatomic, strong)  UIScrollView *commodityScroll;//图片滚动栏
@property (nonatomic, strong)  UIPageControl *bannerPageControl;    //广告横幅的指示器
@property (nonatomic, strong)  UIImageView *lineImageView;    //波浪分割线
@property (nonatomic, strong)  UILabel *commodityNameLabel;    //商品姓名
@property (nonatomic, strong)  UILabel *commodityDescribeLabel;    //商品描述

@property (nonatomic, strong)  UIView *priceInfoView;    //价格信息区域
@property (nonatomic, strong)  UILabel *nowMoneyLable;    //现在价格
@property (nonatomic, strong)  UILabel *oldMoneyLable;    //过去价格
@property (nonatomic, strong)  UILabel *memberMoneyLable;    //会员价格
@property (nonatomic, strong)  UIButton *shareButton;//分享按钮

//@property (nonatomic, strong)  UIView *specificationsView;    //规格区域
//@property (nonatomic, strong)  UILabel *specificationsTitle;    //规格
//@property (nonatomic, strong)  UILabel *specificationsNumber;    //规格数值
//@property (nonatomic, strong)  UIImageView *specificationsArrow;    //规格箭头

@property (nonatomic, strong)  UIView *deliverInfoView;    //送货信息区域
@property (nonatomic, strong)  UIImageView *dengesIco;    //当日送
@property (nonatomic, strong)  UILabel *dengesLabel;
@property (nonatomic, strong)  UIImageView *freeShippingIco;    //免运费
@property (nonatomic, strong)  UILabel *freeShippingLabel;
@property (nonatomic, strong)  UIImageView *cashOnDeliveryIco;    //货到付款
@property (nonatomic, strong)  UILabel *cashOnDeliveryLabel;

@property (nonatomic, strong)  UIView *changeView;    //视图切换区域
@property (nonatomic, strong)  UIButton *detailButton;    //商品详情
@property (nonatomic, strong)  UIView *detailFlagView;
@property (nonatomic, strong)  UIButton *appraiseButton;    //评价
@property (nonatomic, strong)  UIView *appraiseFlagView;

//@property (nonatomic, strong)  UILabel *detailDescribeLabel;//商品详情的描述
@property (nonatomic, strong)  WKWebView *detailDescribeWeb;//商品详情的描述

@property (nonatomic, strong)  UITableView *appraiseTableView;//商品评价的内容列表

@property (nonatomic, strong)  UITableView *specificationsTableView;//商品的规格列表

@property (nonatomic, assign) NSNumber *collectId;//收藏编号
@property (nonatomic, strong)  NSArray *commodityImageArray;//顶部图片数组
@property (nonatomic, strong)  NSMutableArray *appraiseArray;//商品评价的内容数组
@property (nonatomic, strong)  NSMutableArray *specificationsArray;//商品规格数组
@property (nonatomic, strong) NSString *commoditySpecificationID;//商品规格编号

@property (nonatomic, assign) BOOL  isBuy;//是否直接购买

@property (nonatomic, assign) float special;

@property (nonatomic, strong) NSString *stringDetail;

@end

@implementation CommodityDetailController

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
    
    [super initNavBarItems:@"商品详情"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
    [super addRightButton:@"购物车" lightedImage:@"购物车" selector:@selector(gotoBuyingCarPage)];
    [super setHintNum:[[ConstObject instance] cartNum]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.appraiseArray = [[NSMutableArray alloc] init];
    self.isBuy = NO;
    //测试数据
    //    for(int i=0;i<4;i++){
    //        NSDictionary *myDictionary = [[NSDictionary alloc]init];
    //        [self.appraiseArray addObject:myDictionary];
    //    }
    
   self.stringDetail = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"product\":{\"product_id\":6848,\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"meta_description\":\"\u65b0\u7c73\u5b63--\u65b0\u7c73\u9a7e\u5230\uff0c\u5bb6\u4e2d\u5fc5\u5907\uff01\u8425\u517b\u4e30\u5bcc\uff0c\u9187\u9999\u53ef\u53e3\",\"flag\":\"0\",\"description\":\"<p style=\"line-height: 3em;\"><span style=\"font-family: \u5b8b\u4f53,SimSun; font-size: 14px;\">\u3010\u914d\u9001\u65f6\u6548\u3011<\/span><\/p><p style=\"line-height: 3em;\"><span style=\"font-family: \u5b8b\u4f53,SimSun; font-size: 14px;\">8:30~18:00\u4e0b\u5355\uff0c2\u5c0f\u65f6\u5185\u9001\u8d27\u4e0a\u95e8\uff1b18:00\u540e\u4e0b\u5355\uff0c\u6b21\u65e5\u914d\u9001\u3002<\/span><\/p><p style=\"line-height: 3em;\"><span style=\"font-family: \u5b8b\u4f53, SimSun; font-size: 14px; line-height: 48px;\">\u3010\u4ea7\u54c1\u4ecb\u7ecd\u3011<\/span><\/p><p style=\"line-height: 3em;\">&nbsp;&nbsp;<span style=\"font-size: 14px; font-family: \u5b8b\u4f53, SimSun;\">\u201c\u6cf0\u56fd\u9999\u7c73\u51fa\u798f\u6c34\uff0c\u4e2d\u56fd\u9999\u7c73\u51fa\u4e94\u5e38\u201d\u3002\u4e94\u5e38\u5e02\u56e0\u76db\u4ea7\u6709\u673a\u5927\u7c73\u800c\u540d\u95fb\u5929\u4e0b\uff0c\u88ab\u8a89\u4e3a\u4e2d\u56fd\u7684\u201c\u6709\u673a\u6c34\u7a3b\u738b\u56fd\u201d<span style=\"font-size: 14px; line-height: 3em;\">\u4e94\u5e38\u5927\u7c73\u9897\u7c92\u9971\u6ee1,\u8d28\u5730\u575a\u786c,\u8272\u6cfd\u6e05\u767d\u900f\u660e\uff1b\u996d\u7c92\u6cb9\u4eae\uff0c\u9999\u5473\u6d53\u90c1\uff0c\u662f\u65e5\u5e38\u751f\u6d3b\u4e2d\u505a\u7c73\u996d\u7684\u4f73\u54c1\u3002\u4e94\u5e38\u5927\u7c73\u7d20\u6709\u201c\u8d21\u7c73\u201d\u4e4b\u79f0\u3002<\/span><\/span><span style=\"font-family: \u5b8b\u4f53, SimSun; font-size: 14px; line-height: 3em;\">\u53d7\u4ea7\u533a\u72ec\u7279\u7684\u5730\u7406\u3001\u6c14\u5019\u7b49\u56e0\u7d20\u5f71\u54cd\uff0c\u4e14\u6c34\u7a3b\u6210\u719f\u671f\u4ea7\u533a\u663c\u591c\u6e29\u5dee\u5927\uff0c\u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\u4e2d\u53ef\u901f\u6eb6\u7684\u53cc\u94fe\u7cd6\u79ef\u7d2f\u8f83\u591a\uff0c\u5bf9\u4eba\u4f53\u5065\u5eb7\u975e\u5e38\u6709\u76ca\u3002<\/span><\/p><p><br\/><\/p>\",\"price\":35,\"special\":35,\"member_price\":33,\"yunfei\":\"\u65e0\u8fd0\u8d39\",\"payment_method\":\"\u5168\u573a\u514d\u8fd0\u8d39\",\"delivery_speed\":\"\u5f53\u65e5\u9001\",\"images\":[\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151013\/1444723326441545-640x480.jpg\"],\"is_collection\":0,\"count_comment\":133,\"score\":5,\"carnum\":0,\"review_comment\":[{\"avatar\":\"\",\"review_id\":\"766\",\"images\":[],\"author\":\"\u51e1\u51e1\u4e70\u83dc\",\"rating\":\"5\",\"text\":\"\u4e1c\u897f\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-09 13:19:02\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"754\",\"images\":[],\"author\":\"WSNDKG1445591129\",\"rating\":\"5\",\"text\":\"\u975e\u5e38\u597d\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-09 12:37:00\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"761\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-09 08:25:20\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"780\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u4e1c\u897f\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-08 08:28:37\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"808\",\"images\":[],\"author\":\"jeff8288a960\",\"rating\":\"5\",\"text\":\"\u5feb\u9012\u5f88\u53ca\u65f6\uff0c\u4e1c\u897f\u4e5f\u4e0d\u9519\uff0c\u63a8\u8350\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-07 11:12:23\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"831\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u8d5e\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-06 10:10:39\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"859\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u8d5e\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-05 15:54:32\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"860\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u5f88\u597d\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-05 15:54:32\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"863\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u597d\u8bc4\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-05 15:54:32\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"882\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u8d5e\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-04 14:29:50\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"932\",\"images\":[],\"author\":\"13810653019\",\"rating\":\"5\",\"text\":\"\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 18:23:26\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"910\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u4e0b\u6b21\u8fd8\u4e70\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 16:21:00\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"913\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u4e1c\u897f\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 16:21:00\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"928\",\"images\":[],\"author\":\"\u9ed1\u9762\u7435\u9e6d520\",\"rating\":\"5\",\"text\":\"\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 10:39:04\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"1004\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u597d\u8bc4\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 08:23:02\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"953\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u4e1c\u897f\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-12-03 08:20:52\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"1030\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u6027\u4ef7\u6bd4\u8fd8\u884c\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-11-30 08:35:42\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"1059\",\"images\":[],\"author\":\"\u594b\u6597~\",\"rating\":\"5\",\"text\":\"\u8d5e\uff01\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-11-29 08:47:07\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"1075\",\"images\":[],\"author\":\"13501361087\",\"rating\":\"5\",\"text\":\"\u4e1c\u897f\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-11-28 11:44:12\",\"date_modified\":\"0000-00-00 00:00:00\"},{\"avatar\":\"\",\"review_id\":\"1126\",\"images\":[],\"author\":\"13522662916\",\"rating\":\"5\",\"text\":\"\u4e0d\u9519\u3002\",\"rw_text\":\"\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35.0000\",\"image\":\"cache\/data\/20151013\/1444723326441545.jpg\",\"date_added\":\"2015-11-28 10:42:17\",\"date_modified\":\"0000-00-00 00:00:00\"}]},\"specification\":[{\"product_option_id\":1216,\"option_id\":91,\"name\":\"e\u7ad9\u7c73\",\"type\":\"radio\",\"option_value\":[{\"product_option_value_id\":2136,\"option_value_id\":661,\"name\":\"5kg\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/no_image-50x50.jpg\",\"price\":0,\"quantity\":0,\"subtract\":\"0\",\"price_prefix\":\"+\",\"prefixprice\":\"0.0000\"},{\"product_option_value_id\":2137,\"option_value_id\":662,\"name\":\"10kg\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/no_image-50x50.jpg\",\"price\":0,\"quantity\":0,\"subtract\":\"0\",\"price_prefix\":\"+\",\"prefixprice\":\"35.0000\"},{\"product_option_value_id\":2138,\"option_value_id\":663,\"name\":\"25kg\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/no_image-50x50.jpg\",\"price\":0,\"quantity\":0,\"subtract\":\"0\",\"price_prefix\":\"+\",\"prefixprice\":\"140.0000\"}],\"required\":\"0\"}]}}";
    
    //按钮区域
    self.patButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.32-10, ScreenHeight-64-60, ScreenWidth*0.32, 50)];
    self.patButton.tag = 0;
    [self.patButton addTarget:self action:@selector(buyCommodity:) forControlEvents:UIControlEventTouchUpInside];
    [self.patButton setTitle:@"购 买" forState:UIControlStateNormal];
    self.patButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.patButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:122.0/255.0 blue:3.0/255.0 alpha:1.0];
    self.patButton.layer.cornerRadius = 5;
    self.patButton.layer.masksToBounds = YES;
    [self.patButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.patButton];
    
    
    
    self.addCartButton = [[UIButton alloc]initWithFrame:CGRectMake(self.patButton.frame.origin.x-ScreenWidth*0.32-7, ScreenHeight-64-60, ScreenWidth*0.32, 50)];
    self.addCartButton.tag = 1;
    [self.addCartButton addTarget:self action:@selector(buyCommodity:) forControlEvents:UIControlEventTouchUpInside];
    [self.addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    self.addCartButton.backgroundColor = kRedColor;
    self.addCartButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.addCartButton.layer.cornerRadius = 5;
    self.addCartButton.layer.masksToBounds = YES;
    [self.addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.addCartButton];
    
    self.collectButton = [[UIButton alloc]initWithFrame:CGRectMake(15, ScreenHeight-64-60, self.addCartButton.frame.origin.x-10, 50)];
    [self.collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.collectButton addTarget:self action:@selector(collectCommodity:) forControlEvents:UIControlEventTouchUpInside];
    [self.collectButton setImage:[UIImage imageNamed:@"collect_none"] forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    [self.collectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [self.collectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];//4个参数是上边界，左边界，下边界，右边界。
    self.collectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.collectButton];
    
    UIView *buttonLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.patButton.frame.origin.y-10, ScreenWidth, 0.5)];
    buttonLine.backgroundColor = lineGrayColor;
    [self.view addSubview:buttonLine];
    
    
    //页面整体滚动视图
    self.pageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-70)];
    self.pageScrollView.contentSize=CGSizeMake(self.pageScrollView.bounds.size.width, 800);
    self.pageScrollView.showsHorizontalScrollIndicator=NO;
    self.pageScrollView.showsVerticalScrollIndicator=NO;
    //    self.pageScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.pageScrollView];
    
    //图片滚动栏
    self.commodityScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.7)];
    self.commodityScroll.delegate=self;
    self.commodityScroll.pagingEnabled=YES;        //整页滚动
    self.commodityScroll.bounces=NO;
    self.commodityScroll.alwaysBounceVertical=NO;
    self.commodityScroll.alwaysBounceHorizontal=YES;
    self.commodityScroll.showsHorizontalScrollIndicator=NO;
    self.commodityScroll.showsVerticalScrollIndicator=NO;
    [self.pageScrollView addSubview:self.commodityScroll];
    
    self.bannerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.commodityScroll.frame.size.height-30, ScreenWidth, 20)];
    self.bannerPageControl.tag=198821;
    //        self.bannerPageControl.numberOfPages = 6-2;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    //        self.bannerPageControl.currentPage=0;
    [self.pageScrollView addSubview:self.bannerPageControl];
    
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.commodityScroll.frame.origin.y+self.commodityScroll.frame.size.height-3, ScreenWidth, 3)];
    self.lineImageView.image = [UIImage imageNamed:@"wave"];
    [self.pageScrollView addSubview:self.lineImageView];
    
    self.commodityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.lineImageView.frame.origin.y+self.lineImageView.frame.size.height+10, ScreenWidth-20, 0)];
    self.commodityNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.commodityNameLabel.numberOfLines = 0;
    self.commodityNameLabel.text = @"暂无";
    self.commodityNameLabel.textColor = fontGrayColor;
    self.commodityNameLabel.font = [UIFont systemFontOfSize:16];
    [self.pageScrollView addSubview:self.commodityNameLabel];
    
    self.commodityDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.commodityNameLabel.frame.origin.y+self.commodityNameLabel.frame.size.height, ScreenWidth-20, 0)];
    //自动折行设置
    self.commodityDescribeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.commodityDescribeLabel.numberOfLines = 0;
    self.commodityDescribeLabel.text = @"暂无";
    self.commodityDescribeLabel.font = [UIFont systemFontOfSize:13];
    self.commodityDescribeLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    [self.pageScrollView addSubview:self.commodityDescribeLabel];
    
    //价格信息区域
    self.priceInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.commodityDescribeLabel.frame.origin.y+self.commodityDescribeLabel.frame.size.height+0, ScreenWidth, 65)];
    //    self.priceInfoView.backgroundColor = kGreenColor;
    [self.pageScrollView addSubview:self.priceInfoView];
    
    
    self.nowMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(10.5, 15, 80, 15)];
    self.nowMoneyLable.text = @"￥0元";
    self.nowMoneyLable.textColor = kRedColor;
    self.nowMoneyLable.font = [UIFont systemFontOfSize:22];
    [self.priceInfoView addSubview:self.nowMoneyLable];
    
    
    self.oldMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(90, 18, 70, 15)];
    self.oldMoneyLable.text = @"￥0元";
    self.oldMoneyLable.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    self.oldMoneyLable.textAlignment = NSTextAlignmentCenter;
    self.oldMoneyLable.font = [UIFont systemFontOfSize:16];
    [self.priceInfoView addSubview:self.oldMoneyLable];
    
    UIView *oldMoneyFlag = [[UIView alloc] initWithFrame:CGRectMake(85, self.oldMoneyLable.frame.origin.y+self.oldMoneyLable.frame.size.height-7, 75, 1)];
    oldMoneyFlag.backgroundColor = kGrayColor;
    [self.priceInfoView addSubview:oldMoneyFlag];
    
    self.memberMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(15, self.oldMoneyLable.frame.origin.y+self.oldMoneyLable.frame.size.height+12, 120, 20)];
    self.memberMoneyLable.text = @"会员价￥0元";
    self.memberMoneyLable.backgroundColor = kRedColor;
    self.memberMoneyLable.textColor = [UIColor whiteColor];
    self.memberMoneyLable.textAlignment = NSTextAlignmentCenter;
    self.memberMoneyLable.layer.cornerRadius = 3;
    self.memberMoneyLable.layer.masksToBounds = YES;
    self.memberMoneyLable.font = [UIFont systemFontOfSize:14];
    [self.priceInfoView addSubview:self.memberMoneyLable];
    
    self.shareButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-40, self.memberMoneyLable.frame.origin.y+self.memberMoneyLable.frame.size.height-25, 30, 25)];
    [self.shareButton setImage:[UIImage imageNamed:@"commodity_share"] forState:UIControlStateNormal];
    self.shareButton.hidden = YES;
    [self.priceInfoView addSubview:self.shareButton];
    
    
    //    @property (nonatomic, strong)  UIView *specificationsView;    //规格区域
    //    @property (nonatomic, strong)  UILabel *specificationsTitle;    //规格
    //    @property (nonatomic, strong)  UILabel *specificationsNumber;    //规格数值
    //    @property (nonatomic, strong)  UIImageView *specificationsArrow;    //规格箭头
    
    //    self.specificationsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.memberMoneyLable.frame.origin.y+self.memberMoneyLable.frame.size.height+20, ScreenWidth, 50)];
    //    self.specificationsView.backgroundColor = dilutedGrayColor;
    //       [self.pageScrollView addSubview:self.specificationsView];
    
    self.specificationsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.priceInfoView.frame.origin.y+self.priceInfoView.frame.size.height+20, ScreenWidth, 0)];
    self.specificationsTableView.tag = 198812;
    self.specificationsTableView.delegate = self;
    self.specificationsTableView.dataSource = self;
    //    self.specificationsTableView.hidden = YES;
    self.specificationsTableView.showsVerticalScrollIndicator =
    NO;
    self.specificationsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.specificationsTableView.backgroundColor = dilutedGrayColor;
    [self.pageScrollView addSubview:self.specificationsTableView];
    
    
    
    
    
    //    self.specificationsTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, self.specificationsView.frame.size.height)];
    //    self.specificationsTitle.text = @"规格";
    //    self.specificationsTitle.font = [UIFont systemFontOfSize:14];
    //    [self.specificationsView addSubview:self.specificationsTitle];
    //
    //    self.specificationsNumber = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 70, self.specificationsView.frame.size.height)];
    //    self.specificationsNumber.text = @"￥0g";
    //    self.specificationsNumber.textColor = kGreenColor;
    //     self.specificationsNumber.font = [UIFont systemFontOfSize:14];
    //    [self.specificationsView addSubview:self.specificationsNumber];
    //
    //    self.specificationsArrow = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-20, 0, 7, self.specificationsView.frame.size.height)];
    //    self.specificationsArrow.image = [UIImage imageNamed:@"icon_right_arrow"];
    //    self.specificationsArrow.contentMode = UIViewContentModeScaleAspectFit;
    //    [self.specificationsView addSubview:self.specificationsArrow];
    
    
    //送货信息区域
    self.deliverInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.specificationsTableView.frame.origin.y+self.specificationsTableView.frame.size.height, ScreenWidth, 50)];
    self.deliverInfoView.backgroundColor = kGreenColor;
    [self.pageScrollView addSubview:self.deliverInfoView];
    
    
    self.dengesIco = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 13, self.deliverInfoView.frame.size.height)];
    self.dengesIco.image = [UIImage imageNamed:@"denges_flag"];
    self.dengesIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.deliverInfoView addSubview:self.dengesIco];
    
    self.dengesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.dengesIco.frame.origin.x+self.dengesIco.frame.size.width+9, 0, 70, self.deliverInfoView.frame.size.height)];
    self.dengesLabel.text = @"当日送";
    self.dengesLabel.font = [UIFont systemFontOfSize:14];
    self.dengesLabel.textColor = [UIColor whiteColor];
    [self.deliverInfoView addSubview:self.dengesLabel];
    
    
    self.freeShippingLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.584-70, 0, 70, self.deliverInfoView.frame.size.height)];
    self.freeShippingLabel.text = @"免运费";
    self.freeShippingLabel.textColor = [UIColor whiteColor];
    self.freeShippingLabel.font = [UIFont systemFontOfSize:14];
    [self.deliverInfoView addSubview:self.freeShippingLabel];
    
    self.freeShippingIco = [[UIImageView alloc] initWithFrame:CGRectMake(self.freeShippingLabel.frame.origin.x-13-9, 0, 13, self.deliverInfoView.frame.size.height)];
    self.freeShippingIco.image = [UIImage imageNamed:@"denges_flag"];
    self.freeShippingIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.deliverInfoView addSubview:self.freeShippingIco];
    
    
    self.cashOnDeliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-120, 0, 100, self.deliverInfoView.frame.size.height)];
    self.cashOnDeliveryLabel.text = @"只支持货到付款";
    self.cashOnDeliveryLabel.font = [UIFont systemFontOfSize:14];
    self.cashOnDeliveryLabel.textAlignment = NSTextAlignmentRight;
    self.cashOnDeliveryLabel.textColor = [UIColor whiteColor];
    [self.deliverInfoView addSubview:self.cashOnDeliveryLabel];
    
    self.cashOnDeliveryIco = [[UIImageView alloc] initWithFrame:CGRectMake(self.cashOnDeliveryLabel.frame.origin.x-13-9+3, 0, 13, self.deliverInfoView.frame.size.height)];
    self.cashOnDeliveryIco.image = [UIImage imageNamed:@"denges_flag"];
    self.cashOnDeliveryIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.deliverInfoView addSubview:self.cashOnDeliveryIco];
    
    //视图切换区域
    
    self.changeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.deliverInfoView.frame.origin.y+self.deliverInfoView.frame.size.height, ScreenWidth, 50)];
    self.changeView.backgroundColor = [UIColor whiteColor];
    CALayer *changeViewTopBorder=[[CALayer alloc]init];
    changeViewTopBorder.frame=CGRectMake(0, self.changeView.frame.size.height-0.5, self.changeView.frame.size.width, 0.5);
    changeViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.changeView.layer addSublayer:changeViewTopBorder];
    [self.pageScrollView addSubview:self.changeView];
    
    self.detailButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (ScreenWidth-20)*0.5, self.changeView.frame.size.height)];
    [self.detailButton setTitle:@"商品详情" forState:UIControlStateNormal];
    [self.detailButton setTitleColor:kRedColor forState:UIControlStateNormal];
    self.detailButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.detailButton.tag = 198801;
    [self.detailButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeView addSubview:self.detailButton];
    
    self.detailFlagView = [[UIView alloc] initWithFrame:CGRectMake(10, self.changeView.frame.size.height-2.5, (ScreenWidth-20)*0.5, 2.5)];
    self.detailFlagView.backgroundColor = kRedColor;
    [self.changeView addSubview:self.detailFlagView];
    
    self.appraiseButton = [[UIButton alloc] initWithFrame:CGRectMake(10+(ScreenWidth-20)*0.5, 0, (ScreenWidth-20)*0.5, self.changeView.frame.size.height)];
    [self.appraiseButton setTitle:@"评价" forState:UIControlStateNormal];
    self.appraiseButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.appraiseButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
    self.appraiseButton.tag = 198802;
    [self.appraiseButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeView addSubview:self.appraiseButton];
    
    self.appraiseFlagView = [[UIView alloc] initWithFrame:CGRectMake(10+(ScreenWidth-20)*0.5, self.changeView.frame.size.height-2.5, (ScreenWidth-20)*0.5, 2.5)];
    self.appraiseFlagView.backgroundColor = kRedColor;
    self.appraiseFlagView.hidden = YES;
    [self.changeView addSubview:self.appraiseFlagView];
    
    //    self.detailDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.changeView.frame.origin.y+self.changeView.frame.size.height, ScreenWidth-20, 100)];
    //    self.detailDescribeLabel.text = @"只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款只支持货到付款";
    //    self.detailDescribeLabel.textColor = fontGrayColor;
    //    self.detailDescribeLabel.font = [UIFont systemFontOfSize:14];
    //    self.detailDescribeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    self.detailDescribeLabel.numberOfLines = 0;
    //    [self.pageScrollView addSubview:self.detailDescribeLabel];
    
    self.detailDescribeWeb = [[WKWebView alloc] initWithFrame:CGRectMake(15, self.changeView.frame.origin.y+self.changeView.frame.size.height, ScreenWidth-20, 100)];
    [self.pageScrollView addSubview:self.detailDescribeWeb];
    //    NSString *productURL = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/product/productdetail&product_id=6930"];
    //    NSURL *urlS = [[NSURL alloc] initWithString:productURL];
    //    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlS];
    //    [req setTimeoutInterval:300];
    //    [self.detailDescribeWeb loadRequest:req];
    
    self.appraiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.changeView.frame.origin.y+self.changeView.frame.size.height, ScreenWidth, 400)];
    self.appraiseTableView.tag = 198811;
    self.appraiseTableView.delegate = self;
    self.appraiseTableView.dataSource = self;
    self.appraiseTableView.hidden = YES;
    self.appraiseTableView.showsVerticalScrollIndicator =
    NO;
    self.appraiseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.appraiseTableView.backgroundColor = [UIColor whiteColor];
    [self.appraiseTableView setTableFooterView:[[UIView alloc]init]];
    [self.pageScrollView addSubview:self.appraiseTableView];
    
    
    //已成功添加购物车提示视图
    self.promptAlert=[[MyAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width*0.8, 100)];
    self.promptAlert.center=self.view.center;
    //    self.promptAlert.translatesAutoresizingMaskIntoConstraints = NO;
    self.promptAlert.hidden=YES;
    self.promptAlert.layer.cornerRadius = 8;
    
    self.promptAlert.layer.masksToBounds = YES;
    [self.view addSubview:self.promptAlert];
    
    self.collectId = [NSNumber numberWithInt:0];//默认没有收藏
    [self getProductDetail];//调用接口数据
}

//获取商品详情接口
- (void)getProductDetail
{
    [super showGif];
    [commonModel requestproductview:self.productID httpRequestSucceed:@selector(getProducViewSuccess:) httpRequestFailed:@selector(requestFailed:)];
    //    服务类的3440 积分的 3589
    //    [commonModel requestproductview:@"3589"
    //                 httpRequestSucceed:@selector(getProducViewSuccess:) httpRequestFailed:@selector(getProducViewFailed:)];
}

//获取商品详情接口调用成功
- (void)getProducViewSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"获取商品详情dic%@!!!",completeDic);
    if (completeDic == nil) {
        return;
    }
    NSDictionary *dic = [completeDic objectForKey:@"result"];
    //    int flag = [[[dic objectForKey:@"product"] objectForKey:@"flag"] intValue];取消积分商品
    [self viewDidLayoutSubviews];
    self.productDic = dic;
    
    
    NSArray *specificationDictionary = dic[@"specification"];
    //        NSLog(@"商品规格为%@!!!!!",specificationDictionary[0][@"product_option_id"]);
    if(specificationDictionary&&specificationDictionary.count>0){
        self.commoditySpecificationID = [ NSString stringWithFormat:@"%ld", (long)[specificationDictionary[0][@"product_option_id"] integerValue] ];
    }
    [self setinforWithDic:[self.productDic objectForKey:@"product"]];//给页面控件填充数据
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    myDictionary[@"page"] = [NSString stringWithFormat:@"%d",1];
    myDictionary[@"limit "] = [NSString stringWithFormat:@"%d",10];
    myDictionary[@"waitp"] = @"";
    
    
    
    
    
    NSLog(@"提交订单的参数为：%@!!!!!!!!!!!!!!",myDictionary);
    [commonModel requestcomment:myDictionary httpRequestSucceed:@selector(getCommentSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"接口调用失败dic%@",dic);
}

//获取评价数据调用成功(暂时没有数据)
- (void)getCommentSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *commentDic = [super parseJsonRequest:request];
    NSLog(@"获取评价数据dic%@！！！！！！！！！！！！",commentDic);
    
    
}

//给页面控件填充数据
- (void)setinforWithDic:(NSDictionary *)dic
{
    NSLog(@"获取商品详情页面数据%@!!!!!!!!!!!!!!!",dic);
    
    //填充评价列表数据
    self.appraiseArray = dic[@"review_comment"];
    NSLog(@"评价页面数据%@!!!!!!",self.appraiseArray);
    if (self.appraiseArray&&self.appraiseArray.count>0) {
        [self.appraiseTableView reloadData];
    }
    
    
    
    NSString *name = [dic objectForKey:@"name"];
    NSString *meta_description = [dic objectForKey:@"meta_description"];
    NSNumber *price = [dic objectForKey:@"price"];
    self.special  = [[dic objectForKey:@"special"] floatValue];
    //    if (special.floatValue<=0) {
    //        special = price;
    //    }
    NSNumber *count_comment = [dic objectForKey:@"count_comment"];
    NSNumber *score = [dic objectForKey:@"score"];
    self.commodityImageArray = [dic objectForKey:@"images"];
    //    NSString *yunfei = [dic objectForKey:@"yunfei"];
    NSString *payment_method = [dic objectForKey:@"payment_method"];
    NSString *delivery_speed = [dic objectForKey:@"delivery_speed"];
    NSNumber *collect = [dic objectForKey:@"is_collection"];
    if ([collect integerValue]==0) {
        self.collectButton.tag = 0;
        [self.collectButton setImage:[UIImage imageNamed:@"collect_none"] forState:UIControlStateNormal];
        [self.collectButton setTitle:@" 收藏" forState:UIControlStateNormal];
    }
    else {
        self.collectId = collect;
        self.collectButton.tag = 1;
        [self.collectButton setImage:[UIImage imageNamed:@"collect_already"] forState:UIControlStateNormal];
        [self.collectButton setTitle:@" 已收藏" forState:UIControlStateNormal];
    }
    
    self.commodityNameLabel.text = name;
    self.commodityDescribeLabel.text = meta_description;
    self.nowMoneyLable.text = [NSString stringWithFormat:@"￥%.1f",self.special];
    self.oldMoneyLable.text = [NSString stringWithFormat:@"￥%.1f",[price floatValue]];
    if([dic objectForKey:@"member_price"]&&[[dic objectForKey:@"member_price"] floatValue]>0){
    self.memberMoneyLable.text = [NSString stringWithFormat:@"会员价￥%.1f",[[dic objectForKey:@"member_price"] floatValue]];
    }else{
        self.memberMoneyLable.hidden = YES;
    }
    
    //    self.detailDescribeLabel.text = [dic objectForKey:@"description"];
    NSString *productURL = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/product/productdetail&product_id=%@",[dic objectForKey:@"product_id"]];
    NSURL *urlS = [[NSURL alloc] initWithString:productURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlS];
    [req setTimeoutInterval:300];
    [self.detailDescribeWeb loadRequest:req];
    
    if ([[self.productDic objectForKey:@"specification"] count]>0) {
        self.specificationsArray = [[self.productDic objectForKey:@"specification"][0][@"option_value"] mutableCopy];
        for (int i=0; i<self.specificationsArray.count; i++) {
            NSMutableDictionary *myDictionary = [self.specificationsArray[i] mutableCopy];
            if (i==0) {
                myDictionary[@"selectFlag"] = @"1";
            }else{
                myDictionary[@"selectFlag"] = @"0";
            }
            self.specificationsArray[i] = myDictionary;
        }
        
        
    }else{
        self.specificationsArray = [[NSMutableArray alloc]init];
    }
    NSLog(@"获取的商品规格%@!!!!",self.specificationsArray);
    
    NSNumber *specificationsCount = [NSNumber numberWithInteger:self.specificationsArray.count];
    
    [self performSelectorOnMainThread:@selector(UPdateViewsHeight:) withObject:specificationsCount waitUntilDone:NO];
    [self.specificationsTableView reloadData];
    
    
    //    if (specification &&specification.count>0) {    //规格点击事件
    //        self.specificationsNumber.text = [[specification[0] objectForKey:@"option_value"][0]objectForKey:@"name"];//[NSString stringWithFormat:@"%@,%@",payment_method,delivery_speed];
    //        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSpecifications:)];
    //        [self.specificationsView addGestureRecognizer:tapGesture];
    //    }else{
    //    self.specificationsNumber.text = @"默认规格";
    //    }
    
    
    //    self.imageURLs = [NSMutableArray arrayWithCapacity:0];
    //    for (NSString *urlStr in images) {
    //
    //        [self.imageURLs addObject:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //    }
    //    [self.imagePlayerView initWithCount:images.count delegate:self];
    //    [self.tableView reloadData];
    
    
    
    
    
    //*************************************************
    
    
    
    self.commodityScroll.contentSize=CGSizeMake(self.commodityScroll.bounds.size.width*(self.commodityImageArray.count), 1);
    [self.bannerPageControl setNumberOfPages:self.commodityImageArray.count];
    [self.bannerPageControl setCurrentPage:0];
    //加载页面显示数据
    for(int i=0;i<self.commodityImageArray.count;i++){
        NSString *imageUrl = self.commodityImageArray[i];
        
        UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.commodityScroll.frame.size.width, 0, self.commodityScroll.frame.size.width, self.commodityScroll.frame.size.height)];
        [imageview setImageWithURL:[NSURL URLWithString:imageUrl]];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.tag = i;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPreferentialImageView:)];
        [imageview addGestureRecognizer:singleTap1];
        
        [self.commodityScroll addSubview:imageview];
    }
    
}

//购买商品
- (void)buyCommodity:(UIButton *)myButton {
    
    //    SKUViewController *skuController = [[SKUViewController alloc] init];
    
    if (myButton.tag == 0) {
        //        skuController.type = onceBuy;
        self.isBuy = YES;
    }
    else {
        //        skuController.type = AddToCart;
        self.isBuy = NO;
        
    }
    
    //    NSLog(@"商品信息为：%@!!!",self.productDic);
    if (self.productDic&&[self.productDic objectForKey:@"product"]) {//商品页面未加载完或者没有数据时
        
        NSDictionary *product = [self.productDic objectForKey:@"product"];
        NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
        [addDic setObject:[product objectForKey:@"product_id"] forKey:@"product_id"];
        
        NSIndexPath *indexPath = [self.specificationsTableView indexPathForSelectedRow];
        
        //    NSLog(@"选择的是第%ld行:%@!!!!!!",(long)indexPath.row,self.specificationsArray[indexPath.row]);
        
        if(self.specificationsArray.count>0){
            NSDictionary *specificationsDictionary =  self.specificationsArray[indexPath.row];
            [addDic setObject:[specificationsDictionary objectForKey:@"product_option_value_id"] forKey:[NSString stringWithFormat:@"option[%@]",self.commoditySpecificationID ]];
            
            //         [addDic setObject:[specificationsDictionary objectForKey:@"product_option_value_id"] forKey:@"product_option_value_id"];
            //         [addDic setObject:self.commoditySpecificationID forKey:@"product_option_id"];
        }
        
        
        [addDic setObject:@"1" forKey:@"quantity"];
        
        [super showGif];
        
        if(self.isBuy){//直接购买，同时添加到订单页面
            NSMutableArray *addArray = [[NSMutableArray alloc]init];
            
            
            NSMutableDictionary *addDictionary = [[NSMutableDictionary alloc]init];
            [addDictionary setObject:[product objectForKey:@"product_id"] forKey:@"product_id"];
            [addDictionary setObject:@"1" forKey:@"quantity"];
            //             [addDictionary setObject:[myDictionary objectForKey:@"option"] forKey:@"option"];
            //规格
            NSMutableDictionary *optionDictionary = [[NSMutableDictionary alloc]init];
            if(self.specificationsArray.count>0){
                NSDictionary *specificationsDictionary =  self.specificationsArray[indexPath.row];
                optionDictionary[self.commoditySpecificationID] = [specificationsDictionary objectForKey:@"product_option_value_id"];
                
            }
            [addDictionary setObject:optionDictionary forKey:@"option"];
            [addArray addObject:addDictionary];
            
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization
                                dataWithJSONObject:addArray options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"所添加的订单页的商品为%@!!!!!",jsonString);
            
            NSMutableDictionary *parameterDcitionary = [[NSMutableDictionary alloc]init];parameterDcitionary[@"products"] = jsonString;
            
            [commonModel addOrderCartByPost:parameterDcitionary httpRequestSucceed:@selector(addOrderCartByPostSuccess:) httpRequestFailed:@selector(requestFailed:)];
            
            
        }else{  //添加到购物车
            NSLog(@"加入购物车的参数为%@！！！！！",addDic);
            [commonModel requestAddtoCart:addDic httpRequestSucceed:@selector(AddtoCartSuccess:) httpRequestFailed:@selector(AddtoCartFail:)];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:0.5f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:self.promptAlert
                                        repeats:NO];
        
        
    }else{
        NSLog(@"请稍后再试！");
    }
    //    skuController.delegate = self;
    //    skuController.productDic = self.productDic;
    //    NSArray *specification = [self.productDic objectForKey:@"specification"];
    //    if (specification &&specification.count>0) {
    //        skuController.view.frame = self.navigationController.view.bounds;
    //        [self.navigationController.view addSubview:skuController.view];
    //    }
    //    else{
    //        [skuController goToPay:nil];
    //        self.promptAlert.hidden=NO;
    
    //    }
    
}


//批量添加订单商品成功
- (void)addOrderCartByPostSuccess:(ASIHTTPRequest *)request
{
    NSLog(@"批量添加订单商品成功dic%@",request.responseString);
    
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"批量添加订单商品成功：%@",completeDic);
    //    NSString *code = [completeDic objectForKey:@"code"];
    
    if([[completeDic objectForKey:@"code"] integerValue]==200){//进入下单页
        AddOrderViewController *myViewController = [[AddOrderViewController alloc] init];
        myViewController.isFirst = YES;
        myViewController.isAll = YES;
        [self.navigationController pushViewController:myViewController animated:YES];
    }
}

- (void)AddtoCartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"添加购物车成功dic%@！！！！！！",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            
            if (self.isBuy) {
                //进入下单页
                //                [self enterNetPageForOrder];
                
            }
            else {
                //                if(self.delegate && [self.delegate respondsToSelector:@selector(refreashCartNum)]){
                //                    [self.delegate refreashCartNum];
                //                }
                [self refreashCartNum];
                
                msg = @"已成功添加到购物车";
            }
            break;
        case 6002:
            //添加成功
            msg = @"参数错误";
            break;
        case 6003:
            //添加成功
            msg = @"请选择规格";
            break;
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        [alert show];
    }
    
}

- (void)AddtoCartFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}


//收藏商品
- (void)collectCommodity:(UIButton *)myButton {
    if (self.collectId.integerValue == 0) {
        
        [super showGif];
        [commonModel requestAddFavorite:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"type",[[_productDic objectForKey:@"product"] objectForKey:@"product_id"],@"obj_id", nil] httpRequestSucceed:@selector(AddFavoriteSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    else {
        [super showGif];
        [commonModel requestDeleteFavorite:[NSDictionary dictionaryWithObjectsAndKeys:self.collectId,@"id", nil] httpRequestSucceed:@selector(delFavoriteSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}

//选择规格
- (void)selectSpecifications:(id)sender{
    SKUViewController *skuController = [[SKUViewController alloc] init];
    skuController.type = onceBuy;
    
    skuController.delegate = self;
    skuController.productDic = self.productDic;
    NSArray *specification = [self.productDic objectForKey:@"specification"];
    if (specification &&specification.count>0) {
        skuController.view.frame = self.navigationController.view.bounds;
        [self.navigationController.view addSubview:skuController.view];
    }
    else{
        [skuController goToPay:nil];
        self.promptAlert.hidden=NO;
        [NSTimer scheduledTimerWithTimeInterval:0.5f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:self.promptAlert
                                        repeats:NO];
    }
    
    
    
}

//图片点击事件
-(void)clickPreferentialImageView:(UITapGestureRecognizer *)sender{
    
    NSLog(@"点击了图片！！！！");
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.commodityImageArray.count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [self.commodityImageArray objectAtIndex:i]; // 图片路径
        photo.srcImageView =  self.commodityScroll.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

//隐藏信息弹出框
- (void)timerFireMethod:(NSTimer*)theTimer
{
    MyAlertView *promptAlert = (MyAlertView*)[theTimer userInfo];
    promptAlert.hidden=YES;
    //    promptAlert =NULL;
}

//切换页面
- (void) changePage:(UIButton *) myButton{
    switch (myButton.tag) {
        case 198801:
            
            [self.detailButton setTitleColor:kRedColor forState:UIControlStateNormal];
            self.detailFlagView.hidden = NO;
            [self.appraiseButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
            self.appraiseFlagView.hidden = YES;
            self.detailDescribeWeb.hidden = NO;
            self.appraiseTableView.hidden = YES;
            
            self.pageScrollView.contentSize=CGSizeMake(self.pageScrollView.bounds.size.width, 800+self.specificationsTableView.frame.size.height);
            
            break;
        case 198802:
            
            [self.detailButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
            self.detailFlagView.hidden = YES;
            [self.appraiseButton setTitleColor:kRedColor forState:UIControlStateNormal];
            self.appraiseFlagView.hidden = NO;
            self.detailDescribeWeb.hidden = YES;
            self.appraiseTableView.hidden = NO;
            
            self.pageScrollView.contentSize=CGSizeMake(self.pageScrollView.bounds.size.width, 500+self.appraiseArray.count*182+self.specificationsTableView.frame.size.height);
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super getCartNum];
}


//进入购物车页面
- (void)gotoBuyingCarPage
{
    ShoppingCartController *shoppingCart = [[ShoppingCartController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
}

//返回上一页
-(void)backHomePage{
    [self.navigationController popViewControllerAnimated:YES];
}

//确认购买成功
- (void)requestCheckLoginSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [self enterOrderPage];
            
            break;
        case 1100:
            //添加成功
            //            msg = @"未登录";
            [self pushToLoginVC:NO animation:YES];
            break;
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//加入收藏成功
- (void)AddFavoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.collectId = [dic objectForKey:@"collection_id"];
        self.collectButton.tag = 1;
        [self.collectButton setImage:[UIImage imageNamed:@"collect_already"] forState:UIControlStateNormal];
        [self.collectButton setTitle:@" 已收藏" forState:UIControlStateNormal];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1402){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1403){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1404){
        
        [super showMessageBox:self title:@"" message:@"已收藏过" cancel:nil confirm:@"确定"];
        return;
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        //        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self pushToLoginVC:NO];
    }
}

//取消收藏成功
- (void)delFavoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.collectId = [NSNumber numberWithInt:0];
        self.collectButton.tag = 0;
        [self.collectButton setImage:[UIImage imageNamed:@"collect_none"] forState:UIControlStateNormal];
        [self.collectButton setTitle:@" 收藏" forState:UIControlStateNormal];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1401){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        //        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self pushToLoginVC:NO];
    }
}


//进入下单页
- (void)enterOrderPage
{
    
    AddOrderViewController *myViewController = [[AddOrderViewController alloc] init];
    myViewController.isFirst = YES;
    myViewController.isAll = YES;
    [self.navigationController pushViewController:myViewController animated:YES];
    
    
}

//修改各个视图的UI高度
- (void)UPdateViewsHeight:(NSObject *)responseData {
    NSLog(@"修改的tableView的高度为%@！！！！！", responseData);
    
    NSString *responseString = [NSString stringWithFormat:@"%@",responseData];
    
    CGSize maximumLabelSize = CGSizeMake(self.commodityNameLabel.frame.size.width, 9999);
    CGSize expectedSize = [self.commodityNameLabel sizeThatFits:maximumLabelSize];
    self.commodityNameLabel.frame = CGRectMake(self.commodityNameLabel.frame.origin.x, self.commodityNameLabel.frame.origin.y, self.commodityNameLabel.frame.size.width, expectedSize.height);
    CGSize commodityDescribeMaximumLabelSize = CGSizeMake(self.commodityDescribeLabel.frame.size.width, 9999);
    CGSize commodityDescribeSize = [self.commodityDescribeLabel sizeThatFits:commodityDescribeMaximumLabelSize];
    self.commodityDescribeLabel.frame = CGRectMake(15, self.commodityNameLabel.frame.origin.y+self.commodityNameLabel.frame.size.height, ScreenWidth-20, commodityDescribeSize.height);
    //    CGRectMake(self.commodityDescribeLabel.frame.origin.x, self.commodityDescribeLabel.frame.origin.y, self.commodityDescribeLabel.frame.size.width, commodityDescribeSize.height);
    NSLog(@"标签的高度%f和%f！！！！！", expectedSize.height,commodityDescribeSize.height);
    
    
    //存在商品描述
    //    if(self.commodityDescribeLabel.text&&![self.commodityDescribeLabel.text isEqualToString:@""]){
    //        NSLog(@"存在商品描述！！！！！");
    //        self.commodityDescribeLabel.frame = CGRectMake(15, self.commodityNameLabel.frame.origin.y+self.commodityNameLabel.frame.size.height, ScreenWidth-20, 40);
    //    }
    
    self.priceInfoView.frame = CGRectMake(0, self.commodityDescribeLabel.frame.origin.y+self.commodityDescribeLabel.frame.size.height+0, ScreenWidth, 65);
    
    self.pageScrollView.contentSize=CGSizeMake(self.pageScrollView.bounds.size.width, 800+self.specificationsTableView.frame.size.height);
    
    self.specificationsTableView.frame = CGRectMake(0, self.priceInfoView.frame.origin.y+self.priceInfoView.frame.size.height+20, ScreenWidth, [responseString integerValue]>0?50+50* [responseString integerValue]:0);
    
    
    self.deliverInfoView.frame = CGRectMake(0, self.specificationsTableView.frame.origin.y+self.specificationsTableView.frame.size.height, ScreenWidth, 50);
    
    self.changeView.frame = CGRectMake(0, self.deliverInfoView.frame.origin.y+self.deliverInfoView.frame.size.height, ScreenWidth, 50);
    
    self.detailDescribeWeb.frame = CGRectMake(15, self.changeView.frame.origin.y+self.changeView.frame.size.height, ScreenWidth-20, 100);
    
    //修改列表高度
    self.appraiseTableView.frame = CGRectMake(0, self.changeView.frame.origin.y+self.changeView.frame.size.height, ScreenWidth, self.appraiseArray.count*182+5);
    
    
}

#pragma mark 代理方法

//确认购买后的回调
- (void)enterNetPageForOrder
{
    NSLog(@"直接购买回调！！！！！！");
    
    [super showGif];
    [commonModel requestCheckLogin:nil httpRequestSucceed:@selector(requestCheckLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

//确认添加购物车回调
- (void)refreashCartNum
{
    NSLog(@"加入购物车回调！！！！！！");
    
    self.promptAlert.hidden=NO;
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:self.promptAlert
                                    repeats:NO];
    [super getCartNum];
}

#pragma mark UIScrollViewDelegate
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    //    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

//滚动结束触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    NSLog(@"scrollView  当前页数为 %d",current);
    
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:198821];
    page.currentPage = current;
    
}


#pragma marks tableView代理方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    CALayer *bottomBorder=[[CALayer alloc]init];
    bottomBorder.frame=CGRectMake(0, hView.frame.size.height, hView.frame.size.width, 0.5);
    bottomBorder.backgroundColor=lineGrayColor.CGColor;
    [hView.layer addSublayer:bottomBorder ];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 50)];
    nameLabel.text = @"规格";
    nameLabel.textColor = fontDilutedGrayColor;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [hView addSubview:nameLabel];
    
    return hView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (tableView.tag==198812) {
        height = 50;
    }else{
        height = 0;
    }
    return height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = 0.0;
    
    if (tableView.tag==198811) {
        cellHeight = 182;
        if (((NSArray *)(self.appraiseArray[indexPath.row][@"images"])).count==0) {
            cellHeight -=  58;
        }
        if ([self.appraiseArray[indexPath.row][@"text"] isEqualToString:@""]) {
            cellHeight -=  40;
        }
        
    }else {
        cellHeight = 50;
    }
    return cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger cellCount = 0.0;
    
    if (tableView.tag==198811) {
        cellCount = [self.appraiseArray count];
    }else{
        cellCount = [self.specificationsArray count];
    }
    return  cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==198811) {
        NSString *reusableIdentifier = @"AppraiseCell";
        
        AppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        
        if (!cell)
        {
            cell = [[AppraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        [cell setCellInfo:self.appraiseArray[indexPath.row]];
        
        return cell;
    }else{
        NSString *reusableIdentifier = @"SpecificationsCell";
        
        SpecificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        
        if (!cell)
        {
            cell = [[SpecificationsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        [cell setCellInfo:self.specificationsArray[indexPath.row]];
        
        return cell;
        
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择商品%@!!!!!!!!",indexPath);
    if (tableView.tag==198812) {
        for (int i=0; i<self.specificationsArray.count; i++) {
            NSMutableDictionary *myDictionary = [self.specificationsArray[i] mutableCopy];
            if (i==indexPath.row) {
                myDictionary[@"selectFlag"] = @"1";
                self.nowMoneyLable.text =   [NSString stringWithFormat:@"￥%.1f",(self.special+ [myDictionary[@"price"] floatValue])];
                //            [NSString stringWithFormat:@"￥%@", myDictionary[@"price"] ];
            }else{
                myDictionary[@"selectFlag"] = @"0";
            }
            self.specificationsArray[i] = myDictionary;
        }
        
        
        [self.specificationsTableView reloadData];
        
        [self.specificationsTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    }
}



@end
