//
//  THViewController.m
//  ZoweeSale
//
//  Created by wanglj on 16/2/17.
//  Copyright © 2016年 TH. All rights reserved.
//
#import <objc/runtime.h>
#import "THViewController.h"


@interface THViewController ()

@end

@implementation THViewController

- (void)changeTextTowhite {
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = RGBHex(0x252b33);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (self.navigationController && (self.navigationController.viewControllers.firstObject != self))
    {
        [self setBackBtnHidden:NO];
    }
    else
    {
        [self setBackBtnHidden:YES];
    }
    //手势返回开启
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
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

#pragma mark - 界面显示方法
/**
 *  返回上级页面
 */
- (void)clickedBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackBtnHidden:(BOOL)hidden
{
    self.navigationItem.leftBarButtonItem.customView.hidden = hidden;
}

-(void)setBackBtnEnable:(BOOL)enable
{
    self.navigationItem.leftBarButtonItem.enabled = enable;
    ((UIButton*)self.navigationItem.leftBarButtonItem.customView).enabled = enable;
}

- (void)setRightBtn:(UIButton *)Btn
{
    UIBarButtonItem * rightStateItem = [[UIBarButtonItem alloc] initWithCustomView:Btn];
    self.navigationItem.rightBarButtonItem = rightStateItem;
}


@end
