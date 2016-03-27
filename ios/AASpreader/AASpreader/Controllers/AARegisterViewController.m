//
//  AARegisterViewController.m
//  AASpreader
//
//  Created by yd on 2016/3/12.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AARegisterViewController.h"

@interface AARegisterViewController ()

@property (nonatomic, assign) NSUInteger requestId;

@end

@implementation AARegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismissSelf:(id)sender
{
    // dismiss keyboard
    [self dismissKeyboard];
    // dismiss self or pop
    [super dismissSelf:sender];
}

- (IBAction)sendVerifyCode:(UIButton *)sender
{
    NSString *mobile = @"18100001111";
    NSString *errorMsg = [AAProfileManager checkMobile:mobile];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
    } else {
        // send request
        if (self.requestId > 0) {
            return;
        }
        NSDictionary *params = @{@"mobile": mobile};
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *verifyTask = [[AARequest sharedInstance] get:kAARequestUserRegisterCode parameters:params completion:^(id result, NSError *error) {
            weakSelf.requestId = 0;
            if (!error) {
                if ([result isKindOfClass:[NSDictionary class]]) {
                    // toast 验证码短信已发送
                }
            } else {
                NSLog(@"LOGIN ERROR : %@", error);
            }
        }];
        self.requestId = verifyTask.taskIdentifier;
    }
}

- (IBAction)registerButtonClicked:(UIButton *)sender
{
    // get input
    NSDictionary *inputDict = @{@"mobile": @"18100001111", @"password": @"123456", @"repeatPwd": @"123456", @"code": @"123456"};
    // check input
    BOOL validInput = [self checkInput:inputDict];
    if (validInput) {
        // build request
        [self requestRegister:inputDict];
    }
    
}

- (BOOL)checkInput:(NSDictionary *)inputDict
{
    NSString *mobile = inputDict[@"mobile"];
    NSString *password = inputDict[@"password"];
    NSString *repeadPwd = inputDict[@"repeatPwd"];
    NSString *code = inputDict[@"code"];
    
    NSString *errorMsg = [AAProfileManager checkMobile:mobile];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    if (![code matchesRegex:@"^\\d{6}$" options:0]) {
        errorMsg = @"验证码格式错误";
        return NO;
    }
    errorMsg = [AAProfileManager checkPassword:password];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    if (![password isEqualToString:repeadPwd]) {
        errorMsg = @"两次密码不一致";
        return NO;
    }
    return YES;
}

- (void)requestRegister:(NSDictionary *)inputDict
{
    if (self.requestId > 0) {
        return;
    }
    NSString *encodedPwd = [AAProfileManager encodedPassword:inputDict[@"password"]];
    NSDictionary *params = @{@"mobile": inputDict[@"mobile"], @"password": encodedPwd, @"code": inputDict[@"code"]};
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *loginTask = [[AARequest sharedInstance] get:kAARequestUserRegister parameters:params completion:^(id result, NSError *error) {
        weakSelf.requestId = 0;
        if (!error) {
            if ([result isKindOfClass:[NSDictionary class]]) {
                AAUser *user = [AAUser modelWithJSON:result[@"result"]];
                user.mobile = params[@"mobile"];
                [AAProfileManager sharedProfileManager].currentUser = user;
                // pop or dismiss
                [weakSelf dismissSelf:nil];
            }
        } else {
            NSLog(@"LOGIN ERROR : %@", error);
        }
    }];
    self.requestId = loginTask.taskIdentifier;
}


@end
