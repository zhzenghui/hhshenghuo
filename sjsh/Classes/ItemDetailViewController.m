//
//  ItemDetailViewController.m
//  XHPathCover
//
//  Created by 杜 计生 on 14-8-18.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "UIView+TKCategory.h"
#import "UIImageView+WebCache.h"
//#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "RemarkViewController.h"
#import "SKUViewController.h"
#import "CheckOutViewController.h"
#import "orderGoodsCell.h"
#import "OpenURLViewController.h"
#import "MyAlertView.h"
#import "AddOrderViewController.h"

@interface ItemDetailViewController () <ImagePlayerViewDelegate,SkuResultDelegate>
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, retain) NSNumber *collectId;
@property (nonatomic, strong)  MyAlertView *promptAlert;
@end

@implementation ItemDetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super initNavBarItems:@"商品详情"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
    [super addRightButton:@"购物车" lightedImage:@"购物车" selector:@selector(gotoBuyingCarPage)];
    [super setHintNum:[[ConstObject instance] cartNum]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //已成功添加购物车提示视图
    self.promptAlert=[[MyAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width*0.8, 100)];
    self.promptAlert.center=self.view.center;
    //    self.promptAlert.translatesAutoresizingMaskIntoConstraints = NO;
    self.promptAlert.hidden=YES;
    self.promptAlert.layer.cornerRadius = 8;
    
    self.promptAlert.layer.masksToBounds = YES;
    [self.view addSubview:self.promptAlert];
    
    self.collectId = [NSNumber numberWithInt:0];
    [self getProductDetail];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super getCartNum];
}


- (void)gotoReviewList
{
    RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
    remarkViewController.productID = [[_productDic objectForKey:@"product"] objectForKey:@"product_id"];
    [self.navigationController pushViewController:remarkViewController animated:YES];
    [remarkViewController release];
}


- (void)changeProduct
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定消耗积分兑换此产品吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            //添加兑换方法
            [super showGif];
            [commonModel requestsavepo:[NSDictionary dictionaryWithObjectsAndKeys:[[_productDic objectForKey:@"product"] objectForKey:@"product_id"],@"product_id", nil] httpRequestSucceed:@selector(requestsavepoSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
    }
}

- (void)requestsavepoSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [super showMessageBox:self title:@"" message:@"兑换成功" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 3415){
        [super showMessageBox:self title:@"" message:@"积分不足！" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 3416){
        [super showMessageBox:self title:@"" message:@"缺少收货地址！" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        //        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self pushToLoginVC:NO animation:YES];
    }
}


- (void)viewDidLayoutSubviews
{
    
    if (self.pType == changeType) {
        self.reviewView.hidden = YES;
        self.backScroll.scrollEnabled = YES;
        self.upPullLabel.hidden = YES;
        self.product_price.hidden = YES;
        self.lineView.hidden = YES;
        CGRect rect = self.product_description.frame;
        rect.size.width = self.backScroll.frame.size.width-rect.origin.x*2;
        self.product_description.frame = rect;
        
        self.product_special.hidden = YES;
        
        [self.buyButton setTitle:@"兑 换" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"兑 换" forState:UIControlStateHighlighted];
        [self.buyButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.buyButton addTarget:self action:@selector(changeProduct) forControlEvents:UIControlEventTouchUpInside];
        
        self.addCartButton.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if(self.pType == virtualType){
        
    }
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat height = CGRectGetHeight(self.backScroll.bounds);
    
    //    self.imageURLs = @[[NSURL URLWithString:@"http://www.ghzw.cn/wzsq/UploadFiles_9194/201109/20110915154150869.bmp"],
    //                       [NSURL URLWithString:@"http://sudasuta.com/wp-content/uploads/2013/10/10143181686_375e063f2c_z.jpg"],
    //                       [NSURL URLWithString:@"http://www.yancheng.gov.cn/ztzl/zgycddhsdgy/xwdt/201109/W020110902584601289616.jpg"],
    //                       [NSURL URLWithString:@"http://fzone.oushinet.com/bbs/data/attachment/forum/201208/15/074140zsb6ko6hfhzrb40q.jpg"]];
    [self.imagePlayerView initWithCount:0 delegate:self];
    //    self.imagePlayerView.scrollInterval = 2.0f;
    self.imagePlayerView.autoScroll = NO;
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    
    int otherHeight = 0;
    if (self.pType == virtualType) {
        otherHeight = 190;
        NSArray * otherPs = [[self.productDic objectForKey:@"product"] objectForKey:@"other_products"];
        if (otherPs && [otherPs count]>0) {
            otherHeight += 40+[otherPs count]*84;
        }
        
    }
    
    
    self.backScroll.contentSize = CGSizeMake(width, height);
    self.backScroll.delegate = self;
    //    self.upScroll.contentSize = CGSizeMake(width, 489+otherHeight);
    //    self.upScroll.delegate = self;
    //    self.upScroll.bounces = NO;
    //    [self.upScroll addSubview:self.songView];
    //    [self.upScroll addSubview:self.reviewView];
    [self.backScroll addSubview:self.songView];
    [self.backScroll addSubview:self.reviewView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoReviewList)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [self.reviewView addGestureRecognizer:tapGesture];
    
    
    self.upPullLabel.frame = CGRectMake(0, 489-44+otherHeight, 320, 21);
    [self.backScroll addSubview:self.upPullLabel];
    if (_ratingView.s1 && _ratingView.s2 && _ratingView.s3 && _ratingView.s4 && _ratingView.s5) {
        [_ratingView removeAllSubviews];
    }
    [_ratingView setImagesDeselected:@"grayStar" partlySelected:@"" fullSelected:@"star" andDelegate:nil];
    _ratingView.userInteractionEnabled = NO;
    [self.ratingView displayRating:0];
    
    if (self.pType == virtualType) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 489-44, 320, otherHeight)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        [self.backScroll addSubview:self.tableView];
    }
    
    
    if (self.webview == nil) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(60, 489+otherHeight+10, 200, 20)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:12.0];
        lable.text = @"下拉返回";
        lable.textColor = [UIColor lightGrayColor];
        [self.backScroll addSubview:lable];
        NSString *urlStr = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/product/productdetail&product_id=%@",[_productDic objectForKey:@"product_id"]];
        self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 489+otherHeight-23, width, height)];
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        self.webview.scrollView.delegate = self;
        self.webview.backgroundColor = [UIColor clearColor];
        [self.backScroll addSubview:self.webview];
    }
    else {
        self.webview.frame = CGRectMake(0,489+otherHeight-23, width, height);
    }
    
}

- (void)setinforWithDic:(NSDictionary *)dic
{
    NSString *name = [dic objectForKey:@"name"];
    NSString *meta_description = [dic objectForKey:@"meta_description"];
    NSNumber *price = [dic objectForKey:@"price"];
    NSNumber *special = [dic objectForKey:@"special"];
    //    if (special.floatValue<=0) {
    //        special = price;
    //    }
    NSNumber *count_comment = [dic objectForKey:@"count_comment"];
    NSNumber *score = [dic objectForKey:@"score"];
    NSArray *images = [dic objectForKey:@"images"];
    //    NSString *yunfei = [dic objectForKey:@"yunfei"];
    NSString *payment_method = [dic objectForKey:@"payment_method"];
    NSString *delivery_speed = [dic objectForKey:@"delivery_speed"];
    NSNumber *collect = [dic objectForKey:@"is_collection"];
    if ([collect integerValue]==0) {
        self.favButton.tag = 0;
        [self.favButton setImage:[UIImage imageNamed:@"collect_none"] forState:UIControlStateNormal];
        [self.favButton setTitle:@" 收藏" forState:UIControlStateNormal];
    }
    else {
        self.collectId = collect;
        self.favButton.tag = 1;
        [self.favButton setImage:[UIImage imageNamed:@"collect_already"] forState:UIControlStateNormal];
        [self.favButton setTitle:@" 已收藏" forState:UIControlStateNormal];
    }
    self.yunfeiLabel.text = payment_method;
    self.peisongLabel.text = delivery_speed;//[NSString stringWithFormat:@"%@,%@",payment_method,delivery_speed];
    self.product_name.text = name;
    self.product_description.text = meta_description;
    self.product_special.text = [NSString stringWithFormat:@"￥%.1f",[special floatValue]];
    self.product_price.text = [NSString stringWithFormat:@"￥%.1f",[price floatValue]];
    self.product_price.strikeThroughColor = [UIColor lightGrayColor];
    self.product_price.strikeThroughEnabled = YES;
    [self.product_price setNeedsDisplay];
    self.reviewNum.text = [NSString stringWithFormat:@"已有评价(%d)",[count_comment intValue]];
    self.rateNum.text = [NSString stringWithFormat:@"%.1f分",[score floatValue]];
    [self.ratingView displayRating:score.floatValue];
    
    self.imageURLs = [NSMutableArray arrayWithCapacity:0];
    for (NSString *urlStr in images) {
        
        [self.imageURLs addObject:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    [self.imagePlayerView initWithCount:images.count delegate:self];
    [self.tableView reloadData];
}

//获取商品详情接口
- (void)getProductDetail
{
    [super showGif];
    [commonModel requestproductview:[_productDic objectForKey:@"product_id"] httpRequestSucceed:@selector(getProducViewSuccess:) httpRequestFailed:@selector(getProducViewFailed:)];
    //    服务类的3440 积分的 3589
    //    [commonModel requestproductview:@"3589"
    //                 httpRequestSucceed:@selector(getProducViewSuccess:) httpRequestFailed:@selector(getProducViewFailed:)];
}

//获取商品详情接口调用成功
- (void)getProducViewSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    if (completeDic == nil) {
        return;
    }
    NSDictionary *dic = [completeDic objectForKey:@"result"];
    int flag = [[[dic objectForKey:@"product"] objectForKey:@"flag"] intValue];
    switch (flag) {
        case 0:
            self.pType = generalType;
            break;
        case 1:
            self.pType = virtualType;
            break;
        case 3:
            self.pType = changeType;
            break;
        default:
            break;
    }
    [self viewDidLayoutSubviews];
    self.productDic = dic;
    [self setinforWithDic:[self.productDic objectForKey:@"product"]];
    
}

- (void)getProducViewFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

//- (void)getdetailHtmlString
//{
//    [commonModel requestproductdetail:[_productDic objectForKey:@"product_id"] httpRequestSucceed:@selector(getProducdetailSuccess:) httpRequestFailed:@selector(getProducdetailFailed:)];
//}


//- (void)getProducdetailSuccess:(ASIHTTPRequest *)request{
////    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
//    NSLog(@"dic%@",dic);
//
//}
//
//- (void)getProducdetailFailed:(ASIHTTPRequest *)request{
////    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
//    NSLog(@"dic%@",dic);
//}


- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    NSURL *imageUrl = [self.imageURLs objectAtIndex:index];
    [imageView setImageWithURL:imageUrl placeholderImage:nil];
    
    //    imageView.image = [UIImage imageNamed:@"1"];//[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.imageURLs objectAtIndex:index]]];
    
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.imageURLs.count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [self.imageURLs objectAtIndex:i]; // 图片路径
        photo.srcImageView = imagePlayerView.scrollView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    if (scrollView == self.upScroll) {
    //        [self setOffsetY:scrollView.contentOffset.y];
    //    }
    
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"begin:%@",NSStringFromCGPoint(scrollView.contentOffset));
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat fixAdaptorPadding = 44;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        fixAdaptorPadding = 64;
    }
    CGFloat height = CGRectGetHeight(self.backScroll.bounds);
    
    
    if (scrollView == self.backScroll) {
        if (scrollView.contentOffset.y>0) {
            scrollView.contentSize = CGSizeMake(width, height *2);
            [scrollView setContentOffset:CGPointMake(0, height+44) animated:YES];
            scrollView.scrollEnabled = NO;
            //            [self.backScroll addSubview:self.webview];
        }
        else {
            scrollView.contentSize = CGSizeMake(width, height);
        }
    }
    
    else if (scrollView == self.webview.scrollView){
        if (scrollView.contentOffset.y<0) {
            //            self.backScroll.contentSize = CGSizeMake(320, height);
            [self.backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
            
            self.backScroll.scrollEnabled = YES;
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat height = CGRectGetHeight(self.backScroll.bounds);
    
    
    if (scrollView == self.backScroll) {
        if (scrollView.contentOffset.y>0) {
            scrollView.contentSize = CGSizeMake(width, height *2);
            [scrollView setContentOffset:CGPointMake(0, height+44) animated:YES];
            scrollView.scrollEnabled = NO;
            //            [self.backScroll addSubview:self.webview];
        }
        else {
            scrollView.contentSize = CGSizeMake(width, height);
        }
    }
    else if (scrollView == self.webview.scrollView){
        if (scrollView.contentOffset.y<0) {
            //            self.backScroll.contentSize = CGSizeMake(320, height);
            [ self.backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
            
            self.backScroll.scrollEnabled = YES;
        }
    }
}// called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    
    
}// called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}


- (void)setOffsetY:(CGFloat)y {
    if (y>0) {
        CGPoint center = self.imagePlayerView.center;
        center.y = self.imagePlayerView.frame.size.height/2+0.5*y;
        self.imagePlayerView.center = center;
    }
    
}
- (void)dealloc {
    [_product_name release];
    [_product_price release];
    [_product_description release];
    [_reviewNum release];
    [_ratingView release];
    [_upPullLabel release];
    [_buyButton release];
    [super dealloc];
}
- (IBAction)collect:(UIButton *)sender {
    if (self.collectId.integerValue == 0) {
        
        [super showGif];
        [commonModel requestAddFavorite:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"type",[[_productDic objectForKey:@"product"] objectForKey:@"product_id"],@"obj_id", nil] httpRequestSucceed:@selector(AddFavoriteSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    else {
        [super showGif];
        [commonModel requestDeleteFavorite:[NSDictionary dictionaryWithObjectsAndKeys:self.collectId,@"id", nil] httpRequestSucceed:@selector(delFavoriteSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}

- (void)AddFavoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.collectId = [dic objectForKey:@"collection_id"];
        self.favButton.tag = 1;
        [self.favButton setImage:[UIImage imageNamed:@"collect_already"] forState:UIControlStateNormal];
        [self.favButton setTitle:@" 已收藏" forState:UIControlStateNormal];
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
        [self pushToLoginVC:NO animation:YES];
    }
}

- (void)delFavoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.collectId = [NSNumber numberWithInt:0];
        self.favButton.tag = 0;
        [self.favButton setImage:[UIImage imageNamed:@"collect_none"] forState:UIControlStateNormal];
        [self.favButton setTitle:@" 收藏" forState:UIControlStateNormal];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1401){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        //        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        [self pushToLoginVC:NO animation:YES];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer.view == self.reviewView) {
        return YES;
    }
    else return NO;
}

- (void)delFavoriteFailed:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

- (IBAction)buyTapped:(UIButton *)sender {
    
    SKUViewController *skuController = [[SKUViewController alloc] init];
    
    if (sender.tag == 0) {
        skuController.type = onceBuy;
    }
    else {
        skuController.type = AddToCart;
    }
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

- (void)enterNetPageForOrder
{
    [super showGif];
    [commonModel requestCheckLogin:nil httpRequestSucceed:@selector(requestCheckLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}
- (void)refreashCartNum
{
    self.promptAlert.hidden=NO;
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:self.promptAlert
                                    repeats:NO];
    [super getCartNum];
}

//隐藏信息弹出框
- (void)timerFireMethod:(NSTimer*)theTimer
{
    MyAlertView *promptAlert = (MyAlertView*)[theTimer userInfo];
    promptAlert.hidden=YES;
    //    promptAlert =NULL;
}

- (void)enterOrderPage
{
    //进入下单页
    //    CheckOutViewController *checkVC = [[CheckOutViewController alloc] init];
    //    [self.navigationController pushViewController:checkVC animated:YES];
//    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
//    [detailViewController initWithUrl:KcheckOutPage andTitle:@"填写订单"];
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    [detailViewController release];
    
    AddOrderViewController *myViewController = [[AddOrderViewController alloc] init];
     myViewController.isFirst = YES;
    myViewController.isAll = YES;
    [self.navigationController pushViewController:myViewController animated:YES];
    
    
}

- (void)gotoBuyingCarPage
{
    MyShoppingCartViewController *shoppingCart = [[MyShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
}

//返回上一页
-(void)backHomePage{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    else {
        NSArray * otherPs = [[self.productDic objectForKey:@"product"] objectForKey:@"other_products"];
        if (otherPs && [otherPs count]>0) {
            return [otherPs count]+1;
        }
        else {
            return 0;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row== 0) {
            return 40;
        }
        else {
            return 50;
        }
    }
    else {
        if (indexPath.row == 0) {
            return 40;
        }
        else {
            return 84;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.font = [UIFont systemFontOfSize:12];
                cell.textLabel.textColor = COLOR(64, 64, 64);
                cell.textLabel.text = @"商户信息";
            }
                break;
            case 1:
            {
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = COLOR(64, 64, 64);
                cell.textLabel.text = [[self.productDic objectForKey:@"product"] objectForKey:@"manufacturer_name"];
            }
                break;
            case 2:
            {
                NSString *phoneString = @"暂无商家电话";
                NSArray *phoneList = [[self.productDic objectForKey:@"product"] objectForKey:@"manufacturer_phone"];
                if(phoneList && [phoneList count]>0)
                {
                    phoneString = [phoneList objectAtIndex:0];
                }
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.textLabel.textColor = COLOR(160, 160, 160);
                cell.textLabel.text = phoneString;
                cell.imageView.image = [UIImage imageNamed:@"telephone"];
            }
                break;
            case 3:
            {
                cell.textLabel.font = [UIFont systemFontOfSize:12];
                cell.textLabel.textColor = COLOR(160, 160, 160);
                cell.textLabel.numberOfLines = 2;
                cell.textLabel.text = [[self.productDic objectForKey:@"product"] objectForKey:@"manufacturer_address"];
                cell.imageView.image = [UIImage imageNamed:@"address"];
            }
            default:
                break;
        }
    }
    else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"该商户其他团购";
        }
        else {
            static NSString *cellIdentifier = @"orderGoodsCell";
            
            orderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[[orderGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSDictionary *productDic = [[[self.productDic objectForKey:@"product"] objectForKey:@"other_products"] objectAtIndex:indexPath.row-1];
            cell.tipLabel.text = [productDic objectForKey:@"name"];
            cell.nowPriceLabel.text =[NSString stringWithFormat:@"￥ %@",[productDic objectForKey:@"price"]];
            NSString *imageUrl = [productDic objectForKey:@"image"];
            if ([imageUrl isKindOfClass:[NSNull class]]==NO) {
                imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
            }
            
            cell.tag = indexPath.section;
            return cell;
        }
    }
    return cell;
}

@end
