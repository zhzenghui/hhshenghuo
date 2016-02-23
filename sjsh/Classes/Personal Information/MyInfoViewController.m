//
//  MyInfoViewController.m
//  test
//
//  Created by zwy on 14/11/15.
//  Copyright (c) 2014年 zwy. All rights reserved.
//

#import "MyInfoViewController.h"
#import "NormalCell.h"
#import "PhotoCell.h"
#import "PublicClassMethod.h"
#import "NormalTableViewController.h"
#import "UIImage+Resize.h"
#import "MyAdressViewController.h"
#import "OpenURLViewController.h"
#import "AddressViewController.h"
#import "HHAdressViewController.h"

@implementation MyInfoViewController

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f) style:UITableViewStylePlain];;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [super initNavBarItems:@"我的资料"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.dataArray = [[NSMutableArray alloc] init];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createTableView];
}
#pragma mark -
- (void)createTableView
{
    [self updateTableViewDataSouce];
    
    [self.tableView reloadData];
}
- (void)updateTableViewDataSouce
{
    // 1. TODO 获取我的资料的数据
    
    
    NSString *userName = [_personalDic objectForKey:@"user_name"];
    NSString *nichengName =[_personalDic objectForKey:@"firstname"];
    NSString *address = [_personalDic objectForKey:@"address"];
    NSString *sex =[_personalDic objectForKey:@"sex"];
    NSString *trueName =[_personalDic objectForKey:@"lastname"];
    NSString *marriage =[_personalDic objectForKey:@"marry"];
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:
                      //1 头像
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       [NSArray arrayWithObjects:@"photoCellId",@"normalCellId",@"normalCellId",@"normalCellId", nil],kCellIdentifier,
                       [NSArray arrayWithObjects:@"头像",@"用户名",@"昵称",@"收货地址", nil],kCellTitle,
                       [NSArray arrayWithObjects:@"",userName,nichengName,address, nil],kCellContent,
                       [NSArray arrayWithObjects:CellAccessoryDisclosureIndicator,CellAccessoryNone,CellAccessoryDisclosureIndicator,CellAccessoryDisclosureIndicator, nil],kCellAccessoryType,
                       [NSArray arrayWithObjects:@"First_Sync_Contacts_Segue", nil],kCellSegue,
                       nil],
                      
                      
                      //2 性别
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       [NSArray arrayWithObjects:@"normalCellId",@"normalCellId",@"normalCellId", nil],kCellIdentifier,
                       [NSArray arrayWithObjects:@"性别",@"真实姓名",@"婚姻状况", nil],kCellTitle,
                       [NSArray arrayWithObjects:sex,trueName,marriage, nil],kCellContent,
                       [NSArray arrayWithObjects:CellAccessoryDisclosureIndicator,CellAccessoryDisclosureIndicator,CellAccessoryDisclosureIndicator, nil],kCellAccessoryType,
                       [NSArray arrayWithObjects:@"Delete_Same_Contact_Segue", @"Delete_Same_Contact_Segue",@"Delete_Same_Contact_Segue",nil],kCellSegue,
                       nil],
                      nil];
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
    if([reuseIdentifier isEqualToString:@"photoCellId"])
    {
        PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
        NSString *imageUrl = [_personalDic objectForKey:@"avatar"];
         imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        return cell;
    }
    else 
    {
        NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
        if (cell == nil) {
            cell = [[NormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.accessoryType = [PublicClassMethod cellAccessoryType:cellAccessoryType];
        cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [valueArray objectAtIndex:indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 114;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0.000000001;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 相册
            [self startCameraAndPhotoAlbum];
        }
        else if (indexPath.row == 2)
        {
            // 昵称
            NormalTableViewController *normalTableViewController = [[NormalTableViewController alloc] init];
            normalTableViewController.type = Type_Nickname;
            normalTableViewController.infoDic = self.personalDic;
            normalTableViewController.nickNameStr = [self.personalDic objectForKey:@"firstname"];//TODO
            [self.navigationController pushViewController:normalTableViewController animated:YES];
        }
        else if (indexPath.row == 3)
        {
            // 收货地址
//            MyAdressViewController *normalTableViewController = [[MyAdressViewController alloc] init];
//            [self.navigationController pushViewController:normalTableViewController animated:YES];
            
            
            //跳web页面
//            OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
//            detailViewController.hide400 = YES;
//            [detailViewController initWithUrl:@"http://www.sjsh8.cn/index.php?route=mobile/fuwu/appforaddress" andTitle:@"地址管理"];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *versionType = [userDefaults objectForKey:@"version"];
            
            if ([versionType isEqualToString:@"1"]) {
             AddressViewController *detailViewController = [[AddressViewController alloc] init];
            [self.navigationController pushViewController:detailViewController animated:YES];
            }else{
                HHAdressViewController *detailViewController = [[HHAdressViewController alloc] init];
                [self.navigationController pushViewController:detailViewController animated:YES];
            
            }
//            [detailViewController release];
            
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            // 性别
            NormalTableViewController *normalTableViewController = [[NormalTableViewController alloc] init];
            normalTableViewController.type = Type_Sex;
            normalTableViewController.infoDic = self.personalDic;
            normalTableViewController.sexStr = [self.personalDic objectForKey:@"sex"];//TODO
            [self.navigationController pushViewController:normalTableViewController animated:YES];
        }
        else if (indexPath.row == 1)
        {
            // 真实姓名
            NormalTableViewController *normalTableViewController = [[NormalTableViewController alloc] init];
            normalTableViewController.type = Type_TrueName;
            normalTableViewController.infoDic = self.personalDic;
            normalTableViewController.trueNameStr =[self.personalDic objectForKey:@"lastname"];//TODO
            [self.navigationController pushViewController:normalTableViewController animated:YES];
        }
        else if (indexPath.row == 2)
        {
            // 婚姻状况
            NormalTableViewController *normalTableViewController = [[NormalTableViewController alloc] init];
            normalTableViewController.type = Type_Marriage;
            normalTableViewController.infoDic = self.personalDic;
            normalTableViewController.marriageStr = [self.personalDic objectForKey:@"marry"];;//TODO
            [self.navigationController pushViewController:normalTableViewController animated:YES];
        }
    }

}

- (void)startCameraAndPhotoAlbum{
    UIActionSheet *cameraAction = [[UIActionSheet alloc] initWithTitle:@"修改头像"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    cameraAction.actionSheetStyle = UIBarStyleBlackTranslucent;
    [cameraAction showInView:self.view];
    [cameraAction release];
}

-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (void)updateAvatar:(UIImage *)avatarImage{
    NSLog(@"avatarImage=%@",avatarImage);
    self.image = avatarImage;
    [super showGif];
    [commonModel requestUpdateAvatar:UIImageJPEGRepresentation(avatarImage,0.5) httpRequestSucceed:@selector(requestUpdateAvatarSucceed:) httpRequestFailed:@selector(requestFailed:)];
}

- (void)requestUpdateAvatarSucceed:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        PhotoCell *cell = (PhotoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.headImageView setImage:[self.image resizeImageSize:CGSizeMake(200.0f, 200.0f)]];
        
        [self.personalDic setObject:[dic objectForKey:@"url"] forKey:@"avatar"];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1100){
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }return;
    }

#pragma --mark
#pragma  --mark UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType = 0;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
            break;
        default:
            break;
    }
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:sourceType];
    [imagePicker setAllowsEditing:YES];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
    [imagePicker release];
}

#pragma --mark
#pragma  --mark UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self updateAvatar:image];
}

#pragma mark
#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //获取相册controller描述
    NSString *classDes = [viewController.class description];
    NSLog(@"classDes=%@",classDes);
    if ([classDes isEqualToString:@"PUUIAlbumListViewController"] || [classDes isEqualToString:@"PLUILibraryViewController"] || [classDes isEqualToString:@"PUUIPhotosAlbumViewController"]  || [classDes isEqualToString:@"PLUIAlbumViewController"]) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        if (kSystemIsIOS7) {
//            viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        }
//        else{
//            viewController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:0.f/255.0f blue:200.0f/255.0f alpha:1.0f];
//        }
//        [viewController.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    }
}

@end
