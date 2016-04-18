//
//  PageModuleManager.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "PageModuleManager.h"
#import "HomeContainerCtrl.h"
#import "ListCtrl.h"
#import "MapCtrl.h"

@implementation PageModuleManager

static PageModuleManager *_instance;

+ (instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[PageModuleManager alloc] init];
    });
    
    return _instance;
}

- (void)jumpToHomeCtrl{
    
    HomeContainerCtrl *homeContainerCtrl = [[HomeContainerCtrl alloc] initWithLeftCtrl:[ListCtrl class] andRightCtrlClass:[MapCtrl class]];
    
    UINavigationController *homeCtrl = [[UINavigationController alloc] initWithRootViewController:homeContainerCtrl];
    
    // 设置navBar透明
    [homeCtrl.navigationBar setBackgroundImage:[UIImage imageNamed:@"美女.jpg"] forBarMetrics:UIBarMetricsCompact];
    
    // 隐藏navBar底部细线
    for (UIView *view in homeCtrl.navigationBar.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            
            view.hidden = YES;
        }
    }
    
    
    homeContainerCtrl.title = @"ESTIMATION";
    
    homeContainerCtrl.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"美女.jpg"]];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = homeCtrl;
}

@end
