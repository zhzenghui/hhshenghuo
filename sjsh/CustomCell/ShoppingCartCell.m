//
//  ShoppingCartCell.m
//  sjsh
//  购物车
//  Create-***d by savvy on 15/12/14.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "Define.h"

@implementation ShoppingCartCell


//10+17.5+60+17.5+45
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(-40, 0, ScreenWidth+40, 10)];
        self.topView.image = [UIImage imageNamed:@"backage_cart_gray_line"];
        [self.contentView addSubview:self.topView];
        
        self.cartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 17.5+self.topView.frame.origin.y+self.topView.frame.size.height, 60, 60)];
        self.cartImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.cartImageView.layer.borderWidth = 0.5;
        self.cartImageView.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] CGColor];
        [self.contentView addSubview:self.cartImageView];
        
        self.cartName = [[UILabel alloc] initWithFrame:CGRectMake(80, self.cartImageView.frame.origin.y, ScreenWidth-80-15, 40)];
        self.cartName.font = [UIFont systemFontOfSize:14];
        self.cartName.textColor = fontGrayColor;
        self.cartName.lineBreakMode = NSLineBreakByWordWrapping;
        self.cartName.numberOfLines = 0;//上面两行设置多行显示
        [self.contentView addSubview:self.cartName];
        
//        self.cartMemberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, self.cartImageView.frame.origin.y+self.cartImageView.frame.size.height-14, 80, 14)];
//        self.cartMemberImageView.image = [UIImage imageNamed:@"backage_red_fillet"];
//        [self.contentView addSubview:self.cartMemberImageView];
//        
//        self.cartMember = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 14)];
//        self.cartMember.font = [UIFont systemFontOfSize:12];
//        self.cartMember.textColor = [UIColor whiteColor];
//        self.cartMember.textAlignment = NSTextAlignmentCenter;
//        self.cartMember.text = @"会员价0.0";
//        [self.cartMemberImageView addSubview:self.cartMember];
        
//        self.cartPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.cartMemberImageView.frame.origin.x+self.cartMemberImageView.frame.size.width+5, self.cartImageView.frame.origin.y+self.cartImageView.frame.size.height-14, 100, 14)];
        self.cartPrice = [[UILabel alloc] initWithFrame:CGRectMake(80, self.cartImageView.frame.origin.y+self.cartImageView.frame.size.height-14, 80, 14)];
        self.cartPrice.font = [UIFont systemFontOfSize:14];
        self.cartPrice.textColor = hhRedColor;
        self.cartPrice.text = @"0.0";
        [self.contentView addSubview:self.cartPrice];
        
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(8, self.cartImageView.frame.origin.y+self.cartImageView.frame.size.height+17.5-0.5, ScreenWidth-15, 0.5)];
        self.lineView.image = [UIImage imageNamed:@"backage_line"];
        [self.contentView addSubview:self.lineView];
        
        
        self.cartSpecification = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100-40, self.lineView.frame.origin.y+self.lineView.frame.size.height, 90, 45)];
        self.cartSpecification.textAlignment = NSTextAlignmentRight;
        self.cartSpecification.textColor = fontDilutedGrayColor;
        self.cartSpecification.text = @"暂无";
        self.cartSpecification.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.cartSpecification];
        
        
        self.myStepper = [[MyStepper alloc] initWithFrame:CGRectMake(80, self.lineView.frame.origin.y+self.lineView.frame.size.height+10, 100, 25)];
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
    
    
    self.cartName.text= [productDic objectForKey:@"name"];
    
    self.cartPrice.text=[NSString stringWithFormat:@"￥%@",[[productDic objectForKey:@"price"] stringValue]];
    
//    if ([productDic objectForKey:@"cartMember"]&&![[productDic objectForKey:@"cartMember"] isEqualToString:@""]) {
//         self.cartMember.text=[NSString stringWithFormat:@"会员价￥%@",[[productDic objectForKey:@"price"] stringValue]];
//    }else{
//         self.cartMemberImageView.hidden = YES;
//      self.cartPrice.frame = CGRectMake(self.cartImageView.frame.origin.x+self.cartImageView.frame.size.width+5, self.cartImageView.frame.origin.y+self.cartImageView.frame.size.height-14, 100, 14);
//    }
   
    
    NSString *imageUrl = [productDic objectForKey:@"thumb"];
    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.cartImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    
        NSArray *optionArray = [productDic objectForKey:@"option"];
    if (optionArray&&optionArray.count>0) {
         self.cartSpecification.text = optionArray[0][@"value"];
    }else{
     self.cartSpecification.text = @"";
    }
   
    
    
    self.myStepper.number = [[productDic objectForKey:@"quantity"] integerValue];
    
    
    
}


#pragma mark 控件代理方法
//修改商品数量
- (void)getNumber:(NSInteger)number state:(NSInteger)state{
    NSLog(@"修改商品数量为%ld！！！！！",(long)number);
    self.myDictionary[@"quantity"] = [NSNumber numberWithInteger:number];
     self.myDictionary[@"state"] = [NSNumber numberWithInteger:state];
    self.myDictionary[@"position"] =  [NSNumber numberWithInteger:self.position];
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
