//
//  CustomNavigationBar.h
//  ChuanDaZhi
//
//  Created by nuohuan on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomNavigationBar : UINavigationBar

@end

@implementation CustomNavigationBar

- (void)drawRect:(CGRect)rect;
{
    [super drawRect:CGRectMake(0, -3, self.frame.size.width, self.frame.size.height + 5.5f)];
}
@end

@implementation UINavigationBar (custom)

+ (Class)class
{
    return NSClassFromString(@"CustomNavigationBar");
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    UIImage *backImage = [[UIImage imageNamed:@"topBarBg.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [backImage drawInRect:CGRectMake(0, -3, self.frame.size.width, self.frame.size.height + 5.5f)];
}

@end


