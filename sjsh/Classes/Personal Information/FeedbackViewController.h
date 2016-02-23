//
//  FeedbackViewController.h
//  sjsh
//
//  Created by 杜 计生 on 14/11/15.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

@interface FeedbackViewController : UITempletViewController<UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    UITextField *textF1;
    UITextField *textF2;
    UITextView *FBTextV;
    UIButton *commitB;
}
@end
