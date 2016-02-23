//
//  ImageEditViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/25.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "ImageEditViewController.h"

@interface ImageEditViewController ()
{
    NSInteger index;
}
@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"1/3"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    [super addRightButton:@"delete" lightedImage:@"delete" selector:@selector(deleteImage)];
    
    
    self.view.backgroundColor = COLOR(250, 250, 250);
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, kScreenBounds.size.height - 44.0f)];
    scroll.contentSize = CGSizeMake(kScreenBounds.size.width*3, (kScreenBounds.size.height - 44.0f));
    scroll.backgroundColor = COLOR(0x28, 0x28, 0x28);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    self.scrollview = scroll;
    [self.view addSubview:scroll];
    [scroll release];
        for (int i = 0; i<3; i++) {
            UIImage *image = [self.imageList objectAtIndex:i];
            UIImageView *kuangImg = [[UIImageView alloc] initWithImage:image];
            kuangImg.userInteractionEnabled = YES;
            kuangImg.frame = CGRectMake(i*kScreenBounds.size.width, 0, kScreenBounds.size.width , kScreenBounds.size.height - 44.0f);
            kuangImg.contentMode = UIViewContentModeScaleAspectFit;
            kuangImg.tag = 0;
            switch (i) {
                case 0:
                {
                    imgView1 = kuangImg;
                }
                    break;
                case 1:
                {
                    imgView2 = kuangImg;
                }
                    break;
                case 2:
                {
                    imgView3 = kuangImg;
                }
                    break;
                default:
                    break;
            }
            [self.scrollview addSubview:kuangImg];
            [kuangImg release];
        }
    index = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteImage
{
    switch (index) {
        case 0:
        {
            if (imgView1.tag == 1) {
                return;
            }
            imgView1.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView1.tag = 1;
        }
            break;
        case 1:
        {
            if (imgView3.tag == 1) {
                return;
            }
            imgView2.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView2.tag = 1;
            
        }
            break;
        case 2:
        {
            if (imgView3.tag == 1) {
                return;
            }
            imgView3.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView3.tag = 1;
            
        }
            break;
        default:
            break;
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(resetImageWithIndex:)]) {
        [self.delegate resetImageWithIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    index = scrollView.contentOffset.x/scrollView.frame.size.width;
    for (UIView *subv in self.navigationItem.titleView.subviews) {
        if ([subv isKindOfClass:[UILabel class]]) {
            UILabel *title = (UILabel *)subv;
            title.text = [NSString stringWithFormat:@"%d/%d",index+1,self.imageList.count];
            break;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    index = scrollView.contentOffset.x/scrollView.frame.size.width;
    for (UIView *subv in self.navigationItem.titleView.subviews) {
        if ([subv isKindOfClass:[UILabel class]]) {
            UILabel *title = (UILabel *)subv;
            title.text = [NSString stringWithFormat:@"%d/%d",index+1,self.imageList.count];
            break;
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
