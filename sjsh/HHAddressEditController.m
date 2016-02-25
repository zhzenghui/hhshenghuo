//
//  HHAddressEditController.m
//  sjsh
//
//  Created by savvy on 16/2/23.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHAddressEditController.h"
#import "PublicClassMethod.h"
#import "EditAddressCell.h"

@interface HHAddressEditController (){
    
    UITextField *currentTextField;
    
}

@property(nonatomic,strong)UIScrollView *pageScroll;  //页面滚动视图

//公共区域
@property(nonatomic,strong)UIView *consigneeView;  //收货人区域
@property(nonatomic,strong)UIView *phoneView;  //手机号码区域
@property(nonatomic,strong)UIView *addressView;  //地址区域
@property(nonatomic,strong)UIView *defaultView;  //设为默认区域
//@property(nonatomic,strong)UIView *promptView;  //提示区域
@property(nonatomic,strong)UIButton *submitButton;  //提交按钮
@property(nonatomic,strong)UILabel *defaultTitle;  //设为默认区域
@property(nonatomic,strong)UIImageView *defaultImageView;  //设为默认区域
@property(nonatomic,strong)UILabel *promptContent;  //提示内容

//切换按钮
@property (nonatomic, strong)  UIView *changeView;    //视图切换区域
@property (nonatomic, strong)  UIView *changeLineView;    //底部分割线
@property (nonatomic, strong)  UIButton *selectButton;    //选择按钮
@property (nonatomic, strong)  UIView *selectFlagView;
@property (nonatomic, strong)  UIButton *writeButton;    //填写按钮
@property (nonatomic, strong)  UIView *writeFlagView;


@property(nonatomic,strong)UILabel *consigneeTitleLabel;  //收货人区域
@property(nonatomic,strong)UITextField *consigneeContentText;  //收货人区域
@property(nonatomic,strong)UILabel *phoneTitleLabel;  //手机号码区域
@property(nonatomic,strong)UITextField *phoneContentText;  //手机号码区域
@property(nonatomic,strong)UILabel *addressTitleLabel;  //地址区域
@property(nonatomic,strong)UITextField *addressContentText;  //地址区域




@property(nonatomic ,assign)float rowHeight;//每行的全局高度
@property(nonatomic ,assign)float locationHeight;//所选的地址的高度
@property(nonatomic ,assign)BOOL idDefault;//是否默认


@property(nonatomic,strong) NSDictionary *allMap;
@property(nonatomic ,assign) NSString *bottomDynamicLayoutString;//底部区域的垂直布局
@property(nonatomic,strong)  NSArray *bottomDynamicArray;

@property(nonatomic,strong) NSDictionary *selectMap;//选择区域控件
@property(nonatomic ,assign) NSString *selectContentStirng;//选择内容区域的垂直布局
@property(nonatomic,strong)  NSArray *selectContentArray;

@property(nonatomic ,assign)BOOL isFirst;//第一次进入


@property (nonatomic, strong) NSString * stringList01;
@property (nonatomic, strong) NSString * stringList02;
@property (nonatomic, strong) NSString * stringList03;
@property (nonatomic, strong) NSString * stringList04;


@end

@implementation HHAddressEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"我的地址"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;
    
    self.stringList01 = @"{\"code\":200,\"status\":\"OK\",\"msg\":[\"\u4e00\u533a\",\"\u4e09\u533a\",\"\u56db\u533a\",\"\u4e94\u533a\",\"\u516d\u533a\",\"\u6625\u836b\u56ed\",\"\u5782\u8679\u56ed\",\"\u7fe0\u53e0\u56ed\",\"\u65f6\u96e8\u56ed\",\"\u89c2\u5c71\u56ed\",\"\u6674\u96ea\u56ed\",\"\u6674\u6ce2\u56ed\"]}";
    
    self.stringList02 = @"{\"code\":200,\"status\":\"OK\",\"msg\":[\"1\u53f7\u697c\",\"2\u53f7\u697c\",\"3\u53f7\u697c\",\"4\u53f7\u697c\",\"5\u53f7\u697c\",\"6\u53f7\u697c\",\"7\u53f7\u697c\",\"8\u53f7\u697c\",\"9\u53f7\u697c\"]}";
    
    self.stringList03 = @"{\"code\":200,\"status\":\"OK\",\"msg\":[\"1\u5355\u5143\",\"2\u5355\u5143\",\"3\u5355\u5143\",\"4\u5355\u5143\",\"5\u5355\u5143\",\"6\u5355\u5143\"]}";
    
    self.stringList04 = @"{\"code\":200,\"status\":\"OK\",\"msg\":[]}";
    
    
    self.idDefault = NO;
    self.rowHeight = 60.0;//设置每行高度
    self.locationHeight = 0.0;//展开后的地址高度
    self.isFirst = YES;
    
    NSLog(@"收货地址信息为%@!!!!",self.dataDictionary);
    
    
    //页面滚动视图
    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.pageScroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 600);
    self.pageScroll.showsHorizontalScrollIndicator=NO;
    self.pageScroll.showsVerticalScrollIndicator=NO;
    self.pageScroll.backgroundColor = dilutedGrayColor;
    [self.view addSubview:self.pageScroll];
    
    self.consigneeView = [[UIView alloc] init];
    self.consigneeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.consigneeView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.consigneeView];
    
    self.phoneView = [[UIView alloc] init];
    self.phoneView.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.phoneView];
    CALayer *phoneViewTopBorder=[[CALayer alloc]init];
    phoneViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    phoneViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.phoneView.layer addSublayer:phoneViewTopBorder];
    
    
    self.addressView = [[UIView alloc] init];
    self.addressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.addressView];
    CALayer *addressViewTopBorder=[[CALayer alloc]init];
    addressViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    addressViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.addressView.layer addSublayer:addressViewTopBorder];
    
//    self.changeView = [[UIView alloc] init];
//    self.changeView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.changeView.backgroundColor = [UIColor whiteColor];
//    [self.pageScroll addSubview:self.changeView];
    
//    self.selectView = [[UIView alloc] init];
//    self.selectView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.selectView.backgroundColor = [UIColor clearColor];
//    [self.pageScroll addSubview:self.selectView];
    
    
    
    
   
    
    //默认地址
    self.defaultView = [[UIView alloc] init];
    self.defaultView.translatesAutoresizingMaskIntoConstraints = NO;
    self.defaultView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.defaultView];
    CALayer *defaultViewTopBorder=[[CALayer alloc]init];
    defaultViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    defaultViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.defaultView.layer addSublayer:defaultViewTopBorder];
    CALayer *defaultViewBottomBorder=[[CALayer alloc]init];
    defaultViewBottomBorder.frame=CGRectMake(0, self.rowHeight-0.5, ScreenWidth, 0.5);
    defaultViewBottomBorder.backgroundColor=kGrayColor.CGColor;
    [self.defaultView.layer addSublayer:defaultViewBottomBorder];
    UITapGestureRecognizer *defaultTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateDefault:)];
    [self.defaultView addGestureRecognizer:defaultTapGesture];
    
//    self.promptView = [[UIView alloc] init];
//    self.promptView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.pageScroll addSubview:self.promptView];
    
    
    self.submitButton = [[UIButton alloc] init];
    self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.submitButton setTitle:@"保存" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = kRedColor;
    [self.submitButton addTarget:self action:@selector(submitAddressInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    
    
    //各个UIView的子视图************************************************************
    self.consigneeTitleLabel = [[UILabel alloc] init];
    self.consigneeTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.consigneeTitleLabel.text = @"收货人：";
    self.consigneeTitleLabel.font = [UIFont systemFontOfSize:14];
    self.consigneeTitleLabel.textColor = fontDilutedGrayColor;
    [self.consigneeView addSubview:self.consigneeTitleLabel];
    
    self.consigneeContentText = [[UITextField alloc] init];
    self.consigneeContentText.translatesAutoresizingMaskIntoConstraints = NO;
    self.consigneeContentText.delegate = self;
    [self.consigneeContentText setPlaceholder:@"请输入姓名"];
    self.consigneeContentText.font = [UIFont systemFontOfSize:14];
    [self.consigneeContentText setBorderStyle:UITextBorderStyleNone];
    [self.consigneeView addSubview:self.consigneeContentText];
    
    self.phoneTitleLabel = [[UILabel alloc] init];
    self.phoneTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneTitleLabel.text = @"手机号码：";
    self.phoneTitleLabel.font = [UIFont systemFontOfSize:14];
    self.phoneTitleLabel.textColor = fontDilutedGrayColor;
    [self.phoneView addSubview:self.phoneTitleLabel];
    
    self.phoneContentText = [[UITextField alloc] init];
    self.phoneContentText.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneContentText.delegate = self;
    self.phoneContentText.font = [UIFont systemFontOfSize:14];
    self.phoneContentText.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneContentText setPlaceholder:@"请输入手机号"];
    [self.phoneContentText setBorderStyle:UITextBorderStyleNone];
    [self.phoneView addSubview:self.phoneContentText];
    
    
    self.addressTitleLabel = [[UILabel alloc] init];
    self.addressTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressTitleLabel.text = @"地址：";
    self.addressTitleLabel.font = [UIFont systemFontOfSize:14];
    self.addressTitleLabel.textColor = fontDilutedGrayColor;
    [self.addressView addSubview:self.addressTitleLabel];
    
    self.addressContentText = [[UITextField alloc] init];
    self.addressContentText.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressContentText.delegate = self;
    self.addressContentText.font = [UIFont systemFontOfSize:14];
//    self.addressContentText.keyboardType = UIKeyboardTypeNumberPad;
    [self.addressContentText setPlaceholder:@"请输入地址"];
    [self.addressContentText setBorderStyle:UITextBorderStyleNone];
    [self.addressView addSubview:self.addressContentText];

    
    
    //默认地址
    self.defaultTitle = [[UILabel alloc] init];
    self.defaultTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.defaultTitle.text = @"设为默认地址";
    self.defaultTitle.font = [UIFont systemFontOfSize:14];
    self.defaultTitle.textColor = fontDilutedGrayColor;
    [self.defaultView addSubview:self.defaultTitle];
    
    self.defaultImageView = [[UIImageView alloc] init];
    self.defaultImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.defaultImageView.image = [UIImage imageNamed:@"icon_order_unselected"];
    self.defaultImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.defaultView addSubview:self.defaultImageView];
    
//    self.promptContent = [[UILabel alloc] init];
//    self.promptContent.translatesAutoresizingMaskIntoConstraints = NO;
//    self.promptContent.text = @"*目前只支持世纪城片区\n 如果您在写字楼或店铺请填写其他地址";
//    self.promptContent.font = [UIFont systemFontOfSize:12];
//    self.promptContent.lineBreakMode = NSLineBreakByWordWrapping;
//    self.promptContent.numberOfLines = 0;//上面两行设置多行显示
//    self.promptContent.textColor = fontDilutedGrayColor;
//    [self.promptView addSubview:self.promptContent];
    
    
    [self initAutoLayout];//初始化自动布局
    [self loadPageData];//给页面添加数据
//    [self loadGardenOptions];//加载地址选项数据
    
}




//添加页面数据
-(void)loadPageData{
    if (self.dataDictionary) {
        self.consigneeContentText.text = [self.dataDictionary objectForKey:@"firstname"];
        self.phoneContentText.text = [self.dataDictionary objectForKey:@"mobile_num"];
//        self.gardenTitleLabel.text = [self.dataDictionary objectForKey:@"xiaoqu"];
//        self.buildingTitleLabel.text = [self.dataDictionary objectForKey:@"louhao"];
//        self.unitTitleLabel.text = [self.dataDictionary objectForKey:@"danyuan"];
//        self.roomTitleLabel.text = [self.dataDictionary objectForKey:@"room_number"];
        self.addressContentText.text = [self.dataDictionary objectForKey:@"address_1"];
        
              //        NSLog(@"是否为默认%ld！！！！",(long)[[self.dataDictionary objectForKey:@"default_id"] integerValue]);
        
        self.idDefault = ([[self.dataDictionary objectForKey:@"default_id"] integerValue]==1);
        if (self.idDefault) {
            //            NSLog(@"是为默认！！！！");
            self.defaultImageView.image = [UIImage imageNamed:@"hh_user_address_select"];
        }else{
            //             NSLog(@"不为默认！！！！");
            self.defaultImageView.image = [UIImage imageNamed:@"icon_order_unselected"];
        }
        
    }else{
        NSLog(@"新增地址！！！！！");
    }
    
    
}

//获取园区接口数据
//-(void)loadGardenOptions{
//    [self showGif];
//    [commonModel getGardenData:nil httpRequestSucceed:@selector(loadGardenOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
//}


//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误！！！！！！");
}

//提交地址信息
-(void)submitAddressInfo{
    
    if(!self.consigneeContentText.text||[self.consigneeContentText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"姓名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if(!self.phoneContentText.text||[self.phoneContentText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"手机号不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        NSMutableDictionary *addressDictionary = [NSMutableDictionary dictionary];
        addressDictionary[@"firstname"] = self.consigneeContentText.text;
        addressDictionary[@"mobile_num"] = self.phoneContentText.text;
//        addressDictionary[@"xiaoqu"] = [self.gardenTitleLabel.text isEqualToString:@"请选择小区"]?@"":self.gardenTitleLabel.text;
//        addressDictionary[@"louhao"] = [self.buildingTitleLabel.text isEqualToString:@"请选择楼号"]?@"":self.buildingTitleLabel.text;
//        addressDictionary[@"danyuan"] = [self.unitTitleLabel.text isEqualToString:@"请选择单元"]?@"":self.unitTitleLabel.text;
//        addressDictionary[@"room_number"] = [self.roomTitleLabel.text isEqualToString:@"请选择房间"]?@"":self.roomTitleLabel.text;
        addressDictionary[@"address_1"] = self.addressContentText.text;
        addressDictionary[@"default"] = self.idDefault?@"1":@"0";
        
        NSLog(@"提交地址信息参数为：%@",addressDictionary);
        
        if(self.dataDictionary){
            //修改
            [addressDictionary setObject:[self.dataDictionary objectForKey:@"address_id"] forKey:@"address_id"];
            [commonModel requestupdateaddress:addressDictionary httpRequestSucceed:@selector(requestSubmitAddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }else{
            //添加
            [commonModel requestaddaddress:addressDictionary httpRequestSucceed:@selector(requestSubmitAddressSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }
    }
    
}
//提交地址信息成功
- (void)requestSubmitAddressSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"提交地址信息成功dic%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:self title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
    }
}


#pragma mark 自动布局区域
//初始化自动布局
-(void) initAutoLayout{
    
    //整体布局
    self.allMap = @{
                    @"pageScroll" : self.pageScroll,
                    @"submitButton" : self.submitButton,
                    @"consigneeView" : self.consigneeView,
                    @"phoneView" : self.phoneView,
                    @"addressView" : self.addressView,
                   
                    @"defaultView" : self.defaultView
                    };
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"H:|-0-[pageScroll]-0-|"
                               options:0
                               metrics:nil
                               views:self.allMap]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"H:|-0-[submitButton]-0-|"
                               options:0
                               metrics:nil
                               views:self.allMap]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"V:|-0-[pageScroll]-0-[submitButton(==50)]-0-|"
                               options:0
                               metrics:nil
                               views:self.allMap]];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     [NSString stringWithFormat:@"V:|-0-[consigneeView(==%f)]-0-[phoneView(==%f)]-0-[addressView(==%f)]",self.rowHeight,self.rowHeight,self.rowHeight]
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    
    //初始化的选择区域布局
    self.bottomDynamicLayoutString = [NSString stringWithFormat:@"V:|-%f-[defaultView(==%f)]",200.0,self.rowHeight];
    self.bottomDynamicArray = [NSLayoutConstraint
                               constraintsWithVisualFormat:
                               self.bottomDynamicLayoutString
                               options:0
                               metrics:nil
                               views:self.allMap];
    [self.pageScroll addConstraints:self.bottomDynamicArray];
    
    
    
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[consigneeView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[phoneView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[defaultView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    
       [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[addressView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    
    
    
    //收货人
    
    NSDictionary *consigneeInnerMap = @{
                                        @"consigneeTitleLabel" : self.consigneeTitleLabel,
                                        @"consigneeContentText" : self.consigneeContentText                              };
    [self.consigneeView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"H:|-15-[consigneeTitleLabel(==70)]-0-[consigneeContentText]-0-|"
                                        options:0
                                        metrics:nil
                                        views:consigneeInnerMap]];
    [self.consigneeView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"V:|-0-[consigneeTitleLabel]-0-|"
                                        options:0
                                        metrics:nil
                                        views:consigneeInnerMap]];
    [self.consigneeView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:
                                        @"V:|-0-[consigneeContentText]-0-|"
                                        options:0
                                        metrics:nil
                                        views:consigneeInnerMap]];
    NSDictionary *phoneInnerMap = @{
                                    @"phoneTitleLabel" : self.phoneTitleLabel,
                                    @"phoneContentText" : self.phoneContentText                              };
    [self.phoneView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-15-[phoneTitleLabel(==70)]-0-[phoneContentText]-0-|"
                                    options:0
                                    metrics:nil
                                    views:phoneInnerMap]];
    [self.phoneView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[phoneTitleLabel]-0-|"
                                    options:0
                                    metrics:nil
                                    views:phoneInnerMap]];
    [self.phoneView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[phoneContentText]-0-|"
                                    options:0
                                    metrics:nil
                                    views:phoneInnerMap]];
    
  
    
    NSDictionary *addressInnerMap = @{
                                    @"addressTitleLabel" : self.addressTitleLabel,
                                    @"addressContentText" : self.addressContentText                              };
    [self.addressView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-15-[addressTitleLabel(==70)]-0-[addressContentText]-0-|"
                                    options:0
                                    metrics:nil
                                    views:addressInnerMap]];
    [self.addressView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[addressTitleLabel]-0-|"
                                    options:0
                                    metrics:nil
                                    views:addressInnerMap]];
    [self.addressView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[addressContentText]-0-|"
                                    options:0
                                    metrics:nil
                                    views:addressInnerMap]];
    
    
    //设为默认
    NSDictionary *defaultInnerMap = @{
                                      @"defaultTitle" : self.defaultTitle,
                                      @"defaultImageView" : self.defaultImageView};
    [self.defaultView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-15-[defaultTitle(==100)]"
                                      options:0
                                      metrics:nil
                                      views:defaultInnerMap]];
    [self.defaultView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:[defaultImageView(==20)]-10-|"
                                      options:NSLayoutFormatAlignAllLeft
                                      metrics:nil
                                      views:defaultInnerMap]];
    [self.defaultView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:|-0-[defaultTitle]-0-|"
                                      options:0
                                      metrics:nil
                                      views:defaultInnerMap]];
    [self.defaultView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:|-0-[defaultImageView]-0-|"
                                      options:0
                                      metrics:nil
                                      views:defaultInnerMap]];
    
    
    
}




//修改默认地址
-(void)updateDefault:(UITapGestureRecognizer*)recognizer{
    NSLog(@"设置默认点击事件！！！！！");
    if (self.idDefault) {
        self.idDefault = NO;
        self.defaultImageView.image = [UIImage imageNamed:@"icon_order_unselected"];
    }else{
        self.idDefault = YES;
        self.defaultImageView.image = [UIImage imageNamed:@"hh_user_address_select"];
    }
}



-(void)toReturn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [currentTextField resignFirstResponder];
    return YES;
}

@end
