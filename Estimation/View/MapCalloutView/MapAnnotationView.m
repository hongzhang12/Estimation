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

@property (nonatomic ,weak) UIButton *button;

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
        
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(calloutViewTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        self.button = button;
        
        [button alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:calloutView];
        
        [calloutView constrainBottomSpaceToView:self predicate:@"-5"];
        [calloutView constrainWidth:@"400"];
        [calloutView alignCenterXWithView:self predicate:@"0"];
        
        [calloutView setData];
    }else{
        
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (void)calloutViewTapped{
    
//    __weak typeof(self) weakSelf = self;
    self.calloutViewTapCallBack();
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        
        CGPoint tempoint = [self.button convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.button.bounds, tempoint)){
            
            view = self.button;
        }
    }
    return view;
}

@end
