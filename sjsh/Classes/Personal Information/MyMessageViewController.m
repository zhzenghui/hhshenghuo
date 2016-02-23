//
//  MyReplyViewController.m
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MsgTableViewCell.h"

@interface MyMessageViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@property (nonatomic,assign) NSInteger type;
@end

@implementation MyMessageViewController
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
    self.type = 0;
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@""];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, 40);
        menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部消息"];
        [menu displayMenuInView:self.navigationController.view];
        menu.tag = 100000;
        menu.items = [NSMutableArray arrayWithArray:@[@"全部消息", @"订单信息",@"成长记录",@"账户信息",@"互动消息",@"系统通知"]];
        menu.delegate = self;
        [self.navigationItem.titleView addSubview:menu];
    }
    self.view.backgroundColor = COLOR(255, 255, 255);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    label.text = @"您还没有消息";
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
    page = 1;
    [self fetchData];
}

-(void)fetchData{
    [self showGif];
    [commonModel requestnotice:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page",[NSNumber numberWithInt:10],@"limit",[NSNumber numberWithInt:self.type],@"type" ,nil] httpRequestSucceed:@selector(requestcommentSuccess:) httpRequestFailed:@selector(requestFailed:)];
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
    
//    if([self.dataArray count]>0)
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}


-(void)toReturn
{
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
            moreCell.userInteractionEnabled = NO;
        }
        return moreCell;
    }
    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.section];
    static NSString *cellIdentifier = @"orderActionTableViewCell";
    MsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[MsgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.statusLabel.text = [orderDic objectForKey:@"title"];
    cell.descriptionLabel.text = [orderDic objectForKey:@"message"];
    cell.tag = indexPath.section;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        _delIndex = indexPath.section;
        NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.section];
        [commonModel requestdelnotice:[NSDictionary dictionaryWithObjectsAndKeys:[productDic objectForKey:@"notification_id"],@"ids", nil] httpRequestSucceed:@selector(delnoticeSuccess:) httpRequestFailed:@selector(requestFailed:)];
        [self showGif];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)reviewProduct:(UIButton *)sender
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)delnoticeSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        [_dataArray removeObjectAtIndex:_delIndex];
        [listTableView deleteSections:[NSIndexSet indexSetWithIndex:_delIndex] withRowAnimation:UITableViewRowAnimationFade];
    }else if ([[dic objectForKey:@"code"] intValue] == 1701){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"" message:@"未登录" cancel:nil confirm:@"确定"];
        return;
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

- (void)didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.type = 0;
        }
            break;
        case 1:
        {
            self.type = 200;
        }
            break;
        case 2:
        {
            self.type = 201;
        }
            break;
        case 3:
        {
            self.type = 202;
        }
            break;
        case 4:
        {
            self.type = 118;
        }
            break;
        case 5:
        {
            self.type = 203;
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
