//
//  CommercialTenantListViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-8-3.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CommercialTenantListViewController.h"
#import "SINavigationMenuView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
 
#import "ShopDetailViewController.h"

@interface CommercialTenantListViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,SINavigationMenuDelegate>//,BMKLocationServiceDelegate
{
    BOOL lacateSuccess;
//    BMKLocationService *_locService;
}
@property (nonatomic, retain) UITableView *listTableView;
//@property (nonatomic, retain) AnnotationDemoViewController *annotationController;

@end

@implementation CommercialTenantListViewController

@synthesize theCategoryId;
@synthesize searchBar;
@synthesize shopListArray;
@synthesize strongSearchDisplayController;
@synthesize listTableView;
@synthesize categoryListArray;
@synthesize allCount;

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
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    page = 1;
    self.allCount = @"";
    self.shopListArray = [NSMutableArray arrayWithCapacity:1];
    self.categoryListArray = [NSMutableArray arrayWithCapacity:1];
    
    [super initNavBarItems:nil];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super addRightButton:@"mapIcon" lightedImage:@"mapIcon" selector:@selector(flipAction:)];
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部"];
        [menu displayMenuInView:self.navigationController.view];
        menu.tag = 100000;
        //        menu.items = @[@"News", @"Top Articles", @"Messages", @"Account", @"Settings", @"Top Articles", @"Messages"];
        //        menu.items = @[];
        menu.delegate = self;
        [self.navigationItem.titleView addSubview:menu];
    }
//    [self createHeadView];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(toMapPage)];

    self.listTableView =[[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0.0f, kScreenBounds.size.width, kScreenBounds.size.height-44) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listTableView.backgroundColor = COLOR(240, 240, 240);
    [self.view addSubview:self.listTableView];
//    [table release];
    
    //初始化BMKLocationService
//    lacateSuccess = NO;
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
    
    //添加searchbar
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
//    self.searchBar.placeholder = @"Search";
//    self.searchBar.delegate = self;
//    [self.searchBar sizeToFit];
//    
//    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//    self.searchDisplayController.searchResultsDataSource = self;
//    self.searchDisplayController.searchResultsDelegate = self;
//    self.searchDisplayController.delegate = self;
//    
//    self.listTableView.tableHeaderView = self.searchBar;
//    self.listTableView.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.bounds));
    [super showGif];
    [self performSelectorInBackground:@selector(getCategoryArray) withObject:nil];
    
    [self getShopListWithPage:page];
//    [self performSelector:@selector(locate) withObject:nil afterDelay:0];
    
}

-(void)viewWillAppear:(BOOL)animated{

    
}

-(void)getCategoryArray{

    [commonModel requestShopcategory:theCategoryId httpRequestSucceed:@selector(requestShopcategorySuccess:) httpRequestFailed:@selector(requestShopcategoryFailed:)];
}
//- (void)locate
//{
//    for (int i= 0; i<10; i++) {
//        
//        CLLocationDistance distace = [self calculateDistanceToLocationWithlatitude:39.915+i/50.0 longitude:116.404+i/50.0];
//        NSLog(@"distance = %f",distace);
//    }
//}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    if (_annotationController) {
//        [_annotationController.mapView updateLocationData:userLocation];
//    }
////    NSLog(@"heading is %@",userLocation.heading);
//}
////处理位置坐标更新
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//    if (lacateSuccess == NO) {
//        lacateSuccess = YES;
//        [self.listTableView reloadData];
//    }
//    if (_annotationController) {
//        [_annotationController.mapView updateLocationData:userLocation];
//    }
////    lacateSuccess = YES;
////    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//}
//
////计算距离方法，传过来商家坐标的经纬度，返回与当前位置的距离，单位为M  如返回-1，则说明定位不成功
//- (NSString *)calculateDistanceToLocationWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
//{
//    NSString *distanceStr = @"未知";
//
//    if (!lacateSuccess) {
//        return distanceStr;
//    }
//    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(latitude, longitude);
//    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
////    NSDictionary* testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_COMMON);
//    //转换GPS坐标至百度坐标
////    NSDictionary*testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
////    NSLog(@"x=%@,y=%@",[testdic objectForKey:@"x"],[testdic objectForKey:@"y"]);
//    CLLocationCoordinate2D test1 = _locService.userLocation.location.coordinate;
//    BMKMapPoint point1 = BMKMapPointForCoordinate(test);
//    BMKMapPoint point2 = BMKMapPointForCoordinate(test1);
//    CLLocationDistance distaceNum = BMKMetersBetweenMapPoints(point1,point2);
//    distanceStr = distaceNum>1000?[NSString stringWithFormat:@"%dKM",(int)(distaceNum/1000.0)]:[NSString stringWithFormat:@"%dM",(int)distaceNum];
//    return distanceStr;
//}

- (void)getShopListWithPage:(int)wantPage
{
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    [infoDictionary setValue:theCategoryId forKey:@"category_id"];
    [infoDictionary setValue:@"" forKey:@"name"];
    [infoDictionary setValue:@"manufacturer_type" forKey:@"sort"];
//    [infoDictionary setValue:@"DESC" forKey:@"order"];
//    [infoDictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [infoDictionary setValue:@"10" forKey:@"limit"];
    [infoDictionary setValue:[NSString stringWithFormat:@"%d",wantPage] forKey:@"page"];
    
    [commonModel requestShoplist:infoDictionary httpRequestSucceed:@selector(requestShoplistSuccess:) httpRequestFailed:@selector(requestShoplistFailed:)];
}

- (void)toReturn
{
//    [self hideButton];
//    100000
    for(UIView *view in self.navigationController.view.subviews)
    {
        if(view.tag == 100000)
            [view removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)hideButton{
//
//    returnButton.hidden = YES;
//    rightButtons.hidden = YES;
//}
//
//-(void)noHideButton{
//    
//    returnButton.hidden = NO;
//    rightButtons.hidden = NO;
//}

- (void)flipAction:(id)sender
{
//    if (_annotationController == nil) {
//        _annotationController = [[AnnotationDemoViewController alloc] init];
//        _annotationController.view.frame = listTableView.frame;
//        _annotationController.delegate = self;
//    }
//    
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:NULL];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    [UIView setAnimationTransition:([self.listTableView superview] ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
//                           forView:self.view
//                             cache:YES];
//    
//    if ([self.listTableView superview]) {
//        [self.listTableView removeFromSuperview];
//        [self.view addSubview:_annotationController.view];
//        _annotationController.dataList = shopListArray;
//        [_annotationController addPointAnnotation];
//    } else {
//        [_annotationController.view removeFromSuperview];
//        [self.view addSubview:self.listTableView];
//    }
//    
//    [UIView commitAnimations];
//    
//    if ([self.listTableView superview]) {
//        [self.rightButton setImage:[UIImage imageNamed:@"mapIcon"] forState:UIControlStateNormal];
//    } else {
//        [self.rightButton setImage:[UIImage imageNamed:@"shopListIcon"] forState:UIControlStateNormal];
//    }
}

-(void)requestShopcategorySuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);

    self.categoryListArray = [NSMutableArray arrayWithArray:[[dic objectForKey:@"result"] objectForKey:@"data"]];
    self.allCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count"]];
}

-(void)requestShoplistSuccess:(ASIHTTPRequest *)request{
//    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"商户列表============= dic%@",dic);
    
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1 && [self.shopListArray count] != 0) {
        [self.shopListArray removeAllObjects];
    }
    [self.shopListArray addObjectsFromArray:[dic objectForKey:@"result"]];
    
    moreAction = [[dic objectForKey:@"result"] count] >= 10;
    moreCell.hidden = [self.shopListArray count] == 0;
    [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    /*
    address = "\U6d77\U6dc0\U533a\U84dd\U975b\U5382\U4e2d\U8def";
    image = "";
    "manufacturer_id" = 999;
    "manufacturer_type" = 3;
    name = "\U798f\U5948\U7279\U6d17\U8863";
    phone = "010-88871988";
    pname = "";
    price = "";
    "product_id" = "";
    special = "";
    star = 0;
    "x_l" = "116.29";
    "y_l" = "39.9687";
  */
//    if ([[dic objectForKey:@"code"] intValue] == 200) {
////        NSLog(@"商户成功！");
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}



-(void)requestShopcategoryFailed:(ASIHTTPRequest *)request{
//    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 1000) {
        
    }
}

-(void)requestShoplistFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 1000) {
        
    }
}

//初始化左侧商品类别
- (void)onHandleMenuTap{
    
//    [self hideButton];
    [menu.items addObject:@"全部"];
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
    
//    menu.items = self.categoryListArray;
}

- (void)onHideMenuTap{
    
//    rightButtons.hidden = NO;
//    returnButton.hidden = NO;
}

-(void)onShowMenu{

    return;
    UIView *blackView = [[UIView alloc] init];
    [blackView setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.view addSubview:blackView];
    [blackView setFrame:CGRectMake(0, 0, 320, 1)];
    CATransition *animation = [CATransition animation];
    animation.duration = 7.5f;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromTop;
    [blackView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height+64)];
    [self.view.layer addAnimation:animation forKey:@"animation"];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topButton setTitle:@"全部" forState:UIControlStateNormal];
    [blackView addSubview:topButton];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton setFrame:CGRectMake(120, 30, 50, 30)];
    
    
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"did selected item at index %d", index);
    if(index == 0){
        theCategoryId = @"0";
        page = 1;
        [self getShopListWithPage:page];
    }else{
        NSString *category_id = [NSString stringWithFormat:@"%@",[[self.categoryListArray objectAtIndex:index-1] objectForKey:@"category_id"]];
        page = 1;
        theCategoryId = category_id;
        [self getShopListWithPage:page];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.shopListArray count])
        return 44;
    if([shopListArray count]>0){
        NSDictionary *dataDic = (NSDictionary *)[shopListArray objectAtIndex:indexPath.row];
        NSString *manufacturer_type = [dataDic objectForKey:@"manufacturer_type"];
        NSString *pname = [dataDic objectForKey:@"pname"];
        if([manufacturer_type isEqualToString:@"1"]){
        // 有图有团购
            if (pname && pname.length>0) {
                return 124;
            }
            return 85;
        }else if([manufacturer_type isEqualToString:@"2"]){
        // 有图无团购
            return 85;
        }else{
        //纯文字
            return 70;
        }
    }
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([shopListArray count]>0)
        return [shopListArray count]+1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.shopListArray count] && [self.shopListArray count] > 0) {
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
        static NSString *cellIdentifier1 = @"Cell1";
        CommercialTableViewCell *cell = (CommercialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[[CommercialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if([shopListArray count]>indexPath.row){
            NSDictionary *dataDic = (NSDictionary *)[shopListArray objectAtIndex:indexPath.row];
            NSString *manufacturer_type = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"manufacturer_type"]];
            NSString *starString = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"star"]];
            int rating = [starString intValue];
            NSString *imageUrl = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]];
            NSString *pname = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"pname"]];
            NSString *price = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"price"]];
            NSString *commercialName = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]];
            double x_l = [[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"x_l"]] doubleValue];
            double y_l = [[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"y_l"]] doubleValue];
            NSString *distanceStr = [self calculateDistanceToLocationWithlatitude:y_l longitude:x_l];
            
            
            if([manufacturer_type isEqualToString:@"1"]){
                // 有图有团购
                //        [cell.iconView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
                if (pname && pname.length>0) {
                    [cell.tuanImageView setHidden:NO];
                    [cell.lineImage setFrame:CGRectMake(15, 123, 290, 1)];
                }
                else {
                    [cell.tuanImageView setHidden:YES];
                    [cell.lineImage setFrame:CGRectMake(15, 84, 290, 1)];
                }
                [cell.iconButton setHidden:NO];
                [cell.ratingView setHidden:NO];
                
                [cell.iconButton setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
                [cell.tuanContentLabel setText:pname];
                if(![price isEqualToString:@""])
                    [cell.pricelabel setText:[NSString stringWithFormat:@"¥ %@",price]];
                else
                    [cell.pricelabel setText:[NSString stringWithFormat:@"%@",@""]];
                
                [cell.ratingView displayRating:rating?rating:1];
                
                
                [cell.titleLabel setFrame:CGRectMake(94, 16, 139, 18)];
                [cell.titleLabel setText:commercialName];
            }else if([manufacturer_type isEqualToString:@"2"]){
                // 有图无团购
                [cell.tuanImageView setHidden:YES];
                [cell.iconButton setHidden:NO];
                [cell.ratingView setHidden:NO];
                
                [cell.iconButton setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
                [cell.ratingView displayRating:rating?rating:1];
                [cell.lineImage setFrame:CGRectMake(15, 84, 290, 1)];
                [cell.titleLabel setFrame:CGRectMake(94, 16, 139, 18)];
                [cell.titleLabel setText:commercialName];
            }else{
                //纯文字
                [cell.tuanImageView setHidden:YES];
                [cell.iconButton setHidden:YES];
                [cell.ratingView setHidden:YES];
                
                CGRect tempFrame = cell.callButton.frame;
                tempFrame.origin.y = 12;
                cell.callButton.frame = tempFrame;
                
                cell.titleLabel.frame = CGRectMake(15, 19, 240, 18);
                cell.titleLabel.textAlignment = NSTextAlignmentLeft;
                
                CGRect tempFrame1 = cell.distanceLabel.frame;
                tempFrame1.origin.x = 15;
                tempFrame1.origin.y = 40;
                tempFrame1.size.width = 240;
                cell.distanceLabel.frame = tempFrame1;
                [cell.titleLabel setText:commercialName];
                [cell.lineImage setFrame:CGRectMake(15, 69, 290, 1)];
            }
            [cell.distanceLabel setText:distanceStr];
            cell.callButton.tag = indexPath.row;
            [cell.callButton addTarget:self action:@selector(callButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *dataDic = (NSDictionary *)[shopListArray objectAtIndex:indexPath.row];
//    [self hideButton];
    //    100000
    for(UIView *view in self.navigationController.view.subviews)
    {
        if(view.tag == 100000)
            [view removeFromSuperview];
    }

    NSString *tempId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"manufacturer_id"]];
    ShopDetailViewController *shopDetailViewController = [[ShopDetailViewController alloc] init];
    shopDetailViewController.manufacturer_id = tempId;
    [self.navigationController pushViewController:shopDetailViewController animated:YES];
    [shopDetailViewController release];
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
            [self getShopListWithPage:page];
        }
    }else {
        moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
    }
}

- (void)doneLoadingTableViewData{
	
	reloading = NO;
//	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
}

- (void)callButtonTapped:(UIButton *)button
{
//    if (kSystemIsIOS7) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    } else {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
//    }
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    
    int buttonTag = button.tag;
    
    NSArray *phoneList = [[self.shopListArray objectAtIndex:buttonTag] objectForKey:@"phone"];
    if(phoneList &&[phoneList count]>0){
        
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-1, self.view.bounds.size.width, 1)];
        backImageView.backgroundColor = [UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:0.8];
        [self.navigationController.view addSubview:backImageView];
        [backImageView release];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.03];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        CGRect tempFrame = backImageView.frame;
        tempFrame.origin.y = self.view.bounds.origin.y;
        tempFrame.size.height = self.view.bounds.size.height+64;
        backImageView.frame = tempFrame;
        
        [UIView commitAnimations];
        
        NSString *phone1 = nil,*phone2 = nil,*phone3 = nil;
        phone1 = [phoneList objectAtIndex:0];
        if ([phoneList count]>1) {
            phone2 = [phoneList objectAtIndex:1];
        }
        if ([phoneList count]>2) {
            phone2 = [phoneList objectAtIndex:2];
        }
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:phone1,phone2,phone3, nil];
        
        [sheet showInView:self.view];
        [sheet release];
    }else
    {
        [super showMessageBox:self title:@"暂无商家电话！" message:@"暂无商家电话！" cancel:nil confirm:@"确定"];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect tempFrame = backImageView.frame;
         tempFrame.size.height = 1;
         tempFrame.origin.y = self.view.bounds.size.height+64;
         backImageView.frame = tempFrame;
     }completion:^(BOOL finished){
         
         [backImageView removeFromSuperview];
         backImageView = nil;
     }];

    
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *phone = [actionSheet buttonTitleAtIndex:buttonIndex];
        if (phone != nil) {
            
            NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
            NSURL *url = [[NSURL alloc] initWithString:telUrl];
            
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    
    for (UIView *view in actionSheet.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == actionSheet.cancelButtonIndex+1) {
                UIButton *button = (UIButton *) view;
                [button setFrame:CGRectMake(8, button.frame.origin.y, 304, button.frame.size.height)];
                //改变背景
                [button setBackgroundImage:[UIImage imageNamed:@"cancleBack"] forState:UIControlStateNormal];
                //改变颜色
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //btn的选择状态,否则选择后不变背景
                [button setSelected:YES];
            } else {
                //                if (view.tag == 1) {
                UIButton *button = (UIButton *) view;
                [button setFrame:CGRectMake(8, button.frame.origin.y, 304, button.frame.size.height)];
                //改变背景
                [button setBackgroundImage:[UIImage imageNamed:@"teleBack"] forState:UIControlStateNormal];
                //改变颜色
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //btn的选择状态,否则选择后不变背景
                [button setSelected:YES];
                //                }
            }
        }
        
        }
        
}
- (void)dealloc
{
    [super dealloc];
//    [_locService stopUserLocationService];
    [listTableView release];
//    [_annotationController release];
}

- (UIView *)getNavigationView;
{
    return self.navigationController.view;
}

//- (NSString *)getDistanceToLocationWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
//{
//    return [self calculateDistanceToLocationWithlatitude:latitude longitude:longitude];
//}

- (void)tapCellIndex:(NSInteger)index
{
    
}
- (void)tapCallIndex:(NSInteger)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    [self callButtonTapped:button];
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    [self.listTableView scrollRectToVisible:self.searchBar.frame animated:animated];
}

//-(void)createHeadView{
//    
//    returnButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//    returnButton.backgroundColor = [UIColor clearColor];
//    [returnButton setImage:[UIImage imageNamed:@"leftReturn"] forState:UIControlStateNormal];
////    [returnButton setImage:[UIImage imageNamed:@"returnLight"] forState:UIControlStateHighlighted];
//    [returnButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
//    returnButton.showsTouchWhenHighlighted = YES;
//    if (kSystemIsIOS7) {
//        returnButton.frame = CGRectMake(-5.0f, 22.0f, 60,40);
//    }
//    else{
//        returnButton.frame = CGRectMake(-5.0f, 22.0f, [UIImage imageNamed:@"leftReturn"].size.width,[UIImage imageNamed:@"leftReturn"].size.height);
//    }
//    [self.navigationController.view addSubview:returnButton];
//    
//    
//    rightButtons = [UIButton  buttonWithType:UIButtonTypeCustom];
//    rightButtons.backgroundColor = [UIColor clearColor];
//    [rightButtons setImage:[UIImage imageNamed:@"mapIcon"] forState:UIControlStateNormal];
//    rightButtons.showsTouchWhenHighlighted = YES;
////    [rightButtons setImage:[UIImage imageNamed:@"mapIcon"] forState:UIControlStateHighlighted];
//    [rightButtons addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    if (kSystemIsIOS7) {
//        rightButtons.frame = CGRectMake(260.0f, 20.0f, 60,40);
//    }
//    else{
//        rightButtons.frame = CGRectMake(260.0f, 25.0f, [UIImage imageNamed:@"mapIcon"].size.width,[UIImage imageNamed:@"mapIcon"].size.height);
//    }
//    [self.navigationController.view addSubview:rightButtons];
//
//    
//}
-(void)ratingChanged:(float)newRating{

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

@end
