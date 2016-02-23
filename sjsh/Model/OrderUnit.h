//
//  OrderUnit.h
//  Coolading
//
//  Created by bejoy on 15/1/16.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface OrderUnit : NSObject

- (void)payOrder:(Order*)myorder;

/**
 *  订单支付返回
 */
+ (void)depositPaySucessCallBack:(NSDictionary*)dict;

///**
// *  设计定金
// */
//+ (void)desDepositSucess;
///**
// *  施工定金
// */
//+ (void)ctDepositSucess;
///**
// *  产品定金
// */
//+ (void)productionDepositSucess;

@end
