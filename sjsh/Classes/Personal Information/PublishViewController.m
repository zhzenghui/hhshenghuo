//
//  PublishViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14/11/23.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"发表评论"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(250, 250, 250);
    
    UILabel *pingfenLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 50, 20)];
    pingfenLabel.text = @"评分";
    pingfenLabel.textColor  = COLOR(0x64, 0x64, 0x64);
    pingfenLabel.font = [UIFont systemFontOfSize:14.0];
    pingfenLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pingfenLabel];
    
    for (int i =0; i<5; i++) {
        UIButton *starB = [UIButton buttonWithType:UIButtonTypeCustom];
        starB.adjustsImageWhenHighlighted = NO;
        starB.frame = CGRectMake(65+i*(22+5), 15, 22, 22);
        [starB setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
        starB.tag = i;
        [starB addTarget:self action:@selector(starButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                star1 = starB;
                break;
            case 1:
                star2 = starB;
                break;
            case 2:
                star3 = starB;
                break;
            case 3:
                star4 = starB;
                break;
            case 4:
                star5 = starB;
                break;
            default:
                break;
        }
        [self.view addSubview:starB];
    }
    
    UIImageView *kuangImg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"feedback_textBack"] stretchableImageWithLeftCapWidth:7
                                                                                                                              topCapHeight:7]];
    kuangImg.userInteractionEnabled = YES;
    float height = 180;
    kuangImg.frame = CGRectMake(8, 50, 304, height);
    UITextView *txtV = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 304-20, height-20)];
    [kuangImg addSubview:txtV];
    FBTextV = txtV;
    txtV.delegate = self;
    [txtV release];
    [self.view addSubview:kuangImg];
    [kuangImg release];
    
    UILabel *shaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 50, 20)];
    shaiLabel.text = @"晒图";
    shaiLabel.textColor  = COLOR(0x64, 0x64, 0x64);
    shaiLabel.font = [UIFont systemFontOfSize:14.0];
    shaiLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shaiLabel];
    
    float y = 270;
    for (int i = 0; i<3; i++) {
        UIImageView *kuangImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolderImage"]];
        kuangImg.userInteractionEnabled = YES;
        kuangImg.frame = CGRectMake(15+i*(90+10), y, 90 , 90);
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
        [self.view addSubview:kuangImg];
        [kuangImg release];
    }
    UIButton *tempB = [UIButton buttonWithType:UIButtonTypeCustom];
    tempB.adjustsImageWhenHighlighted = NO;
    tempB.frame = CGRectMake(8, y+90+30, 304, 44);
    [tempB setTitle:@"提交" forState:UIControlStateNormal];
    [tempB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempB setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [tempB addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    commitB = tempB;
    [self.view addSubview:commitB];
    //    [commitB release];
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    starVal = 3;
    [self displayStar:starVal];
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [FBTextV resignFirstResponder];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    CGRect rect = commitB.frame;
    if (CGRectContainsPoint(rect, point)) {
        return NO;
    }
    else if (CGRectContainsPoint(imgView1.frame, point)){
        NSLog(@"1");
        self.selectImageview = imgView1;
        if (self.selectImageview.tag == 0) {
            [self startCameraAndPhotoAlbum];
        }
        else {
            [self pushImageBroswer:0];
        }
    }
    else if (CGRectContainsPoint(imgView2.frame, point)){
        NSLog(@"2");
        self.selectImageview = imgView2;
        if (self.selectImageview.tag == 0) {
            [self startCameraAndPhotoAlbum];
        }
        else {
            [self pushImageBroswer:1];
        }
    }
    else if (CGRectContainsPoint(imgView3.frame, point)){
        NSLog(@"3");
        self.selectImageview = imgView3;
        if (self.selectImageview.tag == 0) {
            [self startCameraAndPhotoAlbum];
        }
        else {
            [self pushImageBroswer:2];
        }
    }
    return YES;
}

- (void)starButtonTap:(UIButton *)button
{
    [self displayStar:button.tag+1];
}

- (void)displayStar:(int)star
{
    starVal = star;
    int count = 0;
    if (count<star) {
        [star1 setImage:[UIImage imageNamed:@"reviewStar_select"] forState:UIControlStateNormal];
    }
    else {
        [star1 setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
    }
    count++;
    if (count<star) {
        [star2 setImage:[UIImage imageNamed:@"reviewStar_select"] forState:UIControlStateNormal];
    }
    else {
        [star2 setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
    }
    count++;
    if (count<star) {
        [star3 setImage:[UIImage imageNamed:@"reviewStar_select"] forState:UIControlStateNormal];
    }
    else {
        [star3 setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
    }
    count++;
    if (count<star) {
        [star4 setImage:[UIImage imageNamed:@"reviewStar_select"] forState:UIControlStateNormal];
    }
    else {
        [star4 setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
    }
    count++;
    if (count<star) {
        [star5 setImage:[UIImage imageNamed:@"reviewStar_select"] forState:UIControlStateNormal];
    }
    else {
        [star5 setImage:[UIImage imageNamed:@"reviewStar_gray"] forState:UIControlStateNormal];
    }
}


-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commitAction{
    if (FBTextV.text.length>0) {
        [super showGif];
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{
                                     @"text":FBTextV.text,
                                     @"product_id":self.reviewID,
                                     @"order_product_id":self.orderProductID,
                                     @"rating":[NSNumber numberWithInt:starVal]
                                     }];
        NSMutableArray *imgArr = [NSMutableArray array];
        
        if (imgView1.tag==1) {
            [imgArr addObject:UIImageJPEGRepresentation(imgView1.image,0.5)];
        }
        if (imgView2.tag==1) {
            [imgArr addObject:UIImageJPEGRepresentation(imgView2.image,0.5)];
        }
        if (imgView3.tag==1) {
            [imgArr addObject:UIImageJPEGRepresentation(imgView3.image,0.5)];
            
        }
        
        [commonModel requestAddProductComment:dic imagedtaList:imgArr httpRequestSucceed:@selector(commitSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
    else {
        [super showMessageBox:nil title:@"" message:@"请将信息填写完整" cancel:nil confirm:@"确定"];
        return;
        
    }
    
}

-(void)commitSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    if (dic == nil) {
        return;
    }
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        [super showMessageBox:self title:@"" message:@"提交成功" cancel:nil confirm:@"确定"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1100){
        
        [super showMessageBox:nil title:@"未登陆" message:@"未登陆！" cancel:nil confirm:@"确定"];
        return;
    }else if ([[dic objectForKey:@"code"] intValue] == 1530){
        
        [super showMessageBox:nil title:@"提示" message:@"当日提交次数已达到上限！" cancel:nil confirm:@"确定"];
    }
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pushImageBroswer:(int)index
{
    ImageEditViewController *imageVC = [[ImageEditViewController alloc] init];
    imageVC.imageList = @[imgView1.image,imgView2.image,imgView3.image];
    imageVC.delegate = self;
    [self.navigationController pushViewController:imageVC animated:YES];
}

- (void)resetImageWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            if (imgView1.tag == 0) {
                return;
            }
            imgView1.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView1.tag = 0;
        }
            break;
        case 1:
        {
            if (imgView3.tag == 0) {
                return;
            }
            imgView2.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView2.tag = 0;
            
        }
            break;
        case 2:
        {
            if (imgView3.tag == 0) {
                return;
            }
            imgView3.image = [UIImage imageNamed:@"placeHolderImage"];
            imgView3.tag = 0;
            
        }
            break;
        default:
            break;
    }
}

- (void)startCameraAndPhotoAlbum{
    UIActionSheet *cameraAction = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    cameraAction.actionSheetStyle = UIBarStyleBlackTranslucent;
    [cameraAction showInView:self.view];
    [cameraAction release];
}

#pragma --mark
#pragma  --mark UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType = 0;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
            break;
        default:
            break;
    }
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:sourceType];
    [imagePicker setAllowsEditing:YES];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
    [imagePicker release];
}

#pragma --mark
#pragma  --mark UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.selectImageview.image = image;
    self.selectImageview.tag=1;
}

#pragma mark
#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //获取相册controller描述
    NSString *classDes = [viewController.class description];
    NSLog(@"classDes=%@",classDes);
    if ([classDes isEqualToString:@"PUUIAlbumListViewController"] || [classDes isEqualToString:@"PLUILibraryViewController"] || [classDes isEqualToString:@"PUUIPhotosAlbumViewController"]  || [classDes isEqualToString:@"PLUIAlbumViewController"]) {
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        //        if (kSystemIsIOS7) {
        //            viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        //        }
        //        else{
        //            viewController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:0.f/255.0f blue:200.0f/255.0f alpha:1.0f];
        //        }
        //        [viewController.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    }
}
@end
