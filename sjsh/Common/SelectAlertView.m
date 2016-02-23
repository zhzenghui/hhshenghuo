//
//  SelectAlertView.m
//  sjsh
//
//  Created by savvy on 15/10/30.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "SelectAlertView.h"
#import "Define.h"
#import "CouponSelectCell.h"


@implementation SelectAlertView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

//初始化布局
-(void)initLayout{
//    @property(nonatomic, strong) UIView* backageTopView; //用于遮盖手机最上面的状态栏
//    @property(nonatomic, strong) UIView* backageView;  //整个屏幕的虚化背景
//    @property(nonatomic, strong) UIView* alertView;  //弹出框视图
//    
//    @property(nonatomic, strong) UIView* alertTitleView; //标题视图
//    @property(nonatomic, strong) UILabel* alertTitle;  //标题内容
//    @property(nonatomic, strong) UIView* alertContentView;   //主体视图
//    
//    @property(nonatomic, strong) UITableView* selectTableView;  //选择列表
//    
//    @property(nonatomic, strong) UIView* alertButtonView; //按钮区域
//    @property(nonatomic, strong) UIButton* alertCancel;  //取消按钮
//    @property(nonatomic, strong) UIButton* alertSubmit;  //确认按钮
    
 

    
    self.backageTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.backageTopView.backgroundColor = [UIColor blackColor];
    self.backageTopView.hidden = YES;
    self.backageTopView.alpha=0.4;
    UIWindow *myWindow = [[UIApplication sharedApplication].delegate window];
    [myWindow addSubview:self.self.backageTopView];
    
    self.backageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.backageView.backgroundColor = [UIColor blackColor];
    self.backageView.alpha=0.4;
    [self addSubview:self.self.backageView];
    
    self.alertView = [[UIView alloc] init];
    self.alertView.layer.cornerRadius = 8;
    self.alertView.layer.masksToBounds = true;
    self.alertView.backgroundColor = [UIColor colorWithRed:243/255 green:243/255 blue:243/255 alpha:1.0];
    [self.alertView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.self.alertView];
    
    //标题区域
    self.alertTitleView = [[UIView alloc] init];
    self.alertTitleView.backgroundColor = [UIColor redColor];
    [self.alertTitleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertView addSubview:self.self.alertTitleView];
    
    self.alertTitle = [[UILabel alloc] init];
    self.alertTitle.backgroundColor = [UIColor whiteColor];
    self.alertTitle.text = @"请选择优惠劵";
    self.alertTitle.textAlignment = NSTextAlignmentCenter;
    self.alertTitle.textColor = fontGrayColor;
    [self.alertTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertTitleView addSubview:self.self.alertTitle];
    
  
    
    //内容区域
    self.alertContentView = [[UIView alloc] init];
    self.alertContentView.backgroundColor = [UIColor yellowColor];
    [self.alertContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertView addSubview:self.self.alertContentView];
    
    self.selectTableView = [[UITableView alloc] init];
    self.selectTableView.backgroundColor = [UIColor whiteColor];
    [self.selectTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.selectTableView.showsVerticalScrollIndicator = NO;
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.selectTableView.dataSource = self;
    self.selectTableView.delegate = self;
//    self.selectTableView.separatorStyle = UITableViewCellStyleSubtitle;
    self.selectTableView.tableFooterView = [[UIView alloc]init];
    [self.alertContentView addSubview:self.self.selectTableView];
    CALayer *lineBorder = [[CALayer alloc] init];
    lineBorder.frame = CGRectMake(0, 0, ScreenWidth, 00.5);
    lineBorder.backgroundColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    [self.selectTableView.layer addSublayer:lineBorder];

 
 
    //按钮区域
    self.alertButtonView = [[UIView alloc] init];
    self.alertButtonView.backgroundColor = [UIColor whiteColor];
    [self.alertButtonView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertView addSubview:self.self.alertButtonView];
    
    
    self.alertCancel = [[UIButton alloc] init];
    self.alertCancel.backgroundColor = [UIColor whiteColor];
    [self.alertCancel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertCancel setTitle:@"取消" forState:UIControlStateNormal];
    self.alertCancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.alertCancel addTarget:self action:@selector(closeAlert)
             forControlEvents:UIControlEventTouchUpInside];
    self.alertCancel.tintColor = [UIColor blackColor];
    [self.alertCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.alertCancel setTitleColor:[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:1.0] forState:UIControlStateNormal];
    self.alertCancel.clipsToBounds = YES;
        self.alertCancel.layer.cornerRadius = 5;//half of the width
    self.alertCancel.layer.borderColor = [[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:1.0] CGColor];
    self.alertCancel.layer.borderWidth=0.5;
    [self.alertButtonView addSubview:self.self.alertCancel];
    
    self.alertSubmit = [[UIButton alloc] init];
    self.alertSubmit.backgroundColor = [UIColor redColor];
    [self.alertSubmit setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertSubmit setTitle:@"确认" forState:UIControlStateNormal];
    [self.alertSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     self.alertSubmit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.alertSubmit addTarget:self action:@selector(submitAlert:)
               forControlEvents:UIControlEventTouchUpInside];
//    [self.alertSubmit setTitleColor:[UIColor colorWithRed:254/255 green:0/255 blue:0/255 alpha:1.0] forState:UIControlStateNormal];
    self.alertSubmit.clipsToBounds = YES;
    self.alertSubmit.layer.cornerRadius = 5;//half of the width
//    self.alertSubmit.layer.borderColor = [[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:1.0] CGColor];
//    self.alertSubmit.backgroundColor = [UIColor colorWithRed:254/255 green:0/255 blue:0/255 alpha:1.0];
    [self.alertButtonView addSubview:self.self.alertSubmit];
    
    
    [self initAutoLayout];
    [self closeAlert];

}

//创建自动布局
-(void)initAutoLayout{
    [self addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.alertView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeCenterX
                               multiplier:1
                               constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.alertView
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.alertView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.9
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.alertView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.7
                         constant:0]];

 
    //控件
    NSDictionary *viewMap = @{
                                  @"alertView":self.alertView,@"alertTitleView":self.alertTitleView,@"alertContentView":self.alertContentView,@"alertTitle":self.alertTitle,@"selectTableView":self.selectTableView,@"alertCancel":self.alertCancel,@"alertSubmit":self.alertSubmit,@"alertButtonView":self.alertButtonView
                                  };
    
    
    //第一层布局
    [self.alertView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:
                               @"H:|-0-[alertTitleView]-0-|"
                               options:0
                               metrics:nil
                               views:viewMap]];
    [self.alertView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-0-[alertContentView]-0-|"
                                    options:0
                                    metrics:nil
                                    views:viewMap]];
    [self.alertView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-0-[alertButtonView]-0-|"
                                    options:0
                                    metrics:nil
                                    views:viewMap]];
    [self.alertView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-0-[alertTitleView(==50)]-0-[alertContentView]-0-[alertButtonView(==50)]-0-|"
                                    options:0
                                    metrics:nil
                                    views:viewMap]];
    
    
    
    [self.alertTitleView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"H:|-0-[alertTitle]-0-|"
                                    options:0
                                    metrics:nil
                                    views:viewMap]];
    [self.alertTitleView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"V:|-0-[alertTitle]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    
    [self.alertContentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"H:|-0-[selectTableView]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    [self.alertContentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"V:|-0-[selectTableView]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    
    [self.alertButtonView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:
                                           @"H:|-0-[alertCancel(==120)]"
                                           options:0
                                           metrics:nil
                                           views:viewMap]];
    [self.alertButtonView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:
                                           @"H:[alertSubmit(==120)]-0-|"
                                           options:0
                                           metrics:nil
                                           views:viewMap]];
    [self.alertButtonView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:
                                           @"V:|-0-[alertSubmit]-0-|"
                                           options:0
                                           metrics:nil
                                           views:viewMap]];
    [self.alertButtonView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:
                                           @"V:|-0-[alertCancel]-0-|"
                                           options:0
                                           metrics:nil
                                           views:viewMap]];

    
    
}

//提交按钮事件
-(void) submitAlert:(UIButton *)myButton{
    [_delegate getSelectItem:self.tableDataArray[self.selectPositionIndex]];

}

//隐藏弹出框
-(void) closeAlert{
    self.hidden=YES;
    self.backageTopView.hidden=YES;
}

//显示弹出框
-(void) showAlert{
    self.hidden=NO;
    self.backageTopView.hidden=NO;
}

-(void)uploadData:(NSMutableArray *)myArray{
    if (myArray&&myArray.count>0) {//刷新tableView
        self.tableDataArray = myArray;
        [self.selectTableView reloadData];
    }
}



#pragma marks tableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *reusableIdentifier = @"CouponSelectCell";
        CouponSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        if (!cell)
        {
            cell = [[CouponSelectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusableIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        [cell setCellInfo:self.tableDataArray[indexPath.row]];
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择的row为%@!!!!!!!!",indexPath);
           self.selectPositionIndex = indexPath.row;
}

@end
