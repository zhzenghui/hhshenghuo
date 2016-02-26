//
//  HHHealthController.m
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHHealthController.h"
#import "ImagePlayerView.h"
#import "MyHeadView.h"
#import "HHHealthCollectionCell.h"
#import "OpenURLViewController.h"
#import "MyWebViewController.h"

@interface HHHealthController ()<UICollectionViewDataSource,UICollectionViewDelegate,ImagePlayerViewDelegate>
{
    BOOL success1;
    BOOL success2;
}

@property(nonatomic,strong)UIScrollView *homeScroll;

@property (nonatomic, retain) UICollectionView *myCollectionView;
@property (nonatomic, retain) NSArray *bannerList;
@property (nonatomic, retain) NSMutableArray *serviceList;

@property (nonatomic, strong) NSString *stringList;


@property(nonatomic, strong) NSMutableArray *preferentialArray;       //本周特惠商品banner数据

@end

@implementation HHHealthController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    success1 = NO;
    success2 = NO;
    [self initNavBarItems:@"淮海生活"];
//    [super addRightButton:@"hh_ico_phone" lightedImage:@"hh_ico_phone" selector:@selector(callPhone)];
    
//    leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//    leftButton.backgroundColor = [UIColor clearColor];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [leftButton setImage:[UIImage imageNamed:@"hh_ico_badge"] forState:UIControlStateNormal];
//    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -0, 0, 10);
//    leftButton.frame = CGRectMake(0, 0, 100, 44);
//    leftButton.tag = NAME_MAX;
//    [leftButton setTitle:@"徐州总工会" forState:UIControlStateNormal];
//    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.view.backgroundColor = dilutedGrayColor;
    self.bannerList = [NSArray array];
    self.serviceList = [NSMutableArray array];
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/jzbj.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/baojie&from=1\",\"flag\":0,\"title\":\"\u5bb6\u653f\u4fdd\u6d01\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/ss.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/songshui&from=1\",\"flag\":\"http:\/\/lib.sjsh8.cn\/wechat\/images\/iconpic-huiyuan.png\",\"title\":\"\u9001\u6c34\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/wx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/jiadian&from=1\",\"flag\":0,\"title\":\"\u7ef4\u4fee\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/wywx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/jiaofei&from=1\",\"flag\":0,\"title\":\"\u7f34\u8d39\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/xy.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/xiyi&from=1\",\"flag\":0,\"title\":\"\u6d17\u8863\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/jdqx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/qingxi&from=1\",\"flag\":0,\"title\":\"\u5bb6\u7535\u6e05\u6d17\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/kshs.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=weidian\/index&from=1\",\"flag\":0,\"title\":\"\u5f00\u9501\u6362\u9501\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/fwzs.png\",\"url\":\"http:\/\/m.dianping.com\/shoplist\/2\/search?keyword=%E4%B8%96%E7%BA%AA%E5%9F%8E&from=1\",\"flag\":0,\"title\":\"\u623f\u5c4b\u79df\u552e\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/hsc.png\",\"url\":\"http:\/\/h.sjsh8.cn\/wap\/index.php?from=1\",\"flag\":0,\"title\":\"\u6362\u7eb1\u7a97\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/tnam.png\",\"url\":\"http:\/\/thirdparty.zlycare.com\/#\/home?phoneNum=login&source=shijishenghuo\",\"title\":\"\u63a8\u62ff\u6309\u6469\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/qcyh.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/yanglao&from=1\",\"flag\":0,\"title\":\"\u6c7d\u8f66\u517b\u62a4\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/sqyl.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/yanglao&from=1\",\"flag\":0,\"title\":\"\u793e\u533a\u517b\u8001\"}]}";
    
    //测试数据
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *labelArray = [[NSMutableArray alloc]init];
    
    [myDictionary setValue:@"test_hh_health_ico01" forKey:@"ico"];
    [myDictionary setValue:@"预约挂号" forKey:@"title"];
    [labelArray addObject:@"门诊挂号"];
    [labelArray addObject:@"专家信息"];
    [labelArray addObject:@"医院信息"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico02" forKey:@"ico"];
    [myDictionary setValue:@"在线咨询" forKey:@"title"];
    [labelArray addObject:@"专家咨询"];
    [labelArray addObject:@"普通咨询"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico03" forKey:@"ico"];
    [myDictionary setValue:@"健康体验" forKey:@"title"];
    [labelArray addObject:@"体验预约"];
    [labelArray addObject:@"体验报告"];
    [labelArray addObject:@"体验建议"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico04" forKey:@"ico"];
    [myDictionary setValue:@"药品查询" forKey:@"title"];
    [labelArray addObject:@"家庭常备"];
    [labelArray addObject:@"保健品"];
    [labelArray addObject:@"医疗器械"];
    [labelArray addObject:@"当季推荐"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico05" forKey:@"ico"];
    [myDictionary setValue:@"健康咨询" forKey:@"title"];
    [labelArray addObject:@"药品知识"];
    [labelArray addObject:@"疾病常识"];
    [labelArray addObject:@"生活百科"];
    [labelArray addObject:@"日常保健"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico06" forKey:@"ico"];
    [myDictionary setValue:@"医疗保养" forKey:@"title"];
    [labelArray addObject:@"疗养预约"];
    [labelArray addObject:@"普通疗养"];
    [labelArray addObject:@"心理疗养"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico07" forKey:@"ico"];
    [myDictionary setValue:@"附近医药" forKey:@"title"];
    [labelArray addObject:@"附近医院"];
    [labelArray addObject:@"附近药店"];
    [labelArray addObject:@"附近健身场所"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico08" forKey:@"ico"];
    [myDictionary setValue:@"健康圈" forKey:@"title"];
    [labelArray addObject:@"病友咨询"];
    [labelArray addObject:@"组织活动"];
    [labelArray addObject:@"病友论坛"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico09" forKey:@"ico"];
    [myDictionary setValue:@"疾病信息" forKey:@"title"];
    [labelArray addObject:@"妇科疾病"];
    [labelArray addObject:@"儿童常见病"];
    [labelArray addObject:@"骨科"];
    [labelArray addObject:@"口腔疾病"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    labelArray = [[NSMutableArray alloc]init];
    [myDictionary setValue:@"test_hh_health_ico10" forKey:@"ico"];
    [myDictionary setValue:@"上门服务" forKey:@"title"];
    [labelArray addObject:@"上门保健"];
    [labelArray addObject:@"上门接诊"];
    [labelArray addObject:@"上门送药"];
    [myDictionary setValue:labelArray forKey:@"labelArray"];
    [self.serviceList addObject:myDictionary];
    
    //整页滚动
    self.homeScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.homeScroll.contentSize=CGSizeMake(ScreenWidth, 1100);
    self.homeScroll.showsHorizontalScrollIndicator=NO;
    self.homeScroll.showsVerticalScrollIndicator=NO;
    self.homeScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.homeScroll];
    
    //顶部滚动
    self.preferentialScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenWidth*297/640)];
    self.preferentialScroll.tag = 198813;
    self.preferentialScroll.delegate=self;
    self.preferentialScroll.pagingEnabled=YES;        //整页滚动
    self.preferentialScroll.bounces=NO;
    self.preferentialScroll.alwaysBounceVertical=NO;
    self.preferentialScroll.alwaysBounceHorizontal=YES;
    self.preferentialScroll.showsHorizontalScrollIndicator=NO;
    self.preferentialScroll.showsVerticalScrollIndicator=NO;
    //    self.bannerScroll.backgroundColor=[UIColor redColor];
    [self.homeScroll addSubview:self.preferentialScroll];
    
    self.preferentialPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.preferentialScroll.frame.origin.y+self.preferentialScroll.frame.size.height-20, ScreenWidth, 20)];
    self.preferentialPageControl.tag=198814;
    //    [self.preferentialPageControl setPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"hh_dot_white_ico.jpg"]]];
    [self.preferentialPageControl setValue:[UIImage imageNamed:@"hh_dot_biue_ico"] forKey:@"_currentPageImage"];
    [self.preferentialPageControl setValue:[UIImage imageNamed:@"hh_dot_white_ico"]  forKey:@"_pageImage"];
    [self.homeScroll addSubview:self.preferentialPageControl];
    
    
    
    
    
    
    //commodityCollection layout
    //    UICollectionViewFlowLayout *fl02 = [[UICollectionViewFlowLayout alloc]init];
    //    fl02.minimumInteritemSpacing = 4;//每列最小边距
    //    fl02.minimumLineSpacing = 6;//每行最小边距
    
    
    //    CGRect rect = CGRectMake(10, self.preferentialScroll.frame.origin.y+self.preferentialScroll.frame.size.height+10, ScreenWidth-20, self.view.bounds.size.height-self.preferentialScroll.frame.size.height-70);
    CGRect rect = CGRectMake(10, self.preferentialScroll.frame.origin.y+self.preferentialScroll.frame.size.height+10, ScreenWidth-20, 1000-self.preferentialScroll.frame.size.height);
    rect.size.height -= 64;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;//每列最小边距
    flowLayout.minimumLineSpacing = 10;//每行最小边距
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor = dilutedGrayColor;
    self.myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    [self.myCollectionView registerClass:[HHHealthCollectionCell class] forCellWithReuseIdentifier:@"HHHealthCollectionCell"];
    
    
    
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    
    [self.homeScroll addSubview:self.myCollectionView];
    
    
    
    
    //    [self jumpToWebViewWithUrlStr:@"http://www.baidu.com" title:@"百度"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"项目即将加载！！！！");
    [super viewWillAppear:animated];
    //    [MobClick beginLogPageView:@"PageThree"];
    [self fetchData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)fetchData
{
    [super showGif];
    
    //    if (success1 == NO) {
    //        [super showGif];
    //        [commonModel requestgethome:nil httpRequestSucceed:@selector(gethomeSuccess:) httpRequestFailed:@selector(requestFailed:)];
    //    }
    //
    //    if (success2 == NO) {
    [commonModel getServerData:nil httpRequestSucceed:@selector(getfuwuSuccess:) httpRequestFailed:@selector(requestFailed:)];
    //    }
    
}






- (void)getfuwuSuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    switch ([code integerValue]) {
        case 200:
        {
            success2 = YES;
            //            self.serviceList = [completeDic objectForKey:@"result"];
            //            [self.myCollectionView reloadData];
            
        }
            break;
        case 1100:
            break;
        default:
            break;
    }
    
    [commonModel getTopBanner:nil httpRequestSucceed:@selector(getMiddleBannerSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}


//获取中间banner广告接口数据成功
-(void)getMiddleBannerSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringBanner02];
    NSLog(@"getMiddleBannerSuccess：%@！！！！",dic);
    
    self.preferentialArray = dic[@"result"];
    
    self.preferentialScroll.contentSize=CGSizeMake(self.preferentialScroll.bounds.size.width*(self.preferentialArray.count), 1);
    [self.preferentialPageControl setNumberOfPages:self.preferentialArray.count];
    [self.preferentialPageControl setCurrentPage:0];
    //加载页面显示数据
    for(int i=0;i<self.preferentialArray.count;i++){
        NSDictionary *myDictionary = self.preferentialArray[i];
        
        UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.preferentialScroll.frame.size.width, 0, self.preferentialScroll.frame.size.width, self.preferentialScroll.frame.size.height)];
        //         NSLog(@"getMiddleBanner图片地址为：%@！！！！",myDictionary[@"image"]);
        [imageview setImageWithURL:[NSURL URLWithString:myDictionary[@"image"]]];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.tag = i;
        //        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPreferentialImageView:)];
        [imageview addGestureRecognizer:singleTap1];
        
        [self.preferentialScroll addSubview:imageview];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误！！！！！！");
}

//本周特惠banner图片点击事件
- (void)clickPreferentialImageView:(UIGestureRecognizer *)tapGesture
{
    NSLog(@"点击了本周特惠图片链接！！！！");
    
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag;
    //    [self enterURLPage:self.preferentialArray[index][@"url"]];
    [self enterURLPage:self.preferentialArray[index][@"url"]];
}

//根据点击的url跳转页面
- (void)enterURLPage:(NSString *)url
{
    NSLog(@"即将跳转到网页url%@!!!!!!!!!!!!!!",url);
    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
    [detailViewController initWithUrl:url andTitle:@""];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

//呼叫客服电话
- (void)callPhone
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"通过淮海生活客服电话下单" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-010-8111", nil];
    [sheet showInView:self.view];
    
    
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"4000108111"];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        
        [[UIApplication sharedApplication] openURL:url];
    }
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
    
    if (scrollView.tag==198813) {
        
        
        // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
        int current = scrollView.contentOffset.x/scrollView.bounds.size.width;
        
        NSLog(@"scrollView  当前页数为 %d",current);
        
        UIPageControl *page = (UIPageControl *)[self.view viewWithTag:198814];
        page.currentPage = current;
        
    }
    
}



#pragma  mark UITableViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.serviceList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHHealthCollectionCell *cell = (HHHealthCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HHHealthCollectionCell" forIndexPath:indexPath];
    if(indexPath.section==0)
    {
        cell.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = [self.serviceList objectAtIndex:indexPath.row];
        
        
        [cell setCellInfo:dic];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGSize size = {320,164};
//    return size;
//}

//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    MyHeadView *headView = nil;
//
//    if([kind isEqual:UICollectionElementKindSectionHeader])
//    {
//        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hxwHeader" forIndexPath:indexPath];
//        [headView.imagePlayerView initWithCount:self.bannerList.count delegate:self];
//    }
//    return headView;
//}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if (section>0) {
    return UIEdgeInsetsMake(0, 0, 0, 0);//22.5
    //    }
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2);
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 18;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 25;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.serviceList objectAtIndex:indexPath.row];
    //    NSString *urlStr = [dic objectForKey:@"url"];
    [self jumpToWebViewWithUrlStr:nil];
}


- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    NSDictionary *dic = [self.bannerList objectAtIndex:index];
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"img"]];
    [imageView setImageWithURL:imageUrl placeholderImage:nil];
    //    imageView.image = [UIImage imageNamed:@"placeHolderImage"];
    //    imageView.image = [UIImage imageNamed:@"1"];//[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.imageURLs objectAtIndex:index]]];
    
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
    NSDictionary *dic = [self.bannerList objectAtIndex:index];
    NSString *urlStr = [dic objectForKey:@"url"];
    [self jumpToWebViewWithUrlStr:urlStr ];
}

- (void)jumpToWebViewWithUrlStr:(NSString *)urlStr
{
    //跳web页面
    MyWebViewController *myWebViewController = [[MyWebViewController alloc] init];
    myWebViewController.myUrl =  (urlStr==nil)?@"https://www.hao123.com":urlStr;
    
    [self.navigationController pushViewController:myWebViewController animated:YES];
    //    [detailViewController release];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [MobClick endLogPageView:@"PageThree"];
}
@end
