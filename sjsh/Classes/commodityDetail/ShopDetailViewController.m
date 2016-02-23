//
//  ShopDetailViewController.m
//  sjsh
//
//  Created by ce on 14-8-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "ShopRemarkTableViewCell.h"
//#import "AnnotationDemoViewController.h"
#import "ItemDetailViewController.h"
#import "CheckOutViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation ShopDetailViewController
@synthesize dataArray;
@synthesize manufacturer_id;

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
     self.view.backgroundColor = [UIColor whiteColor];
    [super initNavBarItems:nil];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
    [super addRightButton:@"购物车" lightedImage:@"购物车" selector:@selector(gotoBuyingCarPage)];
    [super setHintNum:[[ConstObject instance] cartNum]];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.backgroundColor = [UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1];
//    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    [listTableView release];
    
    //设置表头部个人信息
    listTableView.tableHeaderView = ({
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 200.0f)] autorelease];
        view.backgroundColor = [UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1];
        // 头像
        avatarButton = [[UIButton alloc] init];
        avatarButton.frame = CGRectMake(15.0f, 15.0f, 64.0f, 64.0f);
        avatarButton.backgroundColor = [UIColor clearColor];
        [avatarButton.layer setMasksToBounds:YES];
        [avatarButton.layer setBorderColor:[UIColor redColor].CGColor];
        [avatarButton.layer setBorderWidth:1.0f];
        [avatarButton setImage:[UIImage imageNamed:@"avatarButton.png"] forState:UIControlStateNormal];
//        [avatarButton setBackgroundImage:[UIImage imageNamed:@"avatarButton.png"] forState:UIControlStateNormal];
        [avatarButton addTarget:self action:@selector(imageBroswer) forControlEvents:UIControlEventTouchUpInside];
        avatarButton.layer.borderColor = [UIColor clearColor].CGColor;
//        UIImage *tempImage = [UIImage imageNamed:@"pander.jpg"];
//        [avatarButton setImage:tempImage forState:UIControlStateNormal];
        [view addSubview:avatarButton];
        
        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(94.0f, avatarButton.frame.origin.y+10, 170.0f, 22.0f)];
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [nickLabel setText:@""];
        [nickLabel adjustsFontSizeToFitWidth];
        nickLabel.textColor = [UIColor colorWithRed:0x64/255. green:0x64/255. blue:0x64/255. alpha:1];
        nickLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:nickLabel];
        [nickLabel release];
        
        picLabel = [[UILabel alloc] initWithFrame:CGRectMake(94.0f, 62.0f, 170.0f, 13.0f)];
        picLabel.backgroundColor = [UIColor clearColor];
        picLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [picLabel setText:@" 张照片"];
        [picLabel adjustsFontSizeToFitWidth];
        picLabel.textColor = [UIColor colorWithRed:0xa0/255. green:0xa0/255. blue:0xa0/255. alpha:1];
        picLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:picLabel];
        [picLabel release];
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 90, 290, 1)];
        [lineImage setBackgroundColor:[UIColor colorWithRed:0xdc/255. green:0xdc/255. blue:0xdc/255. alpha:1]];
        [view addSubview:lineImage];
        [lineImage release];
        
        UIButton *backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backgroundButton setFrame:CGRectMake(0, 91, 320, 50)];
        [view addSubview:backgroundButton];
        [backgroundButton addTarget:self action:@selector(callTapped) forControlEvents:UIControlEventTouchUpInside];
        [backgroundButton setBackgroundColor:[UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1]];

        UIImageView *telephone = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 14, 15)];
        [telephone setBackgroundColor:[UIColor clearColor]];
        [telephone setImage:[UIImage imageNamed:@"telephone"]];
        [backgroundButton addSubview:telephone];
        [telephone release];
        
        teleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0f, 16.0f, 250.0f, 18.0f)];
        teleLabel.backgroundColor = [UIColor clearColor];
        teleLabel.font = [UIFont fontWithName:@"Arial" size:17.0f];
        [teleLabel adjustsFontSizeToFitWidth];
        teleLabel.textAlignment = NSTextAlignmentLeft;
        teleLabel.textColor = [UIColor colorWithRed:0xa0/255. green:0xa0/255. blue:0xa0/255. alpha:1];
        [backgroundButton addSubview:teleLabel];
        [teleLabel release];
        
        UIImageView *lineImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 91+50, 290, 1)];
        [lineImage1 setBackgroundColor:[UIColor colorWithRed:0xdc/255. green:0xdc/255. blue:0xdc/255. alpha:1]];
        [view addSubview:lineImage1];
        [lineImage1 release];
        
        UIButton *backgroundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [backgroundButton1 setFrame:CGRectMake(0, 91+51, 320, 50)];
        [view addSubview:backgroundButton1];
        [backgroundButton1 addTarget:self action:@selector(locationTapped) forControlEvents:UIControlEventTouchUpInside];
        [backgroundButton1 setBackgroundColor:[UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1]];
        
        UIImageView *addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 14, 15)];
        [addressImage setBackgroundColor:[UIColor clearColor]];
        [addressImage setImage:[UIImage imageNamed:@"address"]];
        [backgroundButton1 addSubview:addressImage];
        [addressImage release];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0f, 16.0f, 250.0f, 18.0f)];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [addressLabel adjustsFontSizeToFitWidth];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor colorWithRed:0xa0/255. green:0xa0/255. blue:0xa0/255. alpha:1];
        [backgroundButton1 addSubview:addressLabel];
        [addressLabel release];
        
        UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 199, 320, 1)];
        [lineImage2 setBackgroundColor:[UIColor colorWithRed:0xb2/255. green:0xb2/255. blue:0xb2/255. alpha:1]];
        [view addSubview:lineImage2];
        [lineImage2 release];

        view;
    });
    NSString *urlStr = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/shop/shopdetail&manufacturer_id=%@",self.manufacturer_id];
    NSURL *url = [NSURL URLWithString:urlStr];
    self.webview = [[WKWebView alloc] initWithFrame:listTableView.bounds];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
//    self.webview.scrollView.delegate = self;
    self.webview.backgroundColor = [UIColor clearColor];
    listTableView.tableFooterView = self.webview;
    
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.webProgress];
    
    [self fetchData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super getCartNum];
}

- (void)imageBroswer
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.imageURLs.count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        NSString *urlStr = [self.imageURLs objectAtIndex:i];
        photo.url =  [NSURL URLWithString:urlStr]; // 图片路径
//        photo.srcImageView = imagePlayerView.scrollView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
- (void)callTapped
{
    NSArray *phoneList = [self.infoDic objectForKey:@"phone"];
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
//        [super showMessageBox:self title:@"暂无商家电话！" message:@"暂无商家电话！" cancel:nil confirm:@"确定"];
    }
}
//- (void)locationTapped
//{
//    AnnotationDemoViewController *_annotationController = [[AnnotationDemoViewController alloc] init];
////    _annotationController.delegate = self;
//    _annotationController.dataList = @[self.infoDic];
//    [_annotationController performSelector:@selector(addPointAnnotation) withObject:nil afterDelay:1];
//    [self.navigationController pushViewController:_annotationController animated:YES];
//    
//}


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

-(void)viewWillAppear:(BOOL)animated{

}

-(void)fetchData{
    [super showGif];
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    //    [infoDictionary setValue:productID forKey:@"product_id"];
    [infoDictionary setValue:manufacturer_id forKey:@"manufacturer_id"];
//    [infoDictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    
    [commonModel requestShopDetail:infoDictionary httpRequestSucceed:@selector(requestShopDetailListSuccess:) httpRequestFailed:@selector(requestShopDetailListFailed:)];
    
}

-(void)requestShopDetailListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    self.infoDic = [dic objectForKey:@"result"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"image"]];
    NSString *imageCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count_image"]];
    NSString *nameString = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"name"]];
    
    
    NSString *addressString = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"address"]];
    self.imageURLs = [self.infoDic objectForKey:@"imagearr"];
    [addressLabel setText:addressString];
    NSArray *phoneList = [[dic objectForKey:@"result"] objectForKey:@"phone"];
    NSString *phoneString = @"暂无商家电话";
    if (phoneList &&[phoneList count]>0) {
        phoneString = [phoneList objectAtIndex:0];
    }
    [teleLabel setText:phoneString];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [avatarButton setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    [nickLabel setText:nameString];
    [picLabel setText:[NSString stringWithFormat:@"%@ 张照片",imageCount]];
    
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1 && [self.dataArray count] != 0) {
        [self.dataArray removeAllObjects];
    }
//    [self.dataArray addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"data"]];
    [self.dataArray addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"product_list"]];
    moreAction = [[[dic objectForKey:@"result"] objectForKey:@"product_list"]  count] >= 10;
    moreCell.hidden = [self.dataArray count] == 0;
    
//    if([self.dataArray count]>0)
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
//    self.allCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count"]];
}

-(void)requestShopDetailListFailed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

#pragma mark --- UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count]+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == [self.dataArray count]) {
//        if (indexPath.row == 1) {
//            return 82;
//        }
//        else {
            return 44;
//        }
    }
    return 120.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
//    if (sectionIndex == [self.dataArray count]) {
//        return 4;
//    }
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section <[self.dataArray count]) {
        static NSString *cellIdentifier = @"ProfileCell";
        ShopDetailCell *cell = (ShopDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell = [[[ShopDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            //        cell.backgroundColor = COLOR(255, 255, 255);
            cell.backgroundColor = [UIColor whiteColor];
        }
        if([self.dataArray count]>0){
            NSDictionary *dataDic = [self.dataArray objectAtIndex:indexPath.section];
            NSString *price = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"price"]];
            NSString *special = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"special"]];
            if ([[dataDic objectForKey:@"special"] floatValue]<=0.0) {
                special = price;
            }
        NSString *imageUrl =[dataDic objectForKey:@"image"];
//        NSString *price =[[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"price"];
        NSString *name =[dataDic objectForKey:@"pname"];
        
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.imageViews setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        [cell.priceLabel setText:special];
        [cell.productNameLabel setText:[NSString stringWithFormat:@"%@",name]];
            [cell.buyButton addTarget:self action:@selector(addToCartAndEnterOrderpage:) forControlEvents:UIControlEventTouchUpInside];
            cell.buyButton.tag = indexPath.section;
        }
        
        return cell;
    }
    else {
        UITableViewCell *cell = nil;
//        if (indexPath.row == 0) {
//            static NSString *identifier = @"reviewCell";
//            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            }
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            NSString *count_comment = [self.infoDic objectForKey:@"count_comment"];
//            cell.textLabel.text = [NSString stringWithFormat:@"已有评论（%@）",count_comment ];
//            return cell;
//        }
//        else if (indexPath.row == 1) {
//            static NSString *cellIdentifier = @"shopRemark";
//            ShopRemarkTableViewCell *cell = (ShopRemarkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if(!cell){
//                cell = [[[ShopRemarkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
//                cell.accessoryType = UITableViewCellAccessoryNone;
//                cell.selectionStyle = UITableViewCellSelectionStyleGray;
//                //        cell.backgroundColor = COLOR(255, 255, 255);
//                cell.backgroundColor = [UIColor whiteColor];
//            }
//            
//            NSArray *reviewList = [self.infoDic objectForKey:@"review_list"];
//            if (reviewList && reviewList.count>0) {
//                NSDictionary *firstDic = [reviewList objectAtIndex:0];
//                cell.timeLabel.text = [firstDic objectForKey:@"date_added"];
//                NSString *name = [firstDic objectForKey:@"author"];
//                if ([name isKindOfClass:[NSNull class]]) {
//                    name = @"";
//                }
//                cell.nameLabel.text = name;
//                cell.valueLabel.text = [firstDic objectForKey:@"text"];
//            }
//            return cell;
//        }
//        else if (indexPath.row == 2) {
//            static NSString *identifier = @"reviewPCell";
//            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            }
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            for (UIView *subV in cell.contentView.subviews) {
//                [subV removeFromSuperview];
//            }
//            
//            UIButton *reviewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            reviewButton.frame = CGRectMake(0, 0, 90, 40);
//            reviewButton.backgroundColor = [UIColor whiteColor];
//            [reviewButton setTitle:@"我要评论" forState:UIControlStateNormal];
//            [reviewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            reviewButton.center = cell.contentView.center;
//            [reviewButton addTarget:self action:@selector(publishReview) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:reviewButton];
//            return cell;
//        }
//        else if (indexPath.row == 3) {
            static NSString *identifier = @"reviewPullCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            for (UIView *subV in cell.contentView.subviews) {
                [subV removeFromSuperview];
            }
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = @"------向上滑动，查看商家介绍------";
            return cell;
//        }
        return cell;
    }
    return nil;
}

- (void)publishReview
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    if (sectionIndex == 0)
        return 0;
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == [self.dataArray count]) {
//        return tableView.frame.size.height;
//    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section<[self.dataArray count]) {
        NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.section];
        NSString *productId = [[productDic objectForKey:@"product_id"] stringValue];
        ItemDetailViewController *detailViewController = [[ItemDetailViewController alloc] initWithNibName:@"ItemDetailViewController" bundle:nil];
        int flag = 0;//[[dataDic objectForKey:@"flag"] integerValue];
        switch (flag) {
            case 0:
                detailViewController.pType = generalType;
                break;
            case 1:
                detailViewController.pType = virtualType;
                break;
            case 3:
                detailViewController.pType = changeType;
                break;
            default:
                break;
        }
        detailViewController.productDic = [NSDictionary dictionaryWithObjectsAndKeys:productId,@"product_id", nil];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


-(void)gotoBuyingCarPage{
    MyShoppingCartViewController *shoppingCart = [[MyShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
    
}

- (void)addToCartAndEnterOrderpage:(UIButton *)button
{
    NSDictionary *product = [self.dataArray objectAtIndex:button.tag];
    NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
    [addDic setObject:[product objectForKey:@"product_id"] forKey:@"product_id"];
    
    [addDic setObject:[NSNumber numberWithInt:1] forKey:@"quantity"];
    [commonModel requestAddtoCart:addDic httpRequestSucceed:@selector(AddtoCartSuccess:) httpRequestFailed:@selector(AddtoCartFail:)];
}

- (void)AddtoCartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [super showGif];
            [commonModel requestCheckLogin:nil httpRequestSucceed:@selector(requestCheckLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
            
            
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)AddtoCartFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

- (void)requestCheckLoginSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"购买成功回调成功dic%@！！！！！！！！！",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [self enterNetPageForOrder];
            
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
    //进入下单页
    CheckOutViewController *checkVC = [[CheckOutViewController alloc] init];
    [self.navigationController pushViewController:checkVC animated:YES];
    
}

- (void)doneLoadingTableViewData{
	
	reloading = NO;
    //	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
}

//返回上一页
-(void)backHomePage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

# pragma WebKit delegate

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        self.webProgress.hidden = self.webview.estimatedProgress == 1;
        [self.webProgress setProgress:self.webview.estimatedProgress animated:true];
    }
}

@end
