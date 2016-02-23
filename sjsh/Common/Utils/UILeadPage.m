//
//  UILeadPage.m
//  ChuanDaZhi
//
//  Created by nuohuan on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "UIAndAPIDefine.h"
#import "UILeadPage.h"

@implementation UILeadPage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      if (iPhone5){
        explainView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 550)];
        explainView.image = [[UIImage imageNamed:@"explain5.png"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
      }
      else{
        explainView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        explainView.image = [[UIImage imageNamed:@"explain.png"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
      }
        [self addSubview:explainView];
        startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn addTarget:self action:@selector(starts) forControlEvents:UIControlEventTouchUpInside];
        if (iPhone5)
          startBtn.frame = CGRectMake(0, 0, 320, 550);
        else
          startBtn.frame = CGRectMake(0, 0, 320, 460);
      
        [self addSubview:startBtn];
    }
    return self;
}

-(void)starts
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
