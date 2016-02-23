//
//  SINavigationMenuView.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SINavigationMenuView.h"
#import "SIMenuButton.h"
#import "QuartzCore/QuartzCore.h"
#import "SIMenuConfiguration.h"
#import "Define.h"
#import "ConstObject.h"

@interface SINavigationMenuView  ()
@property (nonatomic, strong) SIMenuButton *menuButton;
@property (nonatomic, strong) SIMenuButton *menuButton1;

@property (nonatomic, strong) SIMenuTable *table;
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation SINavigationMenuView
@synthesize items;
@synthesize ptotalArray;
@synthesize categoryIdArray;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[SIMenuButton alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
        
        self.items = [NSMutableArray arrayWithCapacity:1];
        self.ptotalArray = [NSMutableArray arrayWithCapacity:1];
        self.categoryIdArray = [NSMutableArray arrayWithCapacity:1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideColor) name:kHideColor object:nil];
        [[ConstObject instance] setSelectNum:0];
    }
    return self;
}

-(void)hideColor{

    self.backgroundColor = [UIColor clearColor];
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap
{
    
    if (self.menuButton.isActive) {
        NSLog(@"On show");
        [self.delegate onHandleMenuTap];
        [self onShowMenu];
        
    } else {
        NSLog(@"On hide");
        [self.delegate onHideMenuTap];
        [self onHideMenu];
        
    }
}

- (void)onShowMenu
{
//    self.backgroundColor = [UIColor blackColor];
    if (!self.table) {
//        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
//        CGRect frame = mainWindow.frame;
//        frame.origin.y += self.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        
        CGRect rect = self.menuContainer.bounds;
        self.table = [[SIMenuTable alloc] initWithFrame:rect items:self.items andTotalArray:self.ptotalArray];
        self.table.menuDelegate = self;
        
        UIImageView *lineImages = [[UIImageView alloc] initWithFrame:CGRectMake(15, 63, 320-30, 0.8)];
        [lineImages setBackgroundColor:[UIColor whiteColor]];
        [self.table addSubview:lineImages];
        self.menuButton1 = [[SIMenuButton alloc] initWithFrame:CGRectMake(80, 27, 160, 30)];
        _menuButton1.title.text = self.menuButton.title.text;
        [_menuButton1 addTarget:self action:@selector(didBackgroundTap) forControlEvents:UIControlEventTouchUpInside];
        [self.table addSubview:_menuButton1];
    }
    [self.menuContainer addSubview:self.table];
    

    [self rotateArrow:M_PI];
    [self.table show];
}


- (void)onHideMenu
{
    [self rotateArrow:0];
    [self.table hide];
    
//    CATransition *animation = [CATransition animation];
//    animation.duration = 7.5f;
//    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeForwards;
//    animation.type = kCATransitionFade;
//    animation.subtype = kCATransitionFromTop;
//    [blackView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height+64)];
//    [self.view.layer addAnimation:animation forKey:@"animation"];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.title.text = [self.items objectAtIndex:index];
    self.menuButton1.title.text = [self.items objectAtIndex:index];
    self.menuButton.isActive = !self.menuButton.isActive;
    self.menuButton1.isActive = !self.menuButton1.isActive;
    [self.menuButton1 performSelector:@selector(layoutSubviews) withObject:nil afterDelay:0.];
    [self onHandleMenuTap];
    [self.delegate didSelectItemAtIndex:index];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap];
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    [super dealloc];
    self.items = nil;
    self.menuButton = nil;
    self.menuButton1 = nil;
    self.menuContainer = nil;
}

@end
