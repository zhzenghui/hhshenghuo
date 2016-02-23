//
//  HHShoppingCategoryCell.m
//  sjsh
//
//  Created by savvy on 16/1/20.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHShoppingCategoryCell.h"
#import "Define.h"

@implementation HHShoppingCategoryCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
          int contentWidth = self.contentView.frame.size.width;
        //150*166
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((contentWidth-45)/2, 15, 45, 45)];
      
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        self.titleView = [[UILabel alloc]initWithFrame:CGRectMake( 0, self.imageView.frame.origin.y+self.imageView.frame.size.height+8, contentWidth, 10)];
//        self.titleView.textColor = [UIColor whiteColor];
        self.titleView.textAlignment=NSTextAlignmentCenter;
        self.titleView.font = [UIFont systemFontOfSize:14];
       
        [self.contentView addSubview:self.titleView];
        
    }
    return self;
}
- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"类别cell数据%@!!!!!!!!!",myDictionary);
    
  
    //    int contentHeight = self.contentView.frame.size.height;
    
    
//    NSString* str = myDictionary[@"rgb"];
//    NSArray *strArray = [str componentsSeparatedByString:@","];
    
//    float red = [strArray[0] floatValue]/255.0;
//    //    NSLog(@"red字符串为%f!!!!!!",red);
//    float green = [strArray[1] floatValue]/255.0;
//    //    NSLog(@"green字符串为%f!!!!!!",green);
//    float blue = [strArray[2] floatValue]/255.0;
//    //    NSLog(@"blue字符串为%f!!!!!!",blue);
//    [self.contentView setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
    
    
    if(self.position%2==1){
//     [self.contentView setBackgroundColor:[UIColor colorWithRed:249/255 green:249/255 blue:249/255 alpha:1.0]];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0]];
    }else{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
//     [self.imageView setImageWithURL:[NSURL URLWithString:myDictionary[@"img"]]];
//    NSString *imageString = [NSString stringWithFormat:@"test_hh_shopping%02d",self.position+1];
    self.imageView.image = [UIImage imageNamed:myDictionary[@"ico"]];
 self.titleView.text=myDictionary[@"title2"];
    self.titleView.textColor = myDictionary[@"color"];
        
        
    
    
}



@end
