//
//  AddressEditController.m
//  sjsh
//
//  Created by savvy on 15/11/23.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AddressEditController.h"
#import "AddressOptionsCell.h"

@interface AddressEditController (){
    
    UITextField *currentTextField;
    
}

@property(nonatomic,strong)UIScrollView *pageScroll;  //页面滚动视图

//公共区域
@property(nonatomic,strong)UIView *consigneeView;  //收货人区域
@property(nonatomic,strong)UIView *phoneView;  //手机号码区域
@property(nonatomic,strong)UIView *defaultView;  //设为默认区域
@property(nonatomic,strong)UIView *promptView;  //提示区域
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
@property (nonatomic, strong)  UIView *selectView;//选择区域
@property (nonatomic, strong)  UIView *writeView;//填写区域

//选择区域
@property(nonatomic,strong)UIView *gardenView;  //园区区域
@property(nonatomic,strong)UIView *gardenOptionsView;  //园区选项区域
@property(nonatomic,strong)UIView *buildingView;  //楼号区域
@property(nonatomic,strong)UIView *buildingOptionsView;  //楼号选项区域
@property(nonatomic,strong)UIView *unitView;  //单元区域
@property(nonatomic,strong)UIView *unitOptionsView;  //单元选项区域
@property(nonatomic,strong)UIView *roomView;  //房间区域
@property(nonatomic,strong)UIView *roomOptionsView;  //房间选项区域
@property(nonatomic,strong)UILabel *consigneeTitleLabel;  //收货人区域
@property(nonatomic,strong)UITextField *consigneeContentText;  //收货人区域
@property(nonatomic,strong)UILabel *phoneTitleLabel;  //手机号码区域
@property(nonatomic,strong)UITextField *phoneContentText;  //手机号码区域
@property(nonatomic,strong)UILabel *gardenNameLabel;  //园区区域
@property(nonatomic,strong)UILabel *gardenTitleLabel;  //园区区域
@property(nonatomic,strong)UIImageView *gardenIco;
@property(nonatomic,strong)UILabel *buildingNameLabel;  //楼号区域
@property(nonatomic,strong)UILabel *buildingTitleLabel;  //楼号选项区域
@property(nonatomic,strong)UIImageView *buildingIco;
@property(nonatomic,strong)UILabel *unitNameLabel;  //单元区域
@property(nonatomic,strong)UILabel *unitTitleLabel;  //单元选项区域
@property(nonatomic,strong)UIImageView *unitIco;
@property(nonatomic,strong)UILabel *roomNameLabel;  //房间区域
@property(nonatomic,strong)UILabel *roomTitleLabel;  //房间选项区域
@property(nonatomic,strong)UIImageView *roomIco;

//填写区域
@property(nonatomic,strong)UIView *addressEditView;  //填写地址区域区域
@property(nonatomic,strong)UIView *addressBackageView;  //填写地址区域区域背景
//@property(nonatomic,strong)UILabel *addressNameLabel;  //填写地址区域区域
@property(nonatomic,strong)UITextField *addressContentText;  //填写地址区域区域

//@property(nonatomic,strong)UICollectionView *gardenCollection;
//@property(nonatomic,strong)UICollectionView *buildingCollection;
//@property(nonatomic,strong)UICollectionView *unitCollection;
//@property(nonatomic,strong)UICollectionView *roomCollection;

@property(nonatomic ,assign)float rowHeight;//每行的全局高度
@property(nonatomic ,assign)float locationHeight;//所选的地址的高度
@property(nonatomic ,assign)BOOL idDefault;//是否默认


@property(nonatomic,strong) NSDictionary *allMap;
@property(nonatomic ,assign) NSString *bottomDynamicLayoutString;//底部区域的垂直布局
@property(nonatomic,strong)  NSArray *bottomDynamicArray;

@property(nonatomic,strong) NSDictionary *selectMap;//选择区域控件
@property(nonatomic ,assign) NSString *selectContentStirng;//选择内容区域的垂直布局
@property(nonatomic,strong)  NSArray *selectContentArray;

@property(nonatomic,strong)   NSLayoutConstraint *selectViewHeightContraint;//选择区域的高度布局

@property(nonatomic,strong)NSString *gardenSelect;  //所选园区
@property(nonatomic,strong)NSString *buildingSelect;  //所选楼号
@property(nonatomic,strong)NSString *unitSelect;  //所选单元
@property(nonatomic,strong)NSString *roomSelect;  //所选房间
@property(nonatomic,strong)NSArray *gardenArray;  //园区列表数据
@property(nonatomic,strong)NSArray *buildingArray;  //楼号列表数据
@property(nonatomic,strong)NSArray *unitArray;  //单元列表数据
@property(nonatomic,strong)NSArray *roomArray;  //房间列表数据

@property(nonatomic ,assign)float gardenHeight;//所选的地址的高度
@property(nonatomic ,assign)float buildingHeight;//所选的地址的高度
@property(nonatomic ,assign)float unitHeight;//所选的地址的高度
@property(nonatomic ,assign)float roomHeight;//所选的地址的高度

@property(nonatomic ,assign)BOOL isFirst;//第一次进入


@property (nonatomic, strong) NSString * stringList01;
@property (nonatomic, strong) NSString * stringList02;
@property (nonatomic, strong) NSString * stringList03;
@property (nonatomic, strong) NSString * stringList04;
@end

@implementation AddressEditController

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
    
    
    self.changeView = [[UIView alloc] init];
    self.changeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.changeView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.changeView];
    
    self.selectView = [[UIView alloc] init];
    self.selectView.translatesAutoresizingMaskIntoConstraints = NO;
    self.selectView.backgroundColor = [UIColor clearColor];
    [self.pageScroll addSubview:self.selectView];
    
    self.writeView = [[UIView alloc] init];
    self.writeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.writeView.hidden = YES;
    self.writeView.backgroundColor = [UIColor clearColor];
    [self.pageScroll addSubview:self.writeView];
    
    //选项区域
    self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (ScreenWidth-20)*0.5, self.changeView.frame.size.height)];
    self.selectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectButton setTitle:@"园区选择" forState:UIControlStateNormal];
    [self.selectButton setTitleColor:kRedColor forState:UIControlStateNormal];
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.selectButton.tag = 198801;
    [self.selectButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeView addSubview:self.selectButton];
    
    self.selectFlagView = [[UIView alloc] initWithFrame:CGRectMake(10, self.changeView.frame.size.height-2.5, (ScreenWidth-20)*0.5, 2.5)];
    self.selectFlagView.translatesAutoresizingMaskIntoConstraints = NO;
    self.selectFlagView.backgroundColor = kRedColor;
    [self.changeView addSubview:self.selectFlagView];
    
    self.writeButton = [[UIButton alloc] initWithFrame:CGRectMake(10+(ScreenWidth-20)*0.5, 0, (ScreenWidth-20)*0.5, self.changeView.frame.size.height)];
    self.writeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.writeButton setTitle:@"其他地址" forState:UIControlStateNormal];
    self.writeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.writeButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
    self.writeButton.tag = 198802;
    [self.writeButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeView addSubview:self.writeButton];
    
    self.writeFlagView = [[UIView alloc] initWithFrame:CGRectMake(10+(ScreenWidth-20)*0.5, self.changeView.frame.size.height-2.5, (ScreenWidth-20)*0.5, 2.5)];
    self.writeFlagView.translatesAutoresizingMaskIntoConstraints = NO;
    self.writeFlagView.backgroundColor = kRedColor;
    self.writeFlagView.hidden = YES;
    [self.changeView addSubview:self.writeFlagView];
    
    self.changeLineView = [[UIView alloc] initWithFrame:CGRectMake(10+(ScreenWidth-20)*0.5, self.changeView.frame.size.height-2.5, (ScreenWidth-20)*0.5, 2.5)];
    self.changeLineView.translatesAutoresizingMaskIntoConstraints = NO;
    self.changeLineView.backgroundColor = lineGrayColor;
    [self.changeView addSubview:self.changeLineView];
    
    
    //选择区域
    self.gardenView = [[UIView alloc] init];
    self.gardenView.translatesAutoresizingMaskIntoConstraints = NO;
    self.gardenView.tag = 198811;
    self.gardenView.backgroundColor = [UIColor whiteColor];
    [self.selectView addSubview:self.gardenView];
    UITapGestureRecognizer *gardenTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateOprions:)];
    [self.gardenView addGestureRecognizer:gardenTapGesture];
    
    self.gardenOptionsView = [[UIView alloc] init];
    self.gardenOptionsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectView addSubview:self.gardenOptionsView];
    
    self.buildingView = [[UIView alloc] init];
    self.buildingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.buildingView.tag = 198812;
    self.buildingView.backgroundColor = [UIColor whiteColor];
    [self.selectView addSubview:self.buildingView];
    UITapGestureRecognizer *buildingTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateOprions:)];
    [self.buildingView addGestureRecognizer:buildingTapGesture];
    CALayer *buildingViewTopBorder=[[CALayer alloc]init];
    buildingViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    buildingViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.buildingView.layer addSublayer:buildingViewTopBorder];
    
    self.buildingOptionsView = [[UIView alloc] init];
    self.buildingOptionsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.buildingOptionsView.hidden = YES;
    [self.selectView addSubview:self.buildingOptionsView];
    
    self.unitView = [[UIView alloc] init];
    self.unitView.translatesAutoresizingMaskIntoConstraints = NO;
    self.unitView.tag = 198813;
    self.unitView.backgroundColor = [UIColor whiteColor];
    [self.selectView addSubview:self.unitView];
    UITapGestureRecognizer *unitTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateOprions:)];
    [self.unitView addGestureRecognizer:unitTapGesture];
    CALayer *unitViewTopBorder=[[CALayer alloc]init];
    unitViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    unitViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.unitView.layer addSublayer:unitViewTopBorder];
    
    self.unitOptionsView = [[UIView alloc] init];
    self.unitOptionsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.unitOptionsView.hidden = YES;
    [self.selectView addSubview:self.unitOptionsView];
    
    self.roomView = [[UIView alloc] init];
    self.roomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.roomView.tag = 198814;
    self.roomView.backgroundColor = [UIColor whiteColor];
    [self.selectView addSubview:self.roomView];
    UITapGestureRecognizer *roomTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateOprions:)];
    [self.roomView addGestureRecognizer:roomTapGesture];
    CALayer *roomViewTopBorder=[[CALayer alloc]init];
    roomViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    roomViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.roomView.layer addSublayer:roomViewTopBorder];
    
    self.roomOptionsView = [[UIView alloc] init];
    self.roomOptionsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.roomOptionsView.hidden = YES;
    [self.selectView addSubview:self.roomOptionsView];
    
    //填写区域
    self.addressEditView = [[UIView alloc] init];
    self.addressEditView.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressEditView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    [self.writeView addSubview:self.addressEditView];
    CALayer *addressEditViewTopBorder=[[CALayer alloc]init];
    addressEditViewTopBorder.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
    addressEditViewTopBorder.backgroundColor=kGrayColor.CGColor;
    [self.addressEditView.layer addSublayer:addressEditViewTopBorder];
    
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
    
    self.promptView = [[UIView alloc] init];
    self.promptView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pageScroll addSubview:self.promptView];
    
    
    self.submitButton = [[UIButton alloc] init];
    self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.submitButton setTitle:@"保存地址" forState:UIControlStateNormal];
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
    
    //园区
    self.gardenNameLabel = [[UILabel alloc] init];
    self.gardenNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.gardenNameLabel.text = @"园区";
    self.gardenNameLabel.font = [UIFont systemFontOfSize:14];
    self.gardenNameLabel.textColor = fontDilutedGrayColor;
    [self.gardenView addSubview:self.gardenNameLabel];
    
    self.gardenTitleLabel = [[UILabel alloc] init];
    self.gardenTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.gardenTitleLabel.text = @"请选择小区";
    self.gardenTitleLabel.font = [UIFont systemFontOfSize:14];
    self.gardenTitleLabel.textColor = fontGrayColor;
    self.gardenTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.gardenView addSubview:self.gardenTitleLabel];
    
    self.gardenIco = [[UIImageView alloc] init];
    self.gardenIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.gardenIco.image = [UIImage imageNamed:@"ico_arrow_down"];
    self.gardenIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.gardenView addSubview:self.gardenIco];
    
    //楼号
    self.buildingNameLabel = [[UILabel alloc] init];
    self.buildingNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.buildingNameLabel.text = @"楼号";
    self.buildingNameLabel.font = [UIFont systemFontOfSize:14];
    self.buildingNameLabel.textColor = fontDilutedGrayColor;
    [self.buildingView addSubview:self.buildingNameLabel];
    
    self.buildingTitleLabel = [[UILabel alloc] init];
    self.buildingTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.buildingTitleLabel.text = @"请选择楼号";
    self.buildingTitleLabel.font = [UIFont systemFontOfSize:14];
    self.buildingTitleLabel.textAlignment = NSTextAlignmentRight;
    self.buildingTitleLabel.textColor = fontGrayColor;
    [self.buildingView addSubview:self.buildingTitleLabel];
    
    self.buildingIco = [[UIImageView alloc] init];
    self.buildingIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.buildingIco.image = [UIImage imageNamed:@"ico_arrow_down"];
    self.buildingIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.buildingView addSubview:self.buildingIco];
    
    //单元
    self.unitNameLabel = [[UILabel alloc] init];
    self.unitNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.unitNameLabel.text = @"单元";
    self.unitNameLabel.font = [UIFont systemFontOfSize:14];
    self.unitNameLabel.textColor = fontDilutedGrayColor;
    [self.unitView addSubview:self.unitNameLabel];
    
    self.unitTitleLabel = [[UILabel alloc] init];
    self.unitTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.unitTitleLabel.text = @"请选择单元";
    self.unitTitleLabel.font = [UIFont systemFontOfSize:14];
    self.unitTitleLabel.textColor = fontGrayColor;
    self.unitTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.unitView addSubview:self.unitTitleLabel];
    
    self.unitIco = [[UIImageView alloc] init];
    self.unitIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.unitIco.image = [UIImage imageNamed:@"ico_arrow_down"];
    self.unitIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.unitView addSubview:self.unitIco];
    
    //房间
    self.roomNameLabel = [[UILabel alloc] init];
    self.roomNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.roomNameLabel.text = @"房间";
    self.roomNameLabel.font = [UIFont systemFontOfSize:14];
    self.roomNameLabel.textColor = fontDilutedGrayColor;
    [self.roomView addSubview:self.roomNameLabel];
    
    self.roomTitleLabel = [[UILabel alloc] init];
    self.roomTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.roomTitleLabel.text = @"请选择房间";
    self.roomTitleLabel.font = [UIFont systemFontOfSize:14];
    self.roomTitleLabel.textColor = fontGrayColor;
    self.roomTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.roomView addSubview:self.roomTitleLabel];
    
    self.roomIco = [[UIImageView alloc] init];
    self.roomIco.translatesAutoresizingMaskIntoConstraints = NO;
    self.roomIco.image = [UIImage imageNamed:@"ico_arrow_down"];
    self.roomIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.roomView addSubview:self.roomIco];
    
    //填写地址
    //    self.addressNameLabel = [[UILabel alloc] init];
    //    self.addressNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.addressNameLabel.text = @"世纪城 — ";
    //    self.addressNameLabel.font = [UIFont systemFontOfSize:14];
    //    self.addressNameLabel.textColor = fontDilutedGrayColor;
    //    [self.addressEditView addSubview:self.addressNameLabel];
    
    
    self.addressBackageView = [[UIView alloc] init];
    self.addressBackageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressBackageView.layer.borderColor=[lineGrayColor CGColor];
    self.addressBackageView.layer.borderWidth= 1.0f;
    self.addressBackageView.layer.cornerRadius = 5;
    self.addressBackageView.layer.masksToBounds = YES;
    [self.addressEditView addSubview:self.addressBackageView];
    
    
    
    
    self.addressContentText = [[UITextField alloc] init];
    self.addressContentText.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressContentText.delegate = self;
    [self.addressContentText setPlaceholder:@"请填写其他地址"];
    //    self.addressContentText.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //    self.addressContentText.leftViewMode = UITextFieldViewModeAlways;
    self.addressContentText.font = [UIFont systemFontOfSize:14.0];
    //    [self.addressContentText setBorderStyle:UITextBorderStyleLine];
    self.addressContentText.textAlignment = UITextAlignmentLeft; //水平左对齐
    self.addressContentText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;  //垂直居中方式
    [self.addressBackageView addSubview:self.addressContentText];
    
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
    
    self.promptContent = [[UILabel alloc] init];
    self.promptContent.translatesAutoresizingMaskIntoConstraints = NO;
    self.promptContent.text = @"*目前只支持世纪城片区\n 如果您在写字楼或店铺请填写其他地址";
    self.promptContent.font = [UIFont systemFontOfSize:12];
    self.promptContent.lineBreakMode = NSLineBreakByWordWrapping;
    self.promptContent.numberOfLines = 0;//上面两行设置多行显示
    self.promptContent.textColor = fontDilutedGrayColor;
    [self.promptView addSubview:self.promptContent];
    
    //选项的view
    //    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.minimumInteritemSpacing = 1;//每列最小边距
    //    flowLayout.minimumLineSpacing = 1;//每行最小边距
    //    self.gardenCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    //    self.gardenCollection.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    //    self.gardenCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    [self.gardenCollection registerClass:[AddressOptionsCell class] forCellWithReuseIdentifier:@"AddressOptionsCell"];
    //    self.gardenCollection.delegate = self;
    //    self.gardenCollection.dataSource = self;
    //    [self.pageScroll addSubview:self.gardenCollection];
    //
    //    self.buildingCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    //    self.buildingCollection.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    //    self.buildingCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    [self.buildingCollection registerClass:[AddressOptionsCell class] forCellWithReuseIdentifier:@"AddressOptionsCell"];
    //    self.buildingCollection.delegate = self;
    //    self.buildingCollection.dataSource = self;
    //    [self.pageScroll addSubview:self.buildingCollection];
    //
    //    self.unitCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    //    self.unitCollection.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    //    self.unitCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    [self.unitCollection registerClass:[AddressOptionsCell class] forCellWithReuseIdentifier:@"AddressOptionsCell"];
    //    self.unitCollection.delegate = self;
    //    self.unitCollection.dataSource = self;
    //    [self.pageScroll addSubview:self.unitCollection];
    //
    //    self.roomCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    //    self.roomCollection.backgroundColor = COLOR(0xf0, 0xf0, 0xf0);
    //    self.roomCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    [self.roomCollection registerClass:[AddressOptionsCell class] forCellWithReuseIdentifier:@"AddressOptionsCell"];
    //    self.roomCollection.delegate = self;
    //    self.roomCollection.dataSource = self;
    //    [self.pageScroll addSubview:self.roomCollection];
    
    [self initAutoLayout];//初始化自动布局
    [self loadPageData];//给页面添加数据
    [self loadGardenOptions];//加载地址选项数据
    
}




//添加页面数据
-(void)loadPageData{
    if (self.dataDictionary) {
        self.consigneeContentText.text = [self.dataDictionary objectForKey:@"firstname"];
        self.phoneContentText.text = [self.dataDictionary objectForKey:@"mobile_num"];
        self.gardenTitleLabel.text = [self.dataDictionary objectForKey:@"xiaoqu"];
        self.buildingTitleLabel.text = [self.dataDictionary objectForKey:@"louhao"];
        self.unitTitleLabel.text = [self.dataDictionary objectForKey:@"danyuan"];
        self.roomTitleLabel.text = [self.dataDictionary objectForKey:@"room_number"];
        self.addressContentText.text = [self.dataDictionary objectForKey:@"address_1"];
        
        self.gardenSelect = [self.dataDictionary objectForKey:@"louhao"];
         self.buildingSelect = [self.dataDictionary objectForKey:@"louhao"];
         self.unitSelect = [self.dataDictionary objectForKey:@"louhao"];
         self.roomSelect = [self.dataDictionary objectForKey:@"louhao"];
        
        //        NSLog(@"是否为默认%ld！！！！",(long)[[self.dataDictionary objectForKey:@"default_id"] integerValue]);
        
        self.idDefault = ([[self.dataDictionary objectForKey:@"default_id"] integerValue]==1);
        if (self.idDefault) {
            //            NSLog(@"是为默认！！！！");
            self.defaultImageView.image = [UIImage imageNamed:@"icon_order_selected"];
        }else{
            //             NSLog(@"不为默认！！！！");
            self.defaultImageView.image = [UIImage imageNamed:@"icon_order_unselected"];
        }
        
    }else{
        NSLog(@"新增地址！！！！！");
    }
    
    
}

//获取园区接口数据
-(void)loadGardenOptions{
    [self showGif];
    [commonModel getGardenData:nil httpRequestSucceed:@selector(loadGardenOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
}


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
        addressDictionary[@"xiaoqu"] = [self.gardenTitleLabel.text isEqualToString:@"请选择小区"]?@"":self.gardenTitleLabel.text;
        addressDictionary[@"louhao"] = [self.buildingTitleLabel.text isEqualToString:@"请选择楼号"]?@"":self.buildingTitleLabel.text;
        addressDictionary[@"danyuan"] = [self.unitTitleLabel.text isEqualToString:@"请选择单元"]?@"":self.unitTitleLabel.text;
        addressDictionary[@"room_number"] = [self.roomTitleLabel.text isEqualToString:@"请选择房间"]?@"":self.roomTitleLabel.text;
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


//选择地址
-(void) selectAddress:(UIButton *)myButton{
    
    
    
    NSLog(@"选择地址%ld!!!!!!",(long)myButton.tag);
    if (myButton.tag<2200) {
        //清空之前的选择样式
        for(int i=0;i<self.gardenArray.count;i++){
            UIButton *clearButton =  (UIButton *)[self.view viewWithTag:2100+i];
            clearButton.backgroundColor = [UIColor clearColor];
        }
        //清空已选的显示标题
//        self.gardenTitleLabel.text = @"请选择小区";
        self.buildingTitleLabel.text = @"请选择楼号";
        self.unitTitleLabel.text = @"请选择单元";
        self.roomTitleLabel.text = @"请选择房间";
        
        self.gardenSelect = self.gardenArray[myButton.tag-2100];
        self.gardenTitleLabel.text = self.gardenSelect;
        [self showGif];
        [commonModel getBuildingData:self.gardenSelect httpRequestSucceed:@selector(loadBuildingOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else if(2200<myButton.tag&&myButton.tag<2300) {
        //清空之前的选择样式
        for(int i=0;i<self.buildingArray.count;i++){
            UIButton *clearButton =  (UIButton *)[self.view viewWithTag:2200+i];
            clearButton.backgroundColor = [UIColor clearColor];
        }
        //清空已选的显示标题
//        self.gardenTitleLabel.text = @"";
//        self.buildingTitleLabel.text = @"";
        self.unitTitleLabel.text = @"请选择单元";
        self.roomTitleLabel.text = @"请选择房间";
        
        self.buildingSelect = self.buildingArray[myButton.tag-2200];
        self.buildingTitleLabel.text = self.buildingSelect;
        [self showGif];
        [commonModel getUnitData:self.gardenSelect building:self.buildingSelect httpRequestSucceed:@selector(loadUnitOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else if(2300<myButton.tag&&myButton.tag<2400) {
        //清空之前的选择样式
        for(int i=0;i<self.unitArray.count;i++){
            UIButton *clearButton =  (UIButton *)[self.view viewWithTag:2300+i];
            clearButton.backgroundColor = [UIColor clearColor];
        }
        //清空已选的显示标题
//        self.gardenTitleLabel.text = @"";
//        self.buildingTitleLabel.text = @"";
//        self.unitTitleLabel.text = @"";
        self.roomTitleLabel.text = @"请选择房间";
        
        self.unitSelect = self.unitArray[myButton.tag-2300];
        self.unitTitleLabel.text = self.unitSelect;
        [self showGif];
        
        [commonModel getRoomData:self.gardenSelect building:self.buildingSelect unit:self.unitSelect httpRequestSucceed:@selector(loadRoomOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else if(2400<myButton.tag&&myButton.tag<2500) {
        //清空之前的选择样式
        for(int i=0;i<self.roomArray.count;i++){
            UIButton *clearButton =  (UIButton *)[self.view viewWithTag:2400+i];
            clearButton.backgroundColor = [UIColor clearColor];
        }
        
        self.roomSelect = self.roomArray[myButton.tag-2400];
        self.roomTitleLabel.text = self.roomSelect;
        //         [self showGif];
        //         [commonModel getBuildingData:self.gardenSelect httpRequestSucceed:@selector(loadBuildingOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    myButton.backgroundColor = kRedColor;
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
                    @"changeView" : self.changeView,
                    @"selectView" : self.selectView,
                    @"writeView" : self.writeView,
                    @"defaultView" : self.defaultView,
                    @"promptView" : self.promptView
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
                                     [NSString stringWithFormat:@"V:|-0-[consigneeView(==%f)]-0-[phoneView(==%f)]-20-[changeView(==%f)]-0-[writeView(==120)]",self.rowHeight,self.rowHeight,self.rowHeight]
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    
    //初始化的选择区域布局
    self.bottomDynamicLayoutString = [NSString stringWithFormat:@"V:|-%f-[defaultView(==%f)]-0-[promptView(==%f)]",self.rowHeight*3+20+self.rowHeight*4+0.5*4+self.locationHeight,self.rowHeight,self.rowHeight*2];
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
                                     @"H:|-0-[promptView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[changeView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    //    [self.pageScroll addConstraints:[NSLayoutConstraint
    //                                     constraintsWithVisualFormat:
    //                                     @"H:|-0-[selectView(==pageScroll)]"
    //                                     options:0
    //                                     metrics:nil
    //                                     views:allMap]];
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[writeView(==pageScroll)]"
                                     options:0
                                     metrics:nil
                                     views:self.allMap]];
    [self.pageScroll addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectView
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:0]];
    [self.pageScroll addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectView
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.pageScroll
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:0]];
    [self.pageScroll addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectView
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.pageScroll
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:1
                                    constant:0]];
    self.selectViewHeightContraint = [NSLayoutConstraint
                                      constraintWithItem:self.selectView
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.pageScroll
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0
                                      constant:self.rowHeight*4+0.5*4+self.locationHeight];
    [self.pageScroll addConstraint:self.selectViewHeightContraint];
    
    
    
    
    
    
    //选项区域约束
    NSDictionary *changeMap = @{
                                @"changeLineView" : self.changeLineView,
                                @"selectButton" : self.selectButton,
                                @"selectFlagView" : self.selectFlagView,
                                @"writeButton" : self.writeButton,
                                @"writeFlagView"  : self.writeFlagView
                                };
    [self.changeView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[changeLineView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:changeMap]];
    [self.changeView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:[changeLineView(==0.5)]-0-|"
                                     options:0
                                     metrics:nil
                                     views:changeMap]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectButton
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeTop
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectButton
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectButton
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.5
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectButton
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                    constant:0]];
    
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeButton
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeTop
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeButton
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeButton
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.5
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeButton
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                    constant:0]];
    
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectFlagView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:-0.5]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectFlagView
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectFlagView
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.5
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.selectFlagView
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0.0
                                    constant:3]];
    
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeFlagView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:-0.5]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeFlagView
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeFlagView
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0.5
                                    constant:0]];
    [self.changeView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.writeFlagView
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.changeView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0.0
                                    constant:3]];
    
    
    
    
    self.selectMap = @{
                       @"gardenView" : self.gardenView,
                       @"gardenOptionsView" : self.gardenOptionsView,
                       @"buildingView" : self.buildingView,
                       @"buildingOptionsView" : self.buildingOptionsView,
                       @"unitView" : self.unitView,
                       @"unitOptionsView" : self.unitOptionsView,
                       @"roomView" : self.roomView,
                       @"roomOptionsView" : self.roomOptionsView
                       };
    
    
    
    self.selectContentStirng = [NSString stringWithFormat: @"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
    self.selectContentArray = [NSLayoutConstraint
                               constraintsWithVisualFormat:
                               self.selectContentStirng
                               options:0
                               metrics:nil
                               views:self.selectMap];
    [self.selectView addConstraints: self.selectContentArray];
    
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[gardenView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[gardenOptionsView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[buildingView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[buildingOptionsView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[unitView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.selectView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[unitOptionsView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[roomView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    [self.pageScroll addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-0-[roomOptionsView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:self.selectMap]];
    
    
    
    //填写区域
    NSDictionary *writeMap = @{
                               @"addressEditView" : self.addressEditView
                               };
    
    [self.writeView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[addressEditView]-0-|"
                                    options:0
                                    metrics:nil
                                    views:writeMap]];
    [self.writeView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-0-[addressEditView]-0-|"
                                    options:0
                                    metrics:nil
                                    views:writeMap]];
    
    
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
    //园区
    NSDictionary *gardenInnerMap = @{
                                     @"gardenNameLabel" : self.gardenNameLabel,
                                     @"gardenTitleLabel" : self.gardenTitleLabel,
                                     @"gardenIco" : self.gardenIco};
    [self.gardenView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-15-[gardenNameLabel(==100)]"
                                     options:0
                                     metrics:nil
                                     views:gardenInnerMap]];
    [self.gardenView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:|-0-[gardenNameLabel]-0-|"
                                     options:0
                                     metrics:nil
                                     views:gardenInnerMap]];
    [self.gardenView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:[gardenTitleLabel(==100)]-5-[gardenIco(==12)]-15-|"
                                     options:0
                                     metrics:nil
                                     views:gardenInnerMap]];
    [self.gardenView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:|-0-[gardenTitleLabel]-0-|"
                                     options:0
                                     metrics:nil
                                     views:gardenInnerMap]];
    [self.gardenView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:|-0-[gardenIco]-0-|"
                                     options:0
                                     metrics:nil
                                     views:gardenInnerMap]];
    
    //楼号
    NSDictionary *buildingInnerMap = @{
                                       @"buildingNameLabel" : self.buildingNameLabel,
                                       @"buildingTitleLabel" : self.buildingTitleLabel,
                                       @"buildingIco" : self.buildingIco};
    [self.buildingView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"H:|-15-[buildingNameLabel(==100)]"
                                       options:0
                                       metrics:nil
                                       views:buildingInnerMap]];
    [self.buildingView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"V:|-0-[buildingNameLabel]-0-|"
                                       options:0
                                       metrics:nil
                                       views:buildingInnerMap]];
    [self.buildingView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"H:[buildingTitleLabel(==100)]-5-[buildingIco(==12)]-15-|"
                                       options:0
                                       metrics:nil
                                       views:buildingInnerMap]];
    [self.buildingView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"V:|-0-[buildingTitleLabel]-0-|"
                                       options:0
                                       metrics:nil
                                       views:buildingInnerMap]];
    [self.buildingView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"V:|-0-[buildingIco]-0-|"
                                       options:0
                                       metrics:nil
                                       views:buildingInnerMap]];
    
    //单元
    NSDictionary *unitInnerMap = @{
                                   @"unitNameLabel" : self.unitNameLabel,
                                   @"unitTitleLabel" : self.unitTitleLabel,
                                   @"unitIco" : self.unitIco};
    [self.unitView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-15-[unitNameLabel(==100)]"
                                   options:0
                                   metrics:nil
                                   views:unitInnerMap]];
    [self.unitView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[unitNameLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:unitInnerMap]];
    [self.unitView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:[unitTitleLabel(==100)]-5-[unitIco(==12)]-15-|"
                                   options:0
                                   metrics:nil
                                   views:unitInnerMap]];
    [self.unitView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[unitTitleLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:unitInnerMap]];
    [self.unitView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[unitIco]-0-|"
                                   options:0
                                   metrics:nil
                                   views:unitInnerMap]];
    
    //房间
    NSDictionary *roomInnerMap = @{
                                   @"roomNameLabel" : self.roomNameLabel,
                                   @"roomTitleLabel" : self.roomTitleLabel,
                                   @"roomIco" : self.roomIco};
    [self.roomView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-15-[roomNameLabel(==100)]"
                                   options:0
                                   metrics:nil
                                   views:roomInnerMap]];
    [self.roomView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[roomNameLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:roomInnerMap]];
    [self.roomView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:[roomTitleLabel(==100)]-5-[roomIco(==12)]-15-|"
                                   options:0
                                   metrics:nil
                                   views:roomInnerMap]];
    [self.roomView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[roomTitleLabel]-0-|"
                                   options:0
                                   metrics:nil
                                   views:roomInnerMap]];
    [self.roomView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-0-[roomIco]-0-|"
                                   options:0
                                   metrics:nil
                                   views:roomInnerMap]];
    
    //填写地址
    NSDictionary *addressEditInnerMap = @{
                                          @"addressBackageView" : self.addressBackageView,
                                          @"addressContentText" : self.addressContentText};
    [self.addressEditView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:
                                          @"H:|-15-[addressBackageView]-15-|"
                                          options:0
                                          metrics:nil
                                          views:addressEditInnerMap]];
    [self.addressEditView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:
                                          @"V:|-15-[addressBackageView]-15-|"
                                          options:0
                                          metrics:nil
                                          views:addressEditInnerMap]];
    [self.addressBackageView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:
                                             @"H:|-10-[addressContentText]-8-|"
                                             options:0
                                             metrics:nil
                                             views:addressEditInnerMap]];
    [self.addressBackageView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:
                                             @"V:|-8-[addressContentText]-8-|"
                                             options:0
                                             metrics:nil
                                             views:addressEditInnerMap]];
    
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
    
    //提示
    NSDictionary *promptInnerMap = @{
                                     @"promptContent" : self.promptContent};
    [self.promptView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-15-[promptContent]-15-|"
                                     options:0
                                     metrics:nil
                                     views:promptInnerMap]];
    [self.promptView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"V:|-0-[promptContent]-5-|"
                                     options:0
                                     metrics:nil
                                     views:promptInnerMap]];
    
    
}

//加载园区成功
- (void)loadGardenOptionsSuccess:(ASIHTTPRequest *)request
{
    if (self.isFirst) {//首次进入，加载全部地址
        [commonModel getBuildingData:self.gardenSelect httpRequestSucceed:@selector(loadBuildingOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else{
        [super hideGif];
    }

    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList01];
    NSLog(@"加载园区：%@！！！！！！",completeDic);
    self.gardenArray = completeDic[@"msg"];
    
    //清空已有控件
    NSArray *gardenOptionsArray = self.gardenOptionsView.subviews;
    for(int i = 0;i<gardenOptionsArray.count;i++){
        UIView *clearView = (UIView *)gardenOptionsArray[i];
        [clearView removeFromSuperview];
    }
    
    
    for(int i=0;i<self.gardenArray.count;i++){
        UIButton *myButton = [[UIButton alloc]init];
        myButton.translatesAutoresizingMaskIntoConstraints = NO;
        myButton.tag = 2100+i;
        [myButton setTitle:self.gardenArray[i] forState:UIControlStateNormal];
        [myButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.gardenOptionsView addSubview:myButton];
        
        int rowNumber = i/3;//行数
        int lineNumber = i%3;//排数(0,1,2)
        float buttonWidth = (ScreenWidth-30)/3;
        float buttonHeight = 15;
        
        self.gardenHeight = (rowNumber+1)*(buttonHeight+5)+0.5;
        
        [self.gardenOptionsView addConstraint:[NSLayoutConstraint
                                               constraintWithItem:myButton
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.gardenOptionsView
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                               constant:lineNumber*(buttonWidth)]];
        [self.gardenOptionsView addConstraint:[NSLayoutConstraint
                                               constraintWithItem:myButton
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.gardenOptionsView
                                               attribute:NSLayoutAttributeTop
                                               multiplier:1
                                               constant:5+rowNumber*(buttonHeight+5)]];
        [self.gardenOptionsView addConstraint:[NSLayoutConstraint
                                               constraintWithItem:myButton
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.gardenOptionsView
                                               attribute:NSLayoutAttributeWidth
                                               multiplier:0.0
                                               constant:buttonWidth]];
        [self.gardenOptionsView addConstraint:[NSLayoutConstraint
                                               constraintWithItem:myButton
                                               attribute:NSLayoutAttributeHeight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.gardenOptionsView
                                               attribute:NSLayoutAttributeHeight
                                               multiplier:0.0
                                               constant:buttonHeight]];
        
        
    }
    [self.gardenOptionsView setNeedsLayout];
    [self.gardenOptionsView layoutIfNeeded];
    
    
  
}


//加载楼号成功
- (void)loadBuildingOptionsSuccess:(ASIHTTPRequest *)request
{
    if (self.isFirst) {//首次进入，加载全部地址
       [commonModel getUnitData:self.gardenSelect building:self.buildingSelect httpRequestSucceed:@selector(loadUnitOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else{
        [super hideGif];
    }
    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList02];
    NSLog(@"加载楼号：%@！！！！！！",completeDic);
    self.buildingArray = completeDic[@"msg"];
    
    //清空已有控件
    for (UIView *subviews in [self.buildingOptionsView subviews]) {
        [subviews removeFromSuperview];
    }
    //     NSLog(@"剩余子控件数量%@!!!!!!!",self.buildingOptionsView.subviews);
    
    for(int i=0;i<self.buildingArray.count;i++){
        UIButton *myButton = [[UIButton alloc]init];
        myButton.translatesAutoresizingMaskIntoConstraints = NO;
        myButton.tag = 2200+i;
        [myButton setTitle:self.buildingArray[i] forState:UIControlStateNormal];
        [myButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.buildingOptionsView addSubview:myButton];
        
        int rowNumber = i/3;//行数
        int lineNumber = i%3;//排数(0,1,2)
        float buttonWidth = (ScreenWidth-30)/3;
        float buttonHeight = 15;
        
        self.buildingHeight = (rowNumber+1)*(buttonHeight+5)+0.5;
        
        [self.buildingOptionsView addConstraint:[NSLayoutConstraint
                                                 constraintWithItem:myButton
                                                 attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.buildingOptionsView
                                                 attribute:NSLayoutAttributeLeft
                                                 multiplier:1
                                                 constant:lineNumber*(buttonWidth)]];
        [self.buildingOptionsView addConstraint:[NSLayoutConstraint
                                                 constraintWithItem:myButton
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.buildingOptionsView
                                                 attribute:NSLayoutAttributeTop
                                                 multiplier:1
                                                 constant:5+rowNumber*(buttonHeight+5)]];
        [self.buildingOptionsView addConstraint:[NSLayoutConstraint
                                                 constraintWithItem:myButton
                                                 attribute:NSLayoutAttributeWidth
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.buildingOptionsView
                                                 attribute:NSLayoutAttributeWidth
                                                 multiplier:0.0
                                                 constant:buttonWidth]];
        [self.buildingOptionsView addConstraint:[NSLayoutConstraint
                                                 constraintWithItem:myButton
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.buildingOptionsView
                                                 attribute:NSLayoutAttributeHeight
                                                 multiplier:0.0
                                                 constant:buttonHeight]];
    }
    [self.buildingOptionsView setNeedsLayout];
    [self.buildingOptionsView layoutIfNeeded];
    
}

//加载单元成功
- (void)loadUnitOptionsSuccess:(ASIHTTPRequest *)request
{
    if (self.isFirst) {//首次进入，加载全部地址
    [commonModel getRoomData:self.gardenSelect building:self.buildingSelect unit:self.unitSelect httpRequestSucceed:@selector(loadRoomOptionsSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }else{
        [super hideGif];
    }
    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList03];
    NSLog(@"加载单元：%@！！！！！！",completeDic);
    self.unitArray = completeDic[@"msg"];
    
    //清空已有控件
    for (UIView *subviews in [self.unitOptionsView subviews]) {
        [subviews removeFromSuperview];
    }
    //     NSLog(@"剩余子控件数量%@!!!!!!!",self.buildingOptionsView.subviews);
    
    for(int i=0;i<self.unitArray.count;i++){
        UIButton *myButton = [[UIButton alloc]init];
        myButton.translatesAutoresizingMaskIntoConstraints = NO;
        myButton.tag = 2300+i;
        [myButton setTitle:self.unitArray[i] forState:UIControlStateNormal];
        [myButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.unitOptionsView addSubview:myButton];
        
        int rowNumber = i/3;//行数
        int lineNumber = i%3;//排数(0,1,2)
        float buttonWidth = (ScreenWidth-30)/3;
        float buttonHeight = 15;
        
        self.unitHeight = (rowNumber+1)*(buttonHeight+5)+0.5;
        
        [self.unitOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.unitOptionsView
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1
                                             constant:lineNumber*(buttonWidth)]];
        [self.unitOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.unitOptionsView
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1
                                             constant:5+rowNumber*(buttonHeight+5)]];
        [self.unitOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.unitOptionsView
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.0
                                             constant:buttonWidth]];
        [self.unitOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.unitOptionsView
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:0.0
                                             constant:buttonHeight]];
    }
    [self.unitOptionsView setNeedsLayout];
    [self.unitOptionsView layoutIfNeeded];
}

//加载房间成功
- (void)loadRoomOptionsSuccess:(ASIHTTPRequest *)request
{
    [super hideGif];
    NSDictionary *completeDic = [super parseJsonRequest:request];
//    completeDic = [super parseJsonRequestByTest:self.stringList04];
    NSLog(@"加载房间：%@！！！！！！",completeDic);
    self.roomArray = completeDic[@"msg"];
    
    //清空已有控件
    for (UIView *subviews in [self.roomOptionsView subviews]) {
        [subviews removeFromSuperview];
    }
    //     NSLog(@"剩余子控件数量%@!!!!!!!",self.buildingOptionsView.subviews);
    
    for(int i=0;i<self.roomArray.count;i++){
        UIButton *myButton = [[UIButton alloc]init];
        myButton.translatesAutoresizingMaskIntoConstraints = NO;
        myButton.tag = 2400+i;
        [myButton setTitle:self.roomArray[i] forState:UIControlStateNormal];
        [myButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.roomOptionsView addSubview:myButton];
        
        int rowNumber = i/3;//行数
        int lineNumber = i%3;//排数(0,1,2)
        float buttonWidth = (ScreenWidth-30)/3;
        float buttonHeight = 15;
        
        self.roomHeight = (rowNumber+1)*(buttonHeight+5)+0.5;
        
        [self.roomOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.roomOptionsView
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1
                                             constant:lineNumber*(buttonWidth)]];
        [self.roomOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.roomOptionsView
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1
                                             constant:5+rowNumber*(buttonHeight+5)]];
        [self.roomOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.roomOptionsView
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.0
                                             constant:buttonWidth]];
        [self.roomOptionsView addConstraint:[NSLayoutConstraint
                                             constraintWithItem:myButton
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.roomOptionsView
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:0.0
                                             constant:buttonHeight]];
    }
    [self.roomOptionsView setNeedsLayout];
    [self.roomOptionsView layoutIfNeeded];
}


/**
 *  修改地址选择区域布局
 *
 *  @param type  选择区域类型
 *  @param state 点击状态
 */
-(void)updateAddressLayout:(int)type state:(int)state{
    switch (type) {
        case 1://园区
            if(state==0){
                self.gardenOptionsView.hidden = YES;
                for(UIView *view in [self.gardenOptionsView subviews])
                {
                    view.hidden = YES;
                }
            }else{
                self.gardenOptionsView.hidden = NO;
                for(UIView *view in [self.gardenOptionsView subviews])
                {
                    view.hidden = NO;
                }
            }
            
            break;
        case 2://楼号
            if(state==0){
                self.buildingOptionsView.hidden = YES;
                for(UIView *view in [self.buildingOptionsView subviews])
                {
                    view.hidden = YES;
                }
            }else{
                self.buildingOptionsView.hidden = NO;
                for(UIView *view in [self.buildingOptionsView subviews])
                {
                    view.hidden = NO;
                }
            }
            break;
        case 3://单元
            if(state==0){
                self.unitOptionsView.hidden = YES;
                for(UIView *view in [self.unitOptionsView subviews])
                {
                    view.hidden = YES;
                }
            }else{
                self.unitOptionsView.hidden = NO;
                for(UIView *view in [self.unitOptionsView subviews])
                {
                    view.hidden = NO;
                }
            }
            break;
        case 4://房间
            if(state==0){
                self.roomOptionsView.hidden = YES;
                for(UIView *view in [self.roomOptionsView subviews])
                {
                    view.hidden = YES;
                }
            }else{
                self.roomOptionsView.hidden = NO;
                for(UIView *view in [self.roomOptionsView subviews])
                {
                    view.hidden = NO;
                }
            }
            break;
            
        default:
            break;
    }
    
    
    
}



//修改默认地址
-(void)updateDefault:(UITapGestureRecognizer*)recognizer{
    NSLog(@"设置默认点击事件！！！！！");
    if (self.idDefault) {
        self.idDefault = NO;
        self.defaultImageView.image = [UIImage imageNamed:@"icon_order_unselected"];
    }else{
        self.idDefault = YES;
        self.defaultImageView.image = [UIImage imageNamed:@"icon_order_selected"];
    }
}

//显示或者隐藏选项
-(void)updateOprions:(UITapGestureRecognizer*)recognizer{
    NSLog(@"显示或者隐藏选项%ld！！！！！",(long)recognizer.view.tag);
 
    switch (recognizer.view.tag) {
        case 198811:
             self.gardenView.tag = 198821;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
 
            self.locationHeight = self.gardenHeight+0.5;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,self.locationHeight,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
            [self updateAddressLayout:1 state:1];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198821:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
            self.locationHeight = 0.5;
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198812://隐藏变为开启
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198822;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
            self.locationHeight = self.buildingHeight+0.5;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,self.locationHeight,self.rowHeight,0.5,self.rowHeight,0.5];
            [self updateAddressLayout:2 state:1];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198822:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
            self.locationHeight = 0.5;
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198813:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198823;
            self.roomView.tag = 198814;
            self.locationHeight = self.unitHeight+0.5;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,self.locationHeight,self.rowHeight,0.5];
            [self updateAddressLayout:3 state:1];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198823:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
            self.locationHeight = 0.5;
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            break;
        case 198814:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198824;
            self.locationHeight = self.roomHeight+0.5;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,self.locationHeight];
            [self updateAddressLayout:4 state:1];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            break;
        case 198824:
            self.gardenView.tag = 198811;
            self.buildingView.tag = 198812;
            self.unitView.tag = 198813;
            self.roomView.tag = 198814;
            self.selectContentStirng = [NSString stringWithFormat:@"V:|-0-[gardenView(==%f)]-0-[gardenOptionsView(==%f)]-0-[buildingView(==%f)]-0-[buildingOptionsView(==%f)]-0-[unitView(==%f)]-0-[unitOptionsView(==%f)]-0-[roomView(==%f)]-0-[roomOptionsView(==%f)]",self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5,self.rowHeight,0.5];
            self.locationHeight = 0.5;
            [self updateAddressLayout:4 state:0];//修改选择区域状态
            [self updateAddressLayout:1 state:0];//修改选择区域状态
            [self updateAddressLayout:2 state:0];//修改选择区域状态
            [self updateAddressLayout:3 state:0];//修改选择区域状态
            break;
        default:
            break;
    }
    
    //更改滚动视图高度
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 600+self.locationHeight);
    
    //改变整体高度
    [self.pageScroll removeConstraint:self.selectViewHeightContraint];
    self.selectViewHeightContraint = [NSLayoutConstraint
                                      constraintWithItem:self.selectView
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.pageScroll
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:0
                                      constant:self.rowHeight*4+0.5*4+self.locationHeight];
    [self.pageScroll addConstraint:self.selectViewHeightContraint];
    
    //改变底部位置
    [self.pageScroll removeConstraints:self.bottomDynamicArray];
    self.bottomDynamicLayoutString = [NSString stringWithFormat:@"V:|-%f-[defaultView(==%f)]-0-[promptView(==%f)]",self.rowHeight*3+20+self.rowHeight*4+0.5*4+self.locationHeight,self.rowHeight,self.rowHeight];
    self.bottomDynamicArray = [NSLayoutConstraint
                               constraintsWithVisualFormat:
                               self.bottomDynamicLayoutString
                               options:0
                               metrics:nil
                               views:self.allMap];
    [self.pageScroll addConstraints:self.bottomDynamicArray];
    
    //改变具体选择区域的高度
    [self.selectView removeConstraints:self.selectContentArray];
    self.selectContentArray = [NSLayoutConstraint
                               constraintsWithVisualFormat:
                               self.selectContentStirng
                               options:0
                               metrics:nil
                               views:self.selectMap];
    [self.selectView addConstraints:self.selectContentArray];
    
    
    
    
    
    [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pageScroll setNeedsLayout];
        [self.pageScroll layoutIfNeeded];
        //        [self.selectView setNeedsLayout];
        //        [self.selectView layoutIfNeeded];
        
    } completion:NULL];
    
}

//切换页面
- (void) changePage:(UIButton *) myButton{
    switch (myButton.tag) {
        case 198801:
            
            [self.selectButton setTitleColor:kRedColor forState:UIControlStateNormal];
            self.selectFlagView.hidden = NO;
            [self.writeButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
            self.writeFlagView.hidden = YES;
            self.selectView.hidden = NO;
            self.writeView.hidden = YES;
            
            //更改滚动视图高度
            self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 600);
            
            //改变底部位置
            [self.pageScroll removeConstraints:self.bottomDynamicArray];
            self.bottomDynamicLayoutString = [NSString stringWithFormat:@"V:|-%f-[defaultView(==%f)]-0-[promptView(==%f)]",self.rowHeight*3+20+self.rowHeight*4+0.5*4+self.locationHeight,self.rowHeight,self.rowHeight];
            self.bottomDynamicArray = [NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       self.bottomDynamicLayoutString
                                       options:0
                                       metrics:nil
                                       views:self.allMap];
            [self.pageScroll addConstraints:self.bottomDynamicArray];
            [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.pageScroll setNeedsLayout];
                [self.pageScroll layoutIfNeeded];
            } completion:NULL];
            break;
        case 198802:
            
            [self.selectButton setTitleColor:fontGrayColor forState:UIControlStateNormal];
            self.selectFlagView.hidden = YES;
            [self.writeButton setTitleColor:kRedColor forState:UIControlStateNormal];
            self.writeFlagView.hidden = NO;
            self.selectView.hidden = YES;
            self.writeView.hidden = NO;
            
            //更改滚动视图高度
            self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 500);
            
            //改变底部位置
            [self.pageScroll removeConstraints:self.bottomDynamicArray];
            self.bottomDynamicLayoutString = [NSString stringWithFormat:@"V:|-%f-[defaultView(==%f)]-0-[promptView(==%f)]",self.rowHeight*3+20+120,self.rowHeight,self.rowHeight];
            self.bottomDynamicArray = [NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       self.bottomDynamicLayoutString
                                       options:0
                                       metrics:nil
                                       views:self.allMap];
            [self.pageScroll addConstraints:self.bottomDynamicArray];
            [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.pageScroll setNeedsLayout];
                [self.pageScroll layoutIfNeeded];
            } completion:NULL];
            break;
        default:
            break;
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

//触摸屏幕隐藏键盘
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//   [self.view resignFirstResponder];
//}

@end
