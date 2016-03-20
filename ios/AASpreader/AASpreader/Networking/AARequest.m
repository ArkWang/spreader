//
//  AARequest.m
//  AASpreader
//
//  Created by yd on 2016/3/12.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AARequest.h"
#import "AFHTTPSessionManager.h"

static NSString *const kAABaseUrl = @"http://192.168.31.147:8080/";//@"http://127.0.0.1:8080/";

@interface AARequest()

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

@end

@implementation AARequest

+ (instancetype)sharedInstance
{
    static id _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self class] new];
        // initialize and customize a request manager
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSSet *responseAcceptableContentTypes = manager.responseSerializer.acceptableContentTypes;
        if (![responseAcceptableContentTypes containsObject:@"text/plain"]) {
            NSMutableSet *modifiedSet = [NSMutableSet setWithSet:responseAcceptableContentTypes];
            [modifiedSet addObject:@"text/plain"];
            manager.responseSerializer.acceptableContentTypes = modifiedSet;
        }
        [_shareInstance setRequestManager:manager];
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

- (NSURLSessionDataTask *)get:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion
{
    NSURLSessionDataTask *dataTask = [self.requestManager GET:[self fullUrl:urlPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    
    
    NSLog(@"GET From URL:%@, Task ID: %ld", [dataTask.currentRequest.URL description], dataTask.taskIdentifier);
    return dataTask;
}

- (NSURLSessionDataTask *)post:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion
{
    NSURLSessionDataTask *dataTask = [self.requestManager POST:[self fullUrl:urlPath] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    
    NSLog(@"POST From URL:%@, Task ID: %ld", [dataTask.currentRequest.URL description], dataTask.taskIdentifier);
    return dataTask;
}

@end
