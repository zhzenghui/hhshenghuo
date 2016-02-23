//
//  WXPayUtil.h
//  sjsh
//
//  Created by savvy on 15/10/30.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXPayUtil : NSObject


- (void)payOrderByWX:(NSMutableDictionary *) myDictionary;//微信支付

@end
