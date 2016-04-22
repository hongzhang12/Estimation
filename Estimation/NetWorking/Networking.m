//
//  Networking.m
//  Estimation
//
//  Created by zhanghong on 16/4/20.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "Networking.h"
#import <Mantle/Mantle.h>

typedef NS_ENUM(NSInteger, HttpResponseStatusType) {
    
    HttpResponseStatusDefault     = 0,
    HttpResponseStatusSuccess     = 2,
    HttpResponseStatusClientError = 4,
    HttpResponseStatusServerError = 5,
};

static NSString *const kClientError     = @"kClientError";
static NSString *const kServerError     = @"kServerError";
static NSString *const kNetworkingError = @"kNetworkingError";
static NSString *const kParserError     = @"kParserError";


@interface Networking()

@property (nonatomic ,strong) NSURLSession *httpSession;

@end

@implementation Networking

+ (Networking *)shareNetworking{
    
    static Networking  *_shareNetworking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareNetworking = [[Networking alloc] init];
        
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        conf.timeoutIntervalForRequest = 30;
        _shareNetworking.httpSession = [NSURLSession sessionWithConfiguration:conf];
    });
    
    return _shareNetworking;
}

- (NSURLSessionTask *)requestWithRawRet:(NSURLRequest *)request success:(void (^)(NSData *data))success failure:(void (^)(NSError *error))failure{
    
    NSURLSessionTask *task = [self.httpSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        NSInteger statusCode = httpResponse.statusCode;
        
        NSInteger statusType = statusCode/100;
        
        if (statusType == HttpResponseStatusSuccess) {
            
            if (data.length == 0) {
                
                data = nil;
            }
            
            success(data);
        }else{
            
            NSError *newError = nil;
            
            if (error == nil) {
                
                if (statusType == HttpResponseStatusClientError) {
                    
                    newError = [NSError errorWithDomain:kClientError code:statusCode userInfo:nil];
                }else if (statusType == HttpResponseStatusServerError){
                    
                    newError = [NSError errorWithDomain:kServerError code:statusCode userInfo:nil];
                }
            }else{
                
                newError = [NSError errorWithDomain:kNetworkingError code:statusCode userInfo:nil];
            }
            
            failure(newError);
        }
    }];
    
    [task resume];
    return task;
}

- (NSURLSessionTask *)performRequestWithRawRet:(NSURLRequest *)request success:(void (^)(NSData *data))success failure:(void (^)(NSError *error))failure{
    
    return [self requestWithRawRet:request success:^(NSData *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            success(data);
        });
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failure(error);
        });
    }];
}

- (NSURLSessionTask *)performRequestWithJson:(NSURLRequest *)request success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    return [self performRequestWithRawRet:request success:^(NSData *data) {
        
        if (data == nil) {
            
            success(nil);
        }else{
            
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError) {
                
                NSError *error = [NSError errorWithDomain:kParserError code:jsonError.code userInfo:jsonError.userInfo];
                failure(error);
            }{
                
                success(json);
            }
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionTask *)performRequestWithModel:(NSURLRequest *)request modelClass:(Class)modelClass withKey:(NSString *)key success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    return [self performRequestWithJson:request success:^(id json) {
        
        if (json == nil) {
            
            success(nil);
            return;
        }
        
        NSError *error = nil;
        id jsonDict = key?[json objectForKey:key]:json;
        id modelDict = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:jsonDict error:&error];
        if (modelDict==nil && error==nil) {
            
            error = [NSError errorWithDomain:kParserError code:0 userInfo:nil];
        }
        if (error) {
            
            failure(error);
        }else{
            
            success(modelDict);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionTask *)performRequestWithModelArray:(NSURLRequest *)request modelClass:(Class)modelClass withKey:(NSString *)key success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    return [self performRequestWithJson:request success:^(id json) {
        
        if (json == nil) {
            
            success(nil);
            return;
        }
        
        NSError *error = nil;
        NSArray *jsonArray = key?[json objectForKey:key]:json;
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:modelClass fromJSONArray:jsonArray error:&error];
        if (modelArray == nil && error == nil) {
            
            error = [NSError errorWithDomain:kParserError code:0 userInfo:nil];
        }
        
        if (error) {
            
            failure(error);
        }else{
            
            success(modelArray);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
