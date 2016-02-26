//
//  AppraiseViewController.m
//  sjsh
//
//  Created by savvy on 15/11/26.
//  Copyright (c) 2015年 世纪生活. All rights reserved.
//

#import "AppraiseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "SVProgressHUD.h"


@interface AppraiseViewController ()

@property(nonatomic,strong) UITableView *appraiseTableView;//评价列表
@property(nonatomic,strong) UIButton *appraiseButton;//评价按钮

@property(nonatomic,strong) UIButton *photographButton;//晒单
@property(nonatomic,strong) UIImageView *photographImageView;//所拍图片
@property(nonatomic,strong) DJQRateView *commodityGradeView;//商品评分控件



@property(nonatomic,strong) NSString *lastChosenMediaType;//拍照方式

@property(nonatomic,assign) float  appraiseScore;//评分
@property(nonatomic,assign) BOOL  isSubmitAppraise;//是否可以提交评论
@property(nonatomic,assign) int imageCount;//图片数量
@property(nonatomic,assign) int imageURLCount;//图片地址数量
@end

@implementation AppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSubmitAppraise = NO;
    self.imageCount=0;
    self.imageURLCount=0;
    
    NSLog(@"评价页面数据为%@!!!!",self.appraiseArray);
    
    [super initNavBarItems:@"评价晒单"];
    [super addButtonReturn:@"leftReturn" lightedImage:@"leftReturn" selector:@selector(toReturn)];
    self.view.backgroundColor = dilutedGrayColor;
    
    self.appraiseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.appraiseButton addTarget:self action:@selector(submitAppraise) forControlEvents:UIControlEventTouchUpInside];
    self.appraiseButton.backgroundColor = kRedColor;
    [self.appraiseButton setTitle:@"发布评价" forState:UIControlStateNormal];
    self.appraiseButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.appraiseButton];
    
    self.appraiseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-60-64)];
    self.appraiseTableView.delegate = self;
    self.appraiseTableView.dataSource = self;
    self.appraiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.appraiseTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.appraiseTableView];
    
    
    self.photographImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50)];
    self.photographImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.photographImageView];
    
    //    self.photographButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 50)];
    ////    self.photographButton.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.photographButton setTitle:@"晒单" forState:UIControlStateNormal];
    //    self.photographButton.backgroundColor = kRedColor;
    //    self.photographButton.layer.cornerRadius = 5;
    //    self.photographButton.layer.masksToBounds = YES;
    //        [self.view addSubview:self.photographButton];
    
    
    
    
}

//提交评价
-(void)submitAppraise{
    
    [super showGif];
    
    NSLog(@"提交评价！！！");
    // self.appraiseArray[[myDictionary[@"position"] integerValue]][@"appraiseValue"] = myDictionary[@"appraiseValue"];//评分
    //NSMutableArray *imageArray = newAppraiseArray[self.cellPosition][@"imageArray"] ;//图片
    
    //上传照片
    for (int i=0; i<self.appraiseArray.count; i++) {//每个商品
        NSArray *imageArray =  self.appraiseArray[i][@"imageArray"];
        for (int j=0; j<imageArray.count; j++) {//每个图片
            UIImage *myImage = imageArray[j][@"image"];
            //            [self submitImage:myImage];
            if (myImage) {
                
                NSData *imageData =  UIImageJPEGRepresentation(myImage, .5);//返回压缩后的图片数据
                
                NSString * imageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                NSMutableDictionary *imageDictionary = [[NSMutableDictionary alloc]init];
                imageDictionary[@"img"] = imageString;
                imageDictionary[@"orderIndex"] = [NSNumber numberWithInt:i];
                imageDictionary[@"imageIndex"] = [NSNumber numberWithInt:j];
                
                
                CommonModel *common = [[CommonModel alloc] initWithTarget:self];//取消单例，实现异步操作
                [common submitImageByPost:imageDictionary httpRequestSucceed:@selector(submitImageByPostSuccess:) httpRequestFailed:@selector(requestFailed:)];
//                [NSThread sleepForTimeInterval:2.0f];
            }else{
                NSLog(@"照片不存在！");
            }
            self.imageCount++;
        }
    }
    self.isSubmitAppraise = YES;
    if (self.imageCount==0) {//直接提交评论
        NSMutableDictionary *appraiseDictionary = [[NSMutableDictionary alloc]init];
        appraiseDictionary[@"order_id"] = self.orderID;
        
        NSMutableArray *appraiseSubmitArray = [[NSMutableArray alloc]init];
        for (int i=0; i<self.appraiseArray.count; i++) {
            NSMutableDictionary *appraiseSubmitDictionary = [[NSMutableDictionary alloc]init];
            NSDictionary *myDictionary = self.appraiseArray[i];
            appraiseSubmitDictionary[@"pid"] = myDictionary[@"product_id"];//商品编号
            appraiseSubmitDictionary[@"com"] = (myDictionary[@"appraiseComment"]!=nil)?myDictionary[@"appraiseComment"]:@"";//评论
            appraiseSubmitDictionary[@"statr"] = (myDictionary[@"appraiseValue"]!=nil)?myDictionary[@"appraiseValue"]:@"5";//评分
            NSMutableArray *cellImageArray = [[NSMutableArray alloc]init];
            appraiseSubmitDictionary[@"pic"] = cellImageArray;//图片
            [appraiseSubmitArray addObject:appraiseSubmitDictionary];
        }
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:appraiseSubmitArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"所选的地址为%@!!!!!",jsonString);
        
        
        appraiseDictionary[@"reviews"] = jsonString;
        
        [commonModel submitAppraiseByPost:appraiseDictionary httpRequestSucceed:@selector(submitAppraiseByPostSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
}



//上传图片成功
- (void)submitImageByPostSuccess:(ASIHTTPRequest *)request{
    //    [super hideGif];
    self.imageURLCount++;
    //     NSLog(@"上传图片responseString：%@",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"上传图片dic：%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        NSInteger  orderIndex = [dic[@"orderIndex"] integerValue];
        NSInteger  imageIndex = [dic[@"imageIndex"] integerValue];
        NSMutableArray *imageArray = self.appraiseArray[orderIndex][@"imageArray"];
        imageArray[imageIndex][@"imageURL"] = dic[@"img"];
        if (self.isSubmitAppraise&&self.imageURLCount==self.imageCount) {//图片都上传完成，提交评价
            
            NSMutableDictionary *appraiseDictionary = [[NSMutableDictionary alloc]init];
            appraiseDictionary[@"order_id"] = self.orderID;
            
            NSMutableArray *appraiseSubmitArray = [[NSMutableArray alloc]init];
            for (int i=0; i<self.appraiseArray.count; i++) {
                NSMutableDictionary *appraiseSubmitDictionary = [[NSMutableDictionary alloc]init];
                NSDictionary *myDictionary = self.appraiseArray[i];
                appraiseSubmitDictionary[@"pid"] = myDictionary[@"product_id"];//商品编号
                appraiseSubmitDictionary[@"com"] = (myDictionary[@"appraiseComment"]!=nil)?myDictionary[@"appraiseComment"]:@"";//评论
                appraiseSubmitDictionary[@"statr"] = (myDictionary[@"appraiseValue"]!=nil)?myDictionary[@"appraiseValue"]:@"5";//评分
                NSMutableArray *cellImageArray = [[NSMutableArray alloc]init];
                for (int j=0; j<imageArray.count; j++) {
                    cellImageArray[j] = imageArray[j][@"imageURL"];
                }
                appraiseSubmitDictionary[@"pic"] = cellImageArray;//图片
                [appraiseSubmitArray addObject:appraiseSubmitDictionary];
            }
            
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization
                                dataWithJSONObject:appraiseSubmitArray options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"所选的地址为%@!!!!!",jsonString);
            
            
            appraiseDictionary[@"reviews"] = jsonString;
            
            [commonModel submitAppraiseByPost:appraiseDictionary httpRequestSucceed:@selector(submitAppraiseByPostSuccess:) httpRequestFailed:@selector(requestFailed:)];
        }else{
            NSLog(@"未上传完成！");
            
        }
    }
}

//提交评价成功
- (void)submitAppraiseByPostSuccess:(ASIHTTPRequest *)request{
    [super hideGif];
    NSLog(@"提交评价responseString：%@!!!!!",request.responseString);
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"提交评价dic：%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self toReturn];
    }
}

//接口调用错误
- (void)requestFailed:(ASIHTTPRequest *)request
{ [super hideGif];
    NSLog(@"接口调用错误%@！！！！！！",request.error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败，请重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appraiseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"AppraiseEditCell";
    
    AppraiseEditCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[AppraiseEditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    NSMutableDictionary *myDictionary = [self.appraiseArray[indexPath.row] mutableCopy];
    myDictionary[@"cellPosition"] = [NSNumber numberWithLong:indexPath.row];
    cell.position = indexPath.row;
    [cell setCellInfo:myDictionary];
    return cell;
    
}

#pragma mark cell代理方法


//拍照
- (void)doPhotograph:(NSMutableDictionary *)myDictionary{
    
    NSLog(@"拍照的代理方法%@！",myDictionary);
    
    self.cellPosition = [myDictionary[@"cellPosition"] integerValue];
    NSArray *imageArray = myDictionary[@"imageArray"];
    if(imageArray.count<4 ){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择图片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [alert show];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"照片已达上限！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    
}

//删除图片
- (void)deleteImage:(NSMutableDictionary *)myDictionary{
    NSLog(@"删除图片的代理方法%@!!!!！",myDictionary);
    //    NSLog(@"列表数据%@!!!!！",self.appraiseArray);
    self.cellPosition = [myDictionary[@"cellPosition"] integerValue];
    NSInteger imagePosition = [myDictionary[@"imagePosition"] integerValue];
    NSMutableArray *imageArray = [self.appraiseArray[self.cellPosition][@"imageArray"] mutableCopy] ;
    [imageArray removeObjectAtIndex:imagePosition];
    //    [imageArray removeAllObjects];
    self.appraiseArray[self.cellPosition][@"imageArray"] = imageArray;
    //     NSLog(@"修改后的列表数据%@!!!!！",self.appraiseArray);
    [self.appraiseTableView reloadData];
}

//更新评分数量
- (void)updateGradeData:(NSMutableDictionary *)myDictionary{
    NSLog(@"更新评分的代理方法%@!!!!！",myDictionary);
    
    self.appraiseArray[[myDictionary[@"position"] integerValue]][@"appraiseValue"] = myDictionary[@"appraiseValue"];
    [self.appraiseTableView reloadData];
}

//更新评论内容
- (void)updateComment:(NSMutableDictionary *)myDictionary{
    self.appraiseArray[[myDictionary[@"position"] integerValue]][@"appraiseComment"] = myDictionary[@"appraiseComment"];
    [self.appraiseTableView reloadData];
}


#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPiicturePrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        NSLog(@"获取照片成功，开始显示")
        
        UIImage *chosenImage=[info objectForKey:UIImagePickerControllerEditedImage];
        //                     self.photographImageView.image=chosenImage;
        NSMutableArray *newAppraiseArray =  self.appraiseArray;
        NSMutableArray *imageArray = newAppraiseArray[self.cellPosition][@"imageArray"] ;
        NSMutableDictionary *imageDictionary = [[NSMutableDictionary alloc]init];
        imageDictionary[@"image"] = chosenImage;
        [imageArray addObject:imageDictionary];
        self.appraiseArray = newAppraiseArray;
        [self.appraiseTableView reloadData];//添加拍照的数据
        
    }
    if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:^{
        }];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}

@end
