//
//  MoreCell.h
//  hersForum
//
//  Created by hers on 12-12-12.
//  Copyright (c) 2012年 hers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreCell : UITableViewCell{

    UILabel                      *tipLabel;
    UIActivityIndicatorView      *actView;
    
}

- (void)startAction;
- (void)stopAction;
- (void)setTips:(NSString *)aTip;


@end
