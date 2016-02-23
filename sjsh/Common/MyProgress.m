//
//  MyProgress.m
//  sjsh
//
//  Created by savvy on 15/10/29.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MyProgress.h"
#import "SVProgressHUD.h"

@implementation MyProgress




////自定义进度框
////type  1:允许交互
////      2：不允许操作
////      3：不允许交互，界面整体变暗
////      4:不允许交互，界面渐变暗
//class func showWithMaskType(type: Int!){
//    //     SVProgressHUD.showSuccessWithStatus(string)
//    var ProgressType:SVProgressHUDMaskType
//    switch(type){
//        case 1:
//            ProgressType=SVProgressHUDMaskType.None
//        case 2:
//            ProgressType=SVProgressHUDMaskType.Clear
//        case 3:
//            ProgressType=SVProgressHUDMaskType.Black
//        case 4:
//            ProgressType=SVProgressHUDMaskType.Gradient
//        default:
//            ProgressType=SVProgressHUDMaskType.None
//    }
//    SVProgressHUD.showWithMaskType(ProgressType)
//}
//
////进度条消失
//class func dismiss(){
//    SVProgressHUD.dismiss()
//}
//
////成功提示框
//class func showSuccessInfo(string: String!){
//    SVProgressHUD.setBackgroundColor(UIColor(red: 0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8))
//    SVProgressHUD.setForegroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0))
//    SVProgressHUD.showSuccessWithStatus(string)
//}
//
////失败提示框
//class func showErrorInfo(string: String!){
//    SVProgressHUD.showErrorWithStatus(string)
//}

@end
