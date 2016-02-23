//
//  HomeViewController.m
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImageButton.h"
#import "ConstObject.h"
#import "Define.h"
#import "CategoryViewController.h"
#import "PersonalInfoViewController.h"
#import "GMGridView.h"
#import "LoginViewController.h"
#import "CommercialTenantListViewController.h"
#import "OpenURLViewController.h"


#define kImageWidth  62 //UITableViewCell里面图片的宽度
#define kImageHeight  62 //UITableViewCell里面图片的高度

@interface HomeViewController ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>

@property (nonatomic, retain) UITableView *homeTableView;
@property (nonatomic, retain) NSMutableArray *buttonImageArray;
@property (nonatomic, retain) GMGridView *gmGridView;
@property (nonatomic, assign) NSInteger lastDeleteItemIndexAsked;

@end

@implementation HomeViewController
@synthesize homeTableView;
@synthesize buttonImageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super initNavBarItems:@""];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [super addRightButton:@"list" lightedImage:@"listLighted" selector:@selector(toSettingPage)];
//    [super addButtonx/Return:@"personalSettng" lightedImage:@"personalSettngLighted" selector:@selector(toPersonalPage)];
    //默认
    self.buttonImageArray = [NSMutableArray arrayWithObjects:@"食品宅配",@"送水",@"家政保洁",@"亲子",@"女人",@"汽车养护",@"洗衣",@"教育",nil];
    NSString *filePath = [super fileTextPath:@"menuList.plist"];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
	if (!fileExists) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        [buttonImageArray writeToFile:filePath atomically:YES];
        
	}else{
        self.buttonImageArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    [[ConstObject instance] setButtonImageArray:buttonImageArray];
    
//    NSInteger spacing = INTERFACE_IS_PHONE ? 10 : 15;
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = 1;
    
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _gmGridView.centerGrid = NO;
    _gmGridView.enableEditOnLongPress = YES;
    _gmGridView.editing = NO;
    _gmGridView.disableEditOnEmptySpaceTap = YES;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    _gmGridView.mainSuperView = self.view;
    
    int tempNum = ([buttonImageArray count]+1)/3 + ([buttonImageArray count]+1)%3;
    for(int i=0; i<=tempNum; i++){
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100*i, 320, 1)];
        [lineImage setBackgroundColor:COLOR(220, 220, 220)];
        lineImage.tag = 100000;
        [_gmGridView addSubview:lineImage];
        [lineImage release];
        
    }

    for(int i=0;i<2;i++){
    
        UIImageView *lineImages = [[UIImageView alloc] initWithFrame:CGRectMake(106.6667*(i+1), 0, 1, tempNum*100)];
        [lineImages setBackgroundColor:COLOR(220, 220, 220)];
        lineImages.tag = 100000;
        [_gmGridView addSubview:lineImages];
        [lineImages release];

    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toReloadData)
                                                 name:@"toReloadData"
                                               object:nil];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:NO];
    self.navigationController.navigationBar.alpha = 1;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"return"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}

-(void)toReloadData{
    
    self.buttonImageArray = [[ConstObject instance] buttonImageArray];
    int tempNum = ([buttonImageArray count]+1)/3+([buttonImageArray count]+1)%3;
    for(int i=0; i<=tempNum; i++){
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100*i, 320, 1)];
        [lineImage setBackgroundColor:COLOR(220, 220, 220)];
        lineImage.tag = 100000;
        [_gmGridView addSubview:lineImage];
        [lineImage release];
        
    }
    
    for(int i=0;i<2;i++){
        
        UIImageView *lineImages = [[UIImageView alloc] initWithFrame:CGRectMake(106.6667*(i+1), 0, 1, tempNum*100)];
        [lineImages setBackgroundColor:COLOR(220, 220, 220)];
        lineImages.tag = 100000;
        [_gmGridView addSubview:lineImages];
        [lineImages release];
        
    }
    [_gmGridView reloadData];
    
}

-(void)toSettingPage{
    
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    [self.navigationController presentViewController:categoryViewController animated:YES completion:nil];
    [categoryViewController release];
}

-(void)toPersonalPage{
    if(![[ConstObject instance] isLogin]){
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:@"0" forKey:@"isLogin"];
//        NSString *loginStatus = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"isLogin"]];
//        if([loginStatus isEqualToString:@"0"]){
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:nav animated:YES completion:^{
        
        }];
    }else{
        PersonalInfoViewController *personalInfoViewController = [[PersonalInfoViewController alloc] init];
        [self.navigationController pushViewController:personalInfoViewController animated:YES];
        [personalInfoViewController release];
    }
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [buttonImageArray count]+1;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(170, 170);
        }
        else
        {
            return CGSizeMake(106, 100);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 285);
        }
        else
        {
            return CGSizeMake(230, 230);
        }
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        cell.deleteButtonOffset = CGPointMake(100-29, 4);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
//        view.layer.masksToBounds = NO;
//        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect rect = CGRectMake(5, 0, 100, 100);
    if (index < [buttonImageArray count] &&[[buttonImageArray objectAtIndex:index] isEqualToString:@"送水"]) {
            rect = CGRectMake(5+19, 10, kImageWidth, kImageHeight);
    }
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:rect];
    
    if (index == [buttonImageArray count]) {
        imgview.image = [UIImage imageNamed:@"添加"];
    }else{
        imgview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[buttonImageArray objectAtIndex:index]]];
    }
    imgview.userInteractionEnabled = YES;
    [cell.contentView addSubview:imgview];
    [imgview release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 80-6, 100, 20)];
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (index == [buttonImageArray count]) {
        label.text = [NSString stringWithFormat:@"%@",@"添加"];
    }else
        label.text = [NSString stringWithFormat:@"%@",[buttonImageArray objectAtIndex:index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = COLOR(100, 100, 100);
//    label.highlightedTextColor = [UIColor redColor];
    label.font = kFontArial12;
    [cell.contentView addSubview:label];
    [label release];

    return cell;
}

- (BOOL)GMGridView:(GMGridView *)gridView canEditItemAtIndex:(NSInteger)index
{
    if(index<[buttonImageArray count]){
        return YES;
    }
    return NO; //index % 2 == 0;
//    return [self GridViewCanEdit:index];
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
//    NSLog(@"Did tap at index %d", position);
    if(position == [buttonImageArray count])
        [self toSettingPage];
    else {
//        [super showMBProgressHUD:[NSString stringWithFormat:@"Did tap %@  %d",[buttonImageArray objectAtIndex:position],position]];
//    [self performSelector:@selector(showMBHud) withObject:nil afterDelay:1];
        
        NSString *plistPath = [super fileTextPath:@"category.plist"];
        NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
        NSString *tempString = nil;
        
        for(int i=0; i<[listArray count]; i++){
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[listArray objectAtIndex:i]];
            NSString *mainTitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mainTitle"]];
            if([mainTitle isEqualToString:[buttonImageArray objectAtIndex:position]]){
                tempString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryId"]];
                
                NSLog(@"%@,%@",tempString,[buttonImageArray objectAtIndex:position]);
                break;
            }
        }
        
        if([tempString length]>10){
        //跳web页面
            OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
            [detailViewController initWithUrl:tempString andTitle:@""];
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];
            return;
        }
        if([tempString isEqualToString:@"59"]||[tempString isEqualToString:@"511"]){
        
            ShopListViewController *shopListViewController = [[ShopListViewController alloc] init];
            shopListViewController.theCategoryId = tempString;
            [self.navigationController pushViewController:shopListViewController animated:YES];
            [shopListViewController release];
            return;
        }
        CommercialTenantListViewController *controller = [[CommercialTenantListViewController alloc] init];
        controller.theCategoryId = tempString;
//        [controller.navigationItem setHidesBackButton:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}

-(void)showMBHud
{
    [super hideMBProgressHUD];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定暂时移除这项服务吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)GMGridView:(GMGridView *)gridView changedEdit:(BOOL)edit
{

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        
        
        NSString *plistPath = [super fileTextPath:@"category.plist"];
        NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
        for(int i=0; i< [listArray count]; i++){
        
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[listArray objectAtIndex:i]];
            //类别名
            NSString *mainTitle =[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainTitle"]];
            if([mainTitle isEqualToString:[buttonImageArray objectAtIndex:_lastDeleteItemIndexAsked]])
            {
                [dic setObject:@"0" forKey:@"categorySelected"];
                [listArray replaceObjectAtIndex:i withObject:dic];
                [listArray writeToFile:plistPath atomically:YES];
                break;
            }
        }
        [buttonImageArray removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
        NSString *filePath = [super fileTextPath:@"menuList.plist"];
        [buttonImageArray writeToFile:filePath atomically:YES];
        [[ConstObject instance] setButtonImageArray:buttonImageArray];
    }
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.transform=CGAffineTransformMakeScale(1.3f, 1.3f);
//                         cell.contentView.backgroundColor = [UIColor orangeColor];
//                         for (UIView *tempView in cell.contentView.subviews) {
//                             if(tempView.tag == 100000 || tempView.tag == 100001)
//                                 tempView.hidden = YES;
//                                 
//                         }
//                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
//                         cell.contentView.backgroundColor = [UIColor redColor];
//                         cell.contentView.layer.shadowOpacity = 0;
//                         for (UIView *tempView in cell.contentView.subviews) {
//                             if(tempView.tag == 100000 || tempView.tag == 100001)
//                                 tempView.hidden = NO;
                         
//                         }

                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [buttonImageArray objectAtIndex:oldIndex];
    [buttonImageArray removeObject:object];
    [buttonImageArray insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [buttonImageArray exchangeObjectAtIndex:index1 withObjectAtIndex:index2];

    NSString *filePath = [super fileTextPath:@"menuList.plist"];
    [buttonImageArray writeToFile:filePath atomically:YES];
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
//    fullView.layer.masksToBounds = NO;
//    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %ld", (long)index];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor blueColor];
//                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor redColor];
//                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    //设置是否可以删除
//    if(index<[buttonImageArray count]&&(index>4))
//        return YES;
//    return NO;
    return [self GridViewCanEdit:index];
}

-(BOOL)GridViewCanEdit:(NSInteger)index{

    if(index<[buttonImageArray count]){
        NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@"食品宅配",@"送水",@"家政保洁", nil];
        for(int i=0; i<[tempArray count]; i++){
        
            if([[buttonImageArray objectAtIndex:index] isEqualToString:[tempArray objectAtIndex:i]])
                return NO;
        }
        return YES;
    }
    return NO;
}

@end
