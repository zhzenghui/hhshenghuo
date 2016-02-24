//
//  HHShoppingController.m
//  sjsh
//
//  Created by savvy on 16/1/14.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHShoppingController.h"
#import "ErWeiMaViewController.h"
//#import "ZBarReaderViewController.h"
#import "OpenURLViewController.h"

#import "AppDelegate.h"
//#import "MobClick.h"
#import "HHShoppingCategoryCell.h"
#import "HHShoppingCommodityCell.h"
#import "MyOrderDetailViewController.h"
#import "QuickmarkViewController.h"
#import "ShoppingCartController.h"
#import "HHShopListController.h"


#define mainUrl   @"http://www.sjsh8.cn/index.php?route=common/wap_index"

@interface HHShoppingController (){
    float screenDistance ;//屏幕左右两边的边距
    int maxIndex;           //banner的最大数量
    
    UITextField *currentTextField;
}

@property(nonatomic,strong)UIScrollView *homeScroll;
@property(nonatomic, strong) NSMutableArray *topBannerArray;       //顶部广告banner数据
@property(nonatomic, strong) NSMutableArray *categoryCollectionArray;       //商品类别数据
@property(nonatomic, strong) NSMutableArray *preferentialArray;       //本周特惠商品banner数据
@property(nonatomic, strong) NSMutableArray *commodityCollectionArray;       //商品数据


@property (nonatomic, strong) NSString *stringBanner01;
@property (nonatomic, strong) NSString *stringSort;
@property (nonatomic, strong) NSString *stringBanner02;
@property (nonatomic, strong) NSString *stringCommodity;

//@property (nonatomic, strong) UISearchBar *commoditySearchBar;//商品搜索框
@property (nonatomic, strong) NSString *searchingContent;//正在输入的搜索内容
@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容

@end

@implementation HHShoppingController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [super initNavBarItems:@"淮海生活"];
    
    //搜索框
    //    self.commoditySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    //    self.commoditySearchBar.placeholder = @"请搜索商品";   //设置占位符
    //    self.commoditySearchBar.delegate = self;   //设置控件代理
    ////    [self.view addSubview:self.commoditySearchBar];
    //    [self.navigationItem setTitleView:self.commoditySearchBar];
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    [self.navigationItem setTitleView:searchView];
    
    UIImageView *serachBackageView = [[UIImageView alloc]initWithFrame:CGRectMake(-20, searchView.frame.size.height-15, searchView.frame.size.width+40, 5)];
    serachBackageView.image = [UIImage imageNamed:@"hh_backage_serach"];
    serachBackageView.contentMode = UIViewContentModeScaleAspectFit;
    [searchView addSubview:serachBackageView];
    
    UIImageView *serachIcoView = [[UIImageView alloc]initWithFrame:CGRectMake(-15, 0, 12, 40)];
    serachIcoView.image = [UIImage imageNamed:@"hh_ico_search"];
    serachIcoView.contentMode = UIViewContentModeScaleAspectFit;
    [searchView addSubview:serachIcoView];
    
    UITextField *serachTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, searchView.frame.size.width-10, 40)];
    //    [serachTextField setPlaceholder:@"请搜索商品"];
    serachTextField.font = [UIFont systemFontOfSize:13];
    serachTextField.delegate = self;
    serachTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入想要搜索的商品" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]}];
    serachTextField.textColor = [UIColor whiteColor];
    [searchView addSubview:serachTextField];
    
    
    
    
    //    [super addButtonReturn:@"erweima" lightedImage:@"erweima" selector:@selector(startZBarReaderViewController)];
    [super addRightButton:@"hh_ico_cart" lightedImage:@"hh_ico_cart" selector:@selector(gotoBuyingCarPage)];
    [super addButtonReturn:@"hh_ico_menu" lightedImage:@"hh_ico_menu" selector:nil];
    
    screenDistance=5.0;
    maxIndex=0;
    self.view.backgroundColor = dilutedGrayColor;
    
    self.stringBanner01 = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151221\/145067931581491.jpg\",\"url\":\"sjsh:\/\/product?id=6995\",\"comtent\":\"\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151210\/1449748872413621.jpg\",\"url\":\"sjsh:\/\/product?id=6894\",\"comtent\":\"\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151123\/1448269137791372.jpg\",\"url\":\"sjsh:\/\/product?id=6883\",\"comtent\":\"\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151120\/144803096111523.jpg\",\"url\":\"sjsh:\/\/product?id=6881\",\"comtent\":\"\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151111\/144723370142031.jpg\",\"url\":\"sjsh:\/\/service\/?url=http%3A%2F%2Fwww.sjsh8.cn%2F%3Froute%3Dmobile%2Ffuwu%2Finformation%26id%3D25\",\"comtent\":\"\"}]}";
    
    self.stringSort = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"title\":\"\u9001\u6c34\",\"title1\":\"\u4f1a\u5458\u4ef79\u6298\",\"title2\":\"\u6876\u88c5\u6c34\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/sshuiicon.png\",\"rgb\":\"84,186,224\",\"web\":\"#54bae0\",\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=mobile\/fuwu\/songshui\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u74f6\u88c5\u6c34\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/watericon.png\",\"rgb\":\"62,186,64\",\"web\":\"#3eba40\",\"href\":\"sjsh:\/\/category?id=516\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u9152\u6c34\u996e\u6599\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/bearicon.png\",\"rgb\":\"224,96,83\",\"web\":\"#e06053\",\"href\":\"sjsh:\/\/category?id=69\"},{\"title\":\"\u5bb6\u653f\",\"title1\":\"\u4f1a\u5458\u4ef79\u6298\",\"title2\":\"\u5c0f\u65f6\u5de5\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/baojieicon.png\",\"rgb\":\"88,203,134\",\"web\":\"#58cb86\",\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=mobile\/fuwu\/baojie\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u7ef4\u4fee\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/weixicon.png\",\"rgb\":\"100,137,217\",\"web\":\"#6489d9\",\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=mobile\/fuwu\/jiadian\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u5bb6\u7535\u6e05\u6d17\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/cleanricon.png\",\"rgb\":\"126,82,157\",\"web\":\"#7e529d\",\"href\":\"http:\/\/www.sjsh8.cn\/index.php?route=mobile\/fuwu\/qingxi\"},{\"title\":\"\u679c\u9c9c\",\"title1\":\"\u4f1a\u5458\u7279\u4ef7\",\"title2\":\"\u6c34\u679c\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/fruiticon.png\",\"rgb\":\"255,156,0\",\"web\":\"#ff9c00\",\"href\":\"sjsh:\/\/category?id=272\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u852c\u83dc\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/shucicon.png\",\"rgb\":\"150,201,60\",\"web\":\"#96c93c\",\"href\":\"sjsh:\/\/category?id=359\"},{\"title\":\"\",\"title1\":\"\",\"title2\":\"\u5976\u86cb\",\"img\":\"http:\/\/lib.sjsh8.cn\/weidian\/icon\/naiicon.png\",\"rgb\":\"244,204,90\",\"web\":\"#7e529d\",\"href\":\"sjsh:\/\/category?id=65\"}]}";
    
    self.stringBanner02 = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"image\":\"http:\/\/www.sjsh8.cn\/image\/data\/guanggao\/151120002908-403.jpg\",\"url\":\"http:\/\/www.sjsh8.cn\/wechat\/customer?pay=1\",\"comtent\":\"\"}]}";
    
    self.stringCommodity = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151223\/1450875366142222.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=6996\",\"com\":\"\u8d63\u5357\u6a59\u4e09\u767e\u5c71\u8110\u6a591\u7bb1\",\"price\":\"130\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151223\/1450874277158066.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=7085\",\"com\":\"\u5c71\u897f\u5b81\u5316\u5e9c\u7cbe\u917f\u8001\u9648\u918b\",\"price\":\"23\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151223\/1450877168844945.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=6881\",\"com\":\"\u6d1b\u5ddd\u82f9\u679c1\u7bb1\uff0812\u4e2a\u793c\u76d2\uff09\",\"price\":\"90\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151223\/1450876466743432.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=6848\",\"com\":\"\u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"price\":\"35\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151202\/1449067009413513.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=6963\",\"com\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"price\":\"15\"},{\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/20151223\/1450876979704565.jpg\",\"recommend_url\":\"sjsh:\/\/product?id=6914\",\"com\":\"\u767e\u8349\u6e90 \u65b0\u7586\u548c\u7530\u7389\u67a3500g\",\"price\":\"22\"}]}";
    
    //测试数据
    self.categoryCollectionArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping01" forKey:@"ico"];
    [myDictionary setValue:@"食品" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:246.0/255.0 green:192.0/255.0 blue:75.0/255.0 alpha:1.0] forKey:@"color"];
     [myDictionary setValue:@"sjsh://category?id=516" forKey:@"href"];
    
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping02" forKey:@"ico"];
    [myDictionary setValue:@"日用" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:84.0/255.0 green:176.0/255.0 blue:224.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping03" forKey:@"ico"];
    [myDictionary setValue:@"生鲜" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:192.0/255.0 green:211.0/255.0 blue:60.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping04" forKey:@"ico"];
    [myDictionary setValue:@"保健品" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:243.0/255.0 green:149.0/255.0 blue:186.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping05" forKey:@"ico"];
    [myDictionary setValue:@"家庭常备" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:250.0/255.0 green:79.0/255.0 blue:45.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping06" forKey:@"ico"];
    [myDictionary setValue:@"医疗器械" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:51.0/255.0 green:102.0/255.0 blue:153.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping07" forKey:@"ico"];
    [myDictionary setValue:@"养生会所" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:192.0/255.0 green:211.0/255.0 blue:60.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping08" forKey:@"ico"];
    [myDictionary setValue:@"健身场所" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:246.0/255.0 green:192.0/255.0 blue:75.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"test_hh_shopping09" forKey:@"ico"];
    [myDictionary setValue:@"生活百科" forKey:@"title2"];
    [myDictionary setValue:[UIColor colorWithRed:84.0/255.0 green:176.0/255.0 blue:224.0/255.0 alpha:1.0] forKey:@"color"];
    [self.categoryCollectionArray addObject:myDictionary];
    
    
    
    //页面布局*******************************
    self.homeScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.homeScroll.contentSize=CGSizeMake(self.bannerScroll.bounds.size.width, 1300);
    self.homeScroll.showsHorizontalScrollIndicator=NO;
    self.homeScroll.showsVerticalScrollIndicator=NO;
    self.homeScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.homeScroll];
    
    //banner*******************************
    self.bannerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*240/640)];
    self.bannerScroll.tag = 198811;
    self.bannerScroll.delegate=self;
    self.bannerScroll.pagingEnabled=YES;        //整页滚动
    self.bannerScroll.bounces=NO;
    self.bannerScroll.alwaysBounceVertical=NO;
    self.bannerScroll.alwaysBounceHorizontal=YES;
    self.bannerScroll.showsHorizontalScrollIndicator=NO;
    self.bannerScroll.showsVerticalScrollIndicator=NO;
    //    self.bannerScroll.backgroundColor=[UIColor redColor];
    [self.homeScroll addSubview:self.bannerScroll];
    
    //    self.bannerPageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.464-40, ScreenWidth, 40)];
    //    self.bannerPageControl.tag=198801;
    //    self.bannerPageControl.numberOfPages = 6-2;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    //    //    self.bannerPageControl.currentPage=0;
    //    [self.homeScroll addSubview:self.bannerPageControl];
    
    self.myBannerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bannerScroll.frame.origin.y+self.bannerScroll.frame.size.height-20, ScreenWidth, 20)];
    self.myBannerPageControl.tag=198812;
    //    self.myBannerPageControl.numberOfPages = 6-2;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    //    self.myBannerPageControl.currentPage = 0;
    
    //    self.bannerPageControl.currentPage=0;
    //    [self.myBannerPageControl setCurrentPageIndicatorTintColor:fontBlueWithHH];
    [self.myBannerPageControl setValue:[UIImage imageNamed:@"hh_dot_biue_ico"] forKey:@"_currentPageImage"];
    [self.myBannerPageControl setValue:[UIImage imageNamed:@"hh_dot_white_ico"]  forKey:@"_pageImage"];
    [self.homeScroll addSubview:self.myBannerPageControl];
    
    
    //    int maxIndex = 4;
    //    //测试数据
    //    for(int i=0;i<maxIndex;i++){
    //
    //        if (i==0) {
    //            UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
    //            NSString *imageName = [NSString stringWithFormat:@"test_%d.jpg",maxIndex-1];
    //            UIImage *image=[UIImage imageNamed:imageName];
    //            imageview.image=image;
    //            [self.bannerScroll addSubview:imageview];
    //        }
    //
    //        UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
    //        NSString *imageName = [NSString stringWithFormat:@"test_%d.jpg",i];
    //        UIImage *image=[UIImage imageNamed:imageName];
    //        imageview.image=image;
    //        [self.bannerScroll addSubview:imageview];
    //
    //        if (i==(maxIndex-1)) {
    //            UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((maxIndex+1)*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
    //            NSString *imageName = [NSString stringWithFormat:@"test_%d.jpg",0];
    //            UIImage *image=[UIImage imageNamed:imageName];
    //            imageview.image=image;
    //            [self.bannerScroll addSubview:imageview];
    //        }
    //    }
    //    [self.bannerScroll scrollRectToVisible:CGRectMake(self.bannerScroll.bounds.size.width,0,self.bannerScroll.bounds.size.width,self.bannerScroll.bounds.size.height) animated:NO];
    
    
    //UICollectionView layout
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.minimumInteritemSpacing = 0.0;//每列最小边距
    fl.minimumLineSpacing = 1;//每行最小边距
    
    self.categoryCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bannerScroll.frame.origin.y+self.bannerScroll.frame.size.height+0.5                                               , ScreenWidth, ScreenWidth+0.1) collectionViewLayout:fl];
    self.categoryCollection.tag = 198801;
    self.categoryCollection.delegate = self;
    self.categoryCollection.dataSource = self;
    self.categoryCollection.backgroundColor = lineGrayColorWithHH;
    [self.categoryCollection registerClass:[HHShoppingCategoryCell class] forCellWithReuseIdentifier:@"HHShoppingCategoryCell"];//注册缓存标识
    //    self.categoryCollection.backgroundColor=[UIColor clearColor];
    
    //    [self.categoryCollection setBackgroundColor:[UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244  /255.0 alpha:1]];
    //    self.categoryCollection.backgroundColor = [UIColor clearColor];
    [self.homeScroll addSubview:self.categoryCollection];
    
    //    //测试数据
    //    self.categoryCollectionArray = [[NSMutableArray alloc] init];
    //    for (int i=0; i<9; i++) {
    //        NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
    //        [categoryDictionary setValue:@"111" forKey:@"imageUrl"];
    //        [self.categoryCollectionArray addObject:categoryDictionary];
    //    }
    
    //本周特惠商品banner*******************************
    self.preferentialScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, self.categoryCollection.frame.origin.y+self.categoryCollection.frame.size.height+10,ScreenWidth, ScreenWidth*255/640)];
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
    [self.preferentialPageControl setValue:[UIImage imageNamed:@"hh_dot_biue_ico"] forKey:@"_currentPageImage"];
    [self.preferentialPageControl setValue:[UIImage imageNamed:@"hh_dot_white_ico"]  forKey:@"_pageImage"];
    [self.homeScroll addSubview:self.preferentialPageControl];
    
    
    //commodityCollection layout
    UICollectionViewFlowLayout *fl02 = [[UICollectionViewFlowLayout alloc]init];
    fl02.minimumInteritemSpacing = 0.0;//每列最小边距
    fl02.minimumLineSpacing = 1.0;//每行最小边距
    
    self.commodityCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.preferentialScroll.frame.origin.y+self.preferentialScroll.frame.size.height+10, ScreenWidth, (ScreenWidth)*0.5*1.537*2+5) collectionViewLayout:fl02];
    self.commodityCollection.tag = 198802;
    self.commodityCollection.delegate = self;
    self.commodityCollection.dataSource = self;
    self.commodityCollection.backgroundColor = lineGrayColorWithHH;
    [self.commodityCollection registerClass:[HHShoppingCommodityCell class] forCellWithReuseIdentifier:@"HHShoppingCommodityCell"];//注册缓存标识
    //    self.commodityCollection.backgroundColor=[UIColor clearColor];
    [self.homeScroll addSubview:self.commodityCollection];
    
    CALayer *bottomBorder=[[CALayer alloc]init];
    bottomBorder.frame=CGRectMake(0, 0, self.commodityCollection.frame.size.width, 0.5);
    bottomBorder.backgroundColor=lineGrayColor.CGColor;
    [self.commodityCollection.layer addSublayer:bottomBorder ];
    
    //    //测试数据
    //    self.commodityCollectionArray = [[NSMutableArray alloc] init];
    //    for (int i=0; i<4; i++) {
    //        NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
    //        [categoryDictionary setValue:@"111" forKey:@"imageUrl"];
    //        [self.commodityCollectionArray addObject:categoryDictionary];
    //    }
    
    [self initUI];
}





//调用接口显示页面主体
-(void)initUI{
    [super showGif];
    [commonModel getTopBanner:nil httpRequestSucceed:@selector(requestTopBannerSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

//获取首页顶部banner接口数据成功
-(void)requestTopBannerSuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringBanner01];
    NSLog(@"requestTopBannerSuccess：%@！！！！",dic);
    
    self.topBannerArray = dic[@"result"];
    
    if(self.topBannerArray&&self.topBannerArray.count>0){
        maxIndex = self.topBannerArray.count;
        
        
        NSDictionary *myFirstDictionary = self.topBannerArray[0];
        NSDictionary *myEndDictionary = self.topBannerArray[maxIndex-1];
        self.bannerScroll.contentSize=CGSizeMake(self.bannerScroll.bounds.size.width*(maxIndex+2), 1);
        //        self.myBannerPageControl.PointWidth = 15.0;
        //        self.myBannerPageControl.PointHeight = 2.0;
        //        self.myBannerPageControl.distanceOfPoint = 5.0;
        [self.myBannerPageControl setNumberOfPages:maxIndex];
        [self.myBannerPageControl setCurrentPage:0];
        //加载页面显示数据
        for(int i=0;i<maxIndex;i++){
            NSDictionary *myDictionary = self.topBannerArray[i];
            
            if (i==0) {
                UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
                [imageview setImageWithURL:[NSURL URLWithString:myEndDictionary[@"image"]]];
                imageview.tag = maxIndex-1;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
                [imageview addGestureRecognizer:singleTap1];
                [self.bannerScroll addSubview:imageview];
            }
            
            UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
            [imageview setImageWithURL:[NSURL URLWithString:myDictionary[@"image"]]];
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.tag = i;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
            [imageview addGestureRecognizer:singleTap1];
            
            [self.bannerScroll addSubview:imageview];
            
            if (i==(maxIndex-1)) {
                UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((maxIndex+1)*self.bannerScroll.frame.size.width, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height)];
                [imageview setImageWithURL:[NSURL URLWithString:myFirstDictionary[@"image"]]];
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.tag = 0;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerImageView:)];
                [imageview addGestureRecognizer:singleTap1];
                
                [self.bannerScroll addSubview:imageview];
            }
        }
        [self.bannerScroll scrollRectToVisible:CGRectMake(self.bannerScroll.bounds.size.width,0,self.bannerScroll.bounds.size.width,self.bannerScroll.bounds.size.height) animated:NO];
    }else{
        maxIndex = 0;
    }
    //调用商品类别接口
    [commonModel getHomeCategory:nil httpRequestSucceed:@selector(getHomeCategorySuccess:) httpRequestFailed:@selector(requestFailed:)];
}

//获取商品类别接口接口数据成功
-(void)getHomeCategorySuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringSort];
    NSLog(@"getHomeCategorySuccess：%@！！！！",dic);
    
    NSArray *myResultArray = dic[@"result"];
    //测试数据
    //    self.categoryCollectionArray = [myResultArray mutableCopy];
    //
    //    [self.categoryCollection reloadData];
    
    
    [commonModel getMiddleBanner:nil httpRequestSucceed:@selector(getMiddleBannerSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}


//获取中间banner广告接口数据成功
-(void)getMiddleBannerSuccess:(ASIHTTPRequest *)request{
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
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.tag = i;
        //        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPreferentialImageView:)];
        [imageview addGestureRecognizer:singleTap1];
        
        [self.preferentialScroll addSubview:imageview];
    }
    
    
    
    
    
    [commonModel getHomeCommodity:nil httpRequestSucceed:@selector(getHomeCommoditySuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

//获取商品信息展示
-(void)getHomeCommoditySuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringCommodity];
    NSLog(@"getHomeCommoditySuccess：%@！！！！",dic);
    
    NSArray *myResultArray = dic[@"result"];
    //     NSLog(@"getHomeCommoditySuccess：%lu！！！！",myResultArray.count);
    self.commodityCollectionArray = [myResultArray mutableCopy];
    
    
    float commodityCollectionHeight = (ScreenWidth)*0.5*1.537*(self.commodityCollectionArray.count/2)+2;
    CGRect commodityCollectionCGRect = self.commodityCollection.frame;
    commodityCollectionCGRect.size.height = commodityCollectionHeight;
    NSLog(@"高度为：%lu！！！！",((self.commodityCollectionArray.count-1)/2)+1);//count从1开始
    self.homeScroll.contentSize=CGSizeMake(self.bannerScroll.bounds.size.width, 710+commodityCollectionHeight);
    self.commodityCollection.frame = commodityCollectionCGRect;
    [self.commodityCollection reloadData];
    
}




- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误！！！！！！");
}


-(void)toErWeiMaPage{
    
    ErWeiMaViewController *erWeiMaViewController = [[ErWeiMaViewController alloc] init];
    [self.navigationController pushViewController:erWeiMaViewController animated:YES];
    [erWeiMaViewController release];
}

//根据点击的url跳转页面
- (void)enterURLPage:(NSString *)url
{
    NSLog(@"即将跳转到网页url%@!!!!!!!!!!!!!!",url);
    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
    [detailViewController initWithUrl:url andTitle:@""];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

//顶部banner图片点击事件
- (void)clickBannerImageView:(UIGestureRecognizer *)tapGesture
{
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag;
    //    [self enterURLPage:self.topBannerArray[index][@"url"]];
    [self goPageByURL:self.topBannerArray[index][@"url"]];
}

//本周特惠banner图片点击事件
- (void)clickPreferentialImageView:(UIGestureRecognizer *)tapGesture
{
    NSLog(@"点击了本周特惠图片链接！！！！");
    
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag;
    //    [self enterURLPage:self.preferentialArray[index][@"url"]];
    [self goPageByURL:self.preferentialArray[index][@"url"]];
}

//返回上一页
-(void)backHomePage{
    [self.navigationController popViewControllerAnimated:YES];
    //重载cookie,以免部分值域丢失
    [super reloadStoredCookies];
}
- (void)startActivityView{
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.backgroundColor = [UIColor clearColor];
    activityView.frame = CGRectMake(130.0f, 250.0f, 45.0f, 45.0f);
    [activityView startAnimating];
    [self.view addSubview:activityView];
    [activityView release];
}

- (void)stopActivityView{
    [activityView stopAnimating];
}

//根据网址跳转到不同页面
- (void)goPageByURL:(NSString *)urlStr{
    
    NSLog(@"即将跳转到url:%@!!!!!!",urlStr);
    if ([urlStr hasPrefix:@"sjsh://orders/?order_id="]) {//跳转到订单详情
        NSLog(@"跳转到订单详情!!!!!!");
        //进入订单页
        //        [super pushToOrderPage];
        NSString *orderId = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://orders/?order_id=" withString:@""];
        MyOrderDetailViewController *detailVc = [[MyOrderDetailViewController alloc] init];
        detailVc.orderID = orderId;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else if ([urlStr hasPrefix:@"sjsh://product?id="]){//跳转到商品详情
        NSLog(@"跳转到商品详情!!!!!!");
        NSString *productID = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://product?id=" withString:@""];
        CommodityDetailController *myController = [[CommodityDetailController alloc] init];
        myController.productID = productID;
        [self.navigationController pushViewController:myController animated:YES];
    }else if ([urlStr hasPrefix:@"sjsh://category?id="]){//跳转到商品列表
        NSLog(@"跳转到商品列表!!!!!!");
        NSString *categoryID = [urlStr stringByReplacingOccurrencesOfString:@"sjsh://category?id=" withString:@""];
                HHShopListController *myController = [[HHShopListController alloc] init];
                myController.theCategoryId = categoryID;
                [self.navigationController pushViewController:myController animated:YES];
//                UIButton *shangpinTab = [UIButton buttonWithType:UIButtonTypeCustom];
//                shangpinTab.tag = [categoryID integerValue];
//        [[ConstObject instance] setCategoryId:categoryID];
//        [[AppDelegate shareDelegate] tabClickAction:[AppDelegate shareDelegate].shangpinTab];
    }else{
        NSLog(@"跳转到网页!!!!!!");
        [self enterURLPage:urlStr];//跳转网页
    }
    
}

//进入购物车页面
- (void)gotoBuyingCarPage
{
    ShoppingCartController *shoppingCart = [[ShoppingCartController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    //根据scrollView 的位置对page 的当前页赋值（scrollView数量比指示器多2）
    
    if (scrollView.tag==198811) {
        //        int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        
        YHR_PageControl *page = (YHR_PageControl *)[self.view viewWithTag:198812];
        int currentPage=0;
        //    int myMmaxIndex=maxIndex-1;//从0开始
        
        if(current==0){
            currentPage = maxIndex-1;
        }else if(current==maxIndex+1){
            currentPage = 0;
        }else{
            currentPage = current-1;
        }
        page.currentPage = currentPage;
        
        if (scrollView.contentOffset.x == 0) {
            // 用户滑动到1号位置，此时必须跳转到倒2的位置
            [scrollView scrollRectToVisible:CGRectMake(scrollView.contentSize.width - 2 * scrollView.bounds.size.width,0,scrollView.bounds.size.width,scrollView.bounds.size.height) animated:NO];
        }
        else if (scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width) {
            // 用户滑动到最后的位置，此时必须跳转到2号位置
            [scrollView scrollRectToVisible:CGRectMake(scrollView.bounds.size.width,0,scrollView.bounds.size.width,scrollView.bounds.size.height) animated:NO];
        }
    }else{
        
        
        UIPageControl *page = (UIPageControl *)[self.view viewWithTag:198814];
        page.currentPage = current;
        
    }
    
}


#pragma -mark UICollectionView 代理方法

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger conut = 0;
    if (collectionView.tag==198801) {
        conut = self.categoryCollectionArray.count;
    }else if (collectionView.tag==198802){
        conut =  self.commodityCollectionArray.count;
    }
    return conut;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==198801) {
        
        return CGSizeMake((ScreenWidth-2)/3, (ScreenWidth-2)/3);
        
    }else{
        return CGSizeMake((ScreenWidth-1)/2, (ScreenWidth)*0.5*1.537);
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag==198801) {
        HHShoppingCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHShoppingCategoryCell" forIndexPath:indexPath];
        
        cell.position = indexPath.row;
        
        [cell setCellInfo:self.categoryCollectionArray[indexPath.row]];
        cell.tag = indexPath.row;
        return cell;
    }else{
        HHShoppingCommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHShoppingCommodityCell" forIndexPath:indexPath];
        [cell setCellInfo:self.commodityCollectionArray[indexPath.row]];
        return cell;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击的cell是%ld!!!!!!",(long)indexPath.row)
    NSString *myUrl = nil;
    if (collectionView.tag==198801) {
        myUrl = [NSString stringWithFormat:@"%@",self.categoryCollectionArray[indexPath.row][@"href"] ];
        
    }else{
        myUrl = [NSString stringWithFormat:@"%@",self.commodityCollectionArray[indexPath.row][@"recommend_url"] ];
    }
    
    [self goPageByURL:myUrl];
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}





- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [MobClick endLogPageView:@"PageOne"];
}


#pragma mark UISearchBar代理
//-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"搜索框点击了确认%@！！！！！！！",self.searchingContent);
//    self.searchedContent = self.searchingContent;   //确认内容
//    [searchBar resignFirstResponder];
//      //下面开始处理搜索操作
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
//{
//    NSLog(@"搜索框点击了取消%@！！！！！！！",self.searchingContent);
//    self.searchedContent = nil;     //清除确认内容
//    [searchBar resignFirstResponder];
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
//{
//    NSLog(@"搜索框输入的内容为%@！！！！！！！",searchText);
//    self.searchedContent = nil;         //开始输入后，清楚之前确认的内容
//    self.searchingContent = searchText; //正在输入的内容
//}

#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSLog(@"搜索的内容为:%@!!!!!!!", textField.text);
    [currentTextField resignFirstResponder];
    return YES;
}

@end