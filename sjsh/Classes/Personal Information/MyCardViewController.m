//
//  MyCardViewController.m
//  sjsh
//
//  Created by ce on 14-7-25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "MyCardViewController.h"

@interface MyCardViewController ()

@end

@implementation MyCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"我的储值卡"];
    [super addRightButton:@"return" lightedImage:@"returnLighted" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(255, 255, 255);
}

-(void)toReturn{
//    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
