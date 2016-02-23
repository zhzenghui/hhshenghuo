//
//  UIAndAPIDefine.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef ChuanDaZhi_UIAndAPIDefine_h
#define ChuanDaZhi_UIAndAPIDefine_h
#define kVersionNum 1.0

#pragma mark-----------------------------------------------------------------------------------------
#pragma mark -- API
#pragma mark-----------------------------------------------------------------------------------------
//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] applicationFrame]
//iPhone5 定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//新浪微博分享
#define kSinaShareAPI   @"https://upload.api.weibo.com/2/statuses/upload.json"


//统计相关
//应用首次启动
#define kApplicationInitial    @"http://push.hers.cn/record/initial?app=iphone&type=3&uid=%@&source=%@&md5=%@"
//应用启动
#define kApplicationRun    @"http://push.hers.cn/record/run?app=iphone&type=3&uid=%@&source=%@&md5=%@"
//应用停止
#define kApplicationStop    @"http://push.hers.cn/record/stop?app=iphone&type=3&uid=%@&md5=%@"
//应用挂起
#define kApplicationBack    @"http://push.hers.cn/record/back?app=iphone&type=3&uid=%@&md5=%@"
//应用激活
#define kApplicationFront    @"http://push.hers.cn/record/front?app=iphone&type=3&uid=%@&md5=%@"




#pragma mark-----------------------------------------------------------------------------------------
#pragma mark -- 一些组件高度
#pragma mark-----------------------------------------------------------------------------------------
#define kNavBarHeight           44

//可显示区域+navBar
#define kMainScreenRect     CGRectMake(0,0,320,460)
//可显示区域——navBar
#define kShowViewRect       CGRectMake(0,0,320,460-kNavBarHeight)


#pragma mark-----------------------------------------------------------------------------------------
#pragma mark -- 固定图片名称
#pragma mark-----------------------------------------------------------------------------------------

#define kNavBarLeftImage      @".png"
#define kNavBarRightImage     @".png"

#define kBgColor 

#define kDaliyCache                 @"daliy.plist"
#define kNewCache                   @"new.plist"
#define KModelCache                 @"model.plist"
#define kModelDetailEuropeCache     @"modeleurope.plist"
#define kModelDetailAsiaCache       @"modelasia.plist"
//#define kShowDetailCache            @"detail%@.plist"
#define tHistory_Path     @"history.plist"
#define tMyPro_Path     @"mypro.plist"

#define kDaliyPath    [[ConstObject instance] fileTextPath:kDaliyCache]
#define kNewPath    [[ConstObject instance] fileTextPath:kNewCache]
#define KModelPath    [[ConstObject instance] fileTextPath:KModelCache]
#define kModelDetailEuropePath    [[ConstObject instance] fileTextPath:kModelDetailEuropeCache] 
#define kModelDetailAsiaPath    [[ConstObject instance] fileTextPath:kModelDetailAsiaCache] 
//#define kShowDetailPath    [[ConstObject instance] fileTextPath:kShowDetailCache]
#define kEgoPath       


#define kWBSDKDemoAppKey  @"2163738590"
#define kWBSDKDemoAppSecret @"98416cebc77904f8ca31635e0a514d68"

#endif

