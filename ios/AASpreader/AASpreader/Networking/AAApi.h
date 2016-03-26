//
//  AAApi.h
//  AASpreader
//
//  Created by yd on 2016/3/26.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#ifndef AAApi_h
#define AAApi_h

/**
 *  user login and register
 */
static NSString *const kAARequestUserLogin = @"user/login";
static NSString *const kAARequestUserResetPwd = @"user/resetPwd";
static NSString *const kAARequestUserRegisterCode = @"user/registerCode";
static NSString *const kAARequestUserRegister = @"user/register";
static NSString *const kAARequestUserLogout = @"user/logout";
/**
 *  list and post
 */
static NSString *const kAARequestListGet = @"list/getList";
static NSString *const kAARequestListFocus = @"list/focus";
static NSString *const kAARequestPost = @"post/send";

#endif /* AAApi_h */
