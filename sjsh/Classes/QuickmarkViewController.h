//
//  QuickmarkViewController.h
//  sjsh
//
//  Created by savvy on 15/12/24.
//  Copyright © 2015年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import <AVFoundation/AVFoundation.h>

typedef void (^FinishingBlock)(NSString *string);
//二维码识别页面
@interface QuickmarkViewController : UITempletViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    FinishingBlock _finishingBlock;
    UIView *_scanLayer;
}

- (void)turnLight:(BOOL)open;
- (void)finishingBlock:(FinishingBlock)finishingBlock;
@end
