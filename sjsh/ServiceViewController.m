//
//  ServiceViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/10.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ServiceViewController.h"
#import "ImagePlayerView.h"
#import "MyHeadView.h"
#import "ServerCollectionCell.h"
#import "OpenURLViewController.h"
@interface ServiceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ImagePlayerViewDelegate>
{
    BOOL success1;
    BOOL success2;
}
@property (nonatomic, retain) UICollectionView *myCollectionView;
@property (nonatomic, retain) NSArray *bannerList;
@property (nonatomic, retain) NSArray *serviceList;

@property (nonatomic, strong) NSString *stringList;
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    success1 = NO;
    success2 = NO;
    [self initNavBarItems:@"服务"];
    [super addRightButton:@"400" lightedImage:@"400" selector:@selector(call400)];
    
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/jzbj.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/baojie&from=1\",\"flag\":0,\"title\":\"\u5bb6\u653f\u4fdd\u6d01\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/ss.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/songshui&from=1\",\"flag\":\"http:\/\/lib.sjsh8.cn\/wechat\/images\/iconpic-huiyuan.png\",\"title\":\"\u9001\u6c34\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/wx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/jiadian&from=1\",\"flag\":0,\"title\":\"\u7ef4\u4fee\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/wywx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/jiaofei&from=1\",\"flag\":0,\"title\":\"\u7f34\u8d39\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/xy.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/xiyi&from=1\",\"flag\":0,\"title\":\"\u6d17\u8863\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/jdqx.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/qingxi&from=1\",\"flag\":0,\"title\":\"\u5bb6\u7535\u6e05\u6d17\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/kshs.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=weidian\/index&from=1\",\"flag\":0,\"title\":\"\u5f00\u9501\u6362\u9501\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/fwzs.png\",\"url\":\"http:\/\/m.dianping.com\/shoplist\/2\/search?keyword=%E4%B8%96%E7%BA%AA%E5%9F%8E&from=1\",\"flag\":0,\"title\":\"\u623f\u5c4b\u79df\u552e\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/hsc.png\",\"url\":\"http:\/\/h.sjsh8.cn\/wap\/index.php?from=1\",\"flag\":0,\"title\":\"\u6362\u7eb1\u7a97\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/tnam.png\",\"url\":\"http:\/\/thirdparty.zlycare.com\/#\/home?phoneNum=login&source=shijishenghuo\",\"title\":\"\u63a8\u62ff\u6309\u6469\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/qcyh.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/yanglao&from=1\",\"flag\":0,\"title\":\"\u6c7d\u8f66\u517b\u62a4\"},{\"img\":\"http:\/\/lib.sjsh8.cn\/wechat\/icons\/sqyl.png\",\"url\":\"http:\/\/www.sjsh8.cn\/?route=mobile\/fuwu\/yanglao&from=1\",\"flag\":0,\"title\":\"\u793e\u533a\u517b\u8001\"}]}";
    
    CGRect rect = self.view.bounds;
    rect.size.height -= 64;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 1;//每列最小边距
    flowLayout.minimumLineSpacing = 1;//每行最小边距
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
     self.myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
  
    [self.myCollectionView registerClass:[ServerCollectionCell class] forCellWithReuseIdentifier:@"ServerCollectionCell"];
    
    
    
     self.myCollectionView.delegate = self;
     self.myCollectionView.dataSource = self;
     
     [self.view addSubview:self.myCollectionView];
    self.bannerList = [NSArray array];
    self.serviceList = [NSArray array];
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
    
//    if (success1 == NO) {
//        [super showGif];
//        [commonModel requestgethome:nil httpRequestSucceed:@selector(gethomeSuccess:) httpRequestFailed:@selector(requestFailed:)];
//    }
//    
//    if (success2 == NO) {
        [commonModel getServerData:nil httpRequestSucceed:@selector(getfuwuSuccess:) httpRequestFailed:@selector(requestFailed:)];
//    }
    
}

- (void)gethomeSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    switch ([code integerValue]) {
        case 200:
        {
            success1 = YES;
            self.bannerList = [completeDic objectForKey:@"result"];
//            MyHeadView *headerV = (MyHeadView *)[self collectionView:self.myCollectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathWithIndex:0]];
//            [headerV.imagePlayerView initWithCount:self.bannerList.count delegate:self];
            [self.myCollectionView reloadData];
        }
            break;
        case 1100:
            break;
        default:
            break;
    }
    
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
            self.serviceList = [completeDic objectForKey:@"result"];
            [self.myCollectionView reloadData];
            
        }
            break;
        case 1100:
            break;
        default:
            break;
    }
}

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
    ServerCollectionCell *cell = (ServerCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ServerCollectionCell" forIndexPath:indexPath];
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

    return CGSizeMake((ScreenWidth-2)/3, (ScreenWidth-4)/3);
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
    NSString *urlStr = [dic objectForKey:@"url"];
    [self jumpToWebViewWithUrlStr:urlStr title:[dic objectForKey:@"title"]];
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
    [self jumpToWebViewWithUrlStr:urlStr title:@""];
}

- (void)jumpToWebViewWithUrlStr:(NSString *)urlStr title:(NSString *)title
{
    //跳web页面
    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
    [detailViewController initWithUrl:urlStr andTitle:title];
    [self.navigationController pushViewController:detailViewController animated:YES];
//    [detailViewController release];
}

 
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"PageThree"];
}
@end
