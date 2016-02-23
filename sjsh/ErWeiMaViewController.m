//
//  ErWeiMaViewController.m
//  SelfHelpTravel
//
//  Created by ce on 14-8-30.
//
//

#import "ErWeiMaViewController.h"
//#import "ZBarReaderViewController.h"
#import "Define.h"
#import "OpenURLViewController.h"

@implementation ErWeiMaViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [super initNavBarItems:@"扫描二维码"];
    [super addButtonReturn:@"menuButton" lightedImage:@"menuButton" selector:@selector(toShowMenu)];
    
//    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [tempButton setBackgroundColor:[UIColor redColor]];
//    [tempButton setTitle:@"点此扫描二维码" forState:UIControlStateNormal];
//    [tempButton addTarget:self action:@selector(startZBarReaderViewController) forControlEvents:UIControlEventTouchUpInside];
//    [tempButton setFrame:CGRectMake(100, 180, 64*2, 64*2)];
//    [self.view addSubview:tempButton];
    
    UIImageView *storeImage = [[UIImageView alloc] init];
    [storeImage setFrame:CGRectMake(0, -84, 320, self.view.frame.size.height+84)];
    [storeImage setImage:[UIImage imageNamed:@"二维码.jpg"]];
    [self.view addSubview:storeImage];
    [storeImage release];
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
//	//singleTap.numberOfTouchesRequired = 1; singleTap.numberOfTapsRequired = 1; //singleTap.delegate = self;
//	[self.view addGestureRecognizer:singleTap];

    [self startZBarReaderViewController];
}

- (void)handleSingleTap1:(UIGestureRecognizer *)handleSingle
{
    
    CGPoint locationTouch = [handleSingle locationInView:self.view];
    
    if(handleSingle.state == UIGestureRecognizerStateEnded){
        CGRect rect = CGRectMake(0, 100, 320, 454); //1
        
        if (CGRectContainsPoint(rect, locationTouch)){
            
            [self startZBarReaderViewController];
        }
}
    
}

// 开启扫描二维码
- (void)startZBarReaderViewController{
    
//    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
//    reader.showsZBarControls = NO;
//    reader.readerDelegate = self;
//    reader.enableCache = YES;
//    reader.cameraMode = ZBarReaderControllerCameraModeSampling;
//    
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    [self setOverlayPickerView:reader];
//    ZBarImageScanner *scanner = reader.scanner;
//    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
//    view.backgroundColor = [UIColor clearColor];
//    reader.cameraOverlayView = view;
//    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
//    image.frame = CGRectMake(20, 80, 280, 280);
//    [view addSubview:image];
//
//    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
//    _line.image = [UIImage imageNamed:@"line.png"];
//    [image addSubview:_line];
//    //定时器，设定时间过1.5秒，
//    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
//    [self presentViewController:reader animated:YES completion:nil];
//    [reader release];
//    [self performSelector:@selector(reSetNavigationBarStatus) withObject:nil afterDelay:2];
    
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (2*num == 260) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
}

- (void)reSetNavigationBarStatus{
//    if (self.navigationController.navigationBarHidden == YES) {
//        self.navigationController.navigationBarHidden = NO;
//        navigationBarHasHidden = NO;
//    }
}
//重新绘制 ZBarReaderViewController View视图
//- (void)setOverlayPickerView:(ZBarReaderViewController *)reader{
//    //清除原有控件
//    for (UIView *temp in [reader.view subviews]) {
//        for (UIButton *button in [temp subviews]) {
//            if ([button isKindOfClass:[UIButton class]]) {
//                [button removeFromSuperview];
//            }
//        }
//        
//        for (UIToolbar *toolbar in [temp subviews]) {
//            
//            if ([toolbar isKindOfClass:[UIToolbar class]]) {
//                [toolbar setHidden:YES];
//                [toolbar removeFromSuperview];
//            }
//        }
//    }
//    
//    //画中间的基准线
////    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
////    line.backgroundColor = [UIColor redColor];
////    [reader.view addSubview:line];
////    [line release];
//    
//    //最上部view
//    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
//    upView.alpha = 0.3;
//    upView.backgroundColor = [UIColor blackColor];
//    [reader.view addSubview:upView];
//    
//    //用于说明的label
//    UILabel * labIntroudction= [[UILabel alloc] init];
//    labIntroudction.backgroundColor = [UIColor clearColor];
//    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
//    labIntroudction.numberOfLines=2;
//    labIntroudction.textColor=[UIColor whiteColor];
//    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
//    [upView addSubview:labIntroudction];
//    [labIntroudction release];
//    [upView release];
//    
//    //左侧的view
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 280)];
//    leftView.alpha = 0.3;
//    leftView.backgroundColor = [UIColor blackColor];
//    [reader.view addSubview:leftView];
//    [leftView release];
//    
//    //右侧的view
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 280)];
//    rightView.alpha = 0.3;
//    rightView.backgroundColor = [UIColor blackColor];
//    [reader.view addSubview:rightView];
//    [rightView release];
//    
//    //底部view
//    UIView *downView = nil;
//    if (iPhone5) {
//        downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 220)];
//    }
//    else{
//        downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 120)];
//    }
//    downView.alpha = 0.3;
//    downView.backgroundColor = [UIColor blackColor];
//    [reader.view addSubview:downView];
//    [downView release];
//    
//    //用于取消操作的button
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.backgroundColor = [UIColor clearColor];
//    cancelButton.alpha = 0.4;
//    if (iPhone5) {
//        [cancelButton setFrame:CGRectMake(20, 420, 280, 40)];
//    }
//    else{
//        [cancelButton setFrame:CGRectMake(20, 390, 280, 40)];
//    }
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
//    [reader.view addSubview:cancelButton];
//    
//}
//
//#pragma -
//#pragma UIImagePickerControllerDelegate
//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info{
//    
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        break;
//    [info objectForKey: UIImagePickerControllerOriginalImage];
//    //判断是否包含 头'http:'
//    NSString *regex = @"http+:[^\\s]*";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    
//    NSLog(@"url=%@",symbol.data);
//    
//    if ([predicate evaluateWithObject:symbol.data]) {
//        [reader dismissViewControllerAnimated:NO completion:^{
//            NSLog(@"Dismiss completed");
//            OpenURLViewController *openUrl = [[OpenURLViewController alloc] init];
//            [openUrl  initWithUrl:symbol.data andTitle:nil];
//            [self.navigationController pushViewController:openUrl animated:YES];
//        [openUrl release];
////            [self goDuoBaoDetailView:symbol.data];
//        }];
//    }
//}
//取消button方法

- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backHomePage{
    
    [self.navigationController popViewControllerAnimated:YES];
    //重载cookie,以免部分值域丢失
    //    [super reloadStoredCookies];
}

@end
