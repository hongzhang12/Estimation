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

@interface MapCtrl ()<MAMapViewDelegate>

@property (nonatomic ,weak) MAMapView *mapView;

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
}

- (void)viewDidAppear:(BOOL)animated{
    
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
    
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(39.54 ,116.23);
//    annotation.title = @"annotation.title";
//    annotation.subtitle = @"annotation.subtitle";
    
    MAPointAnnotation *annotation1 = [[MAPointAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(39.34 ,116.69);
    
    [self.mapView addAnnotations:@[annotation ,annotation1]];
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointAnnotationID = @"pointAnnotationID";
        MapAnnotationView *annotationView = (MapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointAnnotationID];
        
        if (annotationView == nil) {
            
            annotationView  = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointAnnotationID];
            
            annotationView.animatesDrop = YES;
            
            return annotationView;
        }
    }
    
    return nil;
}

@end
