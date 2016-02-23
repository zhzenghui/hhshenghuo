//
//  CheckNetwork.m
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckNetwork.h"
#import "ConstObject.h"
#import "Reachability.h"
 
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;        
            break;
        default:
            isExistenceNetwork = FALSE;
            break;
    }
//	if (!isExistenceNetwork) {
////        if(![[ConstObject instance] ifHasCheckNet]){
////		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:nil message:@"网络无法连接，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
////		[myalert show];
////		[myalert release];
////        }
//
//	}
	return isExistenceNetwork;
}

+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

@end
