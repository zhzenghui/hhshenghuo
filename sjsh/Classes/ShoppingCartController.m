//
//  ShoppingCartController.m
//  sjsh
//  购物车
//  Created by savvy on 15/12/10.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "ShoppingCartController.h"
#import "HHAddOrderViewController.h"
#import "LoginViewController.h"

@interface ShoppingCartController ()

@property (nonatomic, strong)   UIView *blankView;//列表的内容数组

@property (nonatomic, strong)   UIView *bottomView;//底部视图
@property (nonatomic, strong)   UIButton *allSelectButton;//全选按钮
@property (nonatomic, strong)   UILabel *allSelectLabel;//全选标题
@property (nonatomic, strong)   UILabel *sumPriceLabel;//总价
@property (nonatomic, strong)   UIButton *buyButton;//全选按钮

@property(nonatomic, strong) UITableView *cartTableView;//地址列表
@property (nonatomic, strong)  NSMutableArray *cartArray;//列表的内容数组

@property (nonatomic, assign) BOOL isEdit;//是否为编辑模式

@property (nonatomic, strong) NSString *stringList;

@property (nonatomic, assign) float sumVaule ;

@property(nonatomic, assign) NSInteger position;  //正在修改的cell位置
@property(nonatomic, assign) NSInteger positionNumber;  //正在修改的cell位置的商品的数量
@end

@implementation ShoppingCartController

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
    
    [super initNavBarItems:@"购物车"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super addRightTitle:@"编辑" selector:@selector(updateBottomView)];
    
    self.isEdit = NO;
    self.sumVaule = 0.0;
    
    
    self.stringList = @"{\"code\":200,\"status\":\"OK\",\"result\":[{\"key\":3477,\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/data\/xianguoyuan\/140813103513-800-47x47.jpg\",\"product_id\":\"3477\",\"name\":\"\u793e\u533ae\u7ad9 \u4e1d\u74dc 500g\",\"meta_description\":\"\u679c\u852c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"option\":[],\"quantity\":1,\"price\":7.6,\"total\":7.6,\"manufacturer_name\":\"\u793e\u533ae\u7ad9\",\"manufacturer_id\":\"1932\"},{\"key\":6830,\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150921\/144280516635712-47x47.jpg\",\"product_id\":\"6830\",\"name\":\"\u793e\u533ae\u7ad9 \u5357\u679c\u68a8 500g\",\"meta_description\":\"\u679c\u852c\u7c7b\u4ef7\u683c\u6839\u636e\u4ea7\u54c1\u65f6\u4ee4\u8c03\u6574\uff0c\u6b64\u4ea7\u54c1\u4ee5\u6536\u5230\u7684\u5b9e\u9645\u91cd\u91cf\u8ba1\u7b97\u4ef7\u683c\u3002\",\"option\":[],\"quantity\":1,\"price\":4.8,\"total\":4.8,\"manufacturer_name\":\"\u793e\u533ae\u7ad9\",\"manufacturer_id\":\"1932\"},{\"key\":5072,\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20150821\/1440123327910590-47x47.jpg\",\"product_id\":\"5072\",\"name\":\"\u575d\u6e90 \u751f\u6001 \u6563\u517b\u9ed1\u7fbd\u9e21\u571f\u9e21\u86cb1\u76d2\uff0820\u679a\uff09\",\"meta_description\":\"\u6b63\u5b97\u571f\u9e21\u86cb\uff0c\u8425\u517b\u4ef7\u503c\u4e30\u5bcc\",\"option\":[],\"quantity\":1,\"price\":42,\"total\":42,\"manufacturer_name\":\"\u575d\u6e90\",\"manufacturer_id\":\"1935\"},{\"key\":\"6848:YToxOntpOjEyMTY7czo0OiIyMTM2Ijt9\",\"thumb\":\"http:\/\/www.sjsh8.cn\/image\/cache\/cache\/data\/20151013\/1444723326441545-47x47.jpg\",\"product_id\":\"6848\",\"name\":\"\u793e\u533ae\u7ad9 \u4e94\u5e38\u957f\u7c92\u9999\u5927\u7c73\",\"meta_description\":\"\u65b0\u7c73\u5b63--\u65b0\u7c73\u9a7e\u5230\uff0c\u5bb6\u4e2d\u5fc5\u5907\uff01\u8425\u517b\u4e30\u5bcc\uff0c\u9187\u9999\u53ef\u53e3\",\"option\":[{\"product_option_id\":1216,\"product_option_value_id\":\"2136\",\"name\":\"e\u7ad9\u7c73\",\"value\":\"5kg\"}],\"quantity\":1,\"price\":33,\"total\":33,\"manufacturer_name\":\"\u793e\u533ae\u7ad9\",\"manufacturer_id\":\"1932\"}]}";
    
    
    self.blankView = [[UIView alloc] initWithFrame:CGRectMake((MRScreenWidth-180)/2, 135, 180, 180)];
    self.blankView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.blankView];
    
    UIImageView *tuxingImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 120, 115)];
    tuxingImgV.image = [UIImage imageNamed:@"tuxing"];
    [self.blankView addSubview:tuxingImgV];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 136, 140, 20)];
    label.text = @"您还未添加商品，再去";
    label.textColor = COLOR(180, 180, 180);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.blankView addSubview:label];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(137, 136, 60, 20);
    //    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"逛逛吧" forState:UIControlStateNormal];
    [button1 setTitle:@"逛逛吧" forState:UIControlStateHighlighted];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    [self.blankView addSubview:button1];
    
    
    self.cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-70)];
    self.cartTableView.delegate = self;
    self.cartTableView.dataSource = self;
    //    self.addressTableView.showsVerticalScrollIndicator =
    //    NO;
    self.cartTableView.allowsMultipleSelectionDuringEditing = YES;
    self.cartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cartTableView.backgroundColor = dilutedGrayColor;
    self.cartTableView.editing = YES;
    self.cartTableView.tintColor = kRedColor;
    [self.view addSubview:self.cartTableView];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-70-64, ScreenWidth, 70)];
    self.bottomView.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.bottomView];
    CALayer *topBorder=[[CALayer alloc]init];
    topBorder.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, 0.5);
    topBorder.backgroundColor=lineGrayColor.CGColor;
    [self.bottomView.layer addSublayer:topBorder ];
    
    self.allSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
    self.allSelectButton.tag = 198831;
    [self.allSelectButton setImage:[UIImage imageNamed:@"ico_unselect_unedit"] forState:UIControlStateNormal];
    [self.allSelectButton addTarget:self action:@selector(allSelectOrUnselect:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.allSelectButton];
    
    self.allSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.allSelectButton.frame.origin.x+self.allSelectButton.frame.size.width-5, 10, 40, 50)];
    self.allSelectLabel.text = @"全选";
    self.allSelectLabel.textColor = fontGrayColor;
    self.allSelectLabel.font = [UIFont systemFontOfSize:12];
    [self.bottomView addSubview:self.allSelectLabel];
    
    self.sumPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.allSelectLabel.frame.origin.x+self.allSelectLabel.frame.size.width , 10, 200, 50)];
    self.sumPriceLabel.text = @"共计 ￥0.00";
    self.sumPriceLabel.textColor = hhRedColor;
    self.sumPriceLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.bottomView addSubview:self.sumPriceLabel];
    
    self.buyButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.32-10, 10, ScreenWidth*0.32, 50)];
    self.buyButton.backgroundColor = kRedColor;
    [self.buyButton setTitle:@"购买" forState:UIControlStateNormal];
    self.buyButton.tag = 198821;
    self.buyButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.buyButton.layer.cornerRadius = 5;
    self.buyButton.layer.masksToBounds = YES;
    [self.buyButton addTarget:self action:@selector(submitInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.buyButton];
    
    
    [self fetchData];//加载购物车数据
    
    //   UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    textView.backgroundColor = kRedColor;
    //    [self.view addSubview:textView];
    
    
}

//调用接口数据
-(void)fetchData{
    [super showGif];
    [commonModel requestShowCar:nil httpRequestSucceed:@selector(cartListSuccess:) httpRequestFailed:@selector(cartListFail:)];
    
}

- (void)cartListSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    //     completeDic = [super parseJsonRequestByTest:self.stringList];
    NSLog(@"购物车列表dic%@！！！！！！！！！！",completeDic);
    
    if([completeDic[@"code"] integerValue]==1100){//跳转到登陆页
        
        //推出本页
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        [navigationArray removeObjectAtIndex: navigationArray.count-1];  // You can pass your index here
        self.navigationController.viewControllers = navigationArray;
        
        //跳转到登陆页
        LoginViewController *myController = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
        
    }else{
        
        self.cartArray = [NSMutableArray arrayWithArray:[completeDic objectForKey:@"result"]];
        if (self.cartArray.count == 0) {
            self.blankView.hidden = YES;
        }
        else {
            self.blankView.hidden = NO;
        }
        [self.cartTableView reloadData];
        
    }
    //    [self updateTotoaPrice];
}

- (void)cartListFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

//更改底部视图样式
-(void)updateBottomView{
    self.isEdit = !self.isEdit;//修改编辑模式
    if(self.isEdit){//是编辑模式，可以删除商品
        [super.rightButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"删除" forState:UIControlStateNormal];
        self.buyButton.backgroundColor = [UIColor whiteColor];
        [self.buyButton setTitleColor:kRedColor forState:UIControlStateNormal];
        self.bottomView.backgroundColor = kRedColor;
        self.buyButton.tag = 198822;
        [self updateAllSelectButtonStyle];
        
    }else{
        [super.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"购买" forState:UIControlStateNormal];
        self.buyButton.backgroundColor = kRedColor;
        [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buyButton.tag = 198821;
        self.bottomView.backgroundColor = dilutedGrayColor;
        [self updateAllSelectButtonStyle];
    }
    
    self.sumPriceLabel.hidden = self.isEdit;
    
    
}

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

//返回购物页
- (void)gotoShop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//购买或删除
- (void)submitInfo:(UIButton *)myButton
{
    NSArray *selectRows = [self.cartTableView indexPathsForSelectedRows];
    NSLog(@"所选的商品为%@!!!!!",selectRows);
    
    if (myButton.tag==198821) {//购买
        
        NSMutableArray *addArray = [[NSMutableArray alloc]init];
        for (int i=0; i<selectRows.count; i++) {
            NSIndexPath *indexPath =   selectRows[i];
            NSDictionary *myDictionary =  self.cartArray[indexPath.row];
            NSMutableDictionary *addDictionary = [[NSMutableDictionary alloc]init];
            [addDictionary setObject:[myDictionary objectForKey:@"product_id"] forKey:@"product_id"];
            [addDictionary setObject:[myDictionary objectForKey:@"quantity"] forKey:@"quantity"];
            //             [addDictionary setObject:[myDictionary objectForKey:@"option"] forKey:@"option"];
            
            
            //规格,暂缺
            NSMutableDictionary *optionDictionary = [[NSMutableDictionary alloc]init];
            if([myDictionary objectForKey:@"option"]&&[[myDictionary objectForKey:@"option"] count]>0){
                NSDictionary *specificationsDictionary =  [myDictionary objectForKey:@"option"][0];
                optionDictionary[[[specificationsDictionary objectForKey:@"product_option_id"] description]] = [specificationsDictionary objectForKey:@"product_option_value_id"];
                
            }
            [addDictionary setObject:optionDictionary forKey:@"option"];
            NSLog(@"所添加的商品为%@!!!!!",addDictionary);
            [addArray addObject:addDictionary];
        }
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:addArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"所添加的商品为%@!!!!!",jsonString);
        
        NSMutableDictionary *parameterDcitionary = [[NSMutableDictionary alloc]init];parameterDcitionary[@"products"] = jsonString;
        
        [commonModel addOrderCartByPost:parameterDcitionary httpRequestSucceed:@selector(addOrderCartByPostSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
    }else{
        NSLog(@"删除商品！！！！");
        [self showGif];
        
        
        
        //        NSMutableString *keys =  [[NSMutableString alloc] init];
        //        NSMutableString *manufacturerIDs =  [[NSMutableString alloc] init];
        
        NSMutableArray *deleteArray = [[NSMutableArray alloc]init];
        
        for (int i=0; i<selectRows.count; i++) {
            NSIndexPath *indexPath =   selectRows[i];
            NSDictionary *myDictionary =  self.cartArray[indexPath.row];
            NSLog(@"待删除商品为%@!!!!!",myDictionary);
            //                [interfaceArray addObject:myDictionary[@"address_id"]];
            
            NSMutableDictionary *deleteDictionary = [[NSMutableDictionary alloc]init];
            [deleteDictionary setObject:[myDictionary objectForKey:@"key"] forKey:@"key"];
            [deleteDictionary setObject:[myDictionary objectForKey:@"manufacturer_id"] forKey:@"manufacturer_id"];
            
            [deleteArray addObject:deleteDictionary];
            
            
            
            
            //                      [@"key"] = [myDictionary objectForKey:@"key"];
            //                      deleteDictionary[@"manufacturer_id"] = [myDictionary objectForKey:@"manufacturer_id"];
            
            //                        [keys appendString:[NSString stringWithFormat:@",%ld",(long)[[myDictionary objectForKey:@"key"] integerValue]]];
            //                        [manufacturerIDs appendString:[NSString stringWithFormat:@",%ld",(long)[[myDictionary objectForKey:@"manufacturer_id"] integerValue]]];
            
        }
        //       NSString  *keyString = [keys substringFromIndex:1];
        //         NSString  *manufacturerIDString = [manufacturerIDs substringFromIndex:1];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:deleteArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"所选的地址为%@!!!!!",jsonString);
        
        [commonModel requestMutableDelFromCart:[NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"products", nil] httpRequestSucceed:@selector(DelFromCartSuccess:) httpRequestFailed:@selector(requestFailed:)];
        
        
        //    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
        //    infoDictionary[@"address_ids"] = interfaceArray;
        //
        //    NSLog(@"接口参数为%@！！！！！",infoDictionary);
        //    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc]init];
        //    infoDictionary[@"address_ids"] = interfaceArray;
        //
        //    NSString *info = [CommonUtil toJSONData:infoDictionary];
        //    NSLog(@"接口参数为%@！！！！！",info);
        
        
    }
}

//批量添加订单商品成功
- (void)addOrderCartByPostSuccess:(ASIHTTPRequest *)request
{
    NSLog(@"批量添加订单商品成功dic%@",request.responseString);
    
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"批量添加订单商品成功：%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    
    if([[completeDic objectForKey:@"code"] integerValue] ==  200){//进入下单页
        HHAddOrderViewController *myViewController = [[HHAddOrderViewController alloc] init];
        myViewController.isFirst = YES;
        myViewController.isAll = NO;
        [self.navigationController pushViewController:myViewController animated:YES];
    }
}


//全选和全不选
-(void)allSelectOrUnselect:(UIButton *)myButton{
    
    
    if (myButton.tag==198831) {//变为全选
        myButton.tag=198832;
        for (int row=0; row<self.cartArray.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.cartTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self updateAllSelectButtonStyle];
        }
    }else{//变为全不选
        myButton.tag=198831;
        for (int row=0; row<self.cartArray.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.cartTableView deselectRowAtIndexPath:indexPath animated:NO];
            [self updateAllSelectButtonStyle];
            
        }
        
    }
    
}

//修改全选按钮状态(0为非全选，1为全选)
-(void)updateAllSelectButtonStyle{
    if (self.allSelectButton.tag == 198832) {
        
        if (self.isEdit) {
            [self.allSelectButton setImage:[UIImage imageNamed:@"ico_select_edit"] forState:UIControlStateNormal];
            self.allSelectLabel.textColor = [UIColor whiteColor];
        }else{
            [self.allSelectButton setImage:[UIImage imageNamed:@"ico_select_unedit"] forState:UIControlStateNormal];
            self.allSelectLabel.textColor = fontGrayColor;
        }
        
    }else{
        
        if (self.isEdit) {
            [self.allSelectButton setImage:[UIImage imageNamed:@"ico_unselect_edit"] forState:UIControlStateNormal];
            self.allSelectLabel.textColor = [UIColor whiteColor];
        }else{
            [self.allSelectButton setImage:[UIImage imageNamed:@"ico_unselect_unedit"] forState:UIControlStateNormal];
            self.allSelectLabel.textColor = fontGrayColor;
        }
        
    }
    
    
    
}



//删除商品成功
- (void)DelFromCartSuccess:(ASIHTTPRequest *)request
{
    NSLog(@"商品删除成功dic%@",request.responseString);
    
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //删除成功
            [self fetchData];//刷新页面
        default:
            msg = [completeDic objectForKey:@"msg"];
            break;
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

//修改总价的显示数值
-(void)updateShowPrice{
    NSArray *selectRows = [self.cartTableView indexPathsForSelectedRows];
    self.sumVaule = 0.0;//重新统计总价
    for (int i=0; i<selectRows.count; i++) {
        NSIndexPath *indexPath =   selectRows[i];
        NSDictionary *myDictionary =  self.cartArray[indexPath.row];
        self.sumVaule +=([myDictionary[@"price"] floatValue]*[myDictionary[@"quantity"] integerValue]);
        
    }
    self.sumPriceLabel.text = [NSString stringWithFormat:@"共计 ￥%.1f",self.sumVaule];
    
}

#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cartArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"ShoppingCartCell";
    
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    if (!cell)
    {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    //取消选中颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    cell.position = indexPath.row;
    [cell setCellInfo:self.cartArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"列表的第%lu行被选择！！！！！！",indexPath.row);
    
    //       [self.cartTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    
    [self updateShowPrice];//修改总价的显示数值
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"列表的第%lu行被取消！！！！！！",indexPath.row);
    
    //       [self.cartTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    
    [self updateShowPrice];//修改总价的显示数值
    
}




////是否允许滑动删除
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//
//}
//
////滑动删除具体方法
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//
//        NSLog(@"开始删除");
//
//        [self showGif];
//        NSDictionary *myDictionary = self.cartArray[indexPath.row];
//        [commonModel requestDelFromCart:[NSDictionary dictionaryWithObjectsAndKeys:[myDictionary objectForKey:@"key"],@"key",myDictionary[@"manufacturer_id"],@"manufacturer_id", nil] httpRequestSucceed:@selector(DelFromCartSuccess:) httpRequestFailed:@selector(requestFailed:)];
//        [self showGif];
//
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}


#pragma mark cell代理方法
//修改商品信息
- (void)getDictionary:(NSDictionary *)currenDictionary {
    NSLog(@"修改商品%@！！！！！",currenDictionary);
    
    [super showGif];
    //    if ([currenDictionary[@"state"] integerValue]==0) {
    //        self.sumVaule -= [currenDictionary[@"price"] floatValue];
    //    }else{
    //     self.sumVaule += [currenDictionary[@"price"] floatValue];
    //    }
    self.position = [currenDictionary[@"position"] integerValue];
    self.positionNumber = [currenDictionary[@"quantity"] integerValue];
    
    
    NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
    [addDic setObject:[currenDictionary objectForKey:@"product_id"] forKey:@"product_id"];
    [addDic setObject:[currenDictionary objectForKey:@"key"] forKey:@"key"];
    [addDic setObject:[currenDictionary objectForKey:@"manufacturer_id"] forKey:@"manufacturer_id"];
    [addDic setObject:[currenDictionary objectForKey:@"quantity"] forKey:@"quantity"];
    [addDic setObject:[currenDictionary objectForKey:@"price"] forKey:@"price"];
    NSArray *optionArray = [currenDictionary objectForKey:@"option"];
    //暂缺！！！！！！
    if (optionArray&&![[currenDictionary objectForKey:@"option"] isEqual:@""]&&optionArray.count>0) {
        //        [addDic setObject:[currenDictionary objectForKey:@"product_option_value_id"] forKey:[NSString stringWithFormat:@"option[%@]",self.commoditySpecificationID ]];
    }
    //            [addDic setObject:[arr objectAtIndex:0] forKey:[NSString stringWithFormat:@"option[%@]",nodeData.product_option_id]];
    
    
    [commonModel requestupdatecart:addDic httpRequestSucceed:@selector(requestupdatecartSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
}

- (void)requestupdatecartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"修改购物车成功：%@;位置：%ld，数量%ld",completeDic,(long)self.position,(long)
          self.positionNumber);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    
    NSMutableDictionary *myDictionary = [self.cartArray[self.position] mutableCopy];
    NSNumber *myNumber = [NSNumber numberWithInteger:self.positionNumber];
    switch ([code integerValue]) {
        case 200:
            //添加成功
            myDictionary[@"quantity"] = myNumber;
            self.cartArray[self.position] = myDictionary;
            NSLog(@"修改购物车成功：%@！！！！！",self.cartArray);
            
            [self updateShowPrice];
            break;
        case 6002:
            //添加成功
            msg = @"参数错误";
            break;
        case 6003:
            //添加成功
            msg = @"请选择规格";
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

- (void)requestupdatecartFail:(ASIHTTPRequest *)request{
    [super hideGif];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
