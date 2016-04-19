//
//  MapAnnotationView.h
//  Estimation
//
//  Created by zhanghong on 16/4/17.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MapInfoView.h"

@class MapAnnotationView;
typedef void(^CalloutViewTapCallBack)();

@interface MapAnnotationView : MAPinAnnotationView

@property (nonatomic ,weak ,readonly) MapInfoView *calloutView;

@property (nonatomic ,copy) CalloutViewTapCallBack calloutViewTapCallBack;

@end
