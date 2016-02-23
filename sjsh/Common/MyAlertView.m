//
//  MyAlertView.m
//  sjsh
//
//  Created by savvy on 15/8/7.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:self.frame];
        titleLabel.text=@"已成功添加到购物车";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self addSubview:titleLabel];
    
    }
    return self;
}

@end
