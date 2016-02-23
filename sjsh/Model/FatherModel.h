//
//  FatherModel.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "JSON.h"

@interface FatherModel : NSObject

@property (nonatomic,retain) id modelDelegate;
@property (nonatomic,retain) NSOperationQueue *queue;
@property (nonatomic,retain) ASIHTTPRequest *request;
@property (nonatomic,retain) ASIFormDataRequest *formDataRequest;

- (id)initWithDelegate:(id)delegate;

- (void)cancel; 
-(void)updateCookieWithObject:(NSArray *)object;
- (void)get:(NSString*)aURL 
httpRequestSuccess:(SEL)httpRequestSucceed 
httpRequestFailed:(SEL)httpRequestFailed;


//普通post数据用的
-(void)post:(NSString*)aURL 
 dataString:(NSString*)dataString
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;

//普通post数据用的
-(void)post:(NSString*)aURL 
     params:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;


//传图片用的
- (void)post:(NSString*)aURL 
        data:(NSData*)data 
 extraParams:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;

//传图片用的
- (void)post:(NSString*)aURL 
   dataArray:(NSArray *)data 
 extraParams:(NSDictionary *)params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;


//传头像
- (void)postAvatar:(NSString*)aURL
              data:(NSData *)data
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;

@end
