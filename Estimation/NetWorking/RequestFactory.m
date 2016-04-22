//
//  RequestFactory.m
//  Estimation
//
//  Created by zhanghong on 16/4/21.
//  Copyright © 2016年 zhanghong. All rights reserved.
//

#import "RequestFactory.h"

static CGFloat const kRequestTimeoutInvertal = 30.0;

static NSString *_accessToken;

static NSString *const baseUrl = @"http://192.168.1.11:3000";


@implementation NSMutableURLRequest (Builder)

- (void)ss_armWithXformBodyParams:(NSDictionary*)params{
    NSString* formStr = [self ss_combineParams:params];
    formStr = [self ss_formBodyencodeHttpString:formStr];
    
    NSData* formData = [formStr dataUsingEncoding:NSUTF8StringEncoding];
    
    self.HTTPBody = formData;
    
    [self addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self addValue:[@(formData.length) stringValue] forHTTPHeaderField:@"Content-Length"];
}

- (void)ss_armWithJsonBodyParams:(NSDictionary*)params{
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    self.HTTPBody = bodyData;
    [self addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self addValue:[@(bodyData.length) stringValue] forHTTPHeaderField:@"Content-Length"];
}

- (void)ss_armWithQueryParams:(NSDictionary*)params{
    NSString *queryStr = [self ss_combineParams:params];
    queryStr = [self ss_encodeHttpString:queryStr];
    NSString *newUrlStr = [NSString stringWithFormat:@"%@?%@", self.URL.absoluteString, queryStr];
    self.URL = [NSURL URLWithString:newUrlStr];
}

- (void)ss_armWithMultiPartData:(NSData*)data keyValues:(NSDictionary*)dict name:(NSString*)name{
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n", boundary];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, boundary];
    [self addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *tempPostData = [NSMutableData data];
    [tempPostData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Key Value for data
    if(dict){
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [tempPostData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [tempPostData appendData:[obj dataUsingEncoding:NSUTF8StringEncoding]];
            [tempPostData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        }];
    }
    
    // file to send as data
    [tempPostData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
    [tempPostData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [tempPostData appendData:data];
    [tempPostData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self setHTTPBody:tempPostData];
}

- (NSString*)ss_encodeHttpString:(NSString*)string{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*)ss_formBodyencodeHttpString:(NSString*)string{
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&="];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}

- (NSString*)ss_combineParams:(NSDictionary*)params{
    NSMutableString *combined = [[NSMutableString alloc]init];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [combined appendString:key];
        [combined appendString:@"="];
        [combined appendString:obj];
        [combined appendString:@"&"];
    }];
    [combined deleteCharactersInRange:NSMakeRange(combined.length-1, 1)];
    
    return combined;
}

@end

@implementation RequestFactory

+ (NSString *)accessToken{
    
    return _accessToken;
}

+ (void)setAccessToken:(NSString *)accessToken{
    
    _accessToken = accessToken;
}

+ (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                     error:(NSError *)error{
    
    return [self requestWithMethod:method URLString:URLString parameters:nil error:error];
}

+ (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     error:(NSError *)error{
    
    NSParameterAssert(method);
    NSParameterAssert(URLString);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@" ,baseUrl ,URLString]];
    
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = method;
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *userAgent = [NSString stringWithFormat:@"SAAS iOS %@ %@", version, build];
    [mutableRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    if (_accessToken) {
        
        [mutableRequest setAllHTTPHeaderFields:@{@"accessToken" : _accessToken}];
    }
    
    if (parameters) {
        
        mutableRequest = [self requestBySerializingRequest:mutableRequest withParametrs:parameters error:error];
    }
    
    if (error) {
        
        NSLog(@"序列化失败");
        NSParameterAssert(NO);
    }
    
    return mutableRequest;
}

+ (NSMutableURLRequest *)requestBySerializingRequest:(NSMutableURLRequest *)request
                                       withParametrs:(NSDictionary *)parameters
                                               error:(NSError *)error{
    
    NSParameterAssert(request);
    NSParameterAssert(parameters);
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    if ([mutableRequest.HTTPMethod.uppercaseString isEqualToString:@"POST"]) {
        
        [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        mutableRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    }else{
        
        NSString *queryString = [self queryStringWithParameters:parameters];
        
        NSString *urlString = [mutableRequest.URL.absoluteString stringByAppendingString:[self encodeHttpString:queryString]];
        mutableRequest.URL = [NSURL URLWithString:urlString];
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    return mutableRequest;
}

+ (NSString *)queryStringWithParameters:(NSDictionary *)parameters{
    
    NSMutableString *mutableString = [NSMutableString stringWithString:@"?"];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [mutableString appendString:key];
        [mutableString appendString:@"="];
        [mutableString appendString:obj];
        [mutableString appendString:@"&"];
    }];
    
    [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length-1, 1)];
    
    return mutableString;
}

+ (NSString *)encodeHttpString:(NSString *)httpString{
    
    return [httpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSMutableURLRequest *)serviceAgentsRequestWithEmail:(NSString *)email{
    
    NSError *error = nil;
    return [self requestWithMethod:@"GET" URLString:@"/api/property-companies/by" parameters:@{@"userEmail" : email} error:error];
}

@end
