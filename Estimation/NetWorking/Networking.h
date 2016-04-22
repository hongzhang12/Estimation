//
//  Networking.h
//  Estimation
//
//  Created by zhanghong on 16/4/20.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

@end

@interface Networking(Private)

+ (Networking *)shareNetworking;

- (NSURLSessionTask *)performRequestWithRawRet:(NSURLRequest *)request success:(void (^)(NSData *data))success failure:(void (^)(NSError                    *error))failure;

- (NSURLSessionTask *)performRequestWithJson:(NSURLRequest *)request success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

- (NSURLSessionTask *)performRequestWithModel:(NSURLRequest *)request modelClass:(Class)modelClass withKey:(NSString *)key success:(void (^)(id model))success failure:(void (^)(NSError *error))failure;

- (NSURLSessionTask *)performRequestWithModelArray:(NSURLRequest *)request modelClass:(Class)modelClass withKey:(NSString *)key success:(void (^)(NSArray *modelArray))success failure:(void (^)(NSError *error))failure;
@end