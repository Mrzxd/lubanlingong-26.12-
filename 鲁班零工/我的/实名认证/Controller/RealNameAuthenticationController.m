
//
//  RealNameAuthenticationController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "LBNavigationController.h"
#import "ServiceAuthenticationController.h"
#import "RealNameAuthenticationController.h"
#import "EmployerCertificationController.h"

@interface RealNameAuthenticationController ()
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIButton *selectButton;
@end

@implementation RealNameAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
     _type = @"1";
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
    _selectButton = workerBtn;
    [workerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [workerBtn addTarget:self action:@selector(workerBtnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [EmployerBtn addTarget:self action:@selector(EmployerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [authenticationButton addTarget:self action:@selector(authenticationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    authenticationButton.titleLabel.font = FontSize(17);
    authenticationButton.backgroundColor = RGBHex(0xFFD301);
    authenticationButton.layer.cornerRadius = 45.0/2*ScalePpth;
    authenticationButton.layer.masksToBounds = YES;
    authenticationButton.clipsToBounds = YES;
    [self.view addSubview:authenticationButton];
}
- (void)workerBtnBtnAction:(UIButton *)button {
    [_selectButton setTitleColor:RGBHex(0xFFB924) forState:UIControlStateNormal];
    _selectButton.backgroundColor = RGBHex(0xffffff);
    button.backgroundColor = RGBHex(0xFFB924);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _type = @"1";
    _selectButton = button;
}
- (void)EmployerBtnAction:(UIButton *)button {
    [_selectButton setTitleColor:RGBHex(0xFFB924) forState:UIControlStateNormal];
     _selectButton.backgroundColor = RGBHex(0xffffff);
     button.backgroundColor = RGBHex(0xFFB924);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     _type = @"0";
     _selectButton = button;
}
- (void)authenticationButtonAction:(UIButton *)button {
    [self real_name_authentication_query];
}
- (void)real_name_authentication_query {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/CardId"] params:@{@"type":_type NonNull} success:^(id  _Nonnull response) {
        switch ([response[@"code"] intValue]) {
            case 0: {
                    if (weakSelf.type.intValue == 0) {
                        [weakSelf toEmployerCertificationController];
                    } else {
                        [weakSelf toServiceAuthenticationController];
                    }
            }
                break;
            case 1: {
                [WHToast showSuccessWithMessage:@"已通过审核认证" duration:1.8 finishHandler:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
                break;
            case 2: {
//                [WHToast showErrorWithMessage:@"审核失败,请重新上传身份证等资料" duration:1.7 finishHandler:^{
                    if (weakSelf.type.intValue == 0) {
                        [weakSelf toEmployerCertificationController];
                    } else {
                        [weakSelf toServiceAuthenticationController];
                    }
//                }];
            }
                break;
            case 3: {
                [WHToast showErrorWithMessage:@"已上传身份证没审核,请等待审核通过" duration:1.8 finishHandler:^{
                   [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
                break;
            default:
                break;
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}
- (void)toEmployerCertificationController {
        EmployerCertificationController *employerCertificationController = [EmployerCertificationController new];
        employerCertificationController.isPresent = YES;
        LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:employerCertificationController];
        [self presentViewController:navi animated:YES completion:nil];
}
- (void)toServiceAuthenticationController {
        ServiceAuthenticationController *serviceAuthenticationvc = [ServiceAuthenticationController new];
        serviceAuthenticationvc.isPresent = YES;
        LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:serviceAuthenticationvc];
        [self presentViewController:navi animated:YES completion:nil];
}
@end
