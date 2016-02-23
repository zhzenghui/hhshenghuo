//
//  MyDuiHuanViewController.m
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyDuiHuanViewController.h"
#import "VCodeTableViewCell.h"

@interface MyDuiHuanViewController ()

@end

@implementation MyDuiHuanViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"我的兑换码"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(255, 255, 255);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    label.text = @"您还没有兑换码";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:label];
    [label release];

    
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
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
    [commonModel requestgetallvcode:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page",[NSNumber numberWithInt:10],@"Limit" ,nil] httpRequestSucceed:@selector(requestgetallvcodeSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestgetallvcodeSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1 && [self.dataArray count] != 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:[completeDic objectForKey:@"result"]];
    
    moreAction = [[completeDic objectForKey:@"result"] count] >= 10;
    moreCell.hidden = [self.dataArray count] == 0;
    
//    if([self.dataArray count]>0)
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}


-(void)toReturn{
//    self.navigationController.navigationBar.alpha = 0;
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
    if (indexPath.row == 0) {
        return 84;
    }
    else if(indexPath.row==1){
        return 50;
    }
    else {
        return 50;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == [self.dataArray count]) {
        return 1;
    }
    
    return 3;
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
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"orderGoodsCell";
        
        orderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[orderGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString *name = [orderDic objectForKey:@"name"];
        if ([name isKindOfClass:[NSNull class]]) {
            name = @"";
        }
        cell.tipLabel.text = name;
        cell.nowPriceLabel.text =[NSString stringWithFormat:@"￥ %@",[orderDic objectForKey:@"special"]];
        NSString *imageUrl = [orderDic objectForKey:@"image"];
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        cell.tag = indexPath.section;
        return cell;
        
    }
    else if(indexPath.row==1){
        static NSString *cellIdentifier = @"orderActionTableViewCell";
        VCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[VCodeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        int status =[[orderDic objectForKey:@"code_status"] integerValue];
        if (status>0) {
            cell.statusLabel.text = @"已兑换";
            cell.statusLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
            cell.descriptionLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        }
        else {
            cell.statusLabel.text = @"未兑换";
            cell.statusLabel.textColor = [UIColor colorWithRed:0x94/255.0f green:0xc4/255.0f blue:0x00/255.0f alpha:1];
            cell.descriptionLabel.textColor = [UIColor colorWithRed:0x94/255.0f green:0xc4/255.0f blue:0x00/255.0f alpha:1];
        }
        cell.tipLabel.text = @"兑换码";
        cell.descriptionLabel.text = [orderDic objectForKey:@"v_code"];
        cell.tag = indexPath.section;
        return cell;
    }
    else {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.text = @"有效期";
        cell.detailTextLabel.text = [orderDic objectForKey:@"endtime"];
        cell.tag = indexPath.section;
        return cell;
    }
    return nil;
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


@end
