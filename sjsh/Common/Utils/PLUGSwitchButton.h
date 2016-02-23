//
//  PLUGSwitchButton.h
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CheckButtonStyleDefault = 0 ,
    CheckButtonStyleBox = 1 ,
    CheckButtonStyleRadio = 2
} CheckButtonStyle;

@interface PLUGSwitchButton : UIControl{
    UILabel * label ;
    UIImageView * icon ;
    BOOL checked ;
    id value , delegate ;
    CheckButtonStyle style ;
    NSString *checkname ;
    NSString *uncheckname ; 
    UILabel *_title;
}

@property (nonatomic,retain) id value;
@property (nonatomic,retain) id delegate;
@property (nonatomic,retain)UILabel* label;
@property (nonatomic,retain)UIImageView* icon;
@property ( assign )CheckButtonStyle style;
@property (nonatomic) BOOL checked;

-( CheckButtonStyle )style;
-( void )setStyle:( CheckButtonStyle )st;
-( BOOL )isChecked;
-( void )setChecked:( BOOL )b;
-( id )initWithFrame:( CGRect ) frame ClassImage:(NSString *)checkImage unClassImage:(NSString*)uncheckImage;
-( id )initWithFrame:( CGRect ) frame checkImage:(NSString *)checkImage uncheckImage:(NSString*)uncheckImage;
-( id )initWithFrame:( CGRect ) frame title:(NSString *)title checkImage:(NSString *)checkImage uncheckImage:(NSString*)uncheckImage;

@end
