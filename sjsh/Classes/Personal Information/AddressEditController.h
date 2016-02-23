//
//  AddressEditController.h
//  sjsh
//  地址编辑页面
//  Created by savvy on 15/11/23.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"

@interface AddressEditController : UITempletViewController<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *dataDictionary;//页面数据
@property(nonatomic ,assign)BOOL idAdd;//是否新增

@end
