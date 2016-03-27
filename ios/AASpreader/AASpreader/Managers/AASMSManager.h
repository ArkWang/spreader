//
//  AASMSManager.h
//  AASpreader
//
//  Created by yd on 2016/3/27.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAASMSAppKey = @"10f6c4561ee10";
static NSString * const kAASMSAppSecret = @"2002b35ae30fd672fc9a8132deab16c3";

@interface AASMSManager : NSObject

+ (void)registerSMSService;

@end
