//
//  HHOrderCommodityCell.m
//  sjsh
//
//  Created by savvy on 16/2/23.
//  Copyright © 2016年 世纪生活. All rights reserved.
//

#import "HHOrderCommodityCell.h"
#import "Define.h"

@implementation HHOrderCommodityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.commodityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
        [self.contentView addSubview:self.commodityImageView];
        
        self.commodityContent = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 100, 15)];
        self.commodityContent.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.commodityContent];
        
        self.commoditySize = [[UILabel alloc] initWithFrame:CGRectMake(80, 37, 100, 15)];
        [self.contentView addSubview:self.commoditySize];
        
        self.commodityPrice = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-90, 0, 70, 15)];
        self.commodityPrice.textAlignment = NSTextAlignmentRight;
        self.commodityPrice.textColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.commodityPrice];
        
        self.commodityTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, ScreenWidth-70-70, 15)];
        self.commodityTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.commodityTitle];
        
        self.myStepper = [[MyStepper alloc] initWithFrame:CGRectMake(ScreenWidth-110, 20, 90, 30)];
        self.myStepper.number = 1;
        self.myStepper.delegate = self;
        [self.contentView addSubview:self.myStepper];
        
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)productDic
{
    self.myDictionary = [productDic mutableCopy];
    
    NSLog(@"商品列表%@!!!!!!!",productDic);
    
    
    self.commodityTitle.text= [productDic objectForKey:@"name"];
    self.commodityContent.text= [productDic objectForKey:@"meta_description"];
    self.commoditySize.text=@"1";
    self.commodityPrice.text=[NSString stringWithFormat:@"￥ %@",[[productDic objectForKey:@"price"] stringValue]];
    
    NSString *imageUrl = [productDic objectForKey:@"thumb"];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.commodityImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    
    //    NSArray *option = [productDic objectForKey:@"option"];
    
    
    self.myStepper.number = [[productDic objectForKey:@"quantity"] integerValue];
    
    //    NSString * myInfo=nil;
    //
    //    if ([option count]>0) {
    //        myInfo=[NSString stringWithFormat:@"%@：%@\n数量：%@",[[option objectAtIndex:0] objectForKey:@"name"],[[option objectAtIndex:0] objectForKey:@"value"], [[productDic objectForKey:@"quantity"] stringValue]];
    //
    //    }
    //    else {
    //        myInfo=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"数量：%@",[[productDic objectForKey:@"quantity"] stringValue]]];
    //    }
    //
    //    NSLog(@"商品描述为：%@!!!!!!!",myInfo);
    
    
}


#pragma mark 控件代理方法
//修改商品数量
- (void)getNumber:(NSInteger)number state:(NSInteger)state{
    NSLog(@"修改商品数量为%ld！！！！！",(long)number);
    self.myDictionary[@"quantity"] = [NSNumber numberWithInteger:number];
    self.myDictionary[@"state"] = [NSNumber numberWithInteger:state];
    
    
    if ([_delegate respondsToSelector:@selector(getDictionary:)]) {
        [_delegate getDictionary: self.myDictionary];
    }
}



- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
