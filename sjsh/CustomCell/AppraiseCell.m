//
//  AppraiseCell.m
//  sjsh
//
//  Created by savvy on 15/11/19.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AppraiseCell.h"
#import "Define.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation AppraiseCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, 150, 15)];
        self.userNameLabel.font = [UIFont systemFontOfSize:12];
        self.userNameLabel.text = @"未知";
        self.userNameLabel.textColor = fontDilutedGrayColor;
        [self.contentView addSubview:self.userNameLabel];

        self.appraiseDate = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-155, 17, 140, 15)];
         self.appraiseDate.text = @"0000/00/00";
        self.appraiseDate.font = [UIFont systemFontOfSize:12];
        self.appraiseDate.textColor = fontDilutedGrayColor;
        self.appraiseDate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.appraiseDate];
        
        self.commodityGradeView = [[DJQRateView alloc] initWithFrame:CGRectMake(15, self.userNameLabel.frame.origin.y+self.userNameLabel.frame.size.height+10, 110, 15)];
//        self.commodityGradeView.delegate = self;
        self.commodityGradeView.rate = 5.0;
//        self.commodityGradeView.startColor = [UIColor colorWithRed:250.0/255.0 green:99.0/255.0 blue:56.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.commodityGradeView];
        
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-115, self.commodityGradeView.frame.origin.y, 100, 15)];
        self.sizeLabel.font = [UIFont systemFontOfSize:12];
        self.sizeLabel.text = @"";
        self.sizeLabel.textAlignment = NSTextAlignmentRight;
        self.sizeLabel.textColor = fontDilutedGrayColor;
        [self.contentView addSubview:self.sizeLabel];

        
        self.appraiseContent = [[UILabel alloc] initWithFrame:CGRectMake(15, self.commodityGradeView.frame.origin.y+self.commodityGradeView.frame.size.height+5, ScreenWidth-30, 40)];
        self.appraiseContent.font = [UIFont systemFontOfSize:14];
//        self.appraiseContent.textAlignment = NSTextAlignmentRight;
        self.appraiseContent.lineBreakMode = NSLineBreakByWordWrapping;
        self.appraiseContent.numberOfLines = 0;//上面两行设置多行显示
         self.appraiseContent.text = @"暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无暂无";
        self.appraiseContent.textColor = fontGrayColor;
        [self.contentView addSubview:self.appraiseContent];
        
        self.appraiseImageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(15, self.appraiseContent.frame.origin.y+self.appraiseContent.frame.size.height+5, ScreenWidth-30, 60)];
//        self.appraiseImageScroll.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.appraiseImageScroll];
        
        
//        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.appraiseImageScroll.frame.origin.y+self.appraiseImageScroll.frame.size.height+16.5, ScreenWidth, 0.5)];
//        self.lineView.backgroundColor = lineGrayColor;
//        [self.contentView addSubview:self.lineView];
        
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    
        NSLog(@"商品评价cell:%@!!!!!!!",myDictionary);
 
    self.userNameLabel.text = myDictionary[@"name"];
     self.appraiseDate.text = myDictionary[@"date_added"];
//    self.sizeLabel.text = @"暂无";
    self.appraiseContent.text = myDictionary[@"text"];
    if(myDictionary[@"text"] ==nil||[myDictionary[@"text"] isEqualToString:@""]){
        self.appraiseImageScroll.frame =CGRectMake(15, self.commodityGradeView.frame.origin.y+self.commodityGradeView.frame.size.height+5, ScreenWidth-30, 60);
           }
    
    
    self.commodityGradeView.rate = [myDictionary[@"rating"] floatValue];
     if (myDictionary[@"images"]!=nil&&![myDictionary[@"images"] isEqual:@""]) {
    NSArray *imageArray = myDictionary[@"images"];
     NSLog(@"商品评价图片:%@!!!!!!!",imageArray);
    float imageWidth = (ScreenWidth-15*4)/3;
   
        for (int i=0; i<imageArray.count; i++) {
            UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15+i*(15+imageWidth), 0, imageWidth, self.appraiseImageScroll.frame.size.height)];
            myImageView.contentMode = UIViewContentModeScaleAspectFit;
            NSString *imageUrl = imageArray[i];
            imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [myImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
            [self.appraiseImageScroll addSubview:myImageView];
        }
    }
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
