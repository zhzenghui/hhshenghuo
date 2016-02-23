//
//  SAMenuTable.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SIMenuTable.h"
#import "SIMenuCell.h"
#import "SIMenuConfiguration.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extension.h"
#import "SICellSelection.h"
#import "Define.h"
#import "ConstObject.h"

@interface SIMenuTable () {
    CGRect endFrame;
    CGRect startFrame;
    
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *totalArrays;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end

@implementation SIMenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items andTotalArray:(NSArray *)totalArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray arrayWithArray:items];
        self.totalArrays = [NSArray arrayWithArray:totalArray];

//        self.layer.backgroundColor = [UIColor color:[SIMenuConfiguration mainColor] withAlpha:1.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height);
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*[SIMenuConfiguration itemCellHeight];
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.backgroundView = nil;
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, [SIMenuConfiguration menuWidth], self.table.bounds.size.height)];
//        header.backgroundColor = [UIColor blackColor];
//        [self.table addSubview:header];

    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    if (!self.table.tableFooterView) {
        [self addFooter];
    }
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
        self.layer.backgroundColor = [UIColor color:[UIColor blackColor] withAlpha:0.8].CGColor;
        self.table.frame = endFrame;
        self.table.contentOffset = CGPointMake(0, [SIMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.table.contentOffset = CGPointMake(0, [SIMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
//            self.layer.backgroundColor = [UIColor color:[SIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
            self.table.frame = startFrame;
            [[NSNotificationCenter defaultCenter] postNotificationName:kHideColor object:nil];
        } completion:^(BOOL finished) {

            [self.table deselectRowAtIndexPath:self.currentIndexPath animated:NO];
//            隐藏后取消cell的选中效果，如不需要，可注掉
            SIMenuCell *cell = (SIMenuCell *)[self.table cellForRowAtIndexPath:self.currentIndexPath];
            [cell setSelected:NO withCompletionBlock:^{

            }];
            self.currentIndexPath = nil;
            [self removeFooter];
            [self.table removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }];
}

- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return [SIMenuConfiguration animationDuration]*percentage/100.0;
}

- (void)addFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [SIMenuConfiguration menuWidth], self.table.bounds.size.height - (self.items.count * [SIMenuConfiguration itemCellHeight]))];
    self.table.tableFooterView = footer;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [footer addGestureRecognizer:tap];
    [tap release];
}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SIMenuCell *cell = (SIMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[SIMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titlesLabel.text = [self.items objectAtIndex:indexPath.row];
    if ([self.totalArrays count]>indexPath.row) {
        cell.countsLabel.text = [self.totalArrays objectAtIndex:indexPath.row];
    }
    else {
        cell.countsLabel.text = @"";
    }
    
    if(indexPath.row == self.items.count-1){
        
        cell.lineImage.frame =CGRectMake(15, 43, 320-30, 1);
        [cell.lineImage setBackgroundColor:[UIColor whiteColor]];
    }else{
    
        cell.lineImage.frame = CGRectMake(32, 43, 320-64, 1);
        [cell.lineImage setBackgroundColor:[UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.4]];
    }
    if(indexPath.row ==[[ConstObject instance] selectNum])
        [cell.backgroundImages setImage:[UIImage imageNamed:@"menuSelect"]];
    else
        [cell.backgroundImages setImage:nil];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentIndexPath = indexPath;
    [[ConstObject instance] setSelectNum:indexPath.row];
    [tableView reloadData];
    SIMenuCell *cell = (SIMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.backgroundImages setImage:[UIImage imageNamed:@"menuSelect"]];
    [cell setSelected:YES withCompletionBlock:^{
        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SIMenuCell *cell = (SIMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO withCompletionBlock:^{

    }];
}

@end
