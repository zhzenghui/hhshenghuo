//
//  PublicClassMethod.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "PublicClassMethod.h"

@implementation PublicClassMethod
+(UIBarButtonItem*)textButtonSetImageAndTarget:(UIViewController*)control andSel:(SEL)action andText:(NSString *)strMessage
{
    UIButton *otherButton = [[UIButton alloc]initWithFrame:CGRectMake(OTHERBTN_X,OTHERBTN_Y,OTHERBTN_WEITH*2+10,OTHERBTN_HIGHT)];
    
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [otherButton setTitle:strMessage forState:UIControlStateNormal];
    [otherButton addTarget:control action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:otherButton];
    
    return backItem;
}
+(UIBarButtonItem*)imageButtonSetImageAndTarget:(UIViewController*)control andSel:(SEL)action  andImage:(UIImage *)image
{
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setFrame:CGRectMake(BACK_X,BACK_Y,BACK_WEITH,BACK_HIGHT)];
    
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:control action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    return backItem;
}

+ (NSInteger)cellAccessoryType:(NSString *)typeStr
{
    if ([typeStr isEqualToString:CellAccessoryNone]) {
        return UITableViewCellAccessoryNone;
    }
    else if ([typeStr isEqualToString:CellAccessoryDisclosureIndicator]) {
        return UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([typeStr isEqualToString:CellAccessoryDetailDisclosureButton]) {
        return UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if ([typeStr isEqualToString:CellAccessoryCheckmark]) {
        return UITableViewCellAccessoryCheckmark;
    }
    return UITableViewCellAccessoryNone;
}

@end
