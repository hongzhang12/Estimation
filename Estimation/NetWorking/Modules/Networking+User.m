//
//  Networking+User.m
//  Estimation
//
//  Created by zhanghong on 16/4/22.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "Networking+User.h"
#import "RequestFactory.h"

@implementation Networking (User)

+ (NSURLSessionTask *)getServiceAgentsWithEmail:(NSString *)email success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSMutableURLRequest *mutableReuqest = [RequestFactory serviceAgentsRequestWithEmail:email];
    
    return [[Networking shareNetworking] performRequestWithRawRet:mutableReuqest success:success failure:failure];
}

@end
