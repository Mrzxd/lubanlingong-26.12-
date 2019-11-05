
//
//  RealNameAuthenticationController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "RealNameAuthenticationController.h"

@interface RealNameAuthenticationController ()

@end

@implementation RealNameAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    
    CGFloat space = (111 - 64) *ScalePpth +statusHeight;
    UILabel *identity = [[UILabel alloc] initWithFrame:AutoFrame(0, space, 375, 23)];
    identity.font  = FontSize(23);
    identity.textAlignment = NSTextAlignmentCenter;
    identity.textColor =  RGBHex(0x333333);
    identity.text = @"请选择你的身份";
    [self.view addSubview:identity];
    
     CGFloat space2 = (197.5 - 64) *ScalePpth +statusHeight;
    UIButton *workerBtn = [[UIButton alloc] initWithFrame:AutoFrame(133, space2, 109.5, 109.5)];
    workerBtn.backgroundColor = RGBHex(0xFFB924);
    [workerBtn setTitle:@"我是工人" forState:UIControlStateNormal];
    [workerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workerBtn.titleLabel.font  = FontSize(20);
//    workerBtn.clipsToBounds = YES;
    workerBtn.layer.shadowColor = RGBHex(0xCCCCCC).CGColor;//阴影颜色
    workerBtn.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    workerBtn.layer.shadowOpacity = 1;//不透明度
    workerBtn.layer.shadowRadius = 8;//半径
    workerBtn.layer.cornerRadius = 109.5 *ScalePpth/2;
//    workerBtn.layer.masksToBounds = YES;
    [self.view addSubview:workerBtn];
    
    CGFloat space3 = (346.5 - 64) *ScalePpth +statusHeight;
    UIButton *EmployerBtn = [[UIButton alloc] initWithFrame:AutoFrame(133, space3, 109.5, 109.5)];
    EmployerBtn.backgroundColor = RGBHex(0xffffff);
    
    [EmployerBtn setTitle:@"我是雇主" forState:UIControlStateNormal];
    [EmployerBtn setTitleColor:RGBHex(0xFFB924) forState:UIControlStateNormal];
    EmployerBtn.titleLabel.font  = FontSize(20);
//    EmployerBtn.clipsToBounds = YES;
    EmployerBtn.layer.shadowColor = RGBHex(0xCCCCCC).CGColor;//阴影颜色
    EmployerBtn.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    EmployerBtn.layer.shadowOpacity = 1;//不透明度
    EmployerBtn.layer.shadowRadius = 8;//半径
    EmployerBtn.layer.cornerRadius = 109.5 *ScalePpth/2;
//    EmployerBtn.layer.masksToBounds = YES;
    [self.view addSubview:EmployerBtn];
    
    UIButton *authenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 508*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
    [authenticationButton setTitle:@"去认证" forState:UIControlStateNormal];
    [authenticationButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    authenticationButton.titleLabel.font = FontSize(17);
    authenticationButton.backgroundColor = RGBHex(0xFFD301);
    authenticationButton.layer.cornerRadius = 45.0/2*ScalePpth;
    authenticationButton.layer.masksToBounds = YES;
    authenticationButton.clipsToBounds = YES;
    [self.view addSubview:authenticationButton];
}

@end
