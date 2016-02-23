//
//  UIViewsAnimation.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewsAnimation : NSObject
{
    UIView* changedView;
}

+(UIViewsAnimation*) sharedInstance;
-(void) pushInAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView;
-(void) pushOutAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView;
-(void) flipInAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView;
-(void) flipOutAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView;
-(void) animationStop;

-(void)pushViewUp:(UIView*)view upHeight:(NSInteger)upHeight;
-(void)pushViewDown:(UIView*)view downHeight:(NSInteger)downHeight;

-(void)labelTextRun:(UIView*)view;


@end
