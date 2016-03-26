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

@end
