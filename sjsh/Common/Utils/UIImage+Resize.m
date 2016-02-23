//
//  UIImage+Resize.m
//  BeautyMakeup
//
//  Created by nuohuan on 13-12-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)resizeImageSize:(CGSize)newSize{
    CGRect drawRect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    CGFloat imageRatio = self.size.width / self.size.height;
    CGFloat newSizeRatio = newSize.width / newSize.height;
    
    CGFloat newHeight = 0;
    CGFloat newWidth = 0;
    
    if (newSizeRatio >= imageRatio) {        // max height is newSize.height
        newHeight = newSize.height;
        newWidth = newHeight * imageRatio;
    } else {
        newWidth = newSize.width;
        newHeight = newWidth / imageRatio;
    }
    
    drawRect.size.width = newWidth;
    drawRect.size.height = newHeight;
    
    drawRect.origin.x = newSize.width / 2 - newWidth / 2;
    drawRect.origin.y = newSize.height / 2 - newHeight / 2;
    
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    
    [self drawInRect:drawRect blendMode:kCGBlendModeNormal alpha:1];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%f,%f",image.size.height,image.size.width);
    return image;
}

@end
