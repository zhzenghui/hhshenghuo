//
//  UIWaitingView.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWaitingView : UIView{
    UIActivityIndicatorView *activityView;
    UILabel *_msg;
}
@property (nonatomic,readonly)UIActivityIndicatorView *activityView;
@property (nonatomic,readonly)UILabel *msg;

@end
