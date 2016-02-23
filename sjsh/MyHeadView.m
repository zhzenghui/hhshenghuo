//
//  MyHeadView.m
//  sjsh
//
//  Created by 杜 计生 on 14/12/13.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyHeadView.h"

@interface MyHeadView()



@end

@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imagePlayerView = [[ImagePlayerView alloc] initWithFrame:self.bounds];
        
        self.imagePlayerView.scrollInterval = 5.0f;
        self.imagePlayerView.autoScroll = YES;
        // adjust pageControl position
        self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
        // hide pageControl or not
        self.imagePlayerView.hidePageControl = NO;
        [self addSubview:self.imagePlayerView];
    }
    return self;
}

@end
