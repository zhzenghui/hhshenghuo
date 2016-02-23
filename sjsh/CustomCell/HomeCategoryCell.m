//
//  HomeCategoryCell.m
//  sjsh
//
//  Created by savvy on 15/10/18.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "HomeCategoryCell.h"

@implementation HomeCategoryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
//        [self.contentView setBackgroundColor:[UIColor redColor]];
  
    }
    return self;
}
- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"类别cell数据%@!!!!!!!!!",myDictionary);
    
    int contentWidth = self.contentView.frame.size.width;
//    int contentHeight = self.contentView.frame.size.height;
    
    
    NSString* str = myDictionary[@"rgb"];
    NSArray *strArray = [str componentsSeparatedByString:@","];
   
    float red = [strArray[0] floatValue]/255.0;
//    NSLog(@"red字符串为%f!!!!!!",red);
     float green = [strArray[1] floatValue]/255.0;
//    NSLog(@"green字符串为%f!!!!!!",green);
    float blue = [strArray[2] floatValue]/255.0;
//    NSLog(@"blue字符串为%f!!!!!!",blue);
    [self.contentView setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
    
    if(self.type==1){
        
        //83*91
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(contentWidth-50*85/94-7, 6, 50*85/94, 50)];
//        [self.imageView setBackgroundColor:[UIColor greenColor]];
       [self.imageView setImageWithURL:[NSURL URLWithString:myDictionary[@"img"]]];
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        self.titleView = [[UILabel alloc]initWithFrame:CGRectMake( self.imageView.frame.origin.x-7.5, self.imageView.frame.origin.y+self.imageView.frame.size.height+8, self.imageView.frame.size.width+15, 10)];
        self.titleView.textColor = [UIColor whiteColor];
        self.titleView.textAlignment=NSTextAlignmentCenter;
        self.titleView.font = [UIFont systemFontOfSize:12];
        self.titleView.text=myDictionary[@"title2"];
        [self.contentView addSubview:self.titleView];
        
        self.contentView01 = [[UILabel alloc]initWithFrame:CGRectMake( 10, 12, 100, 20)];
        self.contentView01.textColor = [UIColor whiteColor];
        self.contentView01.font = [UIFont systemFontOfSize:19];
        self.contentView01.text=myDictionary[@"title"];
        [self.contentView addSubview:self.contentView01];
        
        self.contentView02 = [[UILabel alloc]initWithFrame:CGRectMake( 10, self.contentView01.frame.origin.y+self.contentView01.frame.size.height,contentWidth, 15)];
        self.contentView02.textColor = [UIColor whiteColor];
        self.contentView02.font = [UIFont systemFontOfSize:12];
        self.contentView02.text=myDictionary[@"title1"];
        [self.contentView addSubview:self.contentView02];
    }else{
        //150*166
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((contentWidth-50*150/166)/2, 6, 50*150/166, 50)];
         [self.imageView setImageWithURL:[NSURL URLWithString:myDictionary[@"img"]]];
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        self.titleView = [[UILabel alloc]initWithFrame:CGRectMake( 0, self.imageView.frame.origin.y+self.imageView.frame.size.height+8, contentWidth, 10)];
        self.titleView.textColor = [UIColor whiteColor];
        self.titleView.textAlignment=NSTextAlignmentCenter;
        self.titleView.font = [UIFont systemFontOfSize:12];
        self.titleView.text=myDictionary[@"title2"];
        [self.contentView addSubview:self.titleView];
        
        
    }
    //    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:myDictionary[@"imageUrl"]]]];
    //    [self.imageView setImage:img];
    //    [self.imageView setImage:[UIImage imageNamed:@"test_1.jpg"]];
    
    
}



@end
