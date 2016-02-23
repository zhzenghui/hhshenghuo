//
//  AppraiseViewController.h
//  sjsh
//  评价页面
//  Created by savvy on 15/11/26.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"
#import "DJQRateView.h"
#import "AppraiseEditCell.h"

@interface AppraiseViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AppraiseEditDelegate>

@property(nonatomic,strong) NSMutableArray *appraiseArray;//评价的页面数据
@property(nonatomic,strong) NSString *orderID;              //订单编号
@property(nonatomic,assign) NSInteger  cellPosition;//操作的cell位置
@property(nonatomic,assign) NSInteger  imagePositionOfCell;//操作的cell的图片的位置
@end
