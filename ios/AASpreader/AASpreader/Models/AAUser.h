//
//  AAUser.h
//  AASpreader
//
//  Created by yd on 2016/3/20.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAUser : NSObject

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *sessionId;

/**
 *  use modelWithJSON to new an AAUser instance
 *  use modelToJSONString to
 */
@end
