//
//  AARequest.h
//  AASpreader
//
//  Created by yd on 2016/3/12.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AARequest : NSObject

// singletion
+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)get:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion;

- (NSURLSessionDataTask *)post:(NSString *)urlPath parameters:(NSDictionary *)params completion:(void (^)(id result, NSError *error))completion;

@end
