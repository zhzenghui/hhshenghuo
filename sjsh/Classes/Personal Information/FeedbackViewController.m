//
//  FeedbackViewController.m
//  sjsh
//
//  Created by 杜 计生 on 14/11/15.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "FeedbackViewController.h"

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [super initNavBarItems:@"意见反馈"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR(250, 250, 250);
    float y = 10;
    for (int i = 0; i<3; i++) {
        UIImageView *kuangImg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"feedback_textBack"] stretchableImageWithLeftCapWidth:7
                                                                                                                                  topCapHeight:7]];
        kuangImg.userInteractionEnabled = YES;
        float height = 180;
        switch (i) {
            case 0:
                height = 180;
                kuangImg.frame = CGRectMake(8, y, 304, height);
                UITextView *txtV = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 304-20, height-20)];
                [kuangImg addSubview:txtV];
                FBTextV = txtV;
                txtV.delegate = self;
                [txtV release];
                y += height+10;
                break;
            case 1:
            {
                height = 50;
                kuangImg.frame = CGRectMake(8, y, 304, height);
                UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 304-20, height-20)];
                text.placeholder = @"姓名";
                [kuangImg addSubview:text];
                textF1 = text;
                text.delegate = self;
                [text release];
                
                y += height+10;
            }
                break;
            case 2:
                height = 50;
                kuangImg.frame = CGRectMake(8, y, 304, height);
                UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 304-20, height-20)];
                text.placeholder = @"联系方式（手机、邮箱、QQ）";
                [kuangImg addSubview:text];
                textF2 = text;
                text.delegate = self;
                [text release];
                y += height+30;
                break;
            default:
                break;
        }
        [self.view addSubview:kuangImg];
        [kuangImg release];
    }
    UIButton *tempB = [UIButton buttonWithType:UIButtonTypeCustom];
    tempB.adjustsImageWhenHighlighted = NO;
    tempB.frame = CGRectMake(8, y, 304, 44);
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
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [textF1 resignFirstResponder];
    [textF2 resignFirstResponder];
    [FBTextV resignFirstResponder];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    CGRect rect = commitB.frame;
    if (CGRectContainsPoint(rect, point)) {
        return NO;
    }
    return YES;
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
    if (FBTextV.text.length>0 && textF2.text.length>0 && textF2.text.length>0) {
        [super showGif];
        [commonModel requestcomplaints:@{
                                         @"com":FBTextV.text,
                                         @"username":textF1.text,
                                         @"nums":textF2.text
                                         } httpRequestSucceed:@selector(commitSuccess:) httpRequestFailed:@selector(requestFailed:)];
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, -90, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.view.frame = CGRectMake(0, top_H, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}
@end
