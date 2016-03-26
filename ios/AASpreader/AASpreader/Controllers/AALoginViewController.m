//
//  AALoginViewController.m
//  AASpreader
//
//  Created by yd on 2016/3/12.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AALoginViewController.h"

@interface AALoginViewController ()

@property (nonatomic, assign) NSUInteger requestId;

@end

@implementation AALoginViewController

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

- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    // dismiss keyboard
    [self dismissKeyboard];
    // dismiss self or pop
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)loginButtonClicked:(UIButton *)sender
{
    // get input
    NSDictionary *inputDict = @{@"mobile": @"18100001111", @"password": @"123456"};
    // check input
    BOOL validInput = [self checkInput:inputDict];
    if (validInput) {
        // build request
        [self requestLogin:inputDict];
    }
    
}

- (void)dismissKeyboard
{
    [self setEditing:NO];
}

- (BOOL)checkInput:(NSDictionary *)inputDict
{
    NSString *mobile = inputDict[@"mobile"];
    NSString *password = inputDict[@"password"];
    NSString *errorMsg = [self checkMobile:mobile];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    errorMsg = [self checkPassword:password];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    return YES;
}

- (NSString *)checkMobile:(NSString *)mobile
{
    if (mobile.length <= 0) {
        return @"手机号不能为空";
    }
    return nil;
}

- (NSString *)checkPassword:(NSString *)password
{
    if (password.length <= 0) {
        return @"密码不能为空";
    } else if (password.length < 6) {
        return @"密码至少为6位";
    }
    return nil;
}

- (void)requestLogin:(NSDictionary *)inputDict
{
    if (self.requestId > 0) {
        return;
    }
    NSDictionary *params = @{@"mobile": inputDict[@"mobile"], @"password": inputDict[@"password"]};
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *loginTask = [[AARequest sharedInstance] get:kAARequestUserLogin parameters:params completion:^(id result, NSError *error) {
        weakSelf.requestId = 0;
        if (!error) {
            if ([result isKindOfClass:[NSDictionary class]]) {
                AAUser *user = [AAUser modelWithJSON:result[@"result"]];
                user.mobile = params[@"mobile"];
                [AAProfileManager sharedProfileManager].currentUser = user;
                // pop or dismiss
                [weakSelf cancelButtonClicked:nil];
            }
        } else {
            NSLog(@"LOGIN ERROR : %@", error);
        }
    }];
    self.requestId = loginTask.taskIdentifier;
}

@end
