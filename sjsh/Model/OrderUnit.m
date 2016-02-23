//
//  OrderUnit.m
//  Coolading
//  支付宝支付工具类
//  Created by bejoy on 15/1/16.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import "OrderUnit.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
//#import "IBJProduct.h"
#import "DataSigner.h"

#import "DataVerifier.h"
//#import "UserSettingInfo.h"

@implementation OrderUnit

+ (void)setOrderStatus {
  //    设置订单信息

  //    通知界面更改

  //    用户提示
}

+ (void)depositPaySucessCallBack:(NSDictionary*)callBackDict {
  NSString* s = callBackDict[
      @"result"];  //@"partner=\"2088811008252887\"&seller_id=\"lifeng@coolading.com\"&out_trade_no=\"0HBD4O4MWM7KWB2\"&subject=\"产品定金\"&body=\"产品定金\"&total_fee=\"0.01\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&show_url=\"m.alipay.com\"";

  if ([s isEqualToString:@""]) {
    return;
  }
  NSArray* a = [s componentsSeparatedByString:@"&"];

  NSMutableDictionary* dict = [NSMutableDictionary dictionary];
  for (NSString* ss in a) {
    NSArray* aa = [ss componentsSeparatedByString:@"="];
    NSString* key = aa[0];
    NSString* value = aa[1];
    value = [value stringByReplacingOccurrencesOfString:@"\\\"" withString:@""];
    [dict setValue:value forKey:key];
  }

//  NSString* body = dict[@"body"];
//  DLog(@"%@", body);
 
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"payAlipaySuccessBack"
     object:nil];
  
}

////支付成功后的通知
//[[NSNotificationCenter defaultCenter] addObserver:self
//selector:@selector(payProductSuccessBack) name:@"payProductSuccessBack"
//object:nil];
//[[NSNotificationCenter defaultCenter] addObserver:self
//selector:@selector(payDesSuccessBack) name:@"payDesSuccessBack" object:nil];
//[[NSNotificationCenter defaultCenter] addObserver:self
//selector:@selector(payCtSuccessBack) name:@"payCtSuccessBack" object:nil];
//    设置订单信息

//    通知界面更改

//    用户提示
+ (void)ctDepositSucess {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"payCtSuccessBack"
                                                      object:nil];
}

+ (void)productionDepositSucess {
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"payProductSuccessBack"
                    object:nil];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"payProductSuccess"
                    object:nil];
}

+ (void)depositPaySucess {
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"payDesSuccessBack"
                    object:nil];
}

#pragma - alipay

- (NSString*)generateTradeNO {
  static int kNumber = 15;

  NSString* sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  NSMutableString* resultStr = [[NSMutableString alloc] init];
  //    srand(time(0));
  for (int i = 0; i < kNumber; i++) {
    unsigned index = rand() % [sourceStr length];
    NSString* oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
    [resultStr appendString:oneStr];
  }
  return resultStr;
}

- (void)signVerfier {
  //    NSString *resultdd =
  //    @"partner=\"2088611796017381\"&seller_id=\"zenghui@i-bejoy.com
  //    \"&out_trade_no=\"FGG31MU1XRO9FZN\"&subject=\"1\"&body=\"ddd\"&total_fee=\"0.01\"&notify_url=\"http://www.xxx.com\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&show_url=\"m.alipay.com\"&success=\"true\"&sign_type=\"RSA\"&sign=\"Gb3iwXjgnN9OswhJTeQKWiw250faEoOcHKWpcfdflni0utwk23CpiZfhfNq3ms/t/1WepkM45+YobU687+wiErp1GnlXsQgo03zKCHGCR0cw830V9RTOv+90jPlKDSvAqRCuSnzPE9vO/T8sW5bKWAKR6vRTgwiiBgP8c2Hh/Qk=\"";

  NSString* publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQD5BEf/"
                        @"3z+ESQP+8QzBZCEzU7yj8xeVfybGgzOqYHuK+"
                        @"z5SHJcUMsQG5vtUhCDV33wI2yO4J4CuWGfVPh8M3CgpuoJ1Q/"
                        @"mbHrGOoJMFYbck1ViyVMDLgxn+mNb8+"
                        @"BfoeWWsHYKS7AYld444pSYWwNXVy9GCpOgvtAbbgwZqa1WNSwIDA"
                        @"QAB";

  id<DataVerifier> verfier = CreateRSADataVerifier(publicKey);

  BOOL b = [verfier
      verifyString:@"dd"
          withSign:@"Gb3iwXjgnN9OswhJTeQKWiw250faEoOcHKWpcfdflni0utwk23CpiZfhfN"
                   @"q3ms/t/"
                   @"1WepkM45+YobU687+wiErp1GnlXsQgo03zKCHGCR0cw830V9RTOv+"
                   @"90jPlKDSvAqRCuSnzPE9vO/T8sW5bKWAKR6vRTgwiiBgP8c2Hh/Qk="];

  NSLog(b ? @"Yes" : @"No");
}

/**
 *  product
 */
- (void)payOrder:(Order*)myorder {
  /*
   *点击获取prodcut实例并初始化订单信息
   */
  //    IBJProduct *product = [[IBJProduct alloc] init]; //[self.productList
  //    objectAtIndex:indexPath.row];
  //    product.subject = @"subject";
  //    product.body = @"body";
  //    product.price = .01;
  /*
   *商户的唯一的parnter和seller。
   *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
   */

  /*============================================================================*/
  /*=======================需要填写商户app申请的===================================*/
  /*============================================================================*/
  NSString* partner = @"2088311228128442";
  NSString* seller = @"shijishenghuo@qq.com";
  NSString* privateKey =
     @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJxVJUvS3uA59+D6nNF/RF5EoH+WKhTPETBhvIhnwGFgGbIHsFPCdFH7V/TBTRG0tKHe3ZjJfLSG2jDKjtfeFCRc12iRpcXLm/ARdBeZUtrIA0uQImV2/1WlrrY35Pf5coVQqb8B4ucUoOzXEHnesDRt/xhK35Exbws1X6HatDeDAgMBAAECgYBGuP42Xx8UsSTCUp2+6KQ1QTaagYRoBYTxLkXsL4OIicEWGQRb4AxfSiVwREJpUCanU/tLs1sHEDqE+B3G6mCRnasPieL0x26gIbvH0Rn9p/TbiGYcQ6wXc18GqzHwhqKXJTrH61iBuYgcs5OwnUX4hD+FILebzEH4nzG31DMCAQJBAMoMDTVBj/95yJfD5S9K1UfLAJpN2u3GMwEg3FOIQQ5hKV1yaW6Xf6Ojoj1W++N7Wo0ppEdP+xtDlVE9419bOtECQQDGFAzYtXTYH5oj7gHy7TrzJIGxbf2IvI/tcZS6Azo6nihZ2SM7+jHR44p3C2GmvL62Nn6mVbrNYbaJjSrhw7oTAkEAt4fo+4ZZklyCjPFiHupgAH3zRzcPdktCi3TZDnvHdJNnqr3B7bZqOC/ssMFxv3qOj4nS8wBA/cwPN6P7BORu8QJAMopXJMxX/fVCTTyjfqqNShDcjrsz37nNN5atjjDYoLBON26yENGr+JQIdouO5Q5v0upgsmxZd6IhA0Pj1ysrxQJACc4OSncoVBTgpB4Eu+OVoIxqH4rhH7E3q4boJUd5yXkZhzHAQLyMmtpbG4FejaEhOJd5pwtQWWRFmt77MA1eDA==";  /*============================================================================*/
  /*============================================================================*/
  /*============================================================================*/

  // partner和seller获取失败,提示
  if ([partner length] == 0 || [seller length] == 0) {
    UIAlertView* alert =
        [[UIAlertView alloc] initWithTitle:@"提示"
                                   message:@"缺少partner或者seller。"
                                  delegate:self
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:nil];
    [alert show];
    return;
  }

  /*
   *生成订单信息及签名
   */
  //将商品信息赋予AlixPayOrder的成员变量
  myorder.partner = partner;
  myorder.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
#if DEBUG
  myorder.amount = [NSString stringWithFormat:@"%.2f", .01];  //商品价格
#endif

  //    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//  myorder.service = @"mobile.securitypay.pay";
//  myorder.paymentType = @"1";
//  myorder.inputCharset = @"utf-8";
//  myorder.itBPay = @"30m";
//  myorder.showUrl = @"m.alipay.com";
    

  //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
   NSString *appScheme = @"sjshAlipay";
  //将商品信息拼接成字符串
  NSString* orderSpec = [myorder description];
     NSLog(@"支付宝支付orderSpec = %@！！！！",orderSpec);
//  DLog(@"orderSpec = %@", orderSpec);

  //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
  id<DataSigner> signer = CreateRSADataSigner(privateKey);
  NSString* signedString = [signer signString:orderSpec];

  //将签名成功字符串格式化为订单字符串,请严格按照该格式
  NSString* orderString = nil;
  if (signedString != nil) {
    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                             orderSpec, signedString, @"RSA"];

    [[AlipaySDK defaultService] payOrder:orderString
                              fromScheme:appScheme
                                callback:^(NSDictionary* resultDic) {
//                                  DLog(@"reslut = %@", resultDic);
                                }];

    //        [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
}







@end
