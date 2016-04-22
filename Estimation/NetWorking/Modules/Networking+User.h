//
//  Networking+User.h
//  Estimation
//
//  Created by zhanghong on 16/4/22.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "Networking.h"

@interface Networking (User)

+ (NSURLSessionTask *)getServiceAgentsWithEmail:(NSString *)email success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
