//
//  DetailAnimator.h
//  Estimation
//
//  Created by zhanghong on 16/4/18.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat kDetailTransitionDuration = 0.25f;
static CGFloat kDetailSliderWith = 650.0f;

@interface DetailPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end


@interface DetailDismissAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end