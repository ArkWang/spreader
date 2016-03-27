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

@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) IBOutlet UIButton *loginButton;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mobileTextField becomeFirstResponder];
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

- (IBAction)loginButtonClicked:(UIButton *)sender
{
    [self dismissKeyboard];
    // get input
    NSString *mobile = self.mobileTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *inputDict = @{@"mobile": mobile ? mobile : @"", @"password": password ? password : @""};
    // check input
    BOOL validInput = [self checkInput:inputDict];
    if (validInput) {
        // build request
        [self requestLogin:inputDict];
    }
}

- (BOOL)checkInput:(NSDictionary *)inputDict
{
    NSString *mobile = inputDict[@"mobile"];
    NSString *password = inputDict[@"password"];
    NSString *errorMsg = [AAProfileManager checkMobile:mobile];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    errorMsg = [AAProfileManager checkPassword:password];
    if (errorMsg) {
        NSLog(@"LOGIN ERROR : %@", errorMsg);
        return NO;
    }
    return YES;
}

- (void)requestLogin:(NSDictionary *)inputDict
{
    if (self.requestId > 0) {
        return;
    }
    NSString *encodedPwd = [AAProfileManager encodedPassword:inputDict[@"password"]];
    NSDictionary *params = @{@"mobile": inputDict[@"mobile"], @"password": encodedPwd};
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *loginTask = [[AARequest sharedInstance] get:kAARequestUserLogin parameters:params completion:^(id result, NSError *error) {
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
