//
//  ConstObject.h
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstObject : NSObject{

}

@property (nonatomic, retain) UIViewController *homeViewController;
@property (nonatomic, retain) NSMutableArray *urlArray;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *buttonImageArray;
@property (nonatomic, assign) BOOL isLogin;//判断是否登录
@property (nonatomic, retain) NSString *telephoneNumber;//电话号码
@property (nonatomic, assign) int selectNum;//被选中的序号
@property (nonatomic, retain) UIViewController *vc;
@property (nonatomic, assign) NSInteger cartNum;
@property (nonatomic, retain) NSString *categoryId;
//单例
+ (id)instance;

//获取文件目录
- (NSString*)fileTextPath:(NSString*)fileName;

@end
