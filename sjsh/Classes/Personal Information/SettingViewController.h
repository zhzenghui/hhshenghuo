//
//  SettingViewController.h
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "SettingViewCell.h"

//@protocol settingDelegate <NSObject>
//
//-(void)logoutToLoginVC;
//
//@end

@interface SettingViewController : UITempletViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *settingTableView;
    UIImageView *backImageView;
}
//@property (nonatomic,assign) id<settingDelegate>delegate;
@end
