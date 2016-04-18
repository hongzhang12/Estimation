//
//  HomeCtrl.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "HomeContainerCtrl.h"

@interface HomeContainerCtrl ()

// 避免控制器频繁创建以及数据的重复请求,使用strong
@property (nonatomic ,assign) Class leftCtrlClass;
@property (nonatomic ,assign) Class rightCtrlClass;

@property (nonatomic ,strong) UIViewController *leftCtrl;
@property (nonatomic ,strong) UIViewController *rightCtrl;

@property (nonatomic ,weak) UISegmentedControl *segControl;

@end

@implementation HomeContainerCtrl

- (instancetype)initWithLeftCtrl:(Class)leftCtrlClass andRightCtrlClass:(Class)rightCtrlClass{
    
    NSAssert(leftCtrlClass&&rightCtrlClass, @"leftCtrlClass and rightCtrlClass must not be nil");
    
    if (self = [super init]) {
        
        self.leftCtrlClass = leftCtrlClass;
        self.rightCtrlClass = rightCtrlClass;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpView{
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"List" ,@"Map"]];
    [segControl addTarget:self action:@selector(segmentControlChanged:) forControlEvents:UIControlEventValueChanged];
    segControl.tintColor = RGBColor(13, 177, 244);
    segControl.backgroundColor = [UIColor whiteColor];
    segControl.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:segControl];
    self.segControl = segControl;
    
    [segControl alignCenterXWithView:self.view predicate:@"0"];
    [segControl alignLeadingEdgeWithView:self.view predicate:@"100"];
    [segControl alignTopEdgeWithView:self.view predicate:@"64"];
    [segControl constrainHeight:@"44"];
    
    segControl.selectedSegmentIndex = 0;
    [self segmentControlChanged:segControl];
}

#pragma mark - UI Events

- (void)segmentControlChanged:(UISegmentedControl *)segControl{
    
    NSInteger index = segControl.selectedSegmentIndex;
    
    UIViewController *oldCtrl = nil;
    UIViewController *newCtrl = nil;
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionNone;
    
    if (index == 0) {
        
        // 第一次进入页面是并没有oldCtrl
        if (self.childViewControllers.count == 0) {
            
            oldCtrl = nil;
            newCtrl = self.leftCtrl;
        }else{
            
            oldCtrl = self.rightCtrl;
            newCtrl = self.leftCtrl;
            options = UIViewAnimationOptionTransitionFlipFromRight;
        }
    }else if(index == 1){
        
        oldCtrl = self.leftCtrl;
        newCtrl = self.rightCtrl;
        options = UIViewAnimationOptionTransitionFlipFromLeft;
    }
    [self switchOldCtrl:oldCtrl intoNewCtrl:newCtrl withOptions:options];
}

- (void)switchOldCtrl:(UIViewController *)oldCtrl intoNewCtrl:(UIViewController *)newCtrl  withOptions:(UIViewAnimationOptions)options{
    
    
    if (oldCtrl == nil) {
        
        [self addChildViewController:newCtrl];
        
        [self addConstrainsWithNewCtrl:newCtrl];
        
        [newCtrl didMoveToParentViewController:self];
    }else{

        [oldCtrl willMoveToParentViewController:nil];
        [self addChildViewController:newCtrl];
        
        [self addConstrainsWithNewCtrl:newCtrl];
        
        [self transitionFromViewController:oldCtrl toViewController:newCtrl duration:0.75 options:options animations:^{
            
            
        } completion:^(BOOL finished) {
            
            [oldCtrl removeFromParentViewController];
            [newCtrl didMoveToParentViewController:self];
        }];
    }
}

- (void)addConstrainsWithNewCtrl:(UIViewController *)newCtrl{
    
    UIView *rootView = newCtrl.view;
    
    [self.view addSubview:rootView];
    
    [rootView constrainTopSpaceToView:self.segControl predicate:@"20"];
    [rootView alignLeading:@"0" trailing:@"0" toView:self.view];
    [rootView alignBottomEdgeWithView:self.view predicate:@"0"];
}

#pragma mark - getter and setter

- (UIViewController *)leftCtrl{
    
    if (_leftCtrl == nil) {
        
        _leftCtrl = [[_leftCtrlClass alloc] init];
    }
    
    return _leftCtrl;
}

- (UIViewController *)rightCtrl{
    
    if (_rightCtrl == nil) {
        
        _rightCtrl = [[_rightCtrlClass alloc] init];
    }
    
    return _rightCtrl;
}

@end
