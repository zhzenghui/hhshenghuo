//
//  CommonUtil.m
//  sjsh
//
//  Created by savvy on 15/12/8.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

// 将字典或者数组转化为JSON串
+ (NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}
@end
