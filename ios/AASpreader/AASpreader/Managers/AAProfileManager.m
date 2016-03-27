//
//  AAProfileManager.m
//  AASpreader
//
//  Created by yd on 2016/3/20.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AAProfileManager.h"

static NSString *const kAAProfilePath = @"aaprofile";
static NSString *const kAACurrentUser = @"currentuser";

@interface AAProfileManager()

@property (nonatomic, strong) YYKVStorage *storeManager;

@end

@implementation AAProfileManager

+ (instancetype)sharedProfileManager
{
    static id _sharedProfileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProfileManager = [[[self class] alloc] init];
    });
    return _sharedProfileManager;
}

+ (NSString *)profilePath
{
    NSString *basePath = [UIApplication sharedApplication].documentsPath;
    NSString *profilePath = [basePath stringByAppendingPathComponent:kAAProfilePath];
    return profilePath;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // set store manager
        YYKVStorage *storeManager = [[YYKVStorage alloc] initWithPath:[[self class] profilePath] type:YYKVStorageTypeMixed];
        _storeManager = storeManager;
        // set current user
        _currentUser = [self savedCurrentUser];
    }
    return self;
}

- (void)setCurrentUser:(AAUser *)currentUser
{
    if ([_currentUser isEqual:currentUser]) {
        return;
    }
    // save to local and update current instance
    if ([self saveCurrentUser:currentUser]) {
        _currentUser = currentUser;
        [[NSNotificationCenter defaultCenter] postNotificationName:kAAUserDidChangeNotification object:nil];
    }
}

- (AAUser *)savedCurrentUser
{
    NSData *userData = [self.storeManager getItemValueForKey:kAACurrentUser];
    AAUser *user = [AAUser modelWithJSON:[userData utf8String]];
    return user;
}

- (BOOL)saveCurrentUser:(AAUser *)user
{
    NSString *userJson = [user modelToJSONString];
    NSData *userData = [userJson dataValue];
    return [self.storeManager saveItemWithKey:kAACurrentUser value:userData];
}

@end



@implementation AAProfileManager(Verify)

+ (NSString *)checkMobile:(NSString *)mobile
{
    if (mobile.length <= 0) {
        return @"手机号不能为空";
    }
    return nil;
}

+ (NSString *)checkPassword:(NSString *)password
{
    if (password.length <= 0) {
        return @"密码不能为空";
    } else if (password.length < 6) {
        return @"密码至少为6位";
    }
    return nil;
}

+ (NSString *)encodedPassword:(NSString *)password
{
    return [password md5String];
}

@end
