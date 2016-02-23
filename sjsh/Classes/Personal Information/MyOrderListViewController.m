//
//  MyOrderListViewController.m
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "UIImageView+WebCache.h"
#import "AppraiseViewController.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"
#import "AddOrderViewController.h"

@interface MyOrderListViewController ()
@property (nonatomic, retain) NSString *ids;
@property (nonatomic, assign) int page;//列表当前页数
@property(nonatomic,assign) BOOL  isFirst;//是否首次打开页面

@property (nonatomic, strong) NSString *stringList;
@end

@implementation MyOrderListViewController

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
    
    self.isFirst = YES;
    
    [super initNavBarItems:@""];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super initNavBarItems:@"订单列表"];
    
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"count\":\"39\",\"data\":[{\"order_id\":117138,\"shop_name\":\"\u793e\u533ae\u7ad9\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2015\/12\/07 23:41:42\",\"order_total\":24,\"products\":[{\"order_product_id\":23917,\"product_id\":6847,\"isre\":0,\"name\":\"\u793e\u533ae\u7ad9 \u5229\u4f73\u87f9\u7530\u5927\u7c73\",\"price\":29,\"quantity\":1,\"product_total\":29,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151013\/1444723137454319-100x100.jpg\"}]},{\"order_id\":116470,\"shop_name\":\"3M\",\"status\":\"\u5df2\u5b8c\u6210\",\"order_status_id\":\"5\",\"date_added\":\"2015\/11\/22 20:12:17\",\"order_total\":20,\"products\":[{\"order_product_id\":23063,\"product_id\":6880,\"isre\":1,\"name\":\"3M\u9632\u96fe\u973e9001V\u53e3\u7f69(5\u4e2a\u88c5)\",\"price\":20,\"quantity\":1,\"product_total\":20,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151106\/1446796419798311-100x100.jpg\"}]},{\"order_id\":113534,\"shop_name\":\"\u793e\u533ae\u7ad9\",\"status\":\"\u5df2\u5b8c\u6210\",\"order_status_id\":\"5\",\"date_added\":\"2015\/08\/31 09:46:33\",\"order_total\":29.2,\"products\":[{\"order_product_id\":19114,\"product_id\":2775,\"isre\":1,\"name\":\"\u793e\u533ae\u7ad9 \u897f\u846b\u82a6 500g\",\"price\":2,\"quantity\":2,\"product_total\":4,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/zaipei\/shucai\/xihulu\/140516184603-605-100x100.jpg\"},{\"order_product_id\":19115,\"product_id\":4813,\"isre\":0,\"name\":\"\u793e\u533ae\u7ad9 \u6709\u673a\u83dc\u82b1 500g\",\"price\":4,\"quantity\":1,\"product_total\":4,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150819\/1439964850622785-100x100.jpg\"},{\"order_product_id\":19113,\"product_id\":4048,\"isre\":1,\"name\":\"\u793e\u533ae\u7ad9 \u65f1\u9ec4\u74dc 500g\",\"price\":5,\"quantity\":2,\"product_total\":10,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150306\/1425632057143744-100x100.jpg\"},{\"order_product_id\":19111,\"product_id\":4717,\"isre\":1,\"name\":\"\u793e\u533ae\u7ad9 \u5e7f\u8304 500g\",\"price\":2.2,\"quantity\":2,\"product_total\":4.4,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150831\/1440993283505695-100x100.jpg\"},{\"order_product_id\":19110,\"product_id\":2788,\"isre\":1,\"name\":\"\u793e\u533ae\u7ad9 \u5c16\u6912 500g\",\"price\":2,\"quantity\":2,\"product_total\":4,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/zaipei\/chengyunongzhuang\/jianjiao\/140505153355-276-100x100.jpg\"},{\"order_product_id\":19112,\"product_id\":2141,\"isre\":1,\"name\":\"\u793e\u533ae\u7ad9 \u571f\u8c46 \u7ea6500g\",\"price\":1.7,\"quantity\":2,\"product_total\":3.4,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/zaipei\/shucai\/tudou\/140516183638-715-100x100.jpg\"}]},{\"order_id\":109296,\"shop_name\":\"\u4e07\u5f97\u5999\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2015\/03\/23 17:35:35\",\"order_total\":27.8,\"products\":[{\"order_product_id\":13470,\"product_id\":3842,\"isre\":0,\"name\":\"\u4e07\u5f97\u5999 \u4f4e\u8102\u9c9c\u725b\u5976 500ml\",\"price\":13.9,\"quantity\":1,\"product_total\":13.9,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20141120\/1416455387127954-100x100.jpg\"},{\"order_product_id\":13471,\"product_id\":3843,\"isre\":0,\"name\":\"\u4e07\u5f97\u5999 \u5168\u8102\u9c9c\u725b\u5976 500ml\",\"price\":13.9,\"quantity\":1,\"product_total\":13.9,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20141120\/1416456108462621-100x100.jpg\"}]},{\"order_id\":108505,\"shop_name\":\"\u4e16\u7eaa\u751f\u6d3b\u7f51\u53ca\u65f6\u9001\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2015\/02\/11 14:21:13\",\"order_total\":402,\"products\":[{\"order_product_id\":12372,\"product_id\":3789,\"isre\":0,\"name\":\"\u5929\u79b9 \u76d8\u9526\u87f9\u7530\u5927\u7c73 5kg\",\"price\":36,\"quantity\":1,\"product_total\":36,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150130\/1422603371668863-100x100.jpg\"},{\"order_product_id\":12371,\"product_id\":2759,\"isre\":0,\"name\":\"\u4f59\u957f\u6709 \u4e94\u5e38\u5408\u4f5c\u793e\u76f4\u4f9b \u7a3b\u82b1\u9999\u5927\u7c73 5kg\",\"price\":69,\"quantity\":2,\"product_total\":138,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/zaipei\/yuchangyoupaidaohuaxiang\/140626103528-43-100x100.jpg\"},{\"order_product_id\":12373,\"product_id\":3945,\"isre\":0,\"name\":\" \u4e2d\u7cae \u5c6f\u6cb3 \u91d1\u7586\u7389\u67a3 500g\",\"price\":228,\"quantity\":1,\"product_total\":228,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150121\/1421805728753214-100x100.jpg\"}]},{\"order_id\":107183,\"shop_name\":\"\u9c9c\u679c\u6e90\",\"status\":\"\u5df2\u5b8c\u6210\",\"order_status_id\":\"5\",\"date_added\":\"2014\/12\/04 16:11:59\",\"order_total\":15,\"products\":[{\"order_product_id\":10518,\"product_id\":3877,\"isre\":0,\"name\":\"\u5357\u4e30\u871c\u68542\u65a4+\u5e93\u5c14\u52d2\u9999\u68a82\u65a4\",\"price\":15,\"quantity\":1,\"product_total\":15,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20141204\/1417674385925758-100x100.jpg\"}]},{\"order_id\":105221,\"shop_name\":\"\u9c9c\u679c\u6e90\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2014\/10\/17 15:35:22\",\"order_total\":10.9,\"products\":[{\"order_product_id\":8216,\"product_id\":3477,\"isre\":0,\"name\":\"\u4e1d\u74dc2-3\u6839\uff08\u7ea6850g\uff09\",\"price\":5.9,\"quantity\":1,\"product_total\":5.9,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/xianguoyuan\/140813103513-800-100x100.jpg\"}]},{\"order_id\":104793,\"shop_name\":\"\u9c9c\u679c\u6e90\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2014\/10\/14 21:48:10\",\"order_total\":1,\"products\":[{\"order_product_id\":7742,\"product_id\":3694,\"isre\":0,\"name\":\"\u6d3b\u52a8\u4e13\u4eab  \u65b0\u7586\u7cbe\u9009\u54c8\u5bc6\u74dc1\u7c92\u88c5\uff082-2.5kg\uff09\",\"price\":1,\"quantity\":1,\"product_total\":1,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/zaipei\/xianguo\/hamigua\/141011153005-461-100x100.jpg\"}]},{\"order_id\":104790,\"shop_name\":\"\u9ed1\u767d\u683c [\u6781\u81f4\u7231\u8f66]\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2014\/10\/14 21:35:45\",\"order_total\":1,\"products\":[{\"order_product_id\":7739,\"product_id\":3688,\"isre\":0,\"name\":\"\u9ed1\u767d\u683c60\u5206\u949f\u7cbe\u81f4\u6d17\u8f66\uff08\u9700\u8981\u63d0\u524d\u81f4\u7535\u9884\u7ea6\uff09\",\"price\":1,\"quantity\":1,\"product_total\":1,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/aaazhoubian\/141011140720-484-100x100.jpg\"}]},{\"order_id\":104784,\"shop_name\":\"\u9ed1\u767d\u683c [\u6781\u81f4\u7231\u8f66]\",\"status\":\"\u5df2\u5173\u95ed\",\"order_status_id\":\"10\",\"date_added\":\"2014\/10\/14 21:08:02\",\"order_total\":1,\"products\":[{\"order_product_id\":7733,\"product_id\":3688,\"isre\":0,\"name\":\"\u9ed1\u767d\u683c60\u5206\u949f\u7cbe\u81f4\u6d17\u8f66\uff08\u9700\u8981\u63d0\u524d\u81f4\u7535\u9884\u7ea6\uff09\",\"price\":1,\"quantity\":1,\"product_total\":1,\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/aaazhoubian\/141011140720-484-100x100.jpg\"}]}]}}";
    //    if (self.navigationItem) {
    //        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
    //        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部"];
    //        [menu displayMenuInView:self.navigationController.view];
    //        menu.tag = 100000;
    //        menu.items = [NSMutableArray arrayWithArray:@[@"全部", @"待处理订单",@"待评价订单"]];
    //        menu.delegate = self;
    //        [self.navigationItem.titleView addSubview:menu];
    //    }
    self.view.backgroundColor = COLOR(255, 255, 255);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.selectArray = [NSMutableArray arrayWithCapacity:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    label.text = @"您还没有订单";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:label];
    //    [label release];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listTableView.backgroundColor = [UIColor whiteColor];
    //    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    //    [listTableView release];
    
    //    self.dataArray = [NSMutableArray arrayWithObjects:[NSArray arrayWithObjects:@"",@"", nil],[NSArray arrayWithObjects:@"",@"",@"", nil],[NSArray arrayWithObjects:@"",@"", nil],[NSArray arrayWithObjects:@"", nil], nil];
    self.page = 1;
    self.ids = nil;
    //    [self fetchData];
    
    
    //    __weak ConstructViewController *weakself = self;
    [listTableView addInfiniteScrollingWithActionHandler:^{
        
        if (self.dataArray.count >= 3) {
            //            self.page++;
            [self fetchData];
        }else{
            //        [listTableView.infiniteScrollingView stopAnimating];
        }
    }];
    
    [listTableView addPullToRefreshWithActionHandler:^{
        
        self.page = 1;
        self.dataArray = [[NSMutableArray alloc] init];
        [listTableView reloadData];
        [self fetchData];
        
    }];
    //    [listTableView refresh:listTableView.pullToRefreshView];
    //
    [listTableView triggerPullToRefresh];//调用顶部下拉刷新
}

//加载接口数据
-(void)fetchData{
    if (self.isFirst) {//只有第一次进入页面弹出加载框
        [self showGif];
    }
    [commonModel requestOrder:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.page],@"page",[NSNumber numberWithInt:10],@"limit",self.ids,@"status_id" ,nil] httpRequestSucceed:@selector(orderSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)orderSuccess:(ASIHTTPRequest *)request{
    if (self.isFirst) {
        [super hideGif];
    }
    self.isFirst = NO;
      NSLog(@"订单列表接口返回数据responseString：%@",request.responseString);
    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"订单列表接口返回数据dic：%@！！！！！！",completeDic);
    //待下拉刷新成功后，再清除列表原来的数据
    if (self.page == 1 && [self.dataArray count] != 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:[[completeDic objectForKey:@"result"] objectForKey:@"data"]];
    
    //    moreAction = [[[completeDic objectForKey:@"result"] objectForKey:@"data"] count] >= 10;
    //    moreCell.hidden = [self.dataArray count] == 0;
    
    //    if([self.dataArray count]>0)
    [listTableView reloadData];
    
    //    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    if (self.page == 1){
        [listTableView.pullToRefreshView stopAnimating];
    }else{
        [listTableView.infiniteScrollingView stopAnimating];
    }
    self.page ++;
}

//- (void)orderFail:(ASIHTTPRequest *)request{
//    [super hideGif];
//    NSDictionary *dic = [super parseJsonRequest:request];
//    NSLog(@"dic%@",dic);
//}

//删除订单
- (void)deleteOrderSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"删除订单接口返回数据：%@！！！！",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单删除成功！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        self.page = 1;
        [self fetchData];//刷新页面
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"订单删除失败！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}

//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    
    NSLog(@"接口调用错误！！！！！！%@!!!!!",request.error);
}

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == [self.dataArray count]) {
    return 176;
    //    }
    //    NSArray *arr = [[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"products"];
    //
    //    if (indexPath.row == 0) {
    //        return 41;
    //    }
    //    else if(indexPath.row==[arr count]+2-1){
    //        return 50;
    //    }
    //    else {
    //        return 84;
    //    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (section == [self.dataArray count]) {
    if([self.dataArray count]>0)
    {
        listTableView.hidden = NO;
        return [_dataArray count];
    }
    else {
        listTableView.hidden = YES;
        return 0;
    }
    
    //    }
    //
    //    NSArray *items = [[self.dataArray objectAtIndex:section] objectForKey:@"products"];
    //    return 2+items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == [self.dataArray count]) {
    
    static NSString *reusableIdentifier = @"OrderCell";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    NSDictionary *myDictionary = self.dataArray[indexPath.row];
    
    NSLog(@"第%ld行的cell数据为：%@",(long)indexPath.row,myDictionary);
    
    [cell setCellInfo:myDictionary];
    
    return cell;
    
    
    
    //        static NSString *cellIdentifier = @"OrderCell";
    //        moreCell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if (!moreCell) {
    //            moreCell = [[[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
    //            moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //            [moreCell setTips:@"上拉获取更多"];
    //            moreCell.userInteractionEnabled = NO;
    //        }
    //        return moreCell;
    //    }
    //    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.section];
    //    NSArray *products = [orderDic objectForKey:@"products"];
    //    if (indexPath.row == 0) {
    //        static NSString *cellIdentifier = @"Cell";
    //        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if (cell == nil) {
    //            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    //            cell.accessoryType = UITableViewCellAccessoryNone;
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        }
    //        cell.textLabel.text = [orderDic objectForKey:@"shop_name"];
    //        cell.detailTextLabel.text = [orderDic objectForKey:@"date_added"];
    //        cell.tag = indexPath.section;
    //        return cell;
    //    }
    //    else if(indexPath.row==[products count]+2-1){
    //        static NSString *cellIdentifier = @"orderActionTableViewCell";
    //        orderActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if (cell == nil) {
    //            cell = [[[orderActionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    //            cell.accessoryType = UITableViewCellAccessoryNone;
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        }
    //        cell.state.text =[orderDic objectForKey:@"status"];
    //        [cell.actionButton setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    //        [cell.actionButton setTitle:@"查看" forState:UIControlStateNormal];
    //        cell.actionButton.enabled = NO;
    //        cell.actionButton.adjustsImageWhenDisabled = NO;
    //        cell.tag = indexPath.section;
    //        return cell;
    //    }
    //    else {
    //        static NSString *cellIdentifier = @"orderGoodsCell";
    //
    //        orderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if (cell == nil) {
    //            cell = [[[orderGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        }
    //        NSDictionary *productDic = [products objectAtIndex:indexPath.row-1];
    //        cell.tipLabel.text = [productDic objectForKey:@"name"];
    //        cell.nowPriceLabel.text =[NSString stringWithFormat:@"￥ %@",[productDic objectForKey:@"price"]];
    //        NSString *imageUrl = [productDic objectForKey:@"image"];
    //        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //        [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    //        cell.tag = indexPath.section;
    //        return cell;
    //    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.row];
    MyOrderDetailViewController *detailVc = [[MyOrderDetailViewController alloc] init];
    detailVc.orderID = [orderDic objectForKey:@"order_id"];
    [self.navigationController pushViewController:detailVc animated:YES];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    //    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
//    if (![CheckNetwork isExistenceNetwork]){
//
//        if ((![CheckNetwork isExistenceNetwork] && reloading) ||
//            (![CheckNetwork isExistenceNetwork] &&
//             (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height + 44))){
//                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
//                return;
//            }
//    }
//
//    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
//        if (!moreAction){
//            [moreCell stopAction];
//            [moreCell setTips:@"已加载全部"];
//        }else{
//            [moreCell startAction];
//            [moreCell setTips:@"数据加载中"];
//            [self fetchData];
//        }
//    }else {
//        moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
//    }
//}

- (void)doneLoadingTableViewData{
    
    
    reloading = NO;
    // [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
}

//屏蔽下拉菜单代理方法
//- (void)didSelectItemAtIndex:(NSInteger)index
//{
//    switch (index) {
//        case 0:
//            self.ids = nil;
//            break;
//        case 1:
//            self.ids = @"1,18,17,9,10,11,15,20,22";
//            break;
//        case 2:
//            self.ids = @"5";
//            break;
//        default:
//            break;
//    }
//
//    page = 1;
//    [self fetchData];
//}

//- (void)onHandleMenuTap
//{
//
//}
//-(void)onShowMenu
//{
//
//}
//-(void)onHideMenuTap
//{
//
//}

#pragma mark cell代理方法
- (void)operateOrder:(NSDictionary *)myDictionary{
    
    NSLog(@"订单的操作回调%@！！！",myDictionary);
    
    AppraiseViewController * appraiseViewController = [[AppraiseViewController alloc] init];//评价页
    AddOrderViewController *addOrderViewController = [[AddOrderViewController alloc] init];//添加订单
    
    //为评价页加入冗余数据
    NSMutableArray *myArray = [myDictionary[@"products"] mutableCopy];
    
    for (int i=0; i<myArray.count; i++) {
        NSMutableDictionary *myDictionary = [myArray[i] mutableCopy];
        NSMutableArray *imageArray = [[NSMutableArray alloc]init];
        [myDictionary setValue:imageArray forKey:@"imageArray"];
        myArray[i] = myDictionary;
    }
    
    NSString *myOrderID = [NSString stringWithFormat:@"%@",myDictionary[@"order_id"]];
    switch ([myDictionary[@"type"] integerValue]) {
            
        case 1:
            
            NSLog(@"点击了删除订单！");
            
            NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
            infoDictionary[@"order_id"] = myDictionary[@"order_id"];
            [super showGif];
            [commonModel deleteOrderById:infoDictionary  httpRequestSucceed:@selector(deleteOrderSuccess:) httpRequestFailed:@selector(requestFailed:)];
            break;
            
        case 2:
            
            appraiseViewController.appraiseArray = myArray;
            appraiseViewController.orderID = [myDictionary[@"order_id"] description];
            [self.navigationController pushViewController:appraiseViewController animated:YES];
            
            break;
        case 3://取消订单
            NSLog(@"点击了取消订单！");
            
            NSMutableDictionary *cancelDictionary = [[NSMutableDictionary alloc]init];
            //            cancelDictionary[@"order_id"] = myDictionary[@"order_id"];
            [super showGif];
            [commonModel cancelOrderById:myDictionary[@"order_id"]  httpRequestSucceed:@selector(deleteOrderSuccess:) httpRequestFailed:@selector(requestFailed:)];
            break;
        case 4://去付款
            
            NSLog(@"去付款%@！！！！！",myOrderID);
            
            addOrderViewController.isFirst = NO;
            addOrderViewController.isAll = NO;
            addOrderViewController.orderID = myDictionary[@"order_id"];
            [self.navigationController pushViewController:addOrderViewController animated:YES];
            
            break;
        default:
            break;          
    }
    
}

@end