//
//  CustomPageControl.m
//  sjsh
//
//  Created by savvy on 15/10/19.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    // allocate two bakground images, one as the active page and the other as the inactive
    self.activeImage = [UIImage imageNamed:@"test_1.jpg"];
    self.inactiveImage = [UIImage imageNamed:@"test_2.jpg"];
    
    return self;
    
}


-(void) updateDots

{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* dotView = [self.subviews objectAtIndex:i];
        UIImageView* dot = nil;
        
        for (UIView* subview in dotView.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView*)subview;
                break;
            }
        }
        
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
            [dotView addSubview:dot];
        }
        
        CGSize size;
        size.height = 40;     //自定义圆点的大小
        size.width = 40;
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
        
        if (i == self.currentPage)
        {
            if(self.activeImage)
                dot.image = self.activeImage;
        }
        else
        {
            if (self.inactiveImage)
                dot.image = self.inactiveImage;
        }
    }
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}


@end