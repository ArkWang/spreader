//
//  AASMSManager.m
//  AASpreader
//
//  Created by yd on 2016/3/27.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AASMSManager.h"
#import <SMS_SDK/SMSSDK.h>

@implementation AASMSManager

+ (void)registerSMSService
{
    [SMSSDK registerApp:kAASMSAppKey withSecret:kAASMSAppSecret];
}

@end
