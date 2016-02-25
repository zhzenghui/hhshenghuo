//
//  MyStepper.m
//  sjsh
//
//  Created by savvy on 15/10/23.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "MyStepper.h"

@implementation MyStepper

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

//初始化布局
-(void)initLayout{
    
    self.subtractButton = [[UIButton alloc] init];
    self.subtractButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtractButton.tag = 198801;
    [self.subtractButton setImage:[UIImage imageNamed:@"icon_order_subtract"] forState:UIControlStateNormal];
//    [self.subtractButton setBackgroundImage:[UIImage imageNamed:@"icon_order_subtract"] forState:UIControlStateNormal];
    [self.subtractButton addTarget:self action:@selector(updateNumber:)
                  forControlEvents:UIControlEventTouchUpInside];
    //给图层添加一个有色边框
    self.subtractButton.layer.borderWidth = 0.5;
    self.subtractButton.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] CGColor];
    [self addSubview:self.subtractButton];
    
    self.addButton = [[UIButton alloc] init];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addButton.tag = 198802;
    [self.addButton addTarget:self action:@selector(updateNumber:)
             forControlEvents:UIControlEventTouchUpInside];
    //给图层添加一个有色边框
    self.addButton.layer.borderWidth = 0.5;
    self.addButton.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] CGColor];
//     [self.addButton setImage:[UIImage imageNamed:@"icon_order_add"] forState:UIControlStateNormal];
    [self addSubview:self.addButton];
    
    
    
    self.subtractImageView = [[UIImageView alloc] init];
    self.subtractImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtractImageView.image = [UIImage imageNamed:@"icon_order_subtract"];
    self.subtractImageView.contentMode = UIViewContentModeScaleAspectFit;
     [self.subtractButton addSubview:self.subtractImageView];
    
    self.addImageView = [[UIImageView alloc] init];
    self.addImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.addImageView.image = [UIImage imageNamed:@"icon_order_add"];
    self.addImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.addButton addSubview:self.addImageView];

    
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberLabel.text = @"0";
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont boldSystemFontOfSize:15];
    self.numberLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    //给图层添加一个有色边框
//    self.numberLabel.layer.borderWidth = 0.5;
//    self.numberLabel.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] CGColor];
    [self addSubview:self.numberLabel];
    
    self.numberTopLine = [[UIImageView alloc]init];
    self.numberTopLine.translatesAutoresizingMaskIntoConstraints = NO;
//    self.numberTopLine.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];//背景
     self.numberTopLine.image = [UIImage imageNamed:@"backage_line"];//图片
     [self.numberLabel addSubview:self.numberTopLine];
    
    self.numberBottomLine = [[UIImageView alloc]init];
    self.numberBottomLine.translatesAutoresizingMaskIntoConstraints = NO;
//    self.numberBottomLine.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    self.numberBottomLine.image = [UIImage imageNamed:@"backage_line"];
    [self.numberLabel addSubview:self.numberBottomLine];
    
    NSDictionary *viewMap = @{
                              @"subtractButton" : self.subtractButton,
                              @"addButton" : self.addButton,
                              @"subtractImageView" : self.subtractImageView,
                              @"addImageView" : self.addImageView,
                              @"numberLabel" : self.numberLabel,
                               @"numberTopLine" : self.numberTopLine,
                               @"numberBottomLine" : self.numberBottomLine,
                              };
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-0-[subtractButton]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-0-[addButton]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-0-[numberLabel]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-0-[subtractButton]-0-[numberLabel]-0-[addButton]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    
    [self addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.subtractButton
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeHeight
                               multiplier:1
                               constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    
    
    
    [self.subtractButton addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-0-[subtractImageView]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    [self.subtractButton addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"H:|-0-[subtractImageView]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    [self.addButton addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"V:|-0-[addImageView]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    [self.addButton addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:
                                         @"H:|-0-[addImageView]-0-|"
                                         options:0
                                         metrics:nil
                                         views:viewMap]];
    
    
    //内容的内部边框布局
    [self.numberLabel addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-0-[numberTopLine]-0-|"
                          options:0
                          metrics:nil
                          views:viewMap]];
    [self.numberLabel addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-0-[numberBottomLine]-0-|"
                                      options:0
                                      metrics:nil
                                      views:viewMap]];
    [self.numberLabel addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:[numberBottomLine(==0.5)]-0-|"
                                      options:0
                                      metrics:nil
                                      views:viewMap]];
    [self.numberLabel addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:|-0-[numberTopLine(==0.5)]"
                                      options:0
                                      metrics:nil
                                      views:viewMap]];




}

//设置数值
-(void)setNumber:(NSInteger)number{
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.number];
}

//修改数值
-(void) updateNumber:(UIButton *)myButton{
//    NSLog(@"修改数值！！！！！");
    
    if(myButton.tag == 198801){
        if (self.number!=1) {
            self.number--;
            self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.number];
            //通知数值已改变
            if ([_delegate respondsToSelector:@selector(getNumber:state:)]) {
                [_delegate getNumber:self.number state:0];
            }

        }
    }else{
        self.number++;
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.number];
        //通知数值已改变
        if ([_delegate respondsToSelector:@selector(getNumber:state:)]) {
            [_delegate getNumber:self.number state:1];
        }
    }
   }

@end
