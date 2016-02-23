//
//  CategoryItem.h
//  sjsh
//
//  Created by 计生 杜 on 14/12/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CategoryItemDelegate <NSObject>

- (void)tappedTheindex:(NSInteger)index;

@end
@interface CategoryItem : UIView
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) id<CategoryItemDelegate>delegate;
- (id)initWithFrame:(CGRect)frame Image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title index:(NSInteger)index;
@end
