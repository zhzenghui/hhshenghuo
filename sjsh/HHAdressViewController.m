//
//  HHAdressViewController.m
//  sjsh
//
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHAdressViewController.h"
#import "HHAddressCell.h"
#import "SVProgressHUD.h"
//#import "EditAddressTableView.h"
//#import "AddressEditController.h"

#import "HHAddressEditController.h"
#import "CommonUtil.h"

@interface HHAdressViewController ()
@property (strong, nonatomic)  UIBarButtonItem *deleteItem;//编辑按钮
@property (strong, nonatomic)  UIBarButtonItem *cancelItem;//取消按钮
@property (strong, nonatomic)  UIBarButtonItem *submitItem;//删除按钮
@property (strong, nonatomic)  UIButton *deleteButton;//编辑按钮
@property (strong, nonatomic)  UIButton *cancelButton;//取消按钮
@property (strong, nonatomic)  UIButton *submitButton;//删除按钮

@property(nonatomic, strong) UIButton *addAddressButton;//添加按钮
@property(nonatomic, strong) UITableView *addressTableView;//地址列表

@property (nonatomic, strong)  NSMutableArray *addressArray;//列表的内容数组
@property (nonatomic, assign) NSInteger delIndex;//滑动删除的编号
@property (nonatomic, strong)  NSMutableDictionary *modifyAddressDictionary;//待修改的地址信息

@property (nonatomic, strong) NSString * stringList;

@end

@implementation HHAdressViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.addressArray = [[NSMutableArray alloc] init];
    
    
    self.stringList =  @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"address_id\":8266,\"firstname\":\"\u6d4b\u8bd5\uff0c\u52ff\u9001\uff01\",\"mobile_num\":\"8888\",\"xiaoqu\":\"\",\"louhao\":\"\u53f7\u697c\",\"danyuan\":\"\u5355\u5143\",\"room_number\":\"\",\"address_1\":\"\",\"default_id\":1},{\"address_id\":8246,\"firstname\":\"\u6d4b\u8bd5\",\"mobile_num\":\"15888888888\",\"xiaoqu\":\"\u4e94\u533a\",\"louhao\":\"8\u53f7\u697c\",\"danyuan\":\"\u8bf7\u9009\u62e9\u5355\u5143\",\"room_number\":\"\u8bf7\u9009\u62e9\",\"address_1\":\"\",\"default_id\":0}]}";
    
    //测试数据
    //    for(int i=0;i<4;i++){
    //        NSDictionary *myDictionary = [[NSDictionary alloc]init];
    //        [self.addressArray addObject:myDictionary];
    //    }
    //    self.navigationItem.rightBarButtonItem =
    //初始化导航条
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [self.deleteButton setTitle:@"批量删除" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.deleteButton addTarget:self action:@selector(doEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleteButton];
    
    //    [self.editButtonItem setTarget:self];
    //    [self.editButtonItem setAction:@selector(doEdit:)];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.cancelItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [self.submitButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(deleteAddresses) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.submitItem = [[UIBarButtonItem alloc] initWithCustomView:self.submitButton];
    
    
    [super initNavBarItems:@"我的地址"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.addAddressButton = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-50, ScreenWidth, 50)];
    self.addAddressButton.backgroundColor = kRedColor;
    [self.addAddressButton setImage:[UIImage imageNamed:@"hh_user_address_add"] forState:UIControlStateNormal];
     self.addAddressButton.imageEdgeInsets = UIEdgeInsetsMake(0, -0, 0, 10);
    [self.addAddressButton setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [self.addAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addAddressButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.addAddressButton addTarget:self action:@selector(editAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addAddressButton];
    
    self.addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    self.addressTableView.backgroundColor = [UIColor whiteColor];
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    //    self.addressTableView.showsVerticalScrollIndicator =
    //    NO;
    self.addressTableView.tintColor = kRedColor;//选中颜色
    self.addressTableView.allowsMultipleSelectionDuringEditing = YES;
    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
//    self.addressTableView.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.addressTableView];
    
    
    [self updateButtonsToMatchTableState];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadInterfaceData];//调用接口数据，并刷新页面
}

//获取接口数据
- (void)loadInterfaceData{
    [self showGif];
    [commonModel requestaddress:nil httpRequestSucceed:@selector(requestaddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
}


//获取地址信息
- (void)requestaddressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    //    dic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"地址列表接口：%@!!!!!!!!!!!",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        self.addressArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"result"]];
        [self.addressTableView reloadData];
        //        for(int i=0;i<addressArray.count;i++){
        //            NSLog(@"是否默认：%@!!!!!!!!!!!",addressArray[i][@"default_id"]);
        //            if ([addressArray[i][@"default_id"] integerValue]==1) {
        //                NSString *addressString = [NSString stringWithFormat:@"%@  %@\n%@\n%@",addressArray[i][@"firstname"],addressArray[i][@"mobile_num"],addressArray[i][@"xiaoqu"],addressArray[i][@"louhao"]];
        //                self.addressLabel.text=addressString;
        //                self.addressId = [addressArray[i][@"address_id"] integerValue];
        //            }
        //        }
        
        
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}


//编辑按钮
- (void)doEdit:(UIButton *)sender {
    
    NSLog(@"点击了编辑按钮!!!!!!!");
    [self.addressTableView setEditing:YES animated:YES];
    [self updateButtonsToMatchTableState];
}

//取消编辑按钮
- (void)cancelEdit:(UIButton *)sender {
    
    NSLog(@"点击了取消按钮!!!!!!!");
    [self.addressTableView setEditing:NO animated:YES];
    [self updateButtonsToMatchTableState];
}

-(void)selectLeftAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

//修改或新增地址
-(void)editAddress{
    HHAddressEditController *addressTableView = [[HHAddressEditController alloc] init];
    if (self.modifyAddressDictionary) {
        addressTableView.dataDictionary = self.modifyAddressDictionary;
    }else{
        NSLog(@"新增地址！！！！！");
    }
    [self.navigationController pushViewController:addressTableView animated:YES];
}



//批量删除
-(void)deleteAddresses{
    
    NSArray *selectRows = [self.addressTableView indexPathsForSelectedRows];
    NSMutableArray *interfaceArray = [[NSMutableArray alloc]init];
    NSLog(@"所选的地址为%@!!!!!",selectRows);
    if (selectRows.count==0) {//删除全部
        for (int i=0; i<self.addressArray.count; i++) {
            NSDictionary *myDictionary =  self.addressArray[i];
            [interfaceArray addObject:myDictionary[@"address_id"]];
        }
    }else{//删除选中
        for (int i=0; i<selectRows.count; i++) {
            NSIndexPath *indexPath =   selectRows[i];
            NSDictionary *myDictionary =  self.addressArray[indexPath.row];
            NSLog(@"地址详细为%@!!!!!",myDictionary);
            [interfaceArray addObject:myDictionary[@"address_id"]];
        }
    }
    
    //    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
    //    infoDictionary[@"address_ids"] = interfaceArray;
    //
    //    NSLog(@"接口参数为%@！！！！！",infoDictionary);
    //    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
    //    infoDictionary[@"address_ids"] = interfaceArray;
    //
    //    NSString *info = [CommonUtil toJSONData:infoDictionary];
    //    NSLog(@"接口参数为%@！！！！！",info);
    
    NSString *info = interfaceArray.description;
    //     NSLog(@"接口参数为%@！！！！！",info);
    info = [info substringFromIndex:1];
    info = [info substringToIndex:info.length-1];
    NSLog(@"接口参数为%@！！！！！",info);
    [self showGif];
    [commonModel deleteAddress:info httpRequestSucceed:@selector(deleteAddressesSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

//获取地址信息
- (void)deleteAddressesSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"地址列表接口：%@!!!!!!!!!!!",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self loadInterfaceData];
        
    }
}

//返回上一页
-(void)backHomePage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Updating button state
//修改导航栏按钮作用
- (void)updateButtonsToMatchTableState
{
    if (self.addressTableView.editing)
    {
        // Show the option to cancel the edit.
        self.navigationItem.rightBarButtonItem = self.cancelItem;
        
        [self updateDeleteButtonTitle];//修改按钮标题
        
        // Show the delete button.
        self.navigationItem.leftBarButtonItem = self.submitItem;
    }
    else
    {
        // Not in editing mode.
        //初始化导航栏
        [super initNavBarItems:@"我的地址"];
        [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(backHomePage)];
        
        // Show the edit button, but disable the edit button if there's nothing to edit.
        //        self.editButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem = self.deleteItem;
    }
}

//改变删除按钮标题
- (void)updateDeleteButtonTitle
{
    // Update the delete button's title, based on how many items are selected
    NSArray *selectedRows = [self.addressTableView indexPathsForSelectedRows];//选择单元数量
    
    BOOL allItemsAreSelected = selectedRows.count == self.addressArray.count;//是否全部选择
    BOOL noItemsAreSelected = selectedRows.count == 0;//是否没有选择任何一个
    
    if (allItemsAreSelected || noItemsAreSelected)
    {
        self.submitItem.title = NSLocalizedString(@"删除全部", @"");
        [self.submitButton setTitle:NSLocalizedString(@"删除全部", @"") forState:UIControlStateNormal];
    }
    else
    {
        NSString *titleFormatString =
        NSLocalizedString(@"删除(%d)", @"Title for delete button with placeholder for number");
        self.submitItem.title = [NSString stringWithFormat:titleFormatString, selectedRows.count];
        [self.submitButton setTitle:[NSString stringWithFormat:titleFormatString, selectedRows.count] forState:UIControlStateNormal];
        
    }
}

//调用删除地址接口
- (void) doDeleteAddressInterface:(NSDictionary *)myDictionary{
    [commonModel requestdeladdress:[NSDictionary dictionaryWithObjectsAndKeys:[myDictionary objectForKey:@"address_id"],@"address_id", nil] httpRequestSucceed:@selector(deladdressSuccess:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)deladdressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"删除地址返回结果%@！！！",dic);
    
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        //只显示文字
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"删除成功！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        [self.addressArray removeObjectAtIndex:_delIndex];
        [self.addressTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }else if ([[dic objectForKey:@"code"] intValue] == 1601){
        //只显示文字
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"参数错误！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        //        [super showMessageBox:self title:@"" message:@"参数错误" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"" message:@"未登录" cancel:nil confirm:@"确定"];
        return;
    }
}


#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"AddressCell";
    
    HHAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[HHAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.addressArray[indexPath.row]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.editing){
        [self updateButtonsToMatchTableState];
    }else{
        HHAddressEditController *addressTableView = [[HHAddressEditController alloc] init];
        addressTableView.dataDictionary = [self.addressArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:addressTableView animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
}

//是否允许滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

//滑动删除具体方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSLog(@"开始删除");
        
        [self showGif];
        self.delIndex = indexPath.row;
        NSDictionary *addressDictionary = [self.addressArray objectAtIndex:self.delIndex];
        [self doDeleteAddressInterface:addressDictionary];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}
@end
