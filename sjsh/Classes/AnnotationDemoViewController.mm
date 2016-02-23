//
//  AnnotationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#import "AnnotationDemoViewController.h"
#import "GTM_Base64.h"
#import "UIView+TKCategory.h"
#import "ISBookStore_RatingView.h"
#import "UIImageView+WebCache.h"
@interface AnnotationDemoViewController ()
{
    BMKCircle* circle;
    BMKPolygon* polygon;
    BMKPolygon* polygon2;
    BMKPolyline* polyline;
    BMKGroundOverlay* ground;
    BMKGroundOverlay* ground2;
    BMKPointAnnotation* pointAnnotation;
    BMKAnnotationView* newAnnotation;
    UIButton *arrowButtonR;
    UIButton *arrowButtonL;
}
@end


@implementation AnnotationDemoViewController

@synthesize dataList;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 504)];
    //设置地图缩放级别
    [_mapView setZoomLevel:14];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    //初始化segment
//    segment.selectedSegmentIndex=0;    
    //添加内置覆盖物
//    [self addPointAnnotation];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    if (arrowButtonL == nil && arrowButtonR == nil) {
//        arrowButtonL = [UIButton buttonWithType:UIButtonTypeCustom];
//        arrowButtonL.frame = CGRectMake(20, _mapView.frame.size.height+_mapView.frame.origin.y-54-20, 54, 54);
//        [arrowButtonL setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
//        arrowButtonL.tag = 0;
//        [arrowButtonL addTarget:self action:@selector(mapMove:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:arrowButtonL];
//        //    [arrowButtonL release];
//        
//        arrowButtonR = [UIButton buttonWithType:UIButtonTypeCustom];
//        arrowButtonR.frame = CGRectMake(320-54-20, _mapView.frame.size.height+_mapView.frame.origin.y-54-20, 54, 54);
//        [arrowButtonR setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
//        arrowButtonR.tag = 1;
//        [arrowButtonR addTarget:self action:@selector(mapMove:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:arrowButtonR];
//        //    [arrowButtonR release];
//    }
    
}

- (void)mapMove:(UIButton *)sender
{
    [self setMapRegionWithCoordinate:sender.tag==0?YES:NO];
}

//传入经纬度,将baiduMapView 锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(BOOL)left
{
    BMKCoordinateRegion region;
    CLLocationCoordinate2D coordinate = _mapView.region.center;
    BMKCoordinateSpan span = _mapView.region.span;
    NSLog(@"coordinate = (%f,%f)||span = (%f,%f)",coordinate.latitude,coordinate.longitude,span.latitudeDelta,span.longitudeDelta);
    region = BMKCoordinateRegionMake(coordinate, span);//越小地图显示越详细
    
    [_mapView setRegion:region animated:YES];//执行设定显示范围
    [_mapView setCenterCoordinate:coordinate animated:YES];//根据提供的经纬度为中心原点 以动画的形式移动到该区域
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
}

- (void)dealloc {
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}
//segment进行切换
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UISegmentedControl *tempSeg = (UISegmentedControl *)sender;
    //内置覆盖物
    if(tempSeg.selectedSegmentIndex==0)
    {
        //添加内置覆盖物
        [self addOverlayView];
        //删除标注
        if (pointAnnotation != nil)
        {
            [_mapView removeAnnotation:pointAnnotation];
            pointAnnotation=nil;
            [newAnnotation release];
            newAnnotation=nil;
        }
        //删除图片图层覆盖物
        if (ground != nil)
        {
            [_mapView removeOverlay:ground];
            ground=nil;
        }
        if (ground2 != nil)
        {
            [_mapView removeOverlay:ground2];
            ground2=nil;
        }

    }
    //添加标注
    else if(tempSeg.selectedSegmentIndex==1)
    {
        //删除圆形覆盖物
        if (circle != nil)
        {
            [_mapView removeOverlay:circle];
            circle=nil;
        }
        //删除多边形覆盖物
        if (polygon != nil)
        {
            [_mapView removeOverlay:polygon];
            polygon=nil;
        }
        //删除多边形覆盖物
        if (polygon2 != nil)
        {
            [_mapView removeOverlay:polygon2];
            polygon2=nil;
        }

        //删除折线覆盖物
        if (polyline != nil)
        {
            [_mapView removeOverlay:polyline];
            polyline=nil;
        }
        // 添加一个PointAnnotation
        if (pointAnnotation == nil) {
            [self addPointAnnotation];
        }
        //删除图片图层覆盖物
        if (ground != nil)
        {
            [_mapView removeOverlay:ground];
            ground=nil;
        }
        //删除图片图层覆盖物
        if (ground2 != nil)
        {
            [_mapView removeOverlay:ground2];
            ground2=nil;
        }

    }
    //添加图片图层
    else if(tempSeg.selectedSegmentIndex==2)
    {
        //删除圆形覆盖物
        if (circle != nil)
        {
            [_mapView removeOverlay:circle];
            circle=nil;
        }
        //删除多边形覆盖物
        if (polygon != nil)
        {
            [_mapView removeOverlay:polygon];
            polygon=nil;
        }
        //删除多边形覆盖物
        if (polygon2 != nil)
        {
            [_mapView removeOverlay:polygon2];
            polygon2=nil;
        }

        //删除折线覆盖物
        if (polyline != nil)
        {
            [_mapView removeOverlay:polyline];
            polyline=nil;
        }
        //删除标注
        if (pointAnnotation != nil)
        {
            [_mapView removeAnnotation:pointAnnotation];
            pointAnnotation=nil;
            [newAnnotation release];
            newAnnotation=nil;
        }
        //添加图片图层覆盖物(第一种)
        if (ground == nil) {
            CLLocationCoordinate2D coors;
            coors.latitude = 39.800;
            coors.longitude = 116.404;
            ground = [BMKGroundOverlay groundOverlayWithPosition:coors zoomLevel:11 anchor:CGPointMake(0.0f,0.0f) icon:[UIImage imageWithContentsOfFile:[self getMyBundlePath:@"images/test.png"]]];
            [_mapView addOverlay:ground];
        }
        //添加图片图层覆盖物(第二种)
        if (ground2 == nil) {            
            CLLocationCoordinate2D coords[2] = {0};            
            coords[0].latitude = 39.910;
            coords[0].longitude = 116.370;
            coords[1].latitude = 39.950;
            coords[1].longitude = 116.430;
            
            BMKCoordinateBounds bound;
            bound.southWest = coords[0];
            bound.northEast = coords[1];                        
            ground2 = [BMKGroundOverlay groundOverlayWithBounds:bound icon:[UIImage imageWithContentsOfFile:[self getMyBundlePath:@"images/test.png"]]];
            [_mapView addOverlay:ground2];
            
        }

    }
    
    
}
- (NSString*)getMyBundlePath:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
//        NSLog(@"%@",s);
		return s;
	}
	return nil ;
}

//添加内置覆盖物
- (void)addOverlayView
{
    // 添加圆形覆盖物
    if (circle == nil) {
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
        [_mapView addOverlay:circle];
    }
    // 添加多边形覆盖物
    if (polygon == nil) {
        CLLocationCoordinate2D coords[4] = {0};
        coords[0].latitude = 39.915;
        coords[0].longitude = 116.404;
        coords[1].latitude = 39.815;
        coords[1].longitude = 116.404;
        coords[2].latitude = 39.815;
        coords[2].longitude = 116.504;
        coords[3].latitude = 39.915;
        coords[3].longitude = 116.504;
        polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
        [_mapView addOverlay:polygon];
    }
    // 添加多边形覆盖物
    if (polygon2 == nil) {
        CLLocationCoordinate2D coords[5] = {0};
        coords[0].latitude = 39.965;
        coords[0].longitude = 116.604;
        coords[1].latitude = 39.865;
        coords[1].longitude = 116.604;
        coords[2].latitude = 39.865;
        coords[2].longitude = 116.704;
        coords[3].latitude = 39.905;
        coords[3].longitude = 116.654;
        coords[4].latitude = 39.965;
        coords[4].longitude = 116.704;
        polygon2 = [BMKPolygon polygonWithCoordinates:coords count:5];
        [_mapView addOverlay:polygon2];
    }
    //添加折线覆盖物
    if (polyline == nil) {
        CLLocationCoordinate2D coors[2] = {0};
        coors[0].latitude = 39.895;
        coors[0].longitude = 116.354;
        coors[1].latitude = 39.815;
        coors[1].longitude = 116.304;
        polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
        [_mapView addOverlay:polyline];
    }
}

//添加标注
- (void)addPointAnnotation
{
//    pointAnnotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    pointAnnotation.coordinate = coor;
//    pointAnnotation.title = @"test";
//    pointAnnotation.subtitle = @"此Annotation可拖拽!";
//    [_mapView addAnnotation:pointAnnotation];
//    [pointAnnotation release];
    if ([self.arr count]>0) {
        [_mapView removeAnnotations:_arr];
    }
    if ([self.dataList count]>0) {
        NSDictionary *item = [dataList objectAtIndex:0];
        BMKCoordinateRegion region;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[item objectForKey:@"y_l"] doubleValue], [[item objectForKey:@"x_l"] doubleValue]);
        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.001,0.03);
        region = BMKCoordinateRegionMake(coordinate, span);//越小地图显示越详细
        
        [_mapView setRegion:region animated:YES];//执行设定显示范围
        [_mapView setCenterCoordinate:coordinate animated:YES];//根据提供的经纬度为中心原点 以动画的形式移动到该区域
    }
    self.arr = [NSMutableArray arrayWithCapacity:0];
    for (int i= 0; i<[dataList count]; i++) {
        NSDictionary *item = [dataList objectAtIndex:i];
        CLLocationCoordinate2D test = CLLocationCoordinate2DMake([[item objectForKey:@"y_l"] doubleValue], [[item objectForKey:@"x_l"] doubleValue]);
        
//        NSDictionary*testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
//        NSString *x = [testdic objectForKey:@"x"];
//        NSString *y = [testdic objectForKey:@"y"];
//        NSData *xData = [GTM_Base64 decodeString:x];
//        NSData *yData = [GTM_Base64 decodeString:y];
//        NSString *longitude = [[NSString alloc] initWithData:xData encoding:NSUTF8StringEncoding];
//        NSString *latitude = [[NSString alloc] initWithData:yData encoding:NSUTF8StringEncoding];
        BMKPointAnnotation *pointAnnotation1 = [[BMKPointAnnotation alloc]init];
//        CLLocationCoordinate2D coor;
//        coor.latitude = [latitude doubleValue];
//        coor.longitude = [longitude doubleValue];
        pointAnnotation1.coordinate = test;
        //    pointAnnotation.title = @"";
        //    pointAnnotation.subtitle = @"";
        //        [_mapView addAnnotation:pointAnnotation];
        //        [pointAnnotation release];
        [self.arr addObject:pointAnnotation1];
    }
    [_mapView addAnnotations:_arr];
 
}
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[[BMKCircleView alloc] initWithOverlay:overlay] autorelease];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
		return circleView;
    }
    
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
		return polylineView;
    }
	
	if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[[BMKPolygonView alloc] initWithOverlay:overlay] autorelease];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =2.0;
		return polygonView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[[BMKGroundOverlayView alloc] initWithOverlay:overlay] autorelease];
		return groundView;
    }
	return nil;
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
//    NSString *AnnotationViewID = @"renameMark";
//    if (newAnnotation == nil) {
//        newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        // 设置颜色
//		((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
//        // 从天上掉下效果
//		((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
//        // 设置可拖拽
//		((BMKPinAnnotationView*)newAnnotation).draggable = YES;
//    }
//    return newAnnotation;
    
    NSInteger i = [_arr indexOfObject:annotation];
    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark%d",i];
    
    newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    // 设置可拖拽
    ((BMKPinAnnotationView*)newAnnotation).draggable = NO;
    //设置大头针图标
    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"pin_blue"];
    newAnnotation.canShowCallout = NO;
//    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
//    //设置弹出气泡图片
//    UIImageView *image = [[UIImageView alloc]init];
//                          //WithImage:[UIImage imageNamed:@"call"]];
//                          
//    image.backgroundColor = [UIColor whiteColor];
//    image.frame = CGRectMake(0, 0, 100, 60);
//    [popView addSubview:image];
//    //自定义显示的内容
//    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 20)];
//    driverName.text = @"大脑地图教育";
//    driverName.backgroundColor = [UIColor clearColor];
//    driverName.font = [UIFont systemFontOfSize:14];
//    driverName.textColor = [UIColor grayColor];
//    driverName.textAlignment = NSTextAlignmentCenter;
//    [popView addSubview:driverName];
//    
//    UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
//    carName.text = @"50M";
//    carName.backgroundColor = [UIColor clearColor];
//    carName.font = [UIFont systemFontOfSize:14];
//    carName.textColor = [UIColor lightGrayColor];
//    carName.textAlignment = NSTextAlignmentCenter;
//    [popView addSubview:carName];
//    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
//    pView.frame = CGRectMake(0, 0, 100, 60);
//    ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
//    ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;
//    i++;
    return newAnnotation;

}


- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [view setSelected:NO animated:NO];
    NSString *index = [view.reuseIdentifier stringByReplacingOccurrencesOfString:@"renameMark" withString:@""];
    NSLog(@"index = %@",index);
    
    [self addPopViewWithIndex:[index integerValue]];
}

- (void)addPopViewWithIndex:(NSInteger)index
{
    UIView *navView = [self.delegate getNavigationView];
    if (backView == nil) {
        backView = [[UIView alloc] initWithFrame:navView.bounds];
        backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBackView:)];
        gesture.delegate = self;
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        [backView addGestureRecognizer:gesture];
    }
    NSDictionary *dic = [self.dataList objectAtIndex:index];
    NSInteger type = [[dic objectForKey:@"manufacturer_type"] integerValue];
    
    backView.tag = index;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 124, 280, 210)];
    
    view1.backgroundColor = [UIColor whiteColor];
    CALayer *layer = view1.layer;
    layer.cornerRadius = 5.0;
    layer.shadowOpacity = 0.5;
    layer.masksToBounds = YES;
    NSInteger topX = 0;
    if (type == 3) {//无图
        view1.frame = CGRectMake(20, 200, 280, 60);
    }
    else {
        topX = 150;
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 150)];
        imagView.userInteractionEnabled = YES;
        imagView.backgroundColor = [UIColor orangeColor];
        NSString *imageUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"big_image"]];
        imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imagView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        [view1 addSubview:imagView];
        if (type == 1 ) {
            UIImageView *tuanimagView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 119, 260, 28)];
            tuanimagView.image = [UIImage imageNamed:@"map_tuanBack"];
            tuanimagView.userInteractionEnabled = YES;
            tuanimagView.backgroundColor = [UIColor clearColor];
            [view1 addSubview:tuanimagView];
            
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(28, 3, 145, 21)];
            name.text = [dic objectForKey:@"pname"];
            name.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:14];
            name.textColor = [UIColor whiteColor];
            name.textAlignment = NSTextAlignmentLeft;
            [tuanimagView addSubview:name];
            
            UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(180, 3, 70, 21)];
            price.text = [[dic objectForKey:@"special"] stringValue];
            price.backgroundColor = [UIColor clearColor];
            price.font = [UIFont systemFontOfSize:14];
            price.textColor = [UIColor whiteColor];
            price.textAlignment = NSTextAlignmentRight;
            [tuanimagView addSubview:price];
        }
        
        
    }
    
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, topX+9, 169, 21)];
    name.text = [dic objectForKey:@"name"];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:14];
    name.textColor = COLOR(100, 100, 100);
    name.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:name];
    
    UILabel *distace = [[UILabel alloc]initWithFrame:CGRectMake(10, topX+25+9, 40, 14)];

    distace.text = [self.delegate getDistanceToLocationWithlatitude:[[dic objectForKey:@"y_l"] doubleValue] longitude:[[dic objectForKey:@"x_l"] doubleValue]];
    distace.backgroundColor = [UIColor clearColor];
    distace.font = [UIFont systemFontOfSize:10];
    distace.textColor = COLOR(160, 160, 160);
    distace.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:distace];
    
    ISBookStoreRatingView *ratingView = [[ISBookStoreRatingView alloc] initWithFrame:CGRectMake(52, topX+26+9, 100, 12)];
    [ratingView setImagesDeselected:@"" partlySelected:@"" fullSelected:@"star" andDelegate:nil];
    ratingView.userInteractionEnabled = NO;
    [ratingView displayRating:[[dic objectForKey:@"star"] floatValue]];//
    [view1 addSubview:ratingView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    button.frame = CGRectMake(223, topX+5, 50, 50);
    [button addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button];
    [backView addSubview:view1];
    [navView addSubview:backView];
}

- (void)removeBackView:(UITapGestureRecognizer *)gesture
{
    [backView removeAllSubviews];
    [backView removeFromSuperview];
}

- (void)pushDetail:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCellIndex:)]) {
        [self.delegate tapCellIndex:backView.tag];
    }
    NSLog(@"tap %d",backView.tag);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    CGPoint point = [touch locationInView:backView];
    if ([touch.view isKindOfClass:[UIButton class]])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapCallIndex:)]) {
            [self.delegate tapCallIndex:backView.tag];
        }
        NSLog(@"call");
        return NO;
    }
    else if (touch.view != backView)
    {
        NSLog(@"push");
        return NO;
    }
    return YES;
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}


@end
