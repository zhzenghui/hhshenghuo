//
//  StoredCell.h
//  sjsh
//
//  Created by ce on 14-9-29.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoredCell : UITableViewCell{

    UIImageView *picImageView;
    UILabel *tipLabel;
    UILabel *nowPriceLabel;
}

@property (nonatomic, retain)UIImageView *picImageView;

@property (nonatomic, retain)UILabel *tipLabel;
@property (nonatomic, retain)UILabel *nowPriceLabel;

@end
