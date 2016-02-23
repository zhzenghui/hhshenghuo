//
//  HHAddressEditController.h
//  sjsh
//  地址编辑
//  Created by savvy on 16/2/23.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "UITempletViewController.h"

@interface HHAddressEditController : UITempletViewController<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *dataDictionary;//页面数据
@property(nonatomic ,assign)BOOL idAdd;//是否新增

@end
