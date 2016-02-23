//
//  UIViewsAnimation.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewsAnimation.h"

static UIViewsAnimation* animationInstance;

@implementation UIViewsAnimation

//单实例
+(UIViewsAnimation*) sharedInstance
{
    if (nil == animationInstance)
    {
        animationInstance = [[self alloc] init];
    }
    return animationInstance;
}

-(void) pushInAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView
{
    
    CGRect newFrame = newView.frame;
    newFrame.origin.x = 320;
    newView.frame = newFrame;
    newFrame.origin.x = 0;
    [superView addSubview:newView];
    
    CGRect oldFrame = oldView.frame;
    oldFrame.origin.x = -320;
    changedView = oldView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    
    oldView.frame = oldFrame;
    newView.frame = newFrame;
    
    [UIView commitAnimations];
}

-(void) pushOutAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView
{
    
    CGRect newFrame = newView.frame;
    newFrame.origin.x = -320;
    newView.frame = newFrame;
    newFrame.origin.x = 0;
    [superView addSubview:newView];
    
    CGRect oldFrame = oldView.frame;
    oldFrame.origin.x = 320;
    changedView = oldView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    
    oldView.frame = oldFrame;
    newView.frame = newFrame;
    
    [UIView commitAnimations];
}

-(void) animationStop
{
    ////NSLog(@(@"%@", @"animationStop");
    CGRect rect = changedView.frame;
    rect.origin.x = 0;
    changedView.frame = rect;
    [changedView removeFromSuperview];
    changedView = nil;
}

-(void) flipInAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView
{
    [UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:superView cache:YES];
    
	[oldView removeFromSuperview];
    [superView addSubview:newView];
	[UIView commitAnimations];
}

-(void) flipOutAnimation:(UIView*)superView newView:(UIView*)newView oldView:(UIView*)oldView
{
    [UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:superView cache:YES];	 
    
    [oldView removeFromSuperview];
    [superView addSubview:newView];
	[UIView commitAnimations];
}

-(void)pushViewUp:(UIView *)view upHeight:(NSInteger)upHeight{
    CGRect newRect = view.frame;
    newRect.origin.y -= upHeight;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    
    view.frame = newRect;
    [UIView commitAnimations];
}

-(void)pushViewDown:(UIView *)view downHeight:(NSInteger)downHeight{
    
    CGRect newRect = view.frame;
    newRect.origin.y += downHeight;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    
    view.frame = newRect;
    [UIView commitAnimations];
    
}

-(void)labelTextRun:(UIView*)view{
    CGRect rect = view.frame;
    rect.origin.x = -rect.size.width;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:15.3];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:9999999];
    [UIView setAnimationRepeatAutoreverses:NO];
    view.frame = rect;
    [UIView commitAnimations];
}


@end
