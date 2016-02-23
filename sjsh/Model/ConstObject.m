//
//  ConstObject.m
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConstObject.h"

@implementation ConstObject
@synthesize homeViewController;
@synthesize urlArray;
@synthesize dataArray;
@synthesize buttonImageArray;
@synthesize isLogin;
@synthesize telephoneNumber;
@synthesize selectNum;

+ (id)instance {
	static id obj = nil;
	if( nil == obj ) {
		obj = [[self alloc] init];
        
	}
	return obj;	
}

- (id)init {
	if ((self = [super init])) {
	}
  
  return self;
}

- (NSString*)fileTextPath:(NSString*)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

-(void)dealloc
{

    [dataArray release];
    [buttonImageArray release];
    [super dealloc];
}

@end
