//
//  ViewController.m
//  AASpreader
//
//  Created by yd on 2016/3/9.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading  the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doTestRequest:(id)sender
{
    NSDictionary *apiTestDic = @{@"hello.action": @{}};
    /*
    @{@"user/login":@{@"mobile":@"18100001111", @"password":@"123456"},
      @"user/register":@{@"mobile":@"18100001111", @"password":@"123456", @"code":@"233233"},
      @"user/logout":@{@"sessionId":@"asdf1234"},
      @"user/registerCode":@{@"mobile":@"18100001111"},
      @"user/resetPwd":@{@"mobile":@"18100001111", @"password":@"123456", @"code":@"233233"}};*/
    for (NSString *key in [apiTestDic allKeys]) {
        [self apiTest:key params:apiTestDic[key]];
    }
}

- (void)apiTest:(NSString *)urlPath params:(NSDictionary *)params
{
    NSURLSessionDataTask *testTask = [[AARequest sharedInstance] get:urlPath parameters:params completion:^(id result, NSError *error) {
        if (!error) {
            NSLog(@"%@ -- %@", urlPath, result);
        } else {
            NSLog(@"%@ -- %@", urlPath, error);
        }
    }];
}
@end
