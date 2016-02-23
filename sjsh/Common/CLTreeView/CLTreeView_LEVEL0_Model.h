//
//  CLTreeView_LEVEL0_Model.h
//  CLTreeView
//
//  Created by 钟由 on 14-9-9.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTreeView_LEVEL0_Model : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *result;//选择结果
//@property (strong,nonatomic) NSURL *headImgUrl;//远程图片链接
@property (strong,nonatomic) NSString *option_id;
@property (strong,nonatomic) NSArray *option_value;
@property (strong,nonatomic) NSString *product_option_id;
@end

