//
//  AppDelegate.m
//  EstimationDemo
//
//  Created by zhanghong on 16/4/14.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "AppDelegate.h"
#import "PageModuleManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setUpWindow];
    [[PageModuleManager shareManager] jumpToHomeCtrl];
    
    return YES;
}

- (void)setUpWindow{
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [window makeKeyAndVisible];
    self.window = window;
}


@end
