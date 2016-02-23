//
//  MyJiFenViewController.m
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyJiFenViewController.h"
#import "JifenChangeCell.h"
#import "UIImageView+WebCache.h"
#import "AboutUSViewController.h"
#import "ItemDetailViewController.h"

@interface MyJiFenViewController ()
{
    UILabel *moneyNum;
    NSInteger recordIndex;
}

@end

@implementation MyJiFenViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"我的积分"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(255, 255, 255);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    //    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    [listTableView release];
    listTableView.tableHeaderView = ({
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 334.0f)] autorelease];
        //        view.backgroundColor = COLOR(250, 250, 250);
        view.backgroundColor = [UIColor whiteColor];
        // 头像
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 30, kScreenBounds.size.width, 22.0f)];
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [nickLabel setText:@"可用积分"];
//        [nickLabel adjustsFontSizeToFitWidth];
        //        nickLabel.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
        nickLabel.textColor = [UIColor colorWithRed:0xa0/255.0f green:0xa0/255.0f blue:0xa0/255.0f alpha:1];
        nickLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:nickLabel];
        [nickLabel release];
        
        
        UIButton *moneyString = [UIButton buttonWithType:UIButtonTypeCustom];
        moneyString.frame = CGRectMake(0.0f, view.frame.size.height-40-22, kScreenBounds.size.width, 22.0f);
        [moneyString setTitle:@"如何获得积分" forState:UIControlStateNormal];
        [moneyString setTitleColor:[UIColor colorWithRed:0xa0/255. green:0xa0/255. blue:0xa0/255. alpha:1] forState:UIControlStateNormal];
        moneyString.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [moneyString addTarget:self action:@selector(pushWeb) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moneyString];

        
        moneyNum = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 77, kScreenBounds.size.width, 80.0f)];
        moneyNum.backgroundColor = [UIColor clearColor];
        moneyNum.font = [UIFont fontWithName:@"Arial" size:40.0f];
        [moneyNum setText:@"0.00"];
        [moneyNum adjustsFontSizeToFitWidth];
        moneyNum.textColor = [UIColor colorWithRed:0xff/255. green:0x42/255. blue:0x6e/255. alpha:1];
        moneyNum.textAlignment = NSTextAlignmentCenter;
        [view addSubview:moneyNum];
        [moneyNum release];
        
        
        view;
    });
    
    [self setExtraCellLineHidden:listTableView];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushWeb
{
    AboutUSViewController *aboutViewController = [[AboutUSViewController alloc] init];
    aboutViewController.type = jifen;
    [self.navigationController pushViewController:aboutViewController animated:YES];
    [aboutViewController release];
}

-(void)fetchData{
    [self showGif];
    [commonModel requestmypoints:nil httpRequestSucceed:@selector(requestmypointsSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestmypointsSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    //待下拉刷新成功后，再清除列表原来的数据
    moneyNum.text = [[[completeDic objectForKey:@"result"] objectForKey:@"usepoints"] stringValue];
    [self.dataArray addObjectsFromArray:[[completeDic objectForKey:@"result"] objectForKey:@"data"]];
    [listTableView reloadData];
}

-(void)toReturn{
//    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController popViewControllerAnimated:YES];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *orderDic = [self.dataArray objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"Cell";
    JifenChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[JifenChangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.tipLabel.text = [NSString stringWithFormat:@"￥%d+%d积分",[[orderDic objectForKey:@"price"] intValue],[[orderDic objectForKey:@"points"] intValue]];
    cell.reviewButton.tag = indexPath.section;
    [cell.reviewButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [cell.reviewButton addTarget:self action:@selector(changeProduct:) forControlEvents:UIControlEventTouchUpInside];
    NSString *imageUrl = [orderDic objectForKey:@"image"];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.picImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    cell.descriptionLabel.text = [orderDic objectForKey:@"meta_description"];
    cell.tag = indexPath.section;
    return cell;
    
}

- (void)changeProduct:(UIButton *)sender
{
    recordIndex= sender.tag;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定消耗积分兑换此产品吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            //添加兑换方法
            NSDictionary *orderDic = [self.dataArray objectAtIndex:recordIndex];
            [super showGif];
            [commonModel requestsavepo:[NSDictionary dictionaryWithObjectsAndKeys:[orderDic objectForKey:@"product_id"],@"product_id", nil] httpRequestSucceed:@selector(requestsavepoSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
    }
}



- (void)requestsavepoSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [super showMessageBox:self title:@"" message:@"兑换成功" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 3415){
        [super showMessageBox:self title:@"" message:@"积分不足！" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 3416){
        [super showMessageBox:self title:@"" message:@"缺少收货地址！" cancel:nil confirm:@"确定"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *productId = [[productDic objectForKey:@"product_id"] stringValue];
    ItemDetailViewController *detailViewController = [[ItemDetailViewController alloc] initWithNibName:@"ItemDetailViewController" bundle:nil];
    int flag = 3;//[[dataDic objectForKey:@"flag"] integerValue];
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


@end
