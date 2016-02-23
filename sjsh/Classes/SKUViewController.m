//
//  SKUViewController.m
//  sjsh
//   商品详情，规格选择页面
//  Created by 杜 计生 on 14-9-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "SKUViewController.h"

#import "CLTree.h"

@interface SKUViewController ()
{
    BOOL isBuy;
}
@property(strong,nonatomic) NSMutableArray* dataArray; //保存全部数据的数组
@property(strong,nonatomic) NSArray *displayArray;   //保存要显示在界面上的数据的数组

@end

@implementation SKUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.myTableView.backgroundView = nil;
    self.myTableView.backgroundColor = COLOR(240, 240, 240);
    [self addTestData];//添加演示数据
    [self reloadDataForDisplayArray];//初始化将要显示的数据
    switch (self.type) {
        case AddToCart:
        {
            [self.buyButton setTitle:@"立即加入" forState:UIControlStateNormal];
            [self.buyButton setTitle:@"立即加入" forState:UIControlStateHighlighted];
        }
            break;
        case onceBuy:
        {
            
        }
            break;
        case ModifyCart:
        {
//            self.addCartButton.hidden = YES;
            [self.buyButton setTitle:@"确定" forState:UIControlStateNormal];
            [self.buyButton setTitle:@"确定" forState:UIControlStateHighlighted];
        }
            break;
        default:
            break;
    }
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

//添加商品详细数据
-(void) addTestData{
    self.dataArray = [NSMutableArray array];
    NSArray *specification = [self.productDic objectForKey:@"specification"];
    int count = 0;
    BOOL firstSelect = NO;
     int totalCount = 0;
    
    NSLog(@"商品不同规格%lu!!!!",(unsigned long)specification.count);
    
    for (NSDictionary *skuDic in specification) {
        NSString *name = [skuDic objectForKey:@"name"];
        NSString *option_id = [skuDic objectForKey:@"option_id"];
        NSArray *option_value = [skuDic objectForKey:@"option_value"];
        NSString *product_option_id = [skuDic objectForKey:@"product_option_id"];
        NSString *type = [skuDic objectForKey:@"type"];
        CLTreeViewNode *node3 = [[CLTreeViewNode alloc]init];
        node3.nodeLevel = 0;//根层cell
        node3.type = 0;//type 1的cell
        node3.sonNodes = [NSMutableArray array];
        if (count == 0) {
            node3.isExpanded = YES;
        }
        else
            node3.isExpanded = NO;//关闭状态
        node3.ismutiple = [type isEqualToString:@"radio"]?NO:YES;
        CLTreeView_LEVEL0_Model *tmp3 =[[CLTreeView_LEVEL0_Model alloc]init];
        tmp3.name = name;
        tmp3.result = @"";
        tmp3.option_id = option_id;
        tmp3.option_value = option_value;
        tmp3.product_option_id = product_option_id;
        node3.nodeData = tmp3;

        for (NSDictionary *sonDic in option_value) {
            NSString *name = [sonDic objectForKey:@"name"];
            NSString *option_value_id = [sonDic objectForKey:@"option_value_id"];
            NSString *product_option_value_id = [sonDic objectForKey:@"product_option_value_id"];
            NSString *price_prefix = [sonDic objectForKey:@"prefixprice"];
            NSString *price = [[_productDic objectForKey:@"product"] objectForKey:@"special"];
            if (self.type == ModifyCart) {
                price = [_productDic objectForKey:@"price"];
            }
            NSString *symbol = [sonDic objectForKey:@"price_prefix"];
            float realPrice = [price floatValue];
            if ([symbol isEqualToString:@"+"]) {
                realPrice +=[price_prefix floatValue];
            }
            else {
                realPrice -=[price_prefix floatValue];
            }
            CLTreeViewNode *node5 = [[CLTreeViewNode alloc]init];
            node5.nodeLevel = 1;//第一层节点
            node5.type = 1;//type 2的cell
            node5.sonNodes = nil;
            node5.isExpanded = FALSE;
            
            CLTreeView_LEVEL1_Model *tmp5 =[[CLTreeView_LEVEL1_Model alloc]init];
            tmp5.name = name;
            tmp5.price = realPrice;
            tmp5.option_value_id = option_value_id;
            tmp5.product_option_value_id = product_option_value_id;
            tmp5.price_prefix = price_prefix;
            if (count == 0 && !firstSelect) {
                tmp5.select = YES;
                firstSelect = YES;
            }
            node5.nodeData = tmp5;
            [node3.sonNodes addObject:node5];
            totalCount++;
        }
        [self.dataArray addObject:node3];
        count ++;
    }
    
     NSLog(@"总行数为%lu!!!!",(unsigned long)totalCount);
    if(totalCount>0){
        totalCount++;//加入标题
    }
    
    //修改弹出框中列表的大小和位置
     if(totalCount<5){
    CGRect myMake = CGRectMake(self.myTableView.frame.origin.x, self.myTableView.frame.origin.y+(5-totalCount)*50, self.myTableView.frame.size.width, totalCount*50);
     self.myTableView.frame = myMake;
   
             CGRect myContentMake = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y+(5-totalCount)*50, self.contentView.frame.size.width, self.contentView.frame.size.height-(5-totalCount)*50);
             self.contentView.frame = myContentMake;
         
             CGRect waveImageMake = CGRectMake(self.waveImage.frame.origin.x, self.waveImage.frame.origin.y+(5-totalCount)*50, self.waveImage.frame.size.width, self.waveImage.frame.size.height);
             self.waveImage.frame = waveImageMake;
     }
  
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"level0cell";
    static NSString *indentifier1 = @"level1cell";
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    
    if(node.type == 0){//类型为0的cell
        CLTreeView_LEVEL0_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level0_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];//重新给cell装载数据
        [cell setNeedsDisplay]; //重新描绘cell
        if(cell.node.isExpanded ){
//            [self rotateArrow:cell with:M_PI_2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(node.type == 1){//类型为1的cell
        CLTreeView_LEVEL1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier1];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level1_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        return nil;
    }
}

/*---------------------------------------
 为不同类型cell填充数据
 --------------------------------------- */
-(void) loadDataForTreeViewCell:(UITableViewCell*)cell with:(CLTreeViewNode*)node{
    if(node.type == 0){
        CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL0_Cell*)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL0_Cell*)cell).result.text = nodeData.result;
        //        if(nodeData.headImgPath != nil){
        //            //本地图片
        //            [((CLTreeView_LEVEL0_Cell*)cell).imageView setImage:[UIImage imageNamed:nodeData.headImgPath]];
        //        }
        //        else if (nodeData.headImgUrl != nil){
        //            //加载图片，这里是同步操作。建议使用SDWebImage异步加载图片
        //            [((CLTreeView_LEVEL0_Cell*)cell).imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]]];
        //        }
    }
    
    else if(node.type == 1){
        CLTreeView_LEVEL1_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL1_Cell*)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL1_Cell*)cell).price.text = [NSString stringWithFormat:@"￥%.2f",nodeData.price];
        if (nodeData.select) {
            ((CLTreeView_LEVEL1_Cell*)cell).SelectView.hidden = NO;
        }
        else {
            ((CLTreeView_LEVEL1_Cell*)cell).SelectView.hidden = YES;
        }
    }
    
}

/*---------------------------------------
 cell高度默认为50
 --------------------------------------- */
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}

/*---------------------------------------
 处理cell选中事件，需要自定义的部分
 --------------------------------------- */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];//修改cell的状态(关闭或打开)包括子项
    if(node.type == 1){
        //处理叶子节点选中，此处需要自定义
        
        if (node.ismutiple) {
            //        多选
            CLTreeView_LEVEL1_Model *nodeData = node.nodeData;
            nodeData.select = !(nodeData.select);
        }
        else {
            //        单选
            for (CLTreeViewNode *tmpnode in _dataArray) {
                if ([tmpnode.sonNodes indexOfObject:node] != NSNotFound) {
                    for (CLTreeViewNode *sonnode in tmpnode.sonNodes) {
                        CLTreeView_LEVEL1_Model *nodeData = sonnode.nodeData;
                        if (sonnode == node) {
                            nodeData.select = !(nodeData.select);
                        }
                        else {
                            nodeData.select = NO;
                        }
                        
                    }
                }
            }
        }
        
        
    }
    else{
        CLTreeView_LEVEL0_Cell *cell = (CLTreeView_LEVEL0_Cell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.node.isExpanded ){
//            [self rotateArrow:cell with:M_PI_2];
        }
        else{
//            [self rotateArrow:cell with:0];
        }
    }
}

/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(CLTreeView_LEVEL0_Cell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.arrowView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

/*---------------------------------------
 初始化将要显示的cell的数据
 --------------------------------------- */
-(void) reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}

/*---------------------------------------
 修改cell的状态(关闭或打开) 包括总项展开和子项选择
 --------------------------------------- */
-(void) reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt=0;
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(cnt == row){
//            node.isExpanded = !node.isExpanded;//点击总项，修改子项是否显示
        }
        ++cnt;
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(cnt == row){
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}


- (IBAction)changeNum:(UIButton *)sender {
    int num = self.numlabel.text.intValue;
    if (sender.tag == 0) {
        self.numlabel.text = [NSString stringWithFormat:@"%d",num>1?num-1:1];
    }
    else {
        self.numlabel.text = [NSString stringWithFormat:@"%d",num+1];
    }
}

- (IBAction)tapToDismissed:(id)sender {
    if (self.view.superview) {
        [self.view removeFromSuperview];
    }
}

- (IBAction)addtoCar:(UIButton *)sender {
    NSDictionary *product = [self.productDic objectForKey:@"product"];
    NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
    [addDic setObject:[product objectForKey:@"product_id"] forKey:@"product_id"];
    for (CLTreeViewNode *node in _dataArray) {
        NSMutableArray *arr = [NSMutableArray array];
        for(CLTreeViewNode *node2 in node.sonNodes){
            CLTreeView_LEVEL1_Model *nodeData = node2.nodeData;
            if (nodeData.select) {
                [arr addObject:nodeData.product_option_value_id];
            }
        }
        if ([arr count]>0) {
            CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
            [addDic setObject:[arr objectAtIndex:0] forKey:[NSString stringWithFormat:@"option[%@]",nodeData.product_option_id]];
        }
    }
    NSString *num = @"1";
    if (self.numlabel) {
        num = self.numlabel.text;
    }
    [addDic setObject:[NSNumber numberWithInt:[num integerValue]] forKey:@"quantity"];
    [commonModel requestAddtoCart:addDic httpRequestSucceed:@selector(AddtoCartSuccess:) httpRequestFailed:@selector(AddtoCartFail:)];
    [super showGif];
}

- (IBAction)goToPay:(UIButton *)sender {
    switch (self.type) {
        case AddToCart:
        {
            [self addtoCar:nil];
            isBuy = NO;
        }
            break;
        case onceBuy:
        {
            [self addtoCar:nil];
            isBuy = YES;

        }
            break;
        case ModifyCart:
        {
            [super showGif];
            NSDictionary *product = self.productDic;
            NSMutableDictionary *addDic = [NSMutableDictionary dictionary];
            [addDic setObject:[product objectForKey:@"product_id"] forKey:@"product_id"];
            [addDic setObject:[product objectForKey:@"key"] forKey:@"key"];
            [addDic setObject:[product objectForKey:@"manufacturer_id"] forKey:@"manufacturer_id"];
            for (CLTreeViewNode *node in _dataArray) {
                NSMutableArray *arr = [NSMutableArray array];
                for(CLTreeViewNode *node2 in node.sonNodes){
                    CLTreeView_LEVEL1_Model *nodeData = node2.nodeData;
                    if (nodeData.select) {
                        [arr addObject:nodeData.product_option_value_id];
                    }
                }
                if ([arr count]>0) {
                    CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
                    [addDic setObject:[arr objectAtIndex:0] forKey:[NSString stringWithFormat:@"option[%@]",nodeData.product_option_id]];
                }
            }
            NSString *num = @"1";
            if (self.numlabel) {
                num = self.numlabel.text;
            }
            [addDic setObject:[NSNumber numberWithInt:[num integerValue]] forKey:@"quantity"];
            [commonModel requestupdatecart:addDic httpRequestSucceed:@selector(requestupdatecartSuccess:) httpRequestFailed:@selector(requestupdatecartFail:)];
        }
            break;
        default:
            break;
    }
}

- (void)AddtoCartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [self tapToDismissed:nil];
            if (isBuy) {
                //进入下单页
                if(self.delegate && [self.delegate respondsToSelector:@selector(enterNetPageForOrder)]){
                    [self.delegate enterNetPageForOrder];
                }
                
            }
            else {
                if(self.delegate && [self.delegate respondsToSelector:@selector(refreashCartNum)]){
                    [self.delegate refreashCartNum];
                }
                msg = @"已成功添加到购物车";
            }
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
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
    }
    
}

- (void)AddtoCartFail:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

- (void)requestupdatecartSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
    NSLog(@"dic%@",completeDic);
    NSString *code = [completeDic objectForKey:@"code"];
    NSString *msg = nil;
    switch ([code integerValue]) {
        case 200:
            //添加成功
            [self tapToDismissed:nil];
            if (self.delegate && [self.delegate respondsToSelector:@selector(transforEditResult:)]) {
                [self.delegate transforEditResult:nil];
            }
            msg = @"修改成功";
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if (gestureRecognizer.view == self.reviewView) {
//        return YES;
//    }
    CGPoint point = [touch locationInView:self.view];
    if (point.y<self.view.frame.size.height-415) {
        return YES;
    }
    else {
        return NO;
    }
}
 
@end
