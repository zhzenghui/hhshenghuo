//
//  Message.h
//  NetWork
//
//  Created by mbp  on 13-8-2.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DXAlertView.h"

@interface Message : NSObject {
}

@property(nonatomic, assign) id<UIAlertViewDelegate> delegate;

+ (id)share;

+ (void)messageDXAlert:(NSString*)message;
+ (void)messageDXAlert:(NSString*)message title:(NSString*)title;

+ (DXAlertView*)messageDXAlert:(NSString*)message
                     leftTitle:(NSString*)leftTitle
                    rightTitle:(NSString*)rightTitle;
+ (void)messageAlert:(NSString*)message delegate:(id)delegate;

+ (void)messageAlert:(NSString*)message;

+ (void)messagePrompt:(NSString*)message;
+ (void)messageTip:(NSString*)message;

@end

@protocol MessageDelegate<NSObject>
@optional

@end
