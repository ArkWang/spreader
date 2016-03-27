//
//  AABaseViewController.m
//  AASpreader
//
//  Created by yd on 2016/3/20.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import "AABaseViewController.h"

@interface AABaseViewController ()

@end

@implementation AABaseViewController

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

#pragma mark - custom setting
- (void)customizeNavigationBar
{
    if (self.navigationController) {
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        UINavigationItem *navigationItem = self.navigationItem;
        navigationBar.barTintColor = [UIColor redColor];
        navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName: [UIColor whiteColor]};
        navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    }
}

- (void)setNavigationTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (UIBarButtonItem *)barButtonItem:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.image = image;
    barButtonItem.title = title;
    barButtonItem.actionBlock = block;
    return barButtonItem;
}

- (void)setLeftBarButtonItem:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *barButtonItem = [self barButtonItem:image title:title actionBlock:block];
    if (!barButtonItem.actionBlock) {
        [barButtonItem setTarget:self];
        [barButtonItem setAction:@selector(dismissSelf:)];
    }
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)setRightBarButtonItem:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *barButtonItem = [self barButtonItem:image title:title actionBlock:block];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}


#pragma mark - dismiss
- (void)dismissKeyboard
{
    [self setEditing:NO];
}

- (IBAction)dismissSelf:(id)sender
{
    // dismiss self or pop
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
