//
//  AreaPickerView.m
//  BeautyMakeup
//
//  Created by nuohuan on 14-3-3.
//  Copyright (c) 2014年 hers. All rights reserved.
//

#import "AreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "Define.h"

#define kDuration 0.3

@implementation AreaPickerView

@synthesize delegate=_delegate;
@synthesize locatePickerView = _locatePickerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [_locatePickerView release];
    [provinces release];
    [super dealloc];
}

#pragma mark
#pragma mark -- Functions

- (id)initWithStyle: (id<AreaPickerDelegate>)delegate
{
    self.locatePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, kScreenBounds.size.height-90.0f, kScreenBounds.size.width, 90.0f)];
    self.locatePickerView.backgroundColor = [UIColor whiteColor];
    
    
    if (self) {
        self.delegate = delegate;
        self.locatePickerView.dataSource = self;
        self.locatePickerView.delegate = self;
        
        //加载城市数据
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"province.plist" ofType:nil]];
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        
    }
    return self;
}

#pragma mark
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            return [areas count];
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 26.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([areas count] > 0) {
                return [areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}


#pragma mark -- Animation
//显示城市选择器
- (void)showInView:(UIView *)view
{
    //灰色背景
    bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y-20.0f, kScreenBounds.size.width, kScreenBounds.size.height)];
    bgView.backgroundColor = [UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:0.5f];
    [view addSubview:bgView];
    [bgView release];
    
    self.locatePickerView.frame = CGRectMake(0, view.frame.size.height, self.locatePickerView.frame.size.width, self.locatePickerView.frame.size.height);
    [bgView addSubview:self.locatePickerView];
    
    //选择城市上面的标题栏
    UIImage *pickerViewUpImage = [UIImage imageNamed:@"uipickerviewUpView.png"];
    pickerViewUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, self.locatePickerView.frame.origin.y-pickerViewUpImage.size.height, pickerViewUpImage.size.width, pickerViewUpImage.size.height)];
    [pickerViewUpImageView setImage:pickerViewUpImage];
    pickerViewUpImageView.userInteractionEnabled = YES;
    [bgView addSubview:pickerViewUpImageView];
    [pickerViewUpImageView release];
    
    //标题栏左右按钮
    UIImage *cancleImage = [UIImage imageNamed:@"cancleCityChoose.png"];
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.backgroundColor = [UIColor clearColor];
    [cancleButton setImage:cancleImage forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleAddressInfo) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.frame = CGRectMake(0.0f, (pickerViewUpImage.size.height-cancleImage.size.height)/2, cancleImage.size.width, cancleImage.size.height);
    [pickerViewUpImageView addSubview:cancleButton];
    
    UIImage *saveImage = [UIImage imageNamed:@"saveCity.png"];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = [UIColor clearColor];
    saveButton.frame = CGRectMake(kScreenBounds.size.width - saveImage.size.width, (pickerViewUpImage.size.height-saveImage.size.height)/2, saveImage.size.width, saveImage.size.height);
    [saveButton addTarget:self action:@selector(saveAddressInfo) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setImage:saveImage forState:UIControlStateNormal];
    [pickerViewUpImageView addSubview:saveButton];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.locatePickerView.frame = CGRectMake(kScreenBounds.origin.x, view.frame.size.height - self.locatePickerView.frame.size.height+10.0f, self.locatePickerView.frame.size.width, self.locatePickerView.frame.size.height-10.0f);
        pickerViewUpImageView.frame = CGRectMake(kScreenBounds.origin.x, self.locatePickerView.frame.origin.y-pickerViewUpImage.size.height, pickerViewUpImage.size.width, pickerViewUpImage.size.height);
    }];
}

//取消城市选择器
- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.locatePickerView.frame = CGRectMake(kScreenBounds.origin.x, self.locatePickerView.frame.origin.y+self.locatePickerView.frame.size.height, self.locatePickerView.frame.size.width, self.locatePickerView.frame.size.height);
                         pickerViewUpImageView.frame = CGRectMake(kScreenBounds.origin.x, pickerViewUpImageView.frame.origin.y+pickerViewUpImageView.frame.size.height+self.locatePickerView.frame.size.height, pickerViewUpImageView.frame.size.width, pickerViewUpImageView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [pickerViewUpImageView removeFromSuperview];
                         [self.locatePickerView removeFromSuperview];
                         [bgView removeFromSuperview];
                     }];
}

//取消所选地址信息
- (void)cancleAddressInfo{
    if([self.delegate respondsToSelector:@selector(pickerDidChangeStatus:isCancleChange:)]) {
        [self.delegate pickerDidChangeStatus:self isCancleChange:YES];
    }
}

//保存所选地址信息
- (void)saveAddressInfo{
    if([self.delegate respondsToSelector:@selector(pickerDidChangeStatus:isCancleChange:)]) {
        [self.delegate pickerDidChangeStatus:self isCancleChange:NO];
    }
}

@end
