//
//  MyStoredViewController.m
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyStoredViewController.h"
#import "UIImageView+WebCache.h"

#import "CommodityDetailController.h"
#import "ShopDetailViewController.h"

@interface MyStoredViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@property (nonatomic,assign) NSInteger type;
@end

@implementation MyStoredViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
} 


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@""];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
//    if (self.navigationItem) {
//        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
//        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部"];
//        [menu displayMenuInView:self.navigationController.view];
//        menu.tag = 100000;
//        menu.items = [NSMutableArray arrayWithArray:@[@"全部", @"商品",@"商家",@"话题"]];
//        menu.delegate = self;
//        [self.navigationItem.titleView addSubview:menu];
//    }
    
     [super initNavBarItems:@"我的收藏"];
    
    self.view.backgroundColor = COLOR(255, 255, 255);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    label.text = @"您还没有收藏";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:label];
    [label release];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    //    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    [listTableView release];
    [self setExtraCellLineHidden:listTableView];
    page = 1;
    self.type = -1;
    [self fetchData];
}

-(void)fetchData{
    [super showGif];
    [commonModel requestFavorite:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page",[NSNumber numberWithInt:10],@"limit",[NSNumber numberWithInt:self.type],@"type" ,nil] httpRequestSucceed:@selector(favoriteSuccess:) httpRequestFailed:@selector(favoriteFail:)];
}

- (void)favoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1 && [self.dataArray count] != 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:[[completeDic objectForKey:@"result"] objectForKey:@"data"]];
    
    moreAction = [[[completeDic objectForKey:@"result"] objectForKey:@"data"] count] >= 10;
    moreCell.hidden = [self.dataArray count] == 0;
    
//    if([self.dataArray count]>0)
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}

- (void)favoriteFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

-(void)toReturn{
//    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
        return 44;
    }
        return 84;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.dataArray count]>0)
    {
        listTableView.hidden = NO;
        return [_dataArray count]+1;
    }
    else {
        listTableView.hidden = YES;
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
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
    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.row];
    
        static NSString *cellIdentifier = @"StoredCell";
        
        StoredCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[StoredCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        NSDictionary *productDic = [products objectAtIndex:indexPath.row-1];
        cell.tipLabel.text = [orderDic objectForKey:@"title"];
    float price = [[orderDic objectForKey:@"price"] floatValue];
    float special = [[orderDic objectForKey:@"special"] floatValue];
    if (special == 0) {
        special = price;
    }
        cell.nowPriceLabel.text =[NSString stringWithFormat:@"￥ %.2f",special];
        NSString *imageUrl = [orderDic objectForKey:@"image"];
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        NSString *cellId = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"id"]];
    
        cell.tag = [cellId intValue];
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self.dataArray count]) {
        return;
    }
    NSDictionary *itemDic = [self.dataArray objectAtIndex:indexPath.section];
    NSInteger type = [[itemDic objectForKey:@"type"] integerValue];
    if (type == 0) {//商品
        //    0 表示实物 1 表示服务类虚拟产品 3表示积分产品   flag
        CommodityDetailController *detailViewController = [[CommodityDetailController alloc] init];

//        int flag = 0;
//        switch (flag) {
//            case 0:
//                detailViewController.pType = generalType;
//                break;
//            case 1:
//                detailViewController.pType = virtualType;
//                break;
//            case 3:
//                detailViewController.pType = changeType;
//                break;
//            default:
//                break;
//        }
//        detailViewController.productDic = [NSDictionary dictionaryWithObjectsAndKeys:[itemDic objectForKey:@"obj_id"],@"product_id", nil];
        detailViewController.productID = [itemDic objectForKey:@"obj_id"];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else {//1 商家
        NSString *tempId = [NSString stringWithFormat:@"%@",[itemDic objectForKey:@"obj_id"]];
        ShopDetailViewController *shopDetailViewController = [[ShopDetailViewController alloc] init];
        shopDetailViewController.manufacturer_id = tempId;
        [self.navigationController pushViewController:shopDetailViewController animated:YES];
        [shopDetailViewController release];
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
            [self fetchData];
        }
    }else {
        moreAction ? [moreCell setTips:@"上拉获取更多"] :[moreCell setTips:@"已加载全部"];
    }
}

- (void)doneLoadingTableViewData{
    
    reloading = NO;
    //	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.delIndex = indexPath.row;
        [commonModel requestDeleteFavorite:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",cell.tag],@"id" ,nil] httpRequestSucceed:@selector(DeleteFavoriteSuccess:) httpRequestFailed:@selector(DeleteFavoriteFail:)];
        // Delete the row from the data source.
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)DeleteFavoriteSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    //待下拉刷新成功后，再清除列表原来的数据
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        [_dataArray removeObjectAtIndex:_delIndex];
        [listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }else if ([[dic objectForKey:@"code"] intValue] == 1401){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"" message:@"未登录" cancel:nil confirm:@"确定"];
        return;
    }
    
}

- (void)DeleteFavoriteFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
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

- (void)didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.type = -1;
        }
            break;
        case 1:
        {
            self.type = 0;
        }
            break;
        case 2:
        {
            self.type = 1;
        }
            break;
        case 3:
        {
            self.type = 2;
        }
            break;
        default:
            break;
    }
    page = 1;
    [self fetchData];
}
- (void)onHandleMenuTap
{
    
}
-(void)onShowMenu
{
    
}
-(void)onHideMenuTap
{
    
}

@end
