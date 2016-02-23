//
//  EditAddressTableView.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "EditAddressTableView.h"
#import "PublicClassMethod.h"
#import "EditAddressCell.h"
@implementation EditAddressTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
//    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStyleGrouped];;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [super initNavBarItems:@"收货地址"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super addRightButton:@"save" lightedImage:@"save" selector:@selector(save)];
    self.xiaoquList = @[@"垂虹园",@"春荫园",@"翠叠园",@"观山园",@"金夕园",@"国际公寓",@"烟树园",@"晨月园",@"上河村",@"晴波园",@"晴雪园",@"时雨园",@"世纪新景",@"远大一区",@"远大二区",@"远大三区",@"远大四区",@"远大五区",@"远大六区",@"武警小区一区",@"武警小区二区"];
    self.louhaoList = @[@"1号楼",@"2号楼",@"3号楼",@"4号楼",@"5号楼",@"6号楼",@"7号楼",@"8号楼",@"9号楼",@"10号楼",@"11号楼",@"12号楼",@"13号楼",@"14号楼"];
    self.danyuanList = @[@"一单元",@"二单元",@"三单元",@"四单元",@"五单元",@"六单元",@"七单元"];
    selectIndex = 2;
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, MRScreenHeight ,MRScreenWidth, 180)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self.view addSubview:self.pickView];
    
    [self createTableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save
{
    NSMutableDictionary *upDic = [NSMutableDictionary dictionary];
    NSArray *keys = @[@"firstname",@"mobile_num",@"xiaoqu",@"louhao",@"danyuan",@"room_number",@"address_1"];
    for (int i = 0; i<7; i++) {
        EditAddressCell *cell = (EditAddressCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSString *value = cell.textField.text;
        [upDic setObject:value forKey:[keys objectAtIndex:i]];
    }
    if (self.dataDic) {
        //修改
        [upDic setObject:[_dataDic objectForKey:@"address_id"] forKey:@"address_id"];
        [commonModel requestupdateaddress:upDic httpRequestSucceed:@selector(requestupdateaddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    else {
        //添加
        [commonModel requestaddaddress:upDic httpRequestSucceed:@selector(requestaddaddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}

- (void)requestupdateaddressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}

- (void)requestaddaddressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}
#pragma mark -
- (void)createTableView
{
    [self createTableViewFootView];
    [self updateTableViewDataSouce];
    
    [self.tableView reloadData];
}
- (void)updateTableViewDataSouce
{
    // 1. TODO 获取地址信息
    NSString *firstname = @"";
    NSString *mobile_num = @"";
    NSString *xiaoqu = @"";
    NSString *address_1 = @"";
    NSString *louhao = @"";
    NSString *danyuan = @"";
    NSString *room_number = @"";
    
    if (_dataDic) {
        
        firstname = [_dataDic objectForKey:@"firstname"];
        mobile_num = [_dataDic objectForKey:@"mobile_num"];
        xiaoqu = [_dataDic objectForKey:@"xiaoqu"];
        louhao = [_dataDic objectForKey:@"louhao"];
        danyuan = [_dataDic objectForKey:@"danyuan"];
        room_number = [_dataDic objectForKey:@"room_number"];
        address_1 = [_dataDic objectForKey:@"address_1"];
    }
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:
                      //1
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       [NSArray arrayWithObjects:@"editAddressCell",@"editAddressCell",@"editAddressCell",@"editAddressCell",@"editAddressCell",@"editAddressCell",@"editAddressCell", nil],kCellIdentifier,
                       [NSArray arrayWithObjects:@"收件人",@"手机号码", @"小区",@"楼号",@"单元",@"房号",@"详细地址",nil],kCellTitle,
                       [NSArray arrayWithObjects:firstname?firstname:@"",mobile_num?mobile_num:@"",xiaoqu?xiaoqu:@"",louhao?louhao:@"",danyuan?danyuan:@"",room_number?room_number:@"",address_1?address_1:@"",nil],kCellContent,
                       [NSArray arrayWithObjects:@"姓名",@"11位手机号",@"小区名称",@"楼号",@"单元号",@"房号",@"写字楼商户等其他地址",nil],kCellPlaceholder,
                       [NSArray arrayWithObjects:CellAccessoryNone,CellAccessoryNone,CellAccessoryNone,CellAccessoryNone,CellAccessoryNone,CellAccessoryNone,CellAccessoryNone, nil],kCellAccessoryType,
                       
                       nil],
                      
                      nil];
}

- (void)createTableViewFootView
{
    UIView *endView = [[UIView alloc]
                    initWithFrame:CGRectMake(0, 0, MRScreenWidth, 30)];
    UILabel *endLabel = [[UILabel alloc]
                     initWithFrame:CGRectMake(30, 0, MRScreenWidth - 30 * 2, 30)];
    
    endLabel.textColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:1];
    NSString *endStr = @"目前配送范围只覆盖北京世纪城区地域";
    endLabel.font = [UIFont systemFontOfSize:14];
    endLabel.text = endStr;
    endLabel.textAlignment = NSTextAlignmentCenter;

    [endView addSubview:endLabel];
    self.tableView.tableFooterView = endView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [self.dataArray objectAtIndex:section];
    return [[dic objectForKey:kCellIdentifier] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *cellArray = [dic objectForKey:kCellIdentifier];
    NSString *reuseIdentifier = [cellArray objectAtIndex:indexPath.row];
    NSArray *accessoryArray = [dic objectForKey:kCellAccessoryType];
    NSString *cellAccessoryType = [accessoryArray objectAtIndex:indexPath.row];
    
    NSArray *titleArray = [dic objectForKey:kCellTitle];
    NSArray *valueArray = [dic objectForKey:kCellContent];
    NSArray *placeholderArray = [dic objectForKey:kCellPlaceholder];
    if([reuseIdentifier isEqualToString:@"editAddressCell"])
    {
        EditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[EditAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.textField.text = [valueArray objectAtIndex:indexPath.row];
        cell.textField.placeholder = [placeholderArray objectAtIndex:indexPath.row];
        cell.textField.delegate = self;
        cell.textField.tag = indexPath.row;
        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if(section == 0)
    //    {
    //        return 0.000000001;
    //    }
    return 20;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.000000001;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (selectIndex == 2) {
        return [_xiaoquList count];
    }
    else if(selectIndex == 3) {
        return [_louhaoList count];
    }else if(selectIndex == 4) {
        return [_danyuanList count];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (selectIndex == 2) {
        return [_xiaoquList objectAtIndex:row];
    }
    else if(selectIndex == 3) {
        return [_louhaoList objectAtIndex:row];
    }else if(selectIndex == 4) {
        return [_danyuanList objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    EditAddressCell *cell = (EditAddressCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
    if (selectIndex == 2) {
        cell.textField.text = [_xiaoquList objectAtIndex:row];
    }
    else if(selectIndex == 3) {
        cell.textField.text =  [_louhaoList objectAtIndex:row];
    }else if(selectIndex == 4) {
        cell.textField.text =  [_danyuanList objectAtIndex:row];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag>3) {
        [self.tableView setFrame:CGRectMake(0, 0-50*(textField.tag-3), self.view.frame.size.width, self.view.frame.size.height)];
        
    }
    else {
        [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }

    //获取当前输入框
    if (textField.tag==2||textField.tag==3||textField.tag==4) {
        EditAddressCell *cell = (EditAddressCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
        [cell.textField resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect tempFrame = self.pickView.frame;
             tempFrame.origin.y = self.view.bounds.size.height-200;
             self.pickView.frame = tempFrame;
         }completion:^(BOOL finished){
             selectIndex = textField.tag;
             [self.pickView reloadComponent:0];
         }];
        return NO;
        
    }
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect tempFrame = self.pickView.frame;
         tempFrame.origin.y = self.view.bounds.size.height;
         self.pickView.frame = tempFrame;
     }completion:^(BOOL finished){
     }];
    selectIndex = textField.tag;
    return YES;
}

@end
