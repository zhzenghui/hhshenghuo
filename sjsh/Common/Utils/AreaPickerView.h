//
//  AreaPickerView.h
//  BeautyMakeup
//
//  Created by nuohuan on 14-3-3.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaPickerView;

@protocol AreaPickerDelegate <NSObject>

@optional
//选中地区更新相关页面地址
- (void)pickerDidChangeStatus:(AreaPickerView *)picker isCancleChange:(BOOL)isCancle;

@end

@interface AreaPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray     *provinces;//省
    NSArray     *cities;//市
    NSArray     *areas;//区
    UIView      *bgView;//选择城市背景颜色view
    UIImageView *pickerViewUpImageView;//选择城市上面的导航栏
}

@property (assign, nonatomic) id <AreaPickerDelegate> delegate;//选中地区后更新页面数据走的代理方法
@property (strong, nonatomic) UIPickerView *locatePickerView;//UIPickerView实例

- (id)initWithStyle:(id <AreaPickerDelegate>)delegate;//加载城市数据
- (void)showInView:(UIView *)view;//显示UIPickerView
- (void)cancelPicker;//取消UIPickerView

@end
