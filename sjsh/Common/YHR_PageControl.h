//
//  YHR_PageControl.h
//  sjsh
//
//  Created by savvy on 15/10/20.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHR_PageControl : UIView
 
@property (nonatomic,assign) float PointWidth;
@property (nonatomic,assign) float PointHeight;
@property (nonatomic,assign) float distanceOfPoint;
@property (nonatomic,assign) UIColor * currentPagePointColor;
@property (nonatomic,assign) UIColor * pagePointColor;

//-(float)sizeForNumberOfPages:(NSInteger)pages;

-(void)setNumberOfPages:(NSInteger)pages;
-(void)setCurrentPage:(NSInteger)page;
@end
