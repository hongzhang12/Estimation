//
//  RequestFactory.h
//  Estimation
//
//  Created by zhanghong on 16/4/21.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestFactory : NSObject

+ (NSString *)accessToken;

+ (void)setAccessToken:(NSString *)accessToken;

@end
