//
//  MapAnnotationView.h
//  Estimation
//
//  Created by zhanghong on 16/4/17.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MapInfoView.h"

@interface MapAnnotationView : MAPinAnnotationView

@property (nonatomic ,weak ,readonly) MapInfoView *calloutView;

@end
