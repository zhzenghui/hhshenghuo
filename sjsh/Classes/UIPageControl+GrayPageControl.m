//
//  UIPageControl+GrayPageControl.m
//  XHPathCover
//
//  Created by 杜 计生 on 14-8-20.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "UIPageControl+GrayPageControl.h"

@implementation GrayPageControl
//-(id) initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//
//    activeImage = [[UIImage imageNamed:@"RedPoint.png"] retain];
//    inactiveImage = [[UIImage imageNamed:@"BluePoint.png"] retain];
//
//    return self;
//}
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    activeImage = [[UIImage imageNamed:@"pagecontrol_current"] retain];
//    inactiveImage = [[UIImage imageNamed:@"pagecontrol_white"] retain];
    self.backgroundColor = [UIColor clearColor];
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)iRect
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    int i;
    CGRect rect;
    
    
    iRect = self.bounds;
    
    if (self.opaque) {
        [self.backgroundColor set];
        UIRectFill(iRect);
    }
    
    UIImage *_activeImage = [UIImage imageNamed:@"pagecontrol_current"];
    UIImage *_inactiveImage = [UIImage imageNamed:@"pagecontrol_white"];
    CGFloat _kSpacing = 5.0f;
    
    if (self.hidesForSinglePage && self.numberOfPages == 1) {
        return;
    }
    
    rect.size.height = _activeImage.size.height;
    rect.size.width = self.numberOfPages * _activeImage.size.width + (self.numberOfPages - 1) * _kSpacing;
    rect.origin.x = floorf((iRect.size.width - rect.size.width) / 2.0);
    rect.origin.y = floorf((iRect.size.height - rect.size.height) / 2.0);
    rect.size.width = _activeImage.size.width;
    
    for (i = 0; i < self.numberOfPages; ++i) {
        UIImage *image = (i == self.currentPage) ? _activeImage : _inactiveImage;
        [image drawInRect:rect];
        rect.origin.x += _activeImage.size.width + _kSpacing;
    }
}
@end

