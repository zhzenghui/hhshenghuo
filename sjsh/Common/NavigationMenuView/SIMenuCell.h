//
//  SAMenuCell.h
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIMenuCell : UITableViewCell

@property(nonatomic, retain)UILabel *titlesLabel;
@property(nonatomic, retain)UILabel *countsLabel;
@property(nonatomic, retain)UIImageView *lineImage;
@property(nonatomic, retain)UIImageView *backgroundImages;

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion;
@end
