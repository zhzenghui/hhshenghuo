//
//  ErWeiMaViewController.h
//  SelfHelpTravel
//
//  Created by ce on 14-8-30.
//
//

#import <UIKit/UIKit.h>
//#import "ZBarReaderViewController.h"
#import "UITempletViewController.h"
//#import "ZBarSDK.h"

@interface ErWeiMaViewController : UITempletViewController{

    UIImageView *_line;
    NSTimer *timer;
    int num;
    BOOL upOrdown;
}

@end
