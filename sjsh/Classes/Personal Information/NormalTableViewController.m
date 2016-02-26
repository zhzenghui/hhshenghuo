//
//  NormalTableViewController.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "NormalTableViewController.h"
#import "PublicClassMethod.h"
#import "TextFieldCell.h"
#import "CheckmarkCellId.h"
#import "AddAddressCell.h"
#import "ShowAddressCell.h"

@implementation NormalTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
//    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f-50) style:UITableViewStyleGrouped];;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    NSString *title = @"";
    if (self.type == Type_Nickname) {
        title = @"昵称";
    }
    else if (self.type == Type_Sex)
    {
        title = @"性别";
    }
    else if (self.type == Type_TrueName)
    {
        title = @"真实姓名";
    }
    else if (self.type == Type_Marriage)
    {
        title = @"婚姻状况";
    }
    else if(self.type == Type_Address)
    {
        title = @"收货地址";
    }
    [super initNavBarItems:title];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    if (self.type != Type_Address)
    {
 
        self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
        [self.submitButton setTitle:@"保存" forState:UIControlStateNormal];
        self.submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
        self.submitButton.backgroundColor = kRedColor;
        [self.submitButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.submitButton];

        
        
    }
    
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
    if (self.type == Type_Nickname) {
        TextFieldCell *cell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *name = cell.textField.text;
        if (name) {
            [upDic setObject:name forKey:@"firstname"];
            [self.infoDic setObject:name forKey:@"firstname"];
        }
    }
    else if (self.type == Type_Sex)
    {
        [upDic setObject:self.sexStr forKey:@"sex"];
         [self.infoDic setObject:self.sexStr forKey:@"sex"];
    }
    else if (self.type == Type_TrueName)
    {
        TextFieldCell *cell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *name = cell.textField.text;
        if (name) {
            [upDic setObject:name forKey:@"lastname"];
             [self.infoDic setObject:name forKey:@"lastname"];
        }
    }
    else if (self.type == Type_Marriage)
    {
        [upDic setObject:self.sexStr forKey:@"marry"];
         [self.infoDic setObject:self.sexStr forKey:@"marry"];
    }
    if (upDic) {
        [super showGif];
        [commonModel requestupdateinfo:upDic httpRequestSucceed:@selector(requestupdateinfoSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    
}

- (void)requestupdateinfoSuccess:(ASIHTTPRequest *)request{
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
    [self updateTableViewDataSouce];
    
    [self.tableView reloadData];
}
- (void)updateTableViewDataSouce
{
    
    if (self.type == Type_Nickname) {
        //
        self.title = @"昵称";
        self.dataArray = [[NSMutableArray alloc] initWithObjects:
                          //1 头像
                          [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"textFieldCellId", nil],kCellIdentifier,
                           [NSArray arrayWithObjects:self.nickNameStr, nil],kCellTitle,
                           [NSArray arrayWithObjects:@"", nil],kCellContent,
                           [NSArray arrayWithObjects:CellAccessoryNone, nil],kCellAccessoryType,
                           
                           nil],
                          
                          nil];
    }
    else if (self.type == Type_Address)
    {
        self.title = @"收货地址";
        
        // TODO  先获取已有的地址
        
        self.dataArray = [[NSMutableArray alloc] initWithObjects:
                          //1
                          [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"showAddressCell",@"addAddressCell", nil],kCellIdentifier,
                           [NSArray arrayWithObjects:@"新增地址",@"", nil],kCellTitle,
                           [NSArray arrayWithObjects:@"北京海淀区",@"",nil],kCellContent,
                           [NSArray arrayWithObjects:CellAccessoryDisclosureIndicator,CellAccessoryDisclosureIndicator, nil],kCellAccessoryType,
                           
                           nil],
                          
                          nil];
    }
    else if (self.type == Type_Sex)
    {
        self.title = @"性别";
        self.dataArray = [[NSMutableArray alloc] initWithObjects:
                          //1
                          [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"checkmarkCellId",@"checkmarkCellId", nil],kCellIdentifier,
                           [NSArray arrayWithObjects:@"男",@"女", nil],kCellTitle,
                           [NSArray arrayWithObjects:@"",@"",nil],kCellContent,
                           [NSArray arrayWithObjects:CellAccessoryNone,CellAccessoryNone, nil],kCellAccessoryType,
                           
                           nil],
                          
                          nil];
    }
    else if (self.type == Type_TrueName)
    {
        self.title = @"真实姓名";
        self.dataArray = [[NSMutableArray alloc] initWithObjects:
                          //1
                          [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"textFieldCellId", nil],kCellIdentifier,
                           [NSArray arrayWithObjects:self.trueNameStr, nil],kCellTitle,
                           [NSArray arrayWithObjects:@"", nil],kCellContent,
                           [NSArray arrayWithObjects:CellAccessoryNone, nil],kCellAccessoryType,
                           
                           nil],
                          
                          nil];
    }
    else if (self.type == Type_Marriage)
    {
        self.title = @"婚姻状况";
        self.dataArray = [[NSMutableArray alloc] initWithObjects:
                          //1
                          [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"checkmarkCellId",@"checkmarkCellId",@"checkmarkCellId", nil],kCellIdentifier,
                           [NSArray arrayWithObjects:@"未婚",@"已婚",@"保密", nil],kCellTitle,
                           [NSArray arrayWithObjects:@"",nil],kCellContent,
                           [NSArray arrayWithObjects:CellAccessoryNone,CellAccessoryNone,CellAccessoryNone, nil],kCellAccessoryType,
                           
                           nil],
                          
                          nil];
    }
    
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
    if([reuseIdentifier isEqualToString:@"textFieldCellId"])
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.textField.text = [titleArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if ([reuseIdentifier isEqualToString:@"checkmarkCellId"])
    {
        CheckmarkCellId *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[CheckmarkCellId alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
        if (self.type == Type_Sex) {
            if ([self.sexStr isEqualToString:cell.nameLabel.text]) {
                cell.checkBtn.selected = YES;
            }
            else
            {
                cell.checkBtn.selected = NO;
            }
        }
        else if (self.type == Type_Marriage)
        {
            if ([self.marriageStr isEqualToString:cell.nameLabel.text]) {
                cell.checkBtn.selected = YES;
            }
            else
            {
                cell.checkBtn.selected = NO;
            }
        }
        return cell;
    }
    else if ([reuseIdentifier isEqualToString:@"addAddressCell"])
    {
        AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[AddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        
        return cell;
    }
    else if ([reuseIdentifier isEqualToString:@"showAddressCell"])
    {
        ShowAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[ShowAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [valueArray objectAtIndex:indexPath.row];
        return cell;
    }
//    else
//    {
//        NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//        
//        if (cell == nil) {
//            cell = [[NormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//        }
//        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
//        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
//        cell.valueLabel.text = [valueArray objectAtIndex:indexPath.row];
//        return cell;
//    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == Type_Nickname) {
        return 52.5;
    }
    else if (self.type == Type_Address)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
        
        if (indexPath.row < [[dic objectForKey:kCellIdentifier] count] - 1) {
            return 80;
        }
        return 52.5;
    }
    else if (self.type == Type_Sex)
    {
        return 52.5;
    }
    else if (self.type == Type_TrueName)
    {
        return 52.5;
    }
    else if (self.type == Type_Marriage)
    {
        return 52.5;
    }
    return 52.5;
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

    if (self.type == Type_Nickname) {
        
    }
    else if (self.type == Type_Address)
    {
        // TODO 传地址信息
       
    }
    else if (self.type == Type_Sex)
    {
        CheckmarkCellId *cell = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:indexPath];
        cell.checkBtn.selected = YES;
        if (indexPath.row == 0) {
            self.sexStr = @"男";
            CheckmarkCellId *cellT = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cellT.checkBtn.selected = NO;
            
        }
        else
        {
            self.sexStr = @"女";
            CheckmarkCellId *cellT = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cellT.checkBtn.selected = NO;
        }
        
        
    }
    else if (self.type == Type_TrueName)
    {

    }
    else if (self.type == Type_Marriage)
    {
        // 写死了
        CheckmarkCellId *cell = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:indexPath];
        cell.checkBtn.selected = YES;
        if (indexPath.row == 0) {
            self.sexStr = @"未婚";
            CheckmarkCellId *cell1 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell1.checkBtn.selected = NO;
            CheckmarkCellId *cell2 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell2.checkBtn.selected = NO;
        }
        else if (indexPath.row == 1)
        {
            self.sexStr = @"已婚";
            CheckmarkCellId *cell1 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell1.checkBtn.selected = NO;
            CheckmarkCellId *cell2 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell2.checkBtn.selected = NO;
        }
        else if (indexPath.row == 2)
        {
            self.sexStr = @"保密";
            CheckmarkCellId *cell1 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell1.checkBtn.selected = NO;
            CheckmarkCellId *cell2 = (CheckmarkCellId *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell2.checkBtn.selected = NO;
        }
    }
}

@end
