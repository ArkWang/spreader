//
//  AAProfileManager.h
//  AASpreader
//
//  Created by yd on 2016/3/20.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AAUser.h"

@interface AAProfileManager : NSObject

@property (nonatomic, readonly, strong) AAUser *currentUser;

+ (instancetype)sharedProfileManager;

@end
