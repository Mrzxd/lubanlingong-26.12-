//
//  ZXDBaseViewController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved .
//

#import "ZXDBaseViewController.h"

@interface ZXDBaseViewController ()

@end

@implementation ZXDBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GlobalSingleton.gS_ShareInstance.currentViewController = self;
    //手势返回开启
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController && (self.navigationController.viewControllers.firstObject != self))
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(-30, 0, 35, 35);
    [backButton setTitle:@"" forState:UIControlStateNormal];
    [backButton setImage:[[UIImage imageNamed:@"top_left_arrow-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:19 *ScalePpth];
    _titleLabel.textColor = RGBHex(0x333333);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text  = title;
    [_titleLabel sizeToFit];
}

- (void)pop
{
    if (_isPresent)
        [self dismissViewControllerAnimated:YES completion:nil];
     else
         [self.navigationController popViewControllerAnimated:NO];
}
- (BOOL)detectLoginStatusIsNoLogined {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        return YES;
    }
    return NO;
}
- (void)toLoginWithInfo:(NSString *)info {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        LoginViewController *login = [[LoginViewController alloc] init];login.isRe_visit = YES;
        [GlobalSingleton.gS_ShareInstance.currentViewController presentViewController:login animated:YES completion:nil];
    }
}

@end
