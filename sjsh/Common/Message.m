//
//  Message.m
//  NetWork
//
//  Created by mbp  on 13-8-2.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "Message.h"

static Message* message;
@implementation Message

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

+ (id)share {
  if (message) {
    return message;
  }
  message = [[Message alloc] init];
  return message;
}

+ (void)messageDXAlert:(NSString*)message {
  DXAlertView* alert = [[DXAlertView alloc] initWithTitle:@"提示"
                                              contentText:message
                                          leftButtonTitle:nil
                                         rightButtonTitle:@"好"];
  [alert show];
}

+ (void)messageDXAlert:(NSString*)message title:(NSString*)title {
  DXAlertView* alert = [[DXAlertView alloc] initWithTitle:title
                                              contentText:message
                                          leftButtonTitle:nil
                                         rightButtonTitle:@"好"];
  [alert show];
}

+ (DXAlertView*)messageDXAlert:(NSString*)message
                     leftTitle:(NSString*)leftTitle
                    rightTitle:(NSString*)rightTitle {
  DXAlertView* alert = [[DXAlertView alloc] initWithTitle:@"提示"
                                              contentText:message
                                          leftButtonTitle:leftTitle
                                         rightButtonTitle:rightTitle];

  [alert show];

  return alert;
}

+ (void)messageAlert:(NSString*)message {
  UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:message
                                              delegate:nil
                                     cancelButtonTitle:@"好"
                                     otherButtonTitles:nil];

  [av show];
}

+ (void)messageAlert:(NSString*)message delegate:(id)delegate {
  UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:message
                                              delegate:delegate
                                     cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"确定", nil];

  [av show];
}

+ (void)messagePrompt:(NSString*)message {
}

+ (void)messageTip:(NSString*)message {
}

@end
