//
//  DJQRateView.m
//  rateView
//
//  Created by 丁剑青 on 13-6-23.
//  Copyright (c) 2013年 丁剑青. All rights reserved.
//

#import "DJQRateView.h"

@interface DJQRateView ()

@property(nonatomic) CGRect minImageSize;
@property(nonatomic, strong) NSMutableArray* rateViews;
- (void)baseInit;
- (void)refresh;
@end
@implementation DJQRateView

- (void)baseInit {
  self.rateViews = [[NSMutableArray alloc] init];

  self.rate = 0;
  self.maxRate = 5;

  self.leftMargin = 0;
  self.rightMargin = 0;
  self.midMargin = 4;

  self.minImageSize = CGRectMake(0, 0, 10, 10);
}
- (void)refresh {
  int size = (int)self.rateViews.count;
  for (int i = 0; i < size; i++) {
    DJQStartView* view = [self.rateViews objectAtIndex:i];
    if (self.rate >= i + 1) {
      view.value = 1;
    } else if (self.rate > i) {
      view.value = self.rate - i;
    } else {
      view.value = 0;
    }
  }
}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self baseInit];
  }
  return self;
}
- (void)layoutSubviews {
  [super layoutSubviews];

  float desireImageViewWidth =
      (self.frame.size.width - self.leftMargin - self.rightMargin -
       self.midMargin * (self.maxRate - 1)) /
      self.maxRate;
  float imageWidth = MAX(self.minImageSize.size.width, desireImageViewWidth);
  float imageHeight =
      MAX(self.frame.size.height, self.minImageSize.size.height);

  int size = (int)self.rateViews.count;
  UIImageView* view = NULL;

  for (int i = 0; i < size; i++) {
    view = [self.rateViews objectAtIndex:i];
    view.frame = CGRectMake(self.leftMargin + (self.midMargin + imageWidth) * i,
                            0, imageWidth, imageHeight);
  }
}

- (void)setMaxRate:(int)maxRate {
  _maxRate = maxRate;
  int size = (int)self.rateViews.count;
  DJQStartView* view = NULL;
  if (size > maxRate) {
    for (int i = size - 1; size >= maxRate; i--) {
      view = (DJQStartView*)[self.rateViews objectAtIndex:i];
      [view removeFromSuperview];
      [self.rateViews removeObjectAtIndex:i];
    }
    [self setNeedsLayout];
    [self refresh];
  } else {
    for (int i = size; i < maxRate; i++) {
      view = [[DJQStartView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
      // view.startColor =
      [self.rateViews addObject:view];
      [self addSubview:view];
    }
    [self setNeedsLayout];
    [self refresh];
  }
}

- (void)setRate:(float)rate {
  _rate = rate;
  [self refresh];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  UITouch* touch = [[touches allObjects] firstObject];
  CGPoint touchPoint = [touch locationInView:self];

  int singleCountLenth = self.frame.size.width / 5;
  int x = touchPoint.x;

  int current = x / singleCountLenth;
  int remainder = x % singleCountLenth;

  if (remainder != 0) {
    current++;
  }

  self.rate = current;

  if ([_delegate respondsToSelector:@selector(ratechanger:)]) {
    [_delegate ratechanger:current];
  }
}

@end

#define th M_PI / 180
@implementation DJQStartView

//初始化控件
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat x = frame.size.width / 2;
    CGFloat y = frame.size.height / 2;
    self.radius = x < y ? x : y;
    self.value = 1;
      //设置颜色
      self.startColor = [UIColor colorWithRed:250 / 255.0
                                        green:99 / 255.0
                                         blue:56 / 255.0
                                        alpha:1.00f];
    self.backgroundColor = [UIColor clearColor];
      self.boundsColor = [UIColor colorWithRed:250 / 255.0
                                         green:99 / 255.0
                                          blue:56 / 255.0
                                         alpha:1.00f];
    self.opaque = NO;
  }
  return self;
}
- (void)setFrame:(CGRect)frame {
  CGFloat x = frame.size.width / 2;
  CGFloat y = frame.size.height / 2;
  self.radius = x < y ? x : y;

  [super setFrame:frame];
  [self setNeedsDisplay];
}
- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    CGFloat x = self.frame.size.width / 2;
    CGFloat y = self.frame.size.height / 2;
    self.radius = x < y ? x : y;
    self.value = 1;
    self.startColor = [UIColor yellowColor];
    self.backgroundColor = [UIColor clearColor];
    self.boundsColor = [UIColor blackColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGFloat centerX = rect.size.width / 2;
  CGFloat centerY = rect.size.height / 2;

  CGFloat r0 = self.radius * sin(18 * th) / cos(36 * th); /*计算小圆半径r0 */
  CGFloat x1[5] = {0}, y1[5] = {0}, x2[5] = {0}, y2[5] = {0};

  for (int i = 0; i < 5; i++) {
    x1[i] = centerX +
            self.radius *
                cos((90 + i * 72) * th); /* 计算出大圆上的五个平均分布点的坐标*/
    y1[i] = centerY - self.radius * sin((90 + i * 72) * th);
    x2[i] =
        centerX +
        r0 * cos((54 + i * 72) * th); /* 计算出小圆上的五个平均分布点的坐标*/
    y2[i] = centerY - r0 * sin((54 + i * 72) * th);
  }

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGMutablePathRef startPath = CGPathCreateMutable();
  CGPathMoveToPoint(startPath, NULL, x1[0], y1[0]);

  for (int i = 1; i < 5; i++) {
    CGPathAddLineToPoint(startPath, NULL, x2[i], y2[i]);
    CGPathAddLineToPoint(startPath, NULL, x1[i], y1[i]);
  }

  CGPathAddLineToPoint(startPath, NULL, x2[0], y2[0]);
  CGPathCloseSubpath(startPath);

  CGContextAddPath(context, startPath);

  CGContextSetFillColorWithColor(context, self.startColor.CGColor);

  CGContextSetStrokeColorWithColor(context, self.boundsColor.CGColor);
  CGContextStrokePath(context);

  CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * self.value, y1[2]);

  CGContextAddPath(context, startPath);
  CGContextClip(context);
  CGContextFillRect(context, range);

  CFRelease(startPath);
}

- (void)setValue:(CGFloat)value {
  if (value < 0) {
    _value = 0;
  } else if (value > 1) {
    _value = 1;
  } else {
    _value = value;
  }

  [self setNeedsDisplay];
}

@end
