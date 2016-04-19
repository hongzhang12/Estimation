//
//  DetailPresentationController.m
//  Estimation
//
//  Created by zhanghong on 16/4/19.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "DetailPresentationController.h"
#import "DetailAnimator.h"

@interface DetailPresentationController()

@property (nonatomic ,weak) UIView *dimmingView;

@end

@implementation DetailPresentationController

// life cycle
- (void)presentationTransitionWillBegin{
    
    self.dimmingView.alpha = 0;
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    if (transitionCoordinator) {
        
        // 同时执行这个动画
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            self.dimmingView.alpha = 0.7;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            
        }];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    
    if (!completed) {
        
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin{
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    if (transitionCoordinator) {
        
        // 同时执行这个动画
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            self.dimmingView.alpha = 0.01;
        } completion:nil];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
    if (completed) {
        
        [self.dimmingView removeFromSuperview];
    }
}

// 回调方法
- (void)dimmingViewClicked{
    
//    ZHTransitionDelegate *transitionDelegate = (ZHTransitionDelegate *)self.presentedViewController.transitioningDelegate;
//    // 先把panGesture置为nil，不然会进行交互式动画
//    transitionDelegate.panGesture = nil;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

// 懒加载
- (UIView *)dimmingView{
    
    if (_dimmingView == nil) {
        
        UIView *dimmingView = [[UIView alloc] init];
        dimmingView.backgroundColor = [UIColor blackColor];
        [self.containerView addSubview:dimmingView];
        
        [dimmingView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.containerView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewClicked)];
        [dimmingView addGestureRecognizer:tap];
        
        _dimmingView = dimmingView;
    }
    
    return _dimmingView;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return [[DetailPresentAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return [[DetailDismissAnimator alloc] init];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return [[DetailPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
