//
//  HHShopListController.m
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHShopListController.h"
#import "UIImageView+WebCache.h"
#import "SelectItemView.h"
#import "ShoppingCartController.h"

@interface HHShopListController ()<SelectItemViewDelegate>
{
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    NSInteger currentBtIndex;
    BOOL ascend;
    NSString *sortStr;  //排序方式
    NSInteger myItemIndex;//当前选择的item的序号
}

@property (nonatomic, strong) UISearchBar *commoditySearchBar;//商品搜索框
@property (nonatomic, strong) NSString *searchingContent;//正在输入的搜索内容
@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容



@property (nonatomic, strong) NSString *stringSort;
@property (nonatomic, strong) NSString *stringList;

@end

@implementation HHShopListController
@synthesize dataArray;
@synthesize theCategoryId;
@synthesize categoryListArray;
@synthesize allCount;

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
    
    self.isFirst = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    
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

     [super addRightButton:@"购物车" lightedImage:@"购物车" selector:@selector(gotoBuyingCarPage)];
    [super setHintNum:[[ConstObject instance] cartNum]];
    
    self.stringSort = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"title\":\"\u5168\u90e8\",\"img_on\":\"all_on.png\",\"img\":\"all.png\",\"category_id\":59},{\"title\":\"\u852c\u83dc\",\"img_on\":\"shucai_on.png\",\"img\":\"shucai.png\",\"category_id\":359},{\"title\":\"\u6c34\u679c\",\"img_on\":\"shuiguo_on.png\",\"img\":\"shuiguo.png\",\"category_id\":272},{\"title\":\"\u7cae\u6cb9\u526f\u98df\",\"img_on\":\"liangyou_on.png\",\"img\":\"liangyou.png\",\"category_id\":64},{\"title\":\"\u8089\u79bd\u5976\u86cb\",\"img_on\":\"rouqin_on.png\",\"img\":\"rouqin.png\",\"category_id\":65},{\"title\":\"\u96f6\u98df\u9152\u6c34\",\"img_on\":\"lingshijiushui_on.png\",\"img\":\"lingshijiushui.png\",\"category_id\":69},{\"title\":\"\u6709\u673a\u98df\u54c1\",\"img_on\":\"youjishipin_on.png\",\"img\":\"youjishipin.png\",\"category_id\":300}]}";
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"result\":{\"count\":516,\"data\":[{\"product_id\":\"6930\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e00\u68f5\u6811\u6838\u6843 500g\",\"meta_description\":\"\u5e72\u679c\u7f8e\u98df\uff0c\u8f7b\u677e\u4eab\u7528\",\"price\":\"35.00\",\"special\":\"35.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151123\/1448258932931829-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"5943\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u90fd\u6e2f\u5c0f\u9ec4\u82b1\u9c7c500g\",\"meta_description\":\"\u4ea7\u81ea\u798f\u5efa\u5b81\u5fb7-\u9ec4\u9c7c\u4e4b\u4e61\uff1b\u9ec4\u9c7c\u9c7c\u8089\u7ec4\u7ec7\u67d4\u8f6f\uff0c\u8089\u5ae9\u7ec6\u523a\u5c11\uff0c\u6613\u4e8e\u6d88\u5316\u3002\",\"price\":\"35.00\",\"special\":\"35.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150901\/1441075622549110-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"6963\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e09\u9ec4\u9e21 500g\",\"meta_description\":\"\u751f\u9c9c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"price\":\"15.00\",\"special\":\"15.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151223\/1450885493946352-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"3477\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e1d\u74dc 500g\",\"meta_description\":\"\u679c\u852c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"price\":\"8.00\",\"special\":\"8.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/xianguoyuan\/140813103513-800-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"7011\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e1d\u74dc\u5c16 500g\",\"meta_description\":\"\u679c\u852c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"price\":\"10.00\",\"special\":\"10.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151215\/1450141840416216-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"4802\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e4c\u9e21\u86cb 15\u679a\",\"meta_description\":\"\u751f\u9c9c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\u3002\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u679c\u852c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\u3002\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"price\":\"13.00\",\"special\":\"13.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150819\/1439950519477691-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"6848\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"meta_description\":\"\u65b0\u7c73\u5b63--\u65b0\u7c73\u9a7e\u5230\uff0c\u5bb6\u4e2d\u5fc5\u5907\uff01\u8425\u517b\u4e30\u5bcc\uff0c\u9187\u9999\u53ef\u53e3\",\"price\":\"35.00\",\"special\":\"35.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151013\/1444723326441545-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"6942\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u82b1\u8089 500g\",\"meta_description\":\"\u751f\u9c9c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"price\":\"17.00\",\"special\":\"17.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151123\/1448261739964637-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"6937\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u9999\u82b1\u751f\u7c73 500g\",\"meta_description\":\"\u5e72\u679c\u7f8e\u98df\uff0c\u8f7b\u677e\u4eab\u7528\",\"price\":\"19.00\",\"special\":\"19.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151123\/1448259899229825-128x128.jpg\",\"order_num\":\"0\"},{\"product_id\":\"5931\",\"flag\":\"0\",\"name\":\"\u793e\u533ae\u7ad9 \u4eac\u5e38\u4e00\u54c1\u6709\u673a\u7c735kg\",\"meta_description\":\"\u7c73\u7c92\u5747\u5300\uff0c\u8272\u6cfd\u5149\u4eae\uff0c\u9187\u539a\u7ef5\u957f\uff0c\u82b3\u9999\u56db\u6ea2\",\"price\":\"110.00\",\"special\":\"110.00\",\"image\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150827\/1440639528485123-128x128.jpg\",\"order_num\":\"0\"}]}}";
    
    
    
    //    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    //    if (self.navigationItem) {
    //        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
    //        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部"];
    //        [menu displayMenuInView:self.navigationController.view];
    //        menu.tag = 100000;
    //        menu.items = [NSMutableArray arrayWithArray:@[@"全部"]];
    //        menu.delegate = self;
    //        [self.navigationItem.titleView addSubview:menu];
    //    }
    
    page = 1;
    //    theCategoryId = @"59";
    currentBtIndex = 0;
    ascend = YES;
    sortStr = @"p.sort_order";
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    
    //类别的分割线
    UIImageView *shadowImage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 2, 3, kScreenBounds.size.height - 44.0f)];
    shadowImage.image = [UIImage imageNamed:@"yinying"];
    shadowImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shadowImage];
    
    //左侧类别滚动列表
    self.categoryScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 2, 59, kScreenBounds.size.height -44-40)];
    self.categoryScroll.contentSize = CGSizeMake(59, 0);
    self.categoryScroll.showsHorizontalScrollIndicator = NO;
    self.categoryScroll.showsVerticalScrollIndicator = NO;
    self.categoryScroll.backgroundColor = COLOR(0xf8, 0xf8, 0xf8);
    [self.view addSubview:self.categoryScroll];
    self.categoryScroll.clipsToBounds = NO;
    [self.categoryScroll release];
    
    
    blankButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    blankButton.backgroundColor=[UIColor grayColor];
    [blankButton.layer setMasksToBounds:YES];
    [blankButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [blankButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [blankButton.layer setBorderColor:colorref];//边框颜色
    
    blankButton.frame=CGRectMake(80, (kScreenBounds.size.height - 44-44.0f-38)*0.5, kScreenBounds.size.width-100, 30);
    [blankButton setTitle:@"没有任何商品，点我可刷新。" forState:UIControlStateNormal];
    blankButton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [blankButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [blankButton addTarget:self action:@selector(fetchDataWithPage) forControlEvents:UIControlEventTouchUpInside];
    blankButton.hidden=NO;
    [self.view addSubview:blankButton];
    
    
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(62, 0, kScreenBounds.size.width-62, kScreenBounds.size.height  -44.0f) style:UITableViewStylePlain];
    listTableView.tag = 198802;
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.hidden=YES;
    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTableView];
    
    
//    //排序类型选项
//    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(62, 40, kScreenBounds.size.width-62, 38.0f)] autorelease];
//    //        view.backgroundColor = COLOR(250, 250, 250);
//    view.backgroundColor = [UIColor whiteColor];
//    for (int i = 0; i<4; i++) {
//        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        defaultButton.frame = CGRectMake(65*i, 12, 64, 14);
//        defaultButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
//        [defaultButton setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateNormal];
//        [defaultButton setTitleColor:COLOR(0xfa, 0x63, 0x38) forState:UIControlStateSelected];
//        defaultButton.tag = i;
//        defaultButton.adjustsImageWhenHighlighted = NO;
//        [defaultButton addTarget:self action:@selector(sortData:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:defaultButton];
//        switch (i) {
//            case 0:
//            {
//                defaultButton.selected = YES;
//                [defaultButton setTitle:@"默认" forState:UIControlStateNormal];
//                button1 = defaultButton;
//            }
//                break;
//            case 1:
//            {
//                [defaultButton setTitle:@"价格" forState:UIControlStateNormal];
//                [defaultButton setImage:[UIImage imageNamed:@"jiantou_up1"] forState:UIControlStateNormal];
//                [defaultButton setImage:[UIImage imageNamed:@"jiantou_up2"] forState:UIControlStateSelected];
//                defaultButton.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
//                defaultButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 22);
//                button2 = defaultButton;
//            }
//                break;
//            case 2:
//            {
//                [defaultButton setTitle:@"销量" forState:UIControlStateNormal];
//                [defaultButton setImage:[UIImage imageNamed:@"jiantou_up1"] forState:UIControlStateNormal];
//                [defaultButton setImage:[UIImage imageNamed:@"jiantou_up2"] forState:UIControlStateSelected];
//                defaultButton.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
//                defaultButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 22);
//                button3 = defaultButton;
//            }
//                break;
//            case 3:
//            {
//                [defaultButton setTitle:@"新品" forState:UIControlStateNormal];
//                button4 = defaultButton;
//            }
//                break;
//            default:
//                break;
//        }
//        
//        if (i<3) {
//            UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(65*(i+1)-1, 14, 1, 10)];
//            lineImg.backgroundColor = COLOR(0xdd, 0xdd, 0xdd);
//            [view addSubview:lineImg];
//        }
//        
//    }
//    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 37, view.frame.size.width-30, 1)];
//    lineImg.backgroundColor = COLOR(0xdd, 0xdd, 0xdd);
//    [view addSubview:lineImg];
//    [self.view addSubview:view];
//    
//    //搜索框
//    self.commoditySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    self.commoditySearchBar.placeholder = @"请搜索商品";   //设置占位符
//    self.commoditySearchBar.delegate = self;   //设置控件代理
//    [self.view addSubview:self.commoditySearchBar];
    
    //    [self getCategoryArray];//获取商品类别
    //    [self fetchDataWithPage:page];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //页面加载购物车数量
    if (!self.isFirst) {
        [self performSelector:@selector(getCartNum) withObject:nil afterDelay:0.1];
    }else{//首次进入页面
        NSLog(@"首次进入商品列表！！！！！");
        [self getCategoryArray];//获取商品类别
    }
    self.isFirst = NO;
}

- (void)addCategoryItem
{
    int height = 65*self.categoryListArray.count;
    if (self.categoryScroll.frame.size.height<height) {
        CGSize size = self.categoryScroll.contentSize;
        size.height = height;
        self.categoryScroll.contentSize = size;
    }
    NSInteger i = 0;
    for (NSDictionary *Item in self.categoryListArray) {
        CGRect rect = CGRectMake(0, 65*i, 59, 65);
        
//        UILabel *leftItemLaebl = [[UILabel alloc] initWithFrame:rect];
//        leftItemLaebl.userInteractionEnabled=YES;
//        leftItemLaebl.tag = 198800+i;
//        leftItemLaebl.text = [Item objectForKey:@"title"];
//        leftItemLaebl.textAlignment = NSTextAlignmentCenter;
//        CALayer *bottomBorder=[[CALayer alloc]init];
//        bottomBorder.frame=CGRectMake(0, leftItemLaebl.frame.size.height-0.5, leftItemLaebl.frame.size.width, 0.5);
//        bottomBorder.backgroundColor=lineGrayColor.CGColor;
//        [leftItemLaebl.layer addSublayer:bottomBorder ];
//        
//        if(i==0){
//            leftItemLaebl.textColor = [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
//        }else{
//        leftItemLaebl.textColor = fontGrayColor;
//        }
//        
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftItemClick:)];
//        [leftItemLaebl addGestureRecognizer:tapGesture];
        
        NSString *title = [Item objectForKey:@"title"];
        if (title.length>2) {
//             title = [title substringToIndex:1];//截取下标7之前的字符串
            title = [NSString stringWithFormat:@"%@\n%@",[title substringToIndex:2],[title substringFromIndex:2]];
        }
        
        SelectItemView *leftitem = [[SelectItemView alloc] initWithFrame:rect title:title index:i];
        leftitem.delegate = self;
        [self.categoryScroll addSubview:leftitem];
//        if (i==0) {
//            leftitem.selected = YES;
//        }
        i++;
        
    }
}



- (void)sortData:(UIButton *)button
{
    NSInteger index = button.tag;
    if (index == currentBtIndex ) {
        if (index ==0 ||index == 3) {
            return;
        }
        else {
            
            ascend = !ascend;
            [button setImage:[UIImage imageNamed:ascend?@"jiantou_up1":@"jiantou_down1"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:ascend?@"jiantou_up2":@"jiantou_down2"] forState:UIControlStateSelected];
        }
    }
    else {
        if (currentBtIndex == 0) {
            button1.selected = NO;
        }
        else if (currentBtIndex == 1) {
            [button2 setImage:[UIImage imageNamed:@"jiantou_up1"] forState:UIControlStateNormal];
            [button2 setImage:[UIImage imageNamed:@"jiantou_up2"] forState:UIControlStateSelected];
            button2.selected = NO;
        }
        else if (currentBtIndex == 2) {
            [button3 setImage:[UIImage imageNamed:@"jiantou_up1"] forState:UIControlStateNormal];
            [button3 setImage:[UIImage imageNamed:@"jiantou_up2"] forState:UIControlStateSelected];
            button3.selected = NO;
        }
        else if (currentBtIndex == 3) {
            button4.selected = NO;
        }
        currentBtIndex = index;
        ascend = YES;
        //        排序字段  auto: sort_order，p.sort_order默认，p.price价格，p.date_added 新品，p.order_num销量
        if (currentBtIndex == 0) {
            button1.selected = YES;
            sortStr = @"p.sort_order";
        }
        else if (currentBtIndex == 1) {
            button2.selected = YES;
            sortStr = @"p.price";
        }
        else if (currentBtIndex == 2) {
            button3.selected = YES;
            sortStr = @"p.order_num";
        }
        else if (currentBtIndex == 3) {
            button4.selected = YES;
            sortStr = @"p.date_added";
        }
    }
    page = 1;
    [self fetchDataWithPage:page];
}

//调用商品列表接口，返回数据
-(void)fetchDataWithPage{
    [self fetchDataWithPage:page];
}


//调用商品列表接口，返回数据
-(void)fetchDataWithPage:(NSInteger)wantPage{
    [super showGif];
    //    NSLog(@"开始调用商品列表接口%@！！！！！！！！！！",theCategoryId);
    if (theCategoryId==nil||[theCategoryId isEqualToString:@""]) {
        theCategoryId = @"59";
    }
    NSLog(@"开始调用商品列表接口%@！！！！！！！！！！",theCategoryId);
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    [infoDictionary setValue:theCategoryId forKey:@"category_id"];
    if (sortStr) {
        [infoDictionary setObject:sortStr forKey:@"sort"];
    }
    //    [infoDictionary setValue:@"" forKey:@"name"];
    //    [infoDictionary setValue:@"manufacturer_type" forKey:@"sort"];
    [infoDictionary setObject:ascend?@"asc":@"desc" forKey:@"order"];
    //    //    [infoDictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    //    [infoDictionary setValue:@"10" forKey:@"limit"];
    [infoDictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if(self.searchedContent&&![self.searchedContent isEqualToString:@""]){//存在检索内容
        [infoDictionary setValue: self.searchedContent forKey:@" keywords"];//搜索字段
        [infoDictionary setValue:@"all" forKey:@"category_id"];
        //修改列表状态
        myItemIndex = 0;
    }
    
    
    //    [commonModel requestProductList:infoDictionary httpRequestSucceed:@selector(requestProductListSuccess:) httpRequestFailed:@selector(requestProductListFailed:)];
    [commonModel requestProductList:infoDictionary httpRequestSucceed:@selector(requestProductListSuccess:) httpRequestFailed:@selector(requestProductListFailed:)];
    
}

//获取商品类别
-(void)getCategoryArray{
    [super showGif];
    
    [commonModel requestcategory_icon:nil httpRequestSucceed:@selector(requestShopcategorySuccess:) httpRequestFailed:@selector(requestFailed:)];
}

//获取商品类别成功
-(void)requestShopcategorySuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"获取商品类别：%@",dic);
    
    self.categoryListArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
    //    self.allCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count"]];
    [self addCategoryItem];
    
    //显示当前默认选中的商品信息
    if ([[ConstObject instance] categoryId]) {
        theCategoryId = [[ConstObject instance] categoryId];
        NSLog(@"存在类别编号%@！！！！！",theCategoryId);
        if (self.categoryListArray) {
            NSArray *values = [self.categoryListArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.category_id = %@",[NSNumber numberWithInt:[theCategoryId intValue]]]];
            if (values.count>0) {
                NSLog(@"显示类别为%@！！！！！",[values objectAtIndex:0]);
                NSInteger index = [self.categoryListArray indexOfObject:[values objectAtIndex:0]];
                [self tappedTheindex:index];
            }
            else {
                NSLog(@"没有匹配的商品类别！！！！！");
                //                page = 1;
                [self tappedTheindex:0];//显示为所有类别
                [[ConstObject instance] setCategoryId:nil];
            }
        }
        else {
            NSLog(@"没有商品类型列表！！！！！");
        }
        
    }else{//没有默认选中类别，默认为所有类别
        page = 1;
        [self fetchDataWithPage:page];
        [[ConstObject instance] setCategoryId:nil];
    }
    //   [self fetchDataWithPage:page];
}

//切换商品类别接口调用成功
-(void)requestProductListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    
    //修改列表状态
    for (SelectItemView *item in _categoryScroll.subviews) {
        if ([item isKindOfClass:[SelectItemView class]]) {
            if (item.index == myItemIndex) {
                item.selected = YES;
            } else {
                item.selected = NO;
            }
            
        }
    }
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"商品列表数据：%@！！！！！！！",dic);
    
    //    self.dataArray = [NSMutableArray arrayWithArray:[[dic objectForKey:@"result"] objectForKey:@"data"]];
    //    moreAction = [[[dic objectForKey:@"result"] objectForKey:@"data"] count] >= 10;
    
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"data"]];
    
    moreAction = [[[dic objectForKey:@"result"] objectForKey:@"data"] count] >= 10;
    moreCell.hidden = [self.dataArray count] == 0;
    
    //    if([self.dataArray count]>0)
    [listTableView reloadData];
    if(page == 1 &&[self.dataArray count]==0){
        blankButton.hidden=NO;
        listTableView.hidden=YES;
    }else{//有数据获取
        page ++;
        blankButton.hidden=YES;
        listTableView.hidden=NO;
    }
    
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    //    self.allCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count"]];
}

-(void)requestProductListFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSLog(@"接口调用失败！！！！！！");
    //    blankButton.hidden=NO;
    //    listTableView.hidden=YES;
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 0.0;
    if (tableView.tag == 198802) {
        if(indexPath.row == [self.dataArray count]){
            rowHeight = 44;
        }else{
            rowHeight =  93;
        }
        
    }
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 0;
    if (tableView.tag == 198802) {
        if([self.dataArray count]>0){
            count = [dataArray count]+1;
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 198802) {
        
        if (indexPath.row == [self.dataArray count] && [self.dataArray count] > 0) {
            if(indexPath.row!=0){
                static NSString *cellIdentifier = @"MoreCell";
                moreCell = (MoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!moreCell) {
                    moreCell = [[[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
                    moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [moreCell setTips:@"上拉获取更多"];
                    moreCell.userInteractionEnabled = NO;
                }
                return moreCell;
            }
            return moreCell;
        }else{
            static NSString *cellIdentifier = @"HHShopCell";
            HHShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[[HHShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            if([self.dataArray count]>indexPath.row){
                NSDictionary *dataDic = (NSDictionary *)[dataArray objectAtIndex:indexPath.row];
                cell.myDictionary = dataDic;
//                NSString *product_name = [[NSString stringWithFormat:@"%@\n ",[dataDic objectForKey:@"name"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 NSString *product_name = [NSString stringWithFormat:@"%@\n ",[dataDic objectForKey:@"name"]];
                //            NSString *meta_description = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"meta_description"]];
                NSString *imageUrl = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]];
                NSString *price = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"price"]];
                NSString *special = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"special"]];
                if ([[dataDic objectForKey:@"special"] floatValue]<=0.0) {
                    special = price;
                    //                cell.originPriceLabel.hidden = YES;
                    //                cell.smallLine.hidden = YES;
                }
                else{
                    //                cell.originPriceLabel.hidden = NO;
                    //                cell.smallLine.hidden = NO;
                }
                imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
                [cell.tipLabel setText:product_name];
                //            [cell.decribeLabel setText:meta_description];
                //            [cell.originPriceLabel setText:[NSString stringWithFormat:@"%@",price]];
                [cell.nowPriceLabel setText:[NSString stringWithFormat:@"%@",special]];
                
               
//                    [cell.sellLabel setText:[NSString stringWithFormat:@"已售：%@",[dataDic objectForKey:@"member_price"]]];
                
                
                
            }
            
            return cell;
        }
        
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 198802) {
        if(indexPath.row == [dataArray count]){
            return;
        }
        NSDictionary *dataDic = (NSDictionary *)[dataArray objectAtIndex:indexPath.row];
        //    0 表示实物 1 表示服务类虚拟产品 3表示积分产品   flag
        HHShoppingDetialController *detailViewController = [[HHShoppingDetialController alloc] init];
        //    int flag = [[dataDic objectForKey:@"flag"] integerValue];
        //    switch (flag) {
        //        case 0:
        //            detailViewController.pType = generalType;
        //            break;
        //        case 1:
        //            detailViewController.pType = virtualType;
        //            break;
        //        case 3:
        //            detailViewController.pType = changeType;
        //            break;
        //        default:
        //            break;
        //    }
        //    detailViewController.productDic = dataDic;
        detailViewController.productID = dataDic[@"product_id"];
        detailViewController.hidesBottomBarWhenPushed=YES;//隐藏底部切换视图条
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }else{//选中类别
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (![CheckNetwork isExistenceNetwork]){
        
        if ((![CheckNetwork isExistenceNetwork] && reloading) ||
            (![CheckNetwork isExistenceNetwork] &&
             (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height + 44))){
                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
                return;
            }
    }
    
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
        if (!moreAction){
            [moreCell stopAction];
            [moreCell setTips:@"已加载全部"];
        }else{
            [moreCell startAction];
            [moreCell setTips:@"数据加载中"];
            [self fetchDataWithPage:page];
        }
    }else {
        moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
    }
}

- (void)doneLoadingTableViewData{
    
    reloading = NO;
    //	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"did selected item at index %d", index);
    if(index == 0){
        theCategoryId = @"59";
        page = 1;
        [self fetchDataWithPage:page];
    }else{
        NSString *category_id = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:index-1] objectForKey:@"category_id"]];
        theCategoryId = category_id;
        page = 1;
        [self fetchDataWithPage:page];
    }
}
- (void)onHandleMenuTap
{
    if(theCategoryId)
        [menu.categoryIdArray addObject:theCategoryId];
    if(self.allCount)
        [menu.ptotalArray addObject:self.allCount];
    
    if([self.categoryListArray count]>0){
        for(int i=0; i<[self.categoryListArray count]; i++){
            
            NSString *tempName = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:i] objectForKey:@"name"]];
            NSString *category_id = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:i] objectForKey:@"category_id"]];
            NSString *ptotal = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:i] objectForKey:@"ptotal"]];
            
            [menu.items addObject:tempName];
            [menu.categoryIdArray addObject:category_id];
            [menu.ptotalArray addObject:ptotal];
        }
        
    }
    
}
-(void)onShowMenu
{
    
}
-(void)onHideMenuTap
{
    
}

-(void)gotoBuyingCarPage{
    ShoppingCartController *shoppingCart = [[ShoppingCartController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
    
}

//类别点击事件
-(void)leftItemClick: (UITapGestureRecognizer*)recognizer{
    //获取所点击视图recognizer.view
    NSArray *gardenOptionsArray = self.categoryScroll.subviews;
    for(int i = 0;i<gardenOptionsArray.count;i++){
        UILabel *myLabel = (UILabel *)gardenOptionsArray[i];
        if (recognizer.view.tag == myLabel.tag) {
              myLabel.textColor = [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
            NSString *category_id = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:myLabel.tag-198800] objectForKey:@"category_id"]];
            theCategoryId = category_id;
            page = 1;
            self.searchedContent = nil;//清空搜索内容
            [self fetchDataWithPage:page];//调用接口并修改列表图标状态

        }else{
            myLabel.textColor = fontGrayColor;
        }
    }
}


//#pragma mark UISearchBar代理
//
//-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"搜索框点击了确认%@！！！！！！！",self.searchingContent);
//    self.searchedContent = self.searchingContent;   //确认内容
//    //    [self searchBar:searchBar textDidChange:nil];
//    [searchBar resignFirstResponder];
//    
//    page = 1;
// 
//    [self fetchDataWithPage:page];//调用接口并修改列表图标状态
//    
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
//{
//    NSLog(@"搜索框点击了取消%@！！！！！！！",self.searchingContent);
//    self.searchedContent = nil;     //清除确认内容
//    //    [self searchBar:searchBar textDidChange:nil];
//    [searchBar resignFirstResponder];
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
//{
//    NSLog(@"搜索框输入的内容为%@！！！！！！！",searchText);
//    self.searchedContent = nil;         //开始输入后，清楚之前确认的内容
//    self.searchingContent = searchText; //正在输入的内容
//  
//}


#pragma mark - HHShopCellDelegate

- (void)getDictionary:(NSDictionary *)myDictionary{

    NSLog(@"即将购买的商品为%@!!!!!!!!",myDictionary);

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
    NSString *searchText = textField.text;
    NSLog(@"搜索框输入的内容为%@！！！！！！！",searchText);
    self.searchedContent = nil;         //开始输入后，清楚之前确认的内容
    self.searchedContent = searchText; //正在输入的内容
    page = 1;
     [self fetchDataWithPage:page];//调用接口并修改列表图标状态
    return YES;
}

#pragma mark MCLeftItemDelegate

//商品类别点击监听事件
- (void)tappedTheindex:(NSInteger)index
{
    for (SelectItemView *item in _categoryScroll.subviews) {
        if ([item isKindOfClass:[SelectItemView class]]) {
            if (item.index == index) {
                if (item.selected) {
                    //                    break;
                }
                else {
                    myItemIndex=index;//存储当前选择的序号
                    NSString *category_id = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:index] objectForKey:@"category_id"]];
                    theCategoryId = category_id;
                    page = 1;
                }
                self.searchedContent = nil;//清空搜索内容
                [self fetchDataWithPage:page];//调用接口并修改列表图标状态
            }
            //            else {
            //                item.selected = NO;
            //            }
            
        }
        
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [MobClick beginLogPageView:@"PageTwo"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [MobClick endLogPageView:@"PageTwo"];
}


@end
