//
//  YHR_PageControl.m
//  sjsh
//
//  Created by savvy on 15/10/20.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "YHR_PageControl.h"

@implementation YHR_PageControl

 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 

//-(float)sizeForNumberOfPages:(NSInteger)pages{
//    return _distanceOfPoint*(pages+1) + _PointSize*pages;
//}

-(void) setNumberOfPages:(NSInteger)pages{
    
    //计算左右两边距
    float distance = (self.frame.size.width-pages*_PointWidth-(pages-1)*_distanceOfPoint)/2;
    
    for (int i = 0; i < pages; i++) {
        UIImageView * pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(distance+_distanceOfPoint +(_distanceOfPoint+_PointWidth)*i, (self.frame.size.height-_PointHeight)/2, _PointWidth, _PointHeight)];
        [self addSubview:pointImageView];
    }
}

- (void) setCurrentPage:(NSInteger)page {
    int countOfPages = [self.subviews count];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < countOfPages; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        if (subviewIndex == page) {
            subview.image = [UIImage imageNamed:@"page_index_red"];
        }else{
            subview.image = [UIImage imageNamed:@"page_index_white"];
        }
    }
}
@end
