//
//  UIWaitingView.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIWaitingView.h"

@implementation UIWaitingView

@synthesize activityView;
@synthesize msg =_msg;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 120, 80)];
        //view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        //view.image = [UIImage imageNamed:@"loading_bg.png"];
        view.image = [[UIImage imageNamed:@"toast80.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        [self addSubview:view];
        [view release];
        activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(141, 161, 37, 37)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _msg = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 120, 30)];
        _msg.backgroundColor = [UIColor clearColor];
        _msg.textColor = [UIColor whiteColor];
        _msg.textAlignment = NSTextAlignmentCenter;
        _msg.text = @"请稍后...";
        [self addSubview:_msg];
        [self addSubview:activityView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
