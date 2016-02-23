//
//  AnnotationDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol AnnotationDefineDelegate <NSObject>

- (UIView *)getNavigationView;
- (NSString *)getDistanceToLocationWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
- (void)tapCellIndex:(NSInteger)index;
- (void)tapCallIndex:(NSInteger)index;
@end

@interface AnnotationDemoViewController : UIViewController <BMKMapViewDelegate,UIGestureRecognizerDelegate>{
	 
    UIView *backView;
}
@property (nonatomic, assign) id<AnnotationDefineDelegate>delegate;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, retain) BMKMapView* mapView;

- (void)addPointAnnotation;
@end
