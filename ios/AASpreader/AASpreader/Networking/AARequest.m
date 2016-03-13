//
//  AARequest.m
//  AASpreader
//
//  Created by yd on 2016/3/12.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AARequest.h"
#import "AFHTTPSessionManager.h"

static NSString *const kAABaseUrl = @"http://127.0.0.1:8080/";

@interface AARequest()

@end

@implementation AARequest

- (instancetype)sharedInstance
{
    static id _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self class] new];
    });
    return _shareInstance;
}

- (NSString *)baseURL
{
    return kAABaseUrl;
}

- (NSString *)fullUrl:(NSString *)urlPath
{
    return [[self baseURL] stringByAppendingString:urlPath];
}

- (void)get:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion
{
    [[AFHTTPSessionManager manager] GET:[self fullUrl:urlPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // success
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // failure
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)post:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion
{
    [[AFHTTPSessionManager manager] POST:[self fullUrl:urlPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // success
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // failure
        if (completion) {
            completion(nil, error);
        }
    }];
}

@end
