//
//  FatherModel.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FatherModel.h"
#import "ASINetworkQueue.h"
#import "Define.h"


@implementation FatherModel
@synthesize modelDelegate = _modelDelegate;
@synthesize queue = _queue;
@synthesize request = _request;
@synthesize formDataRequest = _formDataRequest;

- (id)initWithDelegate:(id)_delegate
{
    if ( self = [super init] ) {
        _modelDelegate = _delegate;
        [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    }
    return self;
}
- (void)dealloc
{
    if(_modelDelegate){
        _modelDelegate = nil;
    }
    [self cancel];
    
    [super dealloc];
}

- (void)cancel
{
    [[self queue]cancelAllOperations];
    [[self request] clearDelegatesAndCancel];
    [[self formDataRequest] clearDelegatesAndCancel];
    [self setRequest:nil];
    [self setFormDataRequest:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (NSString *)applicationDocmentDirectory
{
    //搜索路径中的目录域
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)cookiePath
{
    return [[self applicationDocmentDirectory] stringByAppendingPathComponent:@"cookie.plist"];
}

-(NSMutableArray *)getCookie
{
    NSMutableArray *cookies=[[NSMutableArray alloc] initWithContentsOfFile:[self cookiePath]];
    if (cookies) {
        NSMutableArray *newCookies = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in cookies) {
            NSMutableDictionary *cookieDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            NSString *value = [dic objectForKey:@"Value"];
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cookieDic setObject:value forKey:@"Value"];
            NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:cookieDic];
            [newCookies addObject:cookie];
        }
        return newCookies;
    }
    return cookies;
}

-(void)updateCookieWithObject:(NSArray *)object
{
    NSMutableArray *cookies=[[NSMutableArray alloc] initWithCapacity:0];
    for (NSHTTPCookie *cookie in object) {
        NSDictionary *cookieDic = cookie.properties;
        NSString *name = [cookieDic objectForKey:@"Name"];
        if ([name isEqualToString:@"Example_sjsh8"]) {
            [cookies addObject:cookieDic];
        }
        
    }
    BOOL flag=[cookies writeToFile:[self cookiePath] atomically:NO];
    if (flag) {
        NSLog(@"cookie save ok");
    }
    else {
        NSLog(@"cookie save fail");
    }
}


- (void)get:(NSString*)aURL 
httpRequestSuccess:(SEL)httpRequestSucceed 
httpRequestFailed:(SEL)httpRequestFailed
{
    NSLog(@"url=%@",aURL);
    NSURL *url = [NSURL URLWithString:aURL];
    [self setRequest:[ASIHTTPRequest requestWithURL:url]];
    [[self request] setShouldAttemptPersistentConnection:NO];
    [[self request] setUseCookiePersistence:YES];
    [[self request] setDelegate:self.modelDelegate];
//    [[self request] setUseCookiePersistence:NO];
//    NSMutableArray *cookies = [self getCookie];
//    if ([cookies count]>0) {
//        [[self request] setRequestCookies:cookies];
//    }

    [[self request] setTimeOutSeconds:15];
    [[self request] setDidFinishSelector:httpRequestSucceed];
    [[self request] setDidFailSelector:httpRequestFailed];
    [[self request] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)post:(NSString*)aURL 
 dataString:(NSString*)dataString
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;
{
//    [self post:aURL 
//          data:[dataString dataUsingEncoding:NSUTF8StringEncoding] 
//   extraParams:nil httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
    NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
//    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:dataString forKey:@"data"];
//    }
    [[self request] setUseCookiePersistence:NO];
    NSMutableArray *cookies = [self getCookie];
    if ([cookies count]>0) {
        [[self request] setRequestCookies:cookies];
    }
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)post:(NSString*)aURL 
     params:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    [[self request] setUseCookiePersistence:NO];
    NSMutableArray *cookies = [self getCookie];
    if ([cookies count]>0) {
        [[self request] setRequestCookies:cookies];
    }

    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)post:(NSString*)aURL 
        data:(NSData *)data 
 extraParams:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    [[self formDataRequest] setData:data withFileName:@"avatar.jpg" andContentType:@"image/jpeg" forKey:@"data"];
    [[self request] setUseCookiePersistence:NO];
    NSMutableArray *cookies = [self getCookie];
    if ([cookies count]>0) {
        [[self request] setRequestCookies:cookies];
    }

    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)post:(NSString*)aURL 
   dataArray:(NSArray *)data 
 extraParams:(NSDictionary *)params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    int i = 0;
    for (NSData *imageData in data) {
        switch (i) {
            case 0:
                [[self formDataRequest] addData:imageData withFileName:@"ImageFromiPhone.jpg" andContentType:@"image/jpeg" forKey:@"upfile"];
                break;
            case 1:
                [[self formDataRequest] addData:imageData withFileName:@"ImageFromiPhone.jpg" andContentType:@"image/jpeg" forKey:@"upfile1"];
                break;
            case 2:
                [[self formDataRequest] addData:imageData withFileName:@"ImageFromiPhone.jpg" andContentType:@"image/jpeg" forKey:@"upfile2"];
                break;

            default:
                break;
        }
        
        i++;
    }
    
    [[self request] setUseCookiePersistence:YES];
//    NSMutableArray *cookies = [self getCookie];
//    if ([cookies count]>0) {
//        [[self request] setRequestCookies:cookies];
//    }

    
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//传头像
- (void)postAvatar:(NSString*)aURL
              data:(NSData *)data
httpRequestSuccess:(SEL)httpRequestSucceed
 httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    [[self formDataRequest] setData:data withFileName:@"avatar.jpg" andContentType:@"image/jpeg" forKey:@"upfile"];
//    [[self formDataRequest] setValue:data forKey:@"data"];
    [[self request] setUseCookiePersistence:NO];
    NSMutableArray *cookies = [self getCookie];
    if ([cookies count]>0) {
        [[self request] setRequestCookies:cookies];
    }

    [[self formDataRequest] setPostBody:[NSMutableData dataWithData:data]];
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

@end
