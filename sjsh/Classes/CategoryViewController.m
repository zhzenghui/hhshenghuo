//
//  CategoryViewController.m
//  sjsh
//
//  Created by ce on 14-7-21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CategoryViewController.h"
#import "ConstObject.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize listArray;
@synthesize dictplist;

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
//    [super initNavBarItems:@"选择模块"];
    [self createHeadView:@"选择模块"];
    [super addButtonReturn:@"topBackLighted" lightedImage:@"topBackLighted" selector:@selector(toReturn)];
    
    self.view.backgroundColor = COLOR(240, 240, 240);
    
    NSString *plistPath = [super fileTextPath:@"category.plist"];
    self.listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];

//    dataArray =  [NSMutableArray arrayWithObjects:@"家装",@"婚庆",@"鲜花绿植",@"教育",@"亲子",@"便民服务",@"电影",@"酒店",@"艺术摄影",@"休闲娱乐",@"运动健身",@"家政",@"汽车养护",@"电脑维修",@"租车",@"代驾",@"医疗健康",@"旅游",@"公共服务",@"女人",@"商务服务",@"房产中介",@"美食",@"保险理财",@"邻里活动",@"拼车",@"宠物",@"跳蚤市场",@"劳务市场",@"办事指南",@"送水订餐",@"食品宅配",@"搬家",@"维修",@"洗衣",nil];
    
    categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 64.0f, kScreenBounds.size.width, kScreenBounds.size.height-44) style:UITableViewStylePlain];
    categoryTableView.delegate = self;
    categoryTableView.dataSource = self;
    categoryTableView.backgroundColor = COLOR(240, 240, 240);
    categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:categoryTableView];
    [categoryTableView release];

}

-(void)toReturn{
    
    NSString *filePath = [super fileTextPath:@"category.plist"];
    [self.listArray writeToFile:filePath atomically:YES];
    
    NSString *filePath1 = [super fileTextPath:@"menuList.plist"];
    [[[ConstObject instance] buttonImageArray] writeToFile:filePath1 atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toReloadData" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createHeadView:(NSString *)titleName{
    
    UIView *backgroundView = nil;
    
    if (kSystemIsIOS7) {
        backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 64.0f)];
    }
    else{
        backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    }
    
    backgroundView.backgroundColor = [UIColor colorWithRed:0xfa/255. green:0xfa/255. blue:0xfa/255. alpha:1];
    backgroundView.tag = 1011;
    
    //设置标题
    UILabel *aTitleLabel = nil;
    
    if (kSystemIsIOS7) {
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 18.0f, 212.0f, 48.0f)];
    }
    else{
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 15.0f, 212.0f, 40.0f)];
    }
    aTitleLabel.text = titleName;
    aTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    aTitleLabel.textAlignment = NSTextAlignmentCenter;
    aTitleLabel.backgroundColor = [UIColor clearColor];
    aTitleLabel.adjustsFontSizeToFitWidth = YES;
    aTitleLabel.textColor = COLOR(170, 170, 170);
    [backgroundView addSubview:aTitleLabel];
    [aTitleLabel release];
    
    [self.view addSubview:backgroundView];
    
    UIButton *returnButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor clearColor];
    [returnButton setTintColor:[UIColor whiteColor]];
    returnButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [returnButton setImage:[UIImage imageNamed:@"topBack"] forState:UIControlStateNormal];
    [returnButton setImage:[UIImage imageNamed:@"topBackLighted"] forState:UIControlStateHighlighted];
    [returnButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
    
    if (kSystemIsIOS7) {
        returnButton.frame = CGRectMake(-8.0f, 18.0f, [UIImage imageNamed:@"topBack"].size.width,[UIImage imageNamed:@"topBackLighted"].size.height);
    }
    else{
        returnButton.frame = CGRectMake(-5.0f, 15.0f, [UIImage imageNamed:@"topBack"].size.width,[UIImage imageNamed:@"topBackLighted"].size.height);
    }
    returnButton.tag = 10000;
    [self.view addSubview:returnButton];
    
    [backgroundView release];
    
}

#pragma mark --- UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
//    [NSMutableArray arrayWithArray:[dictplist objectForKey:[dataArray objectAtIndex:

    int rowNumber = indexPath.row;
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[self.listArray objectAtIndex:rowNumber]];
    NSString *imageName =[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryImage"]];
    [cell.itemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]];
    [cell.mainTitleLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainTitle"]]];
    [cell.secondTitleLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"secondTitle"]]];
    NSString *categorySelected = [NSString stringWithFormat:@"%@",[dic objectForKey:@"categorySelected"]];
    if([categorySelected isEqualToString:@"0"]){
        //还没有选择的
        cell.addButton.hidden = NO;
        [cell.addButton setImage:[UIImage imageNamed:@"notAdd"] forState:UIControlStateNormal];
        [cell.addButton setImage:[UIImage imageNamed:@"notAddLighted"] forState:UIControlStateHighlighted];
        [cell.addButton addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
        cell.addButton.tag = rowNumber;

    }else if ([categorySelected isEqualToString:@"1"]){
        //被选择了的
        cell.addButton.hidden = NO;
        [cell.addButton setImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
        [cell.addButton setImage:[UIImage imageNamed:@"addButtonLighted"] forState:UIControlStateHighlighted];
        [cell.addButton addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
        cell.addButton.tag = rowNumber;

    }else
        cell.addButton.hidden = YES;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    
    return 10.0f;
}

-(void)changeSelect:(id)sender
{

    UIButton *button = (UIButton *)sender;
    int buttonTag = button.tag;
    
    NSMutableArray *selectedArray = [NSMutableArray arrayWithArray:[[ConstObject instance] buttonImageArray]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.listArray objectAtIndex:buttonTag]];
    NSString *categorySelected = [NSString stringWithFormat:@"%@",[dic objectForKey:@"categorySelected"]];
    //类别名
    NSString *mainTitle =[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainTitle"]];
//    BOOL hasExist = NO;
//
//    for(int i=0; i<[selectedArray count]; i++){
//        NSString *tempTitle = [selectedArray objectAtIndex:i];
//        if([mainTitle isEqualToString:tempTitle])
//            hasExist = YES;
//    }
    
    if([categorySelected isEqualToString:@"0"]){
        
        [dic setValue:@"1" forKey:@"categorySelected"];
        [button setImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"addButtonLighted"] forState:UIControlStateHighlighted];
        
        [self.listArray replaceObjectAtIndex:buttonTag withObject:dic];
        [selectedArray addObject:mainTitle];
        [[ConstObject instance] setButtonImageArray:selectedArray];
        
    }else if([categorySelected isEqualToString:@"1"]){
        
        [dic setValue:@"0" forKey:@"categorySelected"];
        [button setImage:[UIImage imageNamed:@"notAdd"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"notAddLighted"] forState:UIControlStateHighlighted];

        [self.listArray replaceObjectAtIndex:buttonTag withObject:dic];
        [selectedArray removeObject:mainTitle];
        [[ConstObject instance] setButtonImageArray:selectedArray];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

    [listArray release];
    [super dealloc];
}
@end
