 //
//  MapAnnotationView.m
//  Estimation
//
//  Created by zhanghong on 16/4/17.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "MapAnnotationView.h"

@interface MapAnnotationView()

@property (nonatomic ,weak ,readwrite) MapInfoView *calloutView;

@end

@implementation MapAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
    
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (self.selected == selected) {
        
        return;
    }
    
    if (selected) {
        
        MapInfoView *calloutView = [[MapInfoView alloc] init];
        calloutView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:calloutView];
        self.calloutView = calloutView;
        
        [calloutView constrainBottomSpaceToView:self predicate:@"-5"];
        [calloutView constrainWidth:@"400"];
        [calloutView alignCenterXWithView:self predicate:@"0"];
        
        [calloutView setData];
    }else{
        
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
