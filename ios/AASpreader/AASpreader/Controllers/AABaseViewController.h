//
//  AABaseViewController.h
//  AASpreader
//
//  Created by yd on 2016/3/20.
//  Copyright © 2016年 airyLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AABaseViewController : UIViewController

#pragma mark - custom setting
- (void)setNavigationTitle:(NSString *)title;
- (void)setLeftBarButtonItem:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(id sender))block;
- (void)setRightBarButtonItem:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(id sender))block;

#pragma mark - dismiss
- (void)dismissKeyboard;
- (IBAction)dismissSelf:(id)sender;

@end
