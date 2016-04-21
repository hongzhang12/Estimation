//
//  DetailAnimator.m
//  Estimation
//
//  Created by zhanghong on 16/4/18.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "DetailAnimator.h"

@implementation DetailPresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return kDetailTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kDetailSliderWith];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    toView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addConstraints:@[left ,top ,bottom ,width]];

    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:kDetailTransitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        left.constant = -kDetailSliderWith;
        
        // 这句必须用containerView调
        [containerView layoutIfNeeded];

    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:finished];
    }];
}

@end

@implementation DetailDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return kDetailTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];

    NSLayoutConstraint *constraint;
    
    for (NSLayoutConstraint *cons in containerView.constraints) {
        
        if (cons.constant < 0) {
            
            constraint = cons;
            break;
        }
    }
    
    [UIView animateWithDuration:kDetailTransitionDuration animations:^{
        
        constraint.constant = 0;
        // 这句必须用containerView调
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [fromView removeFromSuperview];
        [transitionContext completeTransition:finished];
    }];
}

@end