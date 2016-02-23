//
//  DJQRateView.h
//  rateView
//  评分控件
//  Created by 丁剑青 on 13-6-23.
//  Copyright (c) 2013年 丁剑青. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
rateV = [[DJQRateView alloc] initWithFrame:CGRectMake(0, 200, 320, 100)];
// 不允许编辑需要设置 userInteractionEnabled 为 false
//userInteractionEnabled
rateV.userInteractionEnabled = NO;

[self.view addSubview:rateV];
*/

@protocol DJQRateViewDelegate<NSObject>

- (void)ratechanger:(int)reteNum;

@end

@interface DJQRateView : UIView

@property(nonatomic) float rate;
@property(nonatomic) int maxRate;
@property(nonatomic) float leftMargin;
@property(nonatomic) float rightMargin;
@property(nonatomic) float midMargin;

@property(nonatomic, assign) id<DJQRateViewDelegate> delegate;

@end

@interface DJQStartView : UIView

@property(nonatomic) CGFloat radius;
@property(nonatomic) CGFloat value;  // 范围 0到1
@property(nonatomic, strong) UIColor* startColor;
@property(nonatomic, strong) UIColor* boundsColor;
@end
