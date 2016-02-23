//
//  ImageEditViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14/11/25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"

@protocol imageEditDelegate <NSObject>

- (void)resetImageWithIndex:(NSInteger)index;

@end

@interface ImageEditViewController : UITempletViewController<UIScrollViewDelegate>
{
    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
}
@property (nonatomic, retain) NSArray *imageList;
@property (nonatomic, retain) UIScrollView *scrollview;
@property (nonatomic, assign) id<imageEditDelegate>delegate;
@end
