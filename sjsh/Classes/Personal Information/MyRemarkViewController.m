//
//  MyRemarkViewController.m
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyRemarkViewController.h"
#import "MyCommentCell.h"
#import "UIImageView+WebCache.h"
#import "PublishViewController.h"

@interface MyRemarkViewController ()<SINavigationMenuDelegate>

@end

@implementation MyRemarkViewController
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
    [super initNavBarItems:@""];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部"];
        [menu displayMenuInView:self.navigationController.view];
        menu.tag = 100000;
        menu.items = [NSMutableArray arrayWithArray:@[@"全部", @"待评价"]];
        menu.delegate = self;
        [self.navigationItem.titleView addSubview:menu];
    }
    
    self.view.backgroundColor = COLOR(255, 255, 255);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.selectArray = [NSMutableArray arrayWithCapacity:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    label.text = @"您还没有评论";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:label];
    [label release];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    //    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    [listTableView release];
    page = 1;
    waitp = 0;
    [self fetchData];
    
    
}

-(void)fetchData{
    [self showGif];
    [commonModel requestcomment:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page",[NSNumber numberWithInt:10],@"Limit",[NSNumber numberWithInt:waitp] ,@"waitp",nil] httpRequestSucceed:@selector(requestcommentSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestcommentSuccess:(ASIHTTPRequest *)request{
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
    
//    if([self.dataArray count])
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}


-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self.dataArray count]) {
        return 44;
    }
    return 100;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self.dataArray count]) {
        static NSString *cellIdentifier = @"MoreCell";
        moreCell = (MoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!moreCell) {
            moreCell = [[[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
            moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [moreCell setTips:@"上拉获取更多"];
            moreCell.contentView.backgroundColor = [UIColor whiteColor];
            moreCell.userInteractionEnabled = NO;
        }
        return moreCell;
    }
    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.section];
    static NSString *cellIdentifier = @"orderActionTableViewCell";
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[MyCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.tipLabel.text =[orderDic objectForKey:@"name"];
    cell.reviewButton.tag = indexPath.section;
    int already = [[orderDic objectForKey:@"review_id"] integerValue];
    [cell.reviewButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    if (already > 0) {
        [cell.reviewButton setBackgroundImage:[UIImage imageNamed:@"button_gray"] forState:UIControlStateNormal];
        [cell.reviewButton setTitle:@"已评价" forState:UIControlStateNormal];
        [cell.reviewButton addTarget:self action:@selector(reviewProduct:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [cell.reviewButton setBackgroundImage:[UIImage imageNamed:@"button_yellow"] forState:UIControlStateNormal];
        [cell.reviewButton setTitle:@"我要评价" forState:UIControlStateNormal];
        [cell.reviewButton addTarget:self action:@selector(reviewProduct:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSString *imageUrl = [orderDic objectForKey:@"image"];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    cell.descriptionLabel.text = [orderDic objectForKey:@"text"]?[orderDic objectForKey:@"text"]:@"";
    cell.tag = indexPath.section;
    return cell;
    
}

- (void)reviewProduct:(UIButton *)sender
{
    NSDictionary *productDic = [self.dataArray objectAtIndex:[sender tag]];
    NSString *productId = [productDic objectForKey:@"product_id"];
    NSString *order_productId = [productDic objectForKey:@"order_product_id"];
    PublishViewController *pubVC = [[PublishViewController alloc] init];
    pubVC.reviewID = productId;
    pubVC.orderProductID = order_productId;
    [self.navigationController pushViewController:pubVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            waitp = 0;
            break;
        case 1:
            waitp = 1;
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
