//
//  CommonModel.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FatherModel.h"
#import "Define.h"
#import "ConstObject.h"



@interface CommonModel : FatherModel

typedef void (^BKHttpCallback)(BOOL isSuccessed, NSDictionary *result);
/**
 *  GET方法请求数据
 *
 *  @param url     请求的URL
 *  @param params  请求参数
 *  @param (BOOL isSuccessed, Result *result))callback  回调方法
 */
+ (void)doGetWithUrl:(NSString *)url path:(NSString *)path params:(NSDictionary *)params callback:(BKHttpCallback) callback;

/**
 *  请求WebService数据
 *
 *  @param baseUrl  请求的基础URL
 *  @param params   请求参数
 *  @param (BOOL isSuccessed, Result *result))callback  回调方法
 */
+ (void)doPostWithUrl:(NSString *)url path:(NSString *)path params:(NSDictionary *)params callback:(BKHttpCallback)callback;

/**
 *  Get方法请求图片
 *
 *  @param url      图片URL
 *  @param (BOOL isSuccessed, Result *result))callback  回调方法
 */
+ (void)getImageWithUrl:(NSString *)url callback:(BKHttpCallback)callback;

- (id)initWithTarget:(id)aDelegate;

//首页最新
- (void)requestNeweest:(NSArray *)anArray
        httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//http://www.sjsh8.cn/index.php?route=mobile/checkout/islogin
- (void)requestCheckLogin:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//登录
- (void)requestLogin:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//注册
- (void)requestRegister:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//验证手机短信验证码
- (void)requestchekey:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;
//完成注册
- (void)requestCompleteRegister:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;
//http://www.sjsh8.cn/index.php?route=mobile/user/qq_login_callback    QQ
- (void)requestCheckQQ_registrt:(NSDictionary *)info
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;
//http://www.sjsh8.cn/index.php?route=mobile/user/wx_login_callback   微信
- (void)requestCheckWX_registrt:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//第三方用户注册
//http://www.sjsh8.cn/index.php?route=mobile/user/thrid_registrt
- (void)requestthrid_registrt:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//第三方用户绑定
//http://www.sjsh8.cn/index.php?route=mobile/user/thrid_bd
- (void)requestthrid_bd:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//找回密码 发送验证码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getpassword
- (void)requestgetpassword:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//检测验证码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/passgetyz
- (void)requestgetpassgetyz:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//修改密码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updatepassword
- (void)requestupdatepassword:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//1.3	更改密码
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/changepasswd
- (void)requestchangepasswd:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//4.8	意见反馈
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/complaints
- (void)requestcomplaints:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//退出
- (void)requestlogout:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//1.5.1	个人资料
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/userinfo
- (void)requestUserinfo:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//1.5.2	更改个人资料
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updateinfo
- (void)requestupdateinfo:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;
//1.5.3	修改头像
//Url:  http://www.sjsh8.cn/index.php?route=mobile/user/upavater
- (void)requestUpdateAvatar:(NSData *)imageData
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//1.8.1	地址列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/address
- (void)requestaddress:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;
//1.8.2	添加地址
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addaddress
- (void)requestaddaddress:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;
//1.8.3	修改地址
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/updateaddress
- (void)requestupdateaddress:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;
//1.8.4	删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/deladdress
- (void)requestdeladdress:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//1.9.1	列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/notice
- (void)requestnotice:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//1.9.2	删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/delnotice
- (void)requestdelnotice:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//1.11.1	评论列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/comment
- (void)requestcomment:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//1.10.1	我的积分
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/mypoints
- (void)requestmypoints:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//4.6	兑换码列表
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getallvcode
- (void)requestgetallvcode:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;
//积分兑换
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/savepo
- (void)requestsavepo:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;


//优惠劵列表(暂时定义接口，参数。目前所有用户还未开通优惠劵，后续推出)
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/getallcoupon
- (void)requestgetallcoupon:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//1.6 收藏
- (void)requestFavorite:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//1.6.1	收藏删除
//http://www.sjsh8.cn/index.php?route=mobile/user/delfavorite

- (void)requestDeleteFavorite:(NSDictionary *)info
           httpRequestSucceed:(SEL)httpRequestSucceed
            httpRequestFailed:(SEL)httpRequestFailed;

//1.6.2	添加
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addfavorite
- (void)requestAddFavorite:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//1.7.1	订单列表
//http://www.sjsh8.cn/index.php?route=mobile/user/order

- (void)requestOrder:(NSDictionary *)info
             httpRequestSucceed:(SEL)httpRequestSucceed
              httpRequestFailed:(SEL)httpRequestFailed;

//1.7.2	订单详情
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/orderinfo
- (void)requestOrderInfo:(NSDictionary *)info
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;


//1.7.3	添加产品评论 (只能在购买了此产品才能添加评论，并且在订单页面点击按钮 )
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/addproductcomment
- (void)requestAddProductComment:(NSDictionary *)info imagedtaList:(NSArray *)dataList
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//2.1	产品分类
- (void)requestShopcategory:(NSString *)categoryId
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

//2.2	商户列表
- (void)requestShoplist:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//2.2	产品列表
- (void)requestProductList:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//商品搜索
//http://www.sjsh8.cn/?route=mobile/product/serch_product
- (void)getCommoditySearch:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//3.2	产品详情
- (void)requestproductview:(NSString *)productId
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//
//3.3	产品描述WEB版
- (void)requestproductdetail:(NSString *)productId
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//3.4	产品评论列表
- (void)requestcommentlist:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//3.5产品分类
//http://www.sjsh8.cn/index.php?route=mobile/home/category_icon
- (void)requestcategory_icon:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//3.2	商户详情
- (void)requestShopDetail:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//产品属性
//Url: http://www.sjsh8.cn/index.php?route= mobile/product/getOption
- (void)requestgetOption:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//4.4	修改购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/updatecart
- (void)requestupdatecart:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//	批量修改购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/update_nums_byid
- (void)requestupdateMultipleCart:(NSDictionary *)info
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//4.0	查看购物车(旧版)
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/cartlist
- (void)requestShowCar:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//4.1	查看购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/cartlist
- (void)requestCartList:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//4.2	添加到购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/product/addtocard
- (void)requestAddtoCart:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//4.3	购物车删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/del
- (void)requestDelFromCart:(NSDictionary *)info
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//4.3	购物车批量删除
//Url: http://www.sjsh8.cn/index.php?route=mobile/cart/delnew
- (void)requestMutableDelFromCart:(NSDictionary *)info
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//返回购物车数量
//http://www.sjsh8.cn/index.php?route= mobile/cart/getcount
- (void)requestgetcount:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//批量添加下单购物车
//http://www.sjsh8.cn/index.php?route=mobile/cartcan/addtocart
- (void)addOrderCartByPost:(NSDictionary *)info
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//下单页购物车列表
//http://www.sjsh8.cn/index.php?route=mobile/cartcan/cartlist
- (void)orderCartListByPost:(NSDictionary *)info
         httpRequestSucceed:(SEL)httpRequestSucceed
          httpRequestFailed:(SEL)httpRequestFailed;

// 修改下单页购物车
//Url: http://www.sjsh8.cn/index.php?route=mobile/cartcan/update_nums_byid
- (void) updateMultipleCartByPost:(NSDictionary *)info
               httpRequestSucceed:(SEL)httpRequestSucceed
                httpRequestFailed:(SEL)httpRequestFailed;

//7.1服务模块广告接口
//http://www.sjsh8.cn/index.php?route=mobile/home
- (void)requestgethome:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//7.2服务模块图标接口
//Url: http://www.sjsh8.cn/index.php?route=mobile/home/fuwu
- (void)requestgetfuwu:(NSDictionary *)info
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;


//首页顶部banner广告
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/index_banner
- (void)getTopBanner:(NSString *)route
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;

//中间banner广告
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/z_banner
- (void)getMiddleBanner:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//首页产品推荐
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/apppro
- (void)getHomeCommodity:(NSString *)route
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//首页商品类别
//Url:http://www.sjsh8.cn/index.php?route=mobile/home_new/home_icon
- (void)getHomeCategory:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;


//个人优惠劵查询
//http://www.sjsh8.cn/index.php?route=mobile/order_new/getforcoupon
- (void)getforcoupon:(NSString *)route
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//使用个人优惠劵
//http://www.sjsh8.cn/index.php?route=mobile/order_new/getforcoupon
- (void)getUseCoupon:(NSString *)counum
  httpRequestSucceed:(SEL)httpRequestSucceed
   httpRequestFailed:(SEL)httpRequestFailed;


//提交购物订单(废弃)
//http://www.sjsh8.cn/index.php?route=mobile/order_new
- (void)postSubmitOrder:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//提交购物订单
//Url: http://www.sjsh8.cn/index.php?route=mobile/order_new/order_new_quest
- (void)submitOrderByPost:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//获取银联流水
//http://www.sjsh8.cn/upmpunionpay/purchase.php
- (void)getUPNumber:(NSString *)orderNumber total:(NSString *)total desc:(NSString *)desc
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//获取银联流水(旧版)
//http://www.sjsh8.cn/index.php?route=mobile/order/unionpay
- (void)getUnionpay:(NSString *)orderNumber desc:(NSString *)desc
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed;
- (void)getUnionpay:(NSDictionary *)info
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed;

//获取服务页内容
//http://www.sjsh8.cn/index.php?route=mobile/home_new/fuwu
- (void)getServerData:(NSString *)parameter
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//获取微信预支付订单
//Url: http://www.sjsh8.cn/weixinsdk/getparid.php
- (void)postWeChatPay:(NSDictionary *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//获取地址的园区
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_xiaoqu
- (void)getGardenData:(NSString *)parameter
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//获取地址的楼号
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_louhao&xiaoqu=%@
- (void)getBuildingData:(NSString *)garden
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//获取地址的单元
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_danyuan&xiaoqu=%@&louhao=%@
- (void)getUnitData:(NSString *)garden building:(NSString *)building
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed;

//获取地址的房间
//http://www.sjsh8.cn/?route=mobile/user/ajax_all_fangjian&xiaoqu=%@&louhao=%@&danyuan=%@
- (void)getRoomData:(NSString *)garden building:(NSString *)building unit:(NSString *)unit
 httpRequestSucceed:(SEL)httpRequestSucceed
  httpRequestFailed:(SEL)httpRequestFailed;

//批量删除地址
//Url: http://sjsh8.cn/index.php?route=mobile/user/deladdress_arr
- (void)deleteAddress:(NSString *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//获取会员卡首页
//http://www.sjsh8.cn/?route=mobile/home_new/vip_index
- (void)getMemberIndexData:(NSString *)garden building:(NSString *)building unit:(NSString *)unit
        httpRequestSucceed:(SEL)httpRequestSucceed
         httpRequestFailed:(SEL)httpRequestFailed;

//优惠券信息
- (void)getCouponData:(NSString *)info
   httpRequestSucceed:(SEL)httpRequestSucceed
    httpRequestFailed:(SEL)httpRequestFailed;

//删除订单
//Url: www.sjsh8.cn/index.php?route=mobile/order_new/order_dele
- (void)deleteOrderById:(NSDictionary *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//- (void)deleteOrderByGet:(NSString *)info
//      httpRequestSucceed:(SEL)httpRequestSucceed
//       httpRequestFailed:(SEL)httpRequestFailed;

//取消订单接口
//http://sjsh8.cn/index.php?route=mobile/order_new/order_close
- (void)cancelOrderById:(NSString *)orderID
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;

//会员卡详细查询
//http://www.sjsh8.cn/index.php?route=mobile/user/member_sjsh8
- (void)getMemberDetail:(NSString *)info
     httpRequestSucceed:(SEL)httpRequestSucceed
      httpRequestFailed:(SEL)httpRequestFailed;


//充值会员卡
//http://www.sjsh8.cn/mobile/order_new/user_member_pay
- (void)getRechargeMember:(NSString *)realName phone:(NSString *)phone payWay:(NSString *)payWay
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//再次支付订单
//http://www.sjsh8.cn/mobile/order_new/order_pay_second
- (void)payOrderSecond:(NSString *)orderID
    httpRequestSucceed:(SEL)httpRequestSucceed
     httpRequestFailed:(SEL)httpRequestFailed;

//会员卡支付
//www.sjsh8.cn/index.php?route=mobile/product/productdetail
- (void)payOrderByMember:(NSString *)orderID
      httpRequestSucceed:(SEL)httpRequestSucceed
       httpRequestFailed:(SEL)httpRequestFailed;

//提交图片
//Url: www.sjsh8.cn/index.php?route=mobile/order_new/order_dele
- (void)submitImageByPost:(NSDictionary *)info
       httpRequestSucceed:(SEL)httpRequestSucceed
        httpRequestFailed:(SEL)httpRequestFailed;

//提交评价
//Url: http://www.sjsh8.cn/index.php?route=mobile/user/send_review
- (void)submitAppraiseByPost:(NSDictionary *)info
          httpRequestSucceed:(SEL)httpRequestSucceed
           httpRequestFailed:(SEL)httpRequestFailed;
@end
