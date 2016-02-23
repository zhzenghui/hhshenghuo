//
//  PublicClassMethod.h
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicClassMethod : NSObject
+(UIBarButtonItem*)textButtonSetImageAndTarget:(UIViewController*)control andSel:(SEL)action andText:(NSString *)strMessage;
+(UIBarButtonItem*)imageButtonSetImageAndTarget:(UIViewController*)control andSel:(SEL)action  andImage:(UIImage *)image;
+ (NSInteger)cellAccessoryType:(NSString *)typeStr;
@end
