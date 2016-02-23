//
//  CategoryItem.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/14.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "CategoryItem.h"

@interface CategoryItem()

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *arrowImagview;

@end
@implementation CategoryItem
- (id)initWithFrame:(CGRect)frame Image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title index:(NSInteger)index
{
    self = [super initWithFrame:frame];//59*65
    if (self) {
        // Initialization code
        self.selectedImage = selectedImage;
        self.index = index;
        self.image = image;
        self.clipsToBounds = NO;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(13.0f, 9.0f, 32.0f, 32.0f)];
        imgV.backgroundColor = [UIColor clearColor];
        imgV.userInteractionEnabled = YES;
        imgV.image = image;
        self.iconImage = imgV;
        self.selected = NO;
        
        [self addSubview:self.iconImage];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 42.0f, 59.0f, 15.0f)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.numberOfLines = 1;
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [UIColor colorWithRed:0x2d/255.0f green:0x2d/255.0f blue:0x2d/255.0f alpha:1];
        _title.text = title;
        _title.font = [UIFont fontWithName:@"Arial" size:10.0f];
        [self addSubview:_title];
        [_title release];
        
        UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(59-4.0f, 28.0f, 7.0f, 9.0f)];
        imgV1.backgroundColor = [UIColor clearColor];
        imgV1.userInteractionEnabled = YES;
        imgV1.image = [UIImage imageNamed:@"sanjiao"];
        [self addSubview:imgV1];
        self.arrowImagview = imgV1;
        imgV1.hidden = YES;
        
        UIView *lineImage = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 62, 1)];
        lineImage.backgroundColor = COLOR(0xc7, 0xc7, 0xc7);
        [self addSubview:lineImage];
        [lineImage release];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
        gesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:gesture];
    }
    return self;
}

- (void)itemTapped:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (_delegate && [_delegate respondsToSelector:@selector(tappedTheindex:)]) {
            [_delegate tappedTheindex:_index];
        }
    }
    
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        if (_selected) {
            return;
        }
        self.iconImage.image = self.selectedImage;
        self.title.textColor = [UIColor colorWithRed:0xfa/255.0f green:0x63/255.0f blue:0x38/255.0f alpha:1];
        self.backgroundColor = COLOR(0xff, 0xf9, 0xf7);
        self.arrowImagview.hidden = NO;
    }
    else {
        self.iconImage.image = self.image;
        self.title.textColor = [UIColor colorWithRed:0x2d/255.0f green:0x2d/255.0f blue:0x2d/255.0f alpha:1];
        self.backgroundColor = COLOR(0xf8, 0xf8, 0xf8);
        self.arrowImagview.hidden = YES;
    }
    _selected = selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
