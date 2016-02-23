//
//  MyShoppingCartViewController.m
//  sjsh
//
//  Created by 杜 计生 on 14-8-27.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyShoppingCartViewController.h"
#import "UIImageView+WebCache.h"
#import "SKUViewController.h"
#import "CheckOutViewController.h"
#import "OpenURLViewController.h"
#import "CommodityDetailController.h"
#import "DXAlertView.h"
#import "Message.h"
#import "AddOrderViewController.h"


@interface MyShoppingCartViewController ()<SkuResultDelegate>
{
    NSInteger delIndex;
    NSInteger editIndex;
    NSMutableIndexSet *indicesOfItemsToDelete; //批量选择的数据
}
@property (nonatomic, retain) UIView *bottomView;
@end

@implementation MyShoppingCartViewController

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
    // Do any additional setup after loading the view.
    [super initNavBarItems:@"购物车"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super addRightTitle:@"编辑" selector:@selector(doEdit)];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.selectArray = [NSMutableArray arrayWithCapacity:1];
    
    UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake((MRScreenWidth-180)/2, 135, 180, 180)];
    hintView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:hintView];
    
    UIImageView *tuxingImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 120, 115)];
    tuxingImgV.image = [UIImage imageNamed:@"tuxing"];
    [hintView addSubview:tuxingImgV];
    [tuxingImgV release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 136, 140, 20)];
    label.text = @"您还未添加商品，再去";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [hintView addSubview:label];
    [label release];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(137, 136, 60, 20);
    //    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"逛逛吧" forState:UIControlStateNormal];
    [button1 setTitle:@"逛逛吧" forState:UIControlStateHighlighted];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    [hintView addSubview:button1];
    [button1 release];
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f-59) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = COLOR(240, 240, 240);
    self.listTableView.separatorColor = COLOR(178, 178, 178);
    self.listTableView.tableFooterView = [[UIView alloc] init];
    self.listTableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.listTableView];
    [self.listTableView release];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height-59-44, 320, 59)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.bottomView = view;
    [view release];
    
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    lineview.backgroundColor = COLOR(178, 178, 178);
    [view addSubview:lineview];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 18 , 125, 20)];
    self.totoaPricelabel = label1;
    label1.text = @"合计：0.00元";
//    label1.textColor = COLOR(178, 178, 178);
    label1.textColor=[UIColor blackColor];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"Arial" size:14.0];
    [view addSubview:label1];
    label1.hidden = NO;
    [label1 release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payButton = button;
    button.enabled = YES;
    button.frame = CGRectMake(160, 7, 140, 44);
    [button setBackgroundImage:[UIImage imageNamed:@"checkOutBtn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoPay) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"结 算" forState:UIControlStateNormal];
    [view addSubview:button];
    [button release];
    
    
    //测试代码，可删除
    //    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1", nil];
    
    [self fetchData];
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoShop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)gotoPay
{
    [super showGif];
    [commonModel requestCheckLogin:nil httpRequestSucceed:@selector(requestCheckLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];}

- (void)requestCheckLoginSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [self enterOrderPage];
            
            break;
        case 1100:
            //添加成功
            //            msg = @"未登录";
            [self pushToLoginVC:NO animation:YES];
            break;
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)enterOrderPage
{
    //进入下单页
    //    CheckOutViewController *checkVC = [[CheckOutViewController alloc] init];
    //    [self.navigationController pushViewController:checkVC animated:YES];
//    OpenURLViewController *detailViewController = [[OpenURLViewController alloc] init];
//    [detailViewController initWithUrl:KcheckOutPage andTitle:@"填写订单"];
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    [detailViewController release];
    
    AddOrderViewController *myViewController = [[AddOrderViewController alloc] init];
     myViewController.isFirst = YES;
    myViewController.isAll = NO;
    [self.navigationController pushViewController:myViewController animated:YES];
}


-(void)fetchData{
    [super showGif];
    [commonModel requestShowCar:nil httpRequestSucceed:@selector(cartListSuccess:) httpRequestFailed:@selector(cartListFail:)];
    
}

- (void)cartListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"购物车列表dic%@！！！！！！！！！！",completeDic);
    self.dataArray = [NSMutableArray arrayWithArray:[completeDic objectForKey:@"result"]];
    if (self.dataArray.count == 0) {
        self.bottomView.hidden = YES;
    }
    else {
        self.bottomView.hidden = NO;
    }
    [self.listTableView reloadData];
    [self updateTotoaPrice];
}

- (void)cartListFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self.dataArray count]>0)
    {
        self.listTableView.hidden = NO;
        return [_dataArray count];
    }
    else {
        self.listTableView.hidden = YES;
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.section];
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil];
        cell = self.myCell;
        self.myCell = nil;
        //        cell.accessoryType = UITableViewCellAccessoryNone;
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }
    //    cell.numLabel.text = [NSString stringWithFormat:@"数量：%@",[[productDic objectForKey:@"quantity"] stringValue]];
    UIImage *lineImage=[UIImage imageNamed:@"gray_line.jpg"];
    [cell.myLine setImage:lineImage];
//    cell.myLine.contentMode=UIViewContentModeScaleAspectFill;
    
    cell.titleLabel.text = [productDic objectForKey:@"name"];
    cell.descriptionLabel.text = [productDic objectForKey:@"meta_description"];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥ %@",[[productDic objectForKey:@"price"] stringValue]];
    NSString *imageUrl = [productDic objectForKey:@"thumb"];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.iconImageview setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    NSArray *option = [productDic objectForKey:@"option"];
    
    NSString * myInfo=nil;
    cell.numLabel.hidden=YES;
    if ([option count]>0) {
        myInfo=[NSString stringWithFormat:@"%@：%@\n数量：%@",[[option objectAtIndex:0] objectForKey:@"name"],[[option objectAtIndex:0] objectForKey:@"value"], [[productDic objectForKey:@"quantity"] stringValue]];
        
    }
    else {
        myInfo=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"数量：%@",[[productDic objectForKey:@"quantity"] stringValue]]];
    }
    
    NSLog(@"商品描述为：%@!!!!!!!",myInfo);
    cell.skuLabel.text = myInfo;
    cell.delegate = self;
    cell.tag = indexPath.section;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择商品%@!!!!!!!!",indexPath);
    if (!self.listTableView.editing){
        NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.section];
        NSString *productId = [productDic objectForKey:@"product_id"];
        CommodityDetailController *detailViewController = [[CommodityDetailController alloc] init];
//        int flag = 0;//[[dataDic objectForKey:@"flag"] integerValue];
//        switch (flag) {
//            case 0:
//                detailViewController.pType = generalType;
//                break;
//            case 1:
//                detailViewController.pType = virtualType;
//                break;
//            case 3:
//                detailViewController.pType = changeType;
//                break;
//            default:
//                break;
//        }
//        detailViewController.productDic = [NSDictionary dictionaryWithObjectsAndKeys:productId,@"product_id", nil];
         detailViewController.productID= productId;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        delIndex = indexPath.section;
        NSDictionary *productDic = [self.dataArray objectAtIndex:indexPath.section];
        [commonModel requestDelFromCart:[NSDictionary dictionaryWithObjectsAndKeys:[productDic objectForKey:@"key"],@"key",[productDic objectForKey:@"manufacturer_id"],@"manufacturer_id", nil] httpRequestSucceed:@selector(DelFromCartSuccess:) httpRequestFailed:@selector(DelFromCartFail:)];
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

//批量修改
- (void)doEdit {
    if (self.listTableView.editing){//点击确定按钮，进行删除处理
         NSArray *selectedRows = [self.listTableView indexPathsForSelectedRows];
        NSLog(@"选择删除的商品数目为%lu！！！！！!!!!!!!!!!",(unsigned long)selectedRows.count);
         NSLog(@"选择删除的商品为%@！！！！！!!!!!!!!!!",selectedRows);
        NSString *actionTitle;
        actionTitle = NSLocalizedString(@"你确定要删除这些商品吗?", @"");
       
        BOOL deleteSpecificRows = selectedRows.count > 0;
        if (deleteSpecificRows)
        {

        DXAlertView *dav = [Message messageDXAlert:actionTitle leftTitle:@"取消" rightTitle:@"确定"];
        
        dav.leftBlock = ^() {
        };
        dav.rightBlock = ^() {
            // Delete what the user selected.
                           // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
//                NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];//直接操作列表数据时使用
                NSMutableString *scIds=[[NSMutableString alloc] init];
             NSMutableString *scIds02=[[NSMutableString alloc] init];
  indicesOfItemsToDelete = [NSMutableIndexSet new];
            
            for (int i=0;i<selectedRows.count;i++)
                {
//                    NSIndexPath *selectionIndex=selectedRows[i];
//                    NSLog(@"删除商品%d中！！！！！!!!!!!!!!!",i);
//                    [indicesOfItemsToDelete addIndex:i];
                    //                [scIds appendString:@","];
                     [indicesOfItemsToDelete addIndex:i];
                    NSString *scIdsString=[ NSString stringWithFormat:@",%@",self.dataArray[i][@"key"]];
                     NSString *manufacturer_idString=[ NSString stringWithFormat:@",%@",self.dataArray[i][@"manufacturer_id"]];
//                     NSLog(@"删除商品%@中！！！！！!!!!!!!!!!",self.dataArray[i][@"key"]);
                    [scIds appendString:scIdsString];
                    [scIds02 appendString:manufacturer_idString];
                }
                NSString *key=[scIds substringFromIndex:1];
            NSString *manufacturer_id=[scIds02 substringFromIndex:1];
                NSLog(@"删除商品的编号为%@和%@！！！！！!!!!!!!!!!",key,manufacturer_id);
                //            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//                NSString *url = [NSString string];
            
            NSMutableDictionary *myDictionary=[[NSMutableDictionary alloc]init];
            [myDictionary setValue:key forKey:@"key"];
             [myDictionary setValue:manufacturer_id forKey:@"manufacturer_id"];
            [super showGif];
            [commonModel requestDelFromCart:myDictionary httpRequestSucceed:@selector(MutableDelFromCartSuccess:) httpRequestFailed:@selector(DelFromCartFail:)];
            
        };
         }
  
        [self.listTableView setEditing:NO animated:YES];
        [super addRightTitle:@"编辑" selector:@selector(doEdit)];
    }else{
        indicesOfItemsToDelete=nil;
        [self.listTableView setEditing:YES animated:YES];
        [super addRightTitle:@"确定" selector:@selector(doEdit)];
    }
}


//- (void)deleteSuccess:(ASIHTTPRequest *)request{
//    [super hideGif];
//    NSDictionary *completeDic = [super parseJsonRequest:request];
//    NSLog(@"删除成功dic%@！！！！！！！！！！",completeDic);
//    self.dataArray = [NSMutableArray arrayWithArray:[completeDic objectForKey:@"result"]];
//    [self.listTableView reloadData];
//    [self updateTotoaPrice];
//}



- (void)transforSelectResult:(NSInteger)itemId select:(BOOL)select
{
    if (select) {
        if (self.selectArray.count == 0) {
            //从无数据到有
            [self changeShowStateWithHaveSelect:YES];
        }
        [self.selectArray addObject:[NSString stringWithFormat:@"%d",itemId]];
    }
    else {
        [self.selectArray removeObject:[NSString stringWithFormat:@"%d",itemId]];
        if (self.selectArray.count == 0) {
            //从有到无
            [self changeShowStateWithHaveSelect:NO];
        }
    }
    [self updateTotoaPrice];
    
}


- (void)DelFromCartSuccess:(ASIHTTPRequest *)request
{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //删除成功
                            [_dataArray removeObjectAtIndex:delIndex];
                [self.listTableView deleteSections:[NSIndexSet indexSetWithIndex:delIndex] withRowAnimation:UITableViewRowAnimationFade];
                if (_dataArray.count == 0) {
                    self.bottomView.hidden = YES;
                }
                        break;
        case 6002:
            //添加成功
            msg = @"参数错误";
            break;
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


- (void)MutableDelFromCartSuccess:(ASIHTTPRequest *)request
{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //删除成功
                [_dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
                [self.listTableView deleteSections:indicesOfItemsToDelete withRowAnimation:UITableViewRowAnimationFade];
                if (_dataArray.count == 0) {
                    self.bottomView.hidden = YES;
                }
            
            break;
        case 6002:
            //添加成功
            msg = @"参数错误";
            break;
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}




- (void)DelFromCartFail:(ASIHTTPRequest *)request
{
    [super hideGif];
    
}


- (void)updateTotoaPrice
{
    float totalP = 0.0;
    //重新计算金额
    //    for (NSString *itemId in self.selectArray)
    for(NSDictionary *productDic in self.dataArray) {
        //        NSDictionary *productDic = [self.dataArray objectAtIndex:itemId.integerValue];
        NSInteger num = [[productDic objectForKey:@"quantity"] integerValue];
        float price = [[productDic objectForKey:@"price"] floatValue];
        totalP +=price*num;
    }
    self.totoaPricelabel.text = [NSString stringWithFormat:@"合计：%.2f",totalP];
}

- (void)changeShowStateWithHaveSelect:(BOOL)have
{
    return;
    if (have) {
        self.totoaPricelabel.textColor = COLOR(255, 66, 110);
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
        self.payButton.enabled = YES;
        //右上角图标变图为可用  delete
    }
    else {
        self.totoaPricelabel.textColor = COLOR(178 , 178, 178);
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"buy_disable"] forState:UIControlStateNormal];
        self.payButton.enabled = NO;
        //右上角图标变图为不可用    delete_alpha
    }
}

- (void)transforEditTap:(NSInteger)itemId
{
    editIndex = itemId;
    NSDictionary *dic = [self.dataArray objectAtIndex:itemId];
    [super showGif];
    [commonModel requestgetOption:@{@"product_id":[dic objectForKey:@"product_id"]} httpRequestSucceed:@selector(requestgetOptionSuccess:) httpRequestFailed:@selector(requestFailed:)];
    
}

- (void)transforEditResult:(NSDictionary *)dic
{
    [self fetchData];
}

//获取已选商品详情，开始展示
- (void)requestgetOptionSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    if ([[completeDic objectForKey:@"code"] integerValue] == 200) {
        NSMutableDictionary *productDic = [NSMutableDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:editIndex]];
        NSArray *specification = [[completeDic objectForKey:@"result"] objectForKey:@"specification"];
        if (specification) {
            //            NSLog(@"商品详细属性%@！！！！",specification);
            [productDic setObject:specification forKey:@"specification"];
        }
        NSString *price = [[completeDic objectForKey:@"result"] objectForKey:@"price"];
        if (price) {
            [productDic setObject:price forKey:@"price"];
        }
        
        //展示的弹出框
        SKUViewController *skuController = [[SKUViewController alloc] init];
        skuController.type = ModifyCart;
        skuController.delegate = self;
        skuController.productDic = productDic;
        skuController.view.frame = self.navigationController.view.bounds;
        [self.navigationController.view addSubview:skuController.view];
        
    }
}

@end
