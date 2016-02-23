//
//  MyReplyViewController.m
//  sjsh
//
//  Created by ce on 14-10-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyAdressViewController.h"
#import "AddAddressCell.h"
#import "ShowAddressCell.h"
#import "EditAddressTableView.h"
@interface MyAdressViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@end

@implementation MyAdressViewController
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
    [super initNavBarItems:@"收货地址"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(250, 250, 250);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    //    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.separatorColor = COLOR(178, 178, 178);
    [self.view addSubview:listTableView];
    [listTableView release];
//    [self fetchData];
}

-(void)fetchData{
    [self showGif];
    [commonModel requestaddress:nil httpRequestSucceed:@selector(requestaddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestaddressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.dataArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
        [listTableView reloadData];
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
        return 50;
    }
    return 80;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AddAddressIdentifier = @"AddAddressIdentifier";
    if (indexPath.row == [self.dataArray count]) {
        AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:AddAddressIdentifier];
        if (cell == nil) {
            cell = [[AddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddAddressIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    static NSString *ShowAddressIdentifier = @"ShowAddressIdentifier";
    ShowAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowAddressIdentifier];
    NSDictionary *inforDic = [_dataArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[ShowAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShowAddressIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLabel.text = [inforDic objectForKey:@"firstname"];
    cell.valueLabel.text =[inforDic objectForKey:@"address_1"];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_dataArray count]) {
        return NO;
    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        _delIndex = indexPath.row;
        NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.row];
        [commonModel requestdeladdress:[NSDictionary dictionaryWithObjectsAndKeys:[productDic objectForKey:@"address_id"],@"address_id", nil] httpRequestSucceed:@selector(deladdressSuccess:) httpRequestFailed:@selector(requestFailed:)];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditAddressTableView *addressTableView = [[EditAddressTableView alloc] init];
    if (indexPath.row < [_dataArray count]) {
        addressTableView.dataDic = [_dataArray objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:addressTableView animated:YES];
}

- (void)deladdressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        
        [_dataArray removeObjectAtIndex:_delIndex];
        [listTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }else if ([[dic objectForKey:@"code"] intValue] == 1601){
        
        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"" message:@"未登录" cancel:nil confirm:@"确定"];
        return;
    }
}

@end
