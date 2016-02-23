//
//  RemarkViewController.m
//  sjsh
//
//  Created by ce on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "RemarkViewController.h"
#import "RemarkViewCell.h"
#import "MyShoppingCartViewController.h"

@implementation RemarkViewController
@synthesize dataArray;
@synthesize productID;

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
    [super initNavBarItems:@"商品评价"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
    [super addRightButton:@"购物车" lightedImage:@"购物车" selector:@selector(gotoBuyingCarPage)];
    [super setHintNum:[[ConstObject instance] cartNum]];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTableView];
    [listTableView release];
    
    [super showGif];
    [self fetchData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super getCartNum];
}

-(void)gotoBuyingCarPage{
    MyShoppingCartViewController *shoppingCart = [[MyShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCart animated:YES];
    
}
-(void)fetchData{
    
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
//    [infoDictionary setValue:productID forKey:@"product_id"];
     [infoDictionary setValue:self.productID forKey:@"product_id"];
    [infoDictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [super showGif];
    [commonModel requestcommentlist:infoDictionary httpRequestSucceed:@selector(requestRemarkListSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

-(void)requestRemarkListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
      
    //待下拉刷新成功后，再清除列表原来的数据
    if (page == 1 && [self.dataArray count] != 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"data"]];
    
    moreAction = [[[dic objectForKey:@"result"] objectForKey:@"data"] count] >= 10;
    moreCell.hidden = [self.dataArray count] == 0;
    
//    if([self.dataArray count]>0)
        [listTableView reloadData];
    page ++;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    //    self.allCount = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"result"] objectForKey:@"count"]];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataArray count]>0){
        if(indexPath.row == [self.dataArray count])
           return 44;
        else {
        
//            NSArray *tempArray = [NSArray arrayWithArray:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"images"]];
//            if([tempArray count]>0)
//                return 170;
//            else
                return 90;
        }
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.dataArray count]>0)
        return [dataArray count]+1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        static NSString *cellIdentifier = @"Cell";
//        RemarkData *remarkData = (RemarkData *)[self.dataArray objectAtIndex:indexPath.row];
        NSDictionary *remarkData = (NSDictionary *)[self.dataArray objectAtIndex:indexPath.row];
//        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
//        RemarkViewCell *cell = (RemarkViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        //            if (!cell ) {
//        cell = [[[RemarkViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andData:remarkData] autorelease];
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        RemarkViewCell *cell = (RemarkViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell = [[[RemarkViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            //        cell.backgroundColor = COLOR(255, 255, 255);
            cell.backgroundColor = [UIColor clearColor];
        }

        [cell.firstTitleLabel setText:[remarkData objectForKey:@"author"]];
//        [cell.timeLabel setText:[remarkData objectForKey:@"time"]];
        [cell.remarkTextLabel setText:[remarkData objectForKey:@"text"]];
        NSString *starString = [NSString stringWithFormat:@"%@",[remarkData objectForKey:@"star"]];
        int rating = [starString intValue];
        [cell.ratingView displayRating:rating?rating:1];
        
//        RemarkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
//            cell = [[[RemarkViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        if([self.dataArray count]>indexPath.row){
//            NSDictionary *dataDic = (NSDictionary *)[dataArray objectAtIndex:indexPath.row];
//            NSString *product_name = [[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            NSString *meta_description = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"meta_description"]];
//            NSString *imageUrl = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]];
//            NSString *price = [NSString stringWithFormat:@" ¥ %@",[dataDic objectForKey:@"price"]];
//            NSString *special = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"special"]];
//            
////            [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
////            [cell.tipLabel setText:product_name];
////            [cell.decribeLabel setText:meta_description];
////            [cell.originPriceLabel setText:[NSString stringWithFormat:@"%@",price]];
////            [cell.nowPriceLabel setText:[NSString stringWithFormat:@"%@",special]];
//        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dataDic = (NSDictionary *)[dataArray objectAtIndex:indexPath.row];
//    
//    ItemDetailViewController *detailViewController = [[ItemDetailViewController alloc] initWithNibName:@"ItemDetailViewController" bundle:nil];
//    detailViewController.productDic = dataDic;
//    [self.navigationController pushViewController:detailViewController animated:YES];
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


//返回上一页
-(void)backHomePage{
   
    [self.navigationController popViewControllerAnimated:YES];

}


@end
