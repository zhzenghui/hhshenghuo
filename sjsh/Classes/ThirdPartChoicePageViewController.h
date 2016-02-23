//
//  ThirdPartChoicePageViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/12/21.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"

typedef enum : NSUInteger {
    WXLogin,
    QQ_LOGIN,
} ThirdPartType;
@interface ThirdPartChoicePageViewController : UITempletViewController
@property (nonatomic, assign) ThirdPartType type;
@property (nonatomic, retain) NSDictionary *transforDic;
@end
