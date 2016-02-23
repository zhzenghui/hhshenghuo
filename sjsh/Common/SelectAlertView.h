//
//  SelectAlertView.h
//  sjsh
//
//  Created by savvy on 15/10/30.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectAlertViewDelegate<NSObject>

- (void)getSelectItem:(NSDictionary *)myDictionary;

@end

@interface SelectAlertView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) id<SelectAlertViewDelegate> delegate;


@property(nonatomic, strong) UIView* backageTopView; //用于遮盖手机最上面的状态栏
@property(nonatomic, strong) UIView* backageView;  //整个屏幕的虚化背景
@property(nonatomic, strong) UIView* alertView;  //弹出框视图

@property(nonatomic, strong) UIView* alertTitleView; //标题视图
@property(nonatomic, strong) UILabel* alertTitle;  //标题内容
@property(nonatomic, strong) UIView* alertContentView;   //主体视图

@property(nonatomic, strong) UITableView* selectTableView;  //选择列表

@property(nonatomic, strong) UIView* alertButtonView; //按钮区域
@property(nonatomic, strong) UIButton* alertCancel;  //取消按钮
@property(nonatomic, strong) UIButton* alertSubmit;  //确认按钮

@property(nonatomic, strong) NSArray* tableDataArray;  //选择列表数据

@property(nonatomic, assign) NSInteger selectPositionIndex;  //选择的列表位置


-(void) showAlert;
-(void) closeAlert;
@end
