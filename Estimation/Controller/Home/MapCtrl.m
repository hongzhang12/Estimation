//
//  MapCtrl.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "MapCtrl.h"
#import <AMap2DMap/MAMapKit/MAMapKit.h>
#import "MapAnnotationView.h"
#import "DetailCtrl.h"

static NSString *const MapApiKey = @"159a71e2891356a60cec359c9f5aa996";

@interface MapCtrl ()<MAMapViewDelegate>

@property (nonatomic ,weak) MAMapView *mapView;

@property (nonatomic ,weak) MapAnnotationView *selectAnnoatationView;

@end

@implementation MapCtrl

- (void)viewDidLoad {
    
    [MAMapServices sharedServices].apiKey = MapApiKey;
//    if (![CLLocationManager locationServicesEnabled]) {
//        
//        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//        hud.labelText = @"定位服务不可用，请在设置中打开";
//        [hud show:YES];
//    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RandomColor;
    //159a71e2891356a60cec359c9f5aa996
    
    [self getMapData];
}

- (void)setUpView{
    
    MAMapView *mapView = [[MAMapView alloc] init];
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [mapView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
}

- (void)getMapData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(39.54 ,116.23);
        //    annotation.title = @"annotation.title";
        //    annotation.subtitle = @"annotation.subtitle";
        
        MAPointAnnotation *annotation1 = [[MAPointAnnotation alloc] init];
        annotation1.coordinate = CLLocationCoordinate2DMake(39.34 ,116.69);
        
        NSArray *annotationArr = @[annotation ,annotation1];
        
        [self.mapView addAnnotations:annotationArr];
        
        [self.mapView showAnnotations:annotationArr edgePadding:UIEdgeInsetsMake(200, 200, 200, 200) animated:NO];
    });
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointAnnotationID = @"pointAnnotationID";
        MapAnnotationView *annotationView = (MapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointAnnotationID];
        
        if (annotationView == nil) {
            
            annotationView  = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointAnnotationID];
            
            annotationView.calloutViewTapCallBack = ^{
                
                [self.navigationController pushViewController:[[DetailCtrl alloc] init] animated:YES];
            };
            
            return annotationView;
        }
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"定位失败--%@",error);
    
    [mapView setShowsUserLocation:YES];
}

@end
