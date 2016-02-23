//
//  PLUGSwitchButton.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PLUGSwitchButton.h"

@implementation PLUGSwitchButton

@synthesize label;
@synthesize icon;
@synthesize value;
@synthesize delegate;
@synthesize style;
@synthesize checked;

-( id )initWithFrame:( CGRect ) frame checkImage:(NSString *)checkImage uncheckImage:(NSString*)uncheckImage{
    if ( self =[ super initWithFrame : frame ]) {
        checkname = checkImage;
        uncheckname = uncheckImage;
        icon =[[ UIImageView alloc ] initWithFrame :CGRectMake ( 0 , 0 , (frame . size . width) , (frame . size . height) )];
        [ self setChecked : checked ]; 
        [ self addSubview : icon ];
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];
    }
    return self ;
}
-( id )initWithFrame:( CGRect ) frame title:(NSString *)title checkImage:(NSString *)checkImage uncheckImage:(NSString*)uncheckImage{
    if ( self =[ super initWithFrame : frame ]) {
        checkname = checkImage;
        uncheckname = uncheckImage;
        icon =[[ UIImageView alloc ] initWithFrame :CGRectMake ( 10 , 10 , frame.size.width-20 , frame.size.height-20 )];
        [ self setChecked : checked ]; 
        [ self addSubview : icon ];
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        CGSize size = [title sizeWithFont:font];
        _title = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width - size.width)/2, (frame.size.height - size.height)/2, size.width, size.height)];
        _title.text = title;
        _title.backgroundColor = [UIColor clearColor];
        _title.font = font;
        [self addSubview:_title];
    }
    return self ;
}
-( id )initWithFrame:( CGRect ) frame ClassImage:(NSString *)checkImage unClassImage:(NSString*)uncheckImage{
    if ( self =[ super initWithFrame : frame ]) {
        checkname = checkImage;
        uncheckname = uncheckImage;
        icon =[[ UIImageView alloc ] initWithFrame :CGRectMake ( 0 , 0 , frame . size . width , frame . size . height) ];
        [ self setChecked : checked ]; 
        [ self addSubview : icon ];
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];
    }
    return self ;
}

//-( void )setStyle:( CheckButtonStyle )st{
//    style =st;
//    switch ( style ) {
//        case CheckButtonStyleDefault :
//        case CheckButtonStyleBox :
//            break ;
//        case CheckButtonStyleRadio :
//            break ;
//        default :
//            break ;
//    }
//    [ self setChecked : checked ];
//}
-( BOOL )isChecked{
    return checked ;
}

-(void)setChecked:( BOOL )b
{
    if (b!= checked ){
        checked =b;
    }
    if ( checked ) {
        [ icon setImage :[ UIImage imageNamed : checkname ]];
        _title.textColor = [UIColor whiteColor];
    } else {
        [ icon setImage :[ UIImage imageNamed : uncheckname ]];
        _title.textColor = [UIColor blackColor];
    }
}

-( void )clicked{
    [ self setChecked :! checked ];
    if ( delegate != nil ) {
        SEL sel= NSSelectorFromString ( @"checkButtonClicked" );
        if ([ delegate respondsToSelector :sel]){
            [ delegate performSelector :sel];
        } 
    }
}
-( void )dealloc{
    value = nil ; 
    delegate = nil ;
    [_title release];
    [ label release ];
    [ icon release ];
    [ super dealloc ];
}

@end
