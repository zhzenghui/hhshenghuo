//
//  ForgetPWViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/11/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

typedef enum : NSUInteger {
    forgetPage1,
    forgetPage2,
    forgetPage3,
} forgetPage;

@interface ForgetPWViewController : UITempletViewController
{
    
}
@property (nonatomic, assign) forgetPage page;
@property (nonatomic, retain) UITextField *TextField1;
@property (nonatomic, retain) UITextField *TextField2;
@property (nonatomic, retain) NSArray *params;
@end
