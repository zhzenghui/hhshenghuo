//
//  CommonModel.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonModel.h"
#import "StringUtil.h"
#import "JSON.h"
#import "StringUtil.h"
#import "AFHTTPClient.h"
#import "AFImageRequestOperation.h"
#import "JSONKit.h"

@implementation CommonModel

-(id)initWithTarget:(id)aDelegate
{
    if ( self = [super initWithDelegate:aDelegate]){
        
    }
    return self;
}

+ (void)doGetWithUrl:(NSString *)url path:(NSString *)path params:(NSDictionary *)params callback:(BKHttpCallback) callback
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    [httpClient getPath:path
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject){
                    
                    NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    if (responseJson)
                    {
                        NSDictionary *result = [responseJson objectFromJSONString];
                        callback(YES, result);
                    }
                    else
                    {
                        callback(NO, nil);
                    }
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                    callback(NO, nil);
                }];
}

+ (void)doPostWithUrl:(NSString *)url path:(NSString *)path params:(NSDictionary *)params callback:(BKHttpCallback)callback
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient postPath:path
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject){
                     
                     NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     if (responseJson)
                     {
                         NSDictionary *result = [responseJson objectFromJSONString];
                         callback(YES, result);
                     }
                     else
                     {
                         callback(NO, nil);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     callback(NO, nil);
                 }];
}

+ (void)getImageWithUrl:(NSString *)url callback:(BKHttpCallback)callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:request];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIImage *image = responseObject;
        NSDictionary *result = @{@"image":image};
        callback(YES, result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(NO, nil);
    }];
    [requestOperation start];
}

//首页 最新
-(void)requestNeweest:(NSArray *)anArray
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
//      NSString *urlString = [NSString stringWithFormat:kHomePageNeweest,[anArray objectAtIndex:0],[anArray objectAtIndex:1],kCount];
//      urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//      [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//http://www.sjsh8.cn/index.php?route=mobile/checkout/islogin
- (void)requestCheckLogin:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kCheckLogin];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//登陆
- (void)requestLogin:(NSDictionary *)info
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kLogin];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.8	意见反馈
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/complaints
- (void)requestcomplaints:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
//    NSString *urlString = [NSString stringWithFormat:Kcomplaints,[info objectForKey:@"com"],[info objectForKey:@"nums"],[info objectForKey:@"username"]];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString  httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    NSString *urlString = [NSString stringWithFormat:Kcomplaints];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//退出
- (void)requestlogout:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:kLogout];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:nil httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//注册 发送手机短信验证码
- (void)requestRegister:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kRegister];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//验证手机短信验证码
- (void)requestchekey:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kchekey];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//完成注册
- (void)requestCompleteRegister:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:kCompleteRegister];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//http://www.sjsh8.cn/index.php?route=mobile/user/qq_login_callback    QQ
- (void)requestCheckQQ_registrt:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kCheckQQ];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//http://www.sjsh8.cn/index.php?route=mobile/user/wx_login_callback   微信
- (void)requestCheckWX_registrt:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kCheckWX];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//第三方用户注册
//http://www.sjsh8.cn/index.php?route=mobile/user/thrid_registrt
- (void)requestthrid_registrt:(NSDictionary *)info
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kthrid_registrt];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//第三方用户绑定
//http://www.sjsh8.cn/index.php?route=mobile/user/thrid_bd
- (void)requestthrid_bd:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kthrid_bd];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//找回密码 发送验证码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getpassword
- (void)requestgetpassword:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kgetpassword];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//检测验证码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/passgetyz
- (void)requestgetpassgetyz:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kpassgetyz];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.3	更改密码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/changepasswd
- (void)requestchangepasswd:(NSDictionary *)info
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kchangepasswd];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//    NSString *urlString = [NSString stringWithFormat:Kchangepasswd_get,[info objectForKey:@"opasswd"],[info objectForKey:@"npasswd"],[info objectForKey:@"cpasswd"]];
//    NSLog(@"%@",urlString);
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//修改密码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updatepassword
- (void)requestupdatepassword:(NSDictionary *)info
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kupdatepassword];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
//    NSString *urlString = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/user/updatepassword&fpassword=%@&password=%@&phorem=%@",[info objectForKey:@"fpassword"],[info objectForKey:@"password"],[info objectForKey:@"phorem"]];
//    NSLog(@"%@",urlString);
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}


//1.5.1	个人资料
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/userinfo

- (void)requestUserinfo:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KUserInfo];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//1.5.2	更改个人资料
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updateinfo
- (void)requestupdateinfo:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kupdateinfo];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.5.3	修改头像
//Url:  http://www.sjsh8.cn/index.php?route=mobile/user/upavater
- (void)requestUpdateAvatar:(NSData *)imageData
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kupavater];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super postAvatar:urlString data:imageData httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.8.1	地址列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/address
- (void)requestaddress:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kaddress];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//1.8.2	添加地址
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addaddress
- (void)requestaddaddress:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kaddaddress];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//1.8.3	修改地址
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updateaddress
- (void)requestupdateaddress:(NSDictionary *)info
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kupdateaddress];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//1.8.4	删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/deladdress
- (void)requestdeladdress:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kdeladdress];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.9.1	列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/notice
- (void)requestnotice:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KMsg];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.9.2	删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/delnotice
- (void)requestdelnotice:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KdelNotice];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.11.1	评论列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/comment
- (void)requestcomment:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KComment];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}
//1.10.1	我的积分
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/mypoints
- (void)requestmypoints:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kmypoints];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//积分兑换
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/savepo
- (void)requestsavepo:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;
{
    NSString *urlString = [NSString stringWithFormat:KSavepo];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.6	兑换码列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getallvcode
- (void)requestgetallvcode:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KGetallvcode];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//优惠劵列表(暂时定义接口，参数。目前所有用户还未开通优惠劵，后续推出)
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getallcoupon
- (void)requestgetallcoupon:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kGetAllcoupon];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//1.7.1	订单列表
//http://www.sjsh8.cn/index.php?route=mobile/user/order

- (void)requestOrder:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:order];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.6	收藏列表
//http://www.sjsh8.cn/index.php?route=mobile/user/favorite

- (void)requestFavorite:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:favorite];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.6.1	收藏删除
//http://www.sjsh8.cn/index.php?route=mobile/user/delfavorite

- (void)requestDeleteFavorite:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:deletefavorite];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.6.2	添加
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addfavorite
- (void)requestAddFavorite:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kaddfavorite];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.7.2	订单详情
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/orderinfo
- (void)requestOrderInfo:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:orderinfo];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//1.7.3	添加产品评论 (只能在购买了此产品才能添加评论，并且在订单页面点击按钮 )
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addproductcomment
- (void)requestAddProductComment:(NSDictionary *)info imagedtaList:(NSArray *)dataList
              httpRequestSucceed:(SEL)httpRequestSucceed
               httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:addproductcomment];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super post:urlString dataArray:dataList extraParams:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}



- (void)requestShopcategory:(NSString *)categoryId
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kShopcategory,categoryId];
    NSLog(@"%@",urlString);
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}

- (void)requestShoplist:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kShoplist];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//3.2	产品详情
- (void)requestproductview:(NSString *)productId
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kProductview,productId];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//
//3.3	产品描述WEB版
- (void)requestproductdetail:(NSString *)productId
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kWebDescription,productId];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//3.4	产品评论列表
- (void)requestcommentlist:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kCommentlist];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//3.5产品分类
//http://www.sjsh8.cn/index.php?route=mobile/home/category_icon
- (void)requestcategory_icon:(NSDictionary *)info
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kCategory_icon];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//商品列表
- (void)requestProductList:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:kProductList];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}

//商品搜索
//http://www.sjsh8.cn/?route=mobile/product/serch_product
- (void)getCommoditySearch:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:url_commodity_search];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//3.2	商户详情
- (void)requestShopDetail:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:kShopDetail];
//    NSString *urlString = [NSString stringWithFormat:kShoplist];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//产品属性
//Url: http://www.sjsh8.cn/index.php?route=mobile/product/getOption
- (void)requestgetOption:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KgetOption];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.4	修改购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/updatecart
- (void)requestupdatecart:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kupdatecart];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//	批量修改购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/update_nums_byid
- (void)requestupdateMultipleCart:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:update_nums_byid];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

// 修改下单页购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cartcan/update_nums_byid
- (void) updateMultipleCartByPost:(NSDictionary *)info
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:url_update_cart];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}

//4.0	查看购物车(旧版)
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/showcar
- (void)requestShowCar:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:showcar];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.1	查看购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/cartlist
- (void)requestCartList:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:cartlist];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.2	添加到购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/product/addtocart
- (void)requestAddtoCart:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed
{
    NSLog(@"添加到购物车参数%@!!!!!",info);
    
    NSString *urlString = [NSString stringWithFormat:addtocart];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//4.3	购物车删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/del
- (void)requestDelFromCart:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:delFromcart];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@参数为：%@",urlString,info);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//4.3	购物车批量删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/delnew
- (void)requestMutableDelFromCart:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_delnew];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@参数为：%@",urlString,info);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}
//返回购物车数量
//http://www.sjsh8.cn/index.php?route= mobile/cart/getcount
- (void)requestgetcount:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:KcartNum];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//批量添加下单购物车
//http://www.sjsh8.cn/index.php?route=mobile/cartcan/addtocart
- (void)addOrderCartByPost:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_addtocart];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//下单页购物车列表
//http://www.sjsh8.cn/index.php?route=mobile/cartcan/cartlist
- (void)orderCartListByPost:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_order_cartlist];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//7.1服务模块广告接口
//http://www.sjsh8.cn/index.php?route=mobile/home
- (void)requestgethome:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Khome];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//7.2服务模块图标接口
//Url: http://www.sjsh8.cn/index.php?route=mobile/home/fuwu
- (void)requestgetfuwu:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:Kfuwu];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//首页顶部banner广告
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/index_banner
- (void)getTopBanner:(NSString *)route
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:index_banner];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//中间banner广告
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/z_banner
- (void)getMiddleBanner:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:z_banner];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//首页产品推荐
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/apppro
- (void)getHomeCommodity:(NSString *)route
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:apppro];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//首页商品类别
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/home_icon
- (void)getHomeCategory:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:home_icon];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//个人优惠劵查询
//http://www.sjsh8.cn/index.php?route=mobile/order_new/getforcoupon
- (void)getforcoupon:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:get_forcoupon];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}


//使用个人优惠劵
//http://www.sjsh8.cn/index.php?route=mobile/order_new/usercoupon&counum=参数名
- (void)getUseCoupon:(NSString *)counum
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    NSString *urlString = [NSString stringWithFormat:use_coupon,counum];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}




//提交购物订单(全部购物车商品)
//Url: http://www.sjsh8.cn/index.php?route=mobile/order_new
- (void)postSubmitOrder:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:submit_order];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//提交购物订单(选择购物车商品)
//Url: http://www.sjsh8.cn/index.php?route=mobile/order_new/order_new_quest
- (void)submitOrderByPost:(NSDictionary *)info
httpRequestSucceed:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_submit_order];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}




//获取银联流水
//http://www.sjsh8.cn/upmpunionpay/purchase.php
- (void)getUPNumber:(NSString *)orderNumber total:(NSString *)total desc:(NSString *)desc
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed{

    NSString *urlString = [NSString stringWithFormat:purchase,orderNumber,total,desc];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];

}

//获取银联流水(旧版)
//http://www.sjsh8.cn/index.php?route=mobile/order/unionpay
- (void)getUnionpay:(NSString *)orderNumber desc:(NSString *)desc
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:unionpay,orderNumber,desc];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}
- (void)getUnionpay:(NSDictionary *)info
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:unionpayByPost];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取服务页内容
//http://www.sjsh8.cn/index.php?route=mobile/home_new/fuwu
- (void)getServerData:(NSString *)parameter 
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = server;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}


//获取微信预支付订单
//Url: http://www.sjsh8.cn/weixinsdk/getparid.php
- (void)postWeChatPay:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:getparid];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//获取地址的园区
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_xiaoqu
- (void)getGardenData:(NSString *)parameter
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = get_garden;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取地址的楼号
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_louhao&xiaoqu=%@
- (void)getBuildingData:(NSString *)garden
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:get_building,garden];;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取地址的单元
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_danyuan&xiaoqu=%@&louhao=%@
- (void)getUnitData:(NSString *)garden building:(NSString *)building
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:get_unit,garden,building];;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取地址的房间
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_fangjian&xiaoqu=%@&louhao=%@&danyuan=%@
- (void)getRoomData:(NSString *)garden building:(NSString *)building unit:(NSString *)unit
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:get_room,garden,building,unit];;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//批量删除地址
//Url: http://sjsh8.cn/index.php?route=mobile/user/deladdress_arr
- (void)deleteAddress:(NSString *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:delete_address,info];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//获取会员卡首页
//http://www.sjsh8.cn/?route=mobile/home_new/vip_index
- (void)getMemberIndexData:(NSString *)garden building:(NSString *)building unit:(NSString *)unit
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = member_index;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//获取优惠券信息
//http://www.sjsh8.cn/index.php?route=mobile/user/ajax_coupon
- (void)getCouponData:(NSString *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = url_coupon;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}



//删除订单
//Url: www.sjsh8.cn/index.php?route=mobile/order_new/order_dele
- (void)deleteOrderById:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_delete_order];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@参数为%@！！！",urlString,info);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//取消订单接口
//http://sjsh8.cn/index.php?route=mobile/order_new/order_close
- (void)cancelOrderById:(NSString *)orderID
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:url_cancel_order,orderID];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//- (void)deleteOrderByGet:(NSString *)info
//     httpRequestSucceed:(SEL)httpRequestSucceed
//      httpRequestFailed:(SEL)httpRequestFailed{
//
//    NSString *urlString = [NSString stringWithFormat:@"http://www.sjsh8.cn/index.php?route=mobile/order_new/order_dele&order_id=%@",info];
////    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"正在访问：%@",urlString);
//    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
//}

//会员卡详细查询
//http://www.sjsh8.cn/index.php?route=mobile/user/member_sjsh8
- (void)getMemberDetail:(NSString *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = url_member_detail;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}


//充值会员卡
//http://www.sjsh8.cn/mobile/order_new/user_member_pay
- (void)getRechargeMember:(NSString *)realName phone:(NSString *)phone payWay:(NSString *)payWay
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:url_recharge_member,realName,phone,payWay];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//再次支付订单
//http://www.sjsh8.cn/mobile/order_new/order_pay_second
- (void)payOrderSecond:(NSString *)orderID
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:order_pay_second,orderID];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//会员卡支付
//www.sjsh8.cn/index.php?route=mobile/order_new/member_order
- (void)payOrderByMember:(NSString *)orderID
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *urlString = [NSString stringWithFormat:url_productdetail,orderID];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问：%@",urlString);
    [super get:urlString httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
    
}

//提交图片
//Url: www.sjsh8.cn/index.php?route=mobile/order_new/order_dele
- (void)submitImageByPost:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_image_submit];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"正在访问提交图片：%@参数为%@！！！",urlString,info);
     NSLog(@"正在访问提交图片：%@",urlString);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

//提交评价
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/send_review
- (void)submitAppraiseByPost:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *urlString = [NSString stringWithFormat:url_appraise_submit];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"正在访问评价图片：%@参数为%@！！！",urlString,info);
    [super post:urlString params:info httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

@end
