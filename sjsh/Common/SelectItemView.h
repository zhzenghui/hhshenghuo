//
//  SelectItemView.h
//  sjsh
//  选项自定义类
//  Created by savvy on 16/2/22.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectItemViewDelegate <NSObject>

- (void)tappedTheindex:(NSInteger)index;

@end

@interface SelectItemView : UIView

//@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) id<SelectItemViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title index:(NSInteger)index;

@end
