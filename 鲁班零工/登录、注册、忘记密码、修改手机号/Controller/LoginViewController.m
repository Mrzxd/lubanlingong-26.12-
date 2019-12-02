
//
//  LoginViewController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/13.
//  Copyright © 2019 张兴栋. All rights reserved.
#import "LBTabBarController.h"
#import "RegisterController.h"
#import "LoginViewController.h"
#import "LBNavigationController.h"
#import "ForgetPasswordController.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *phoneTextField;
    UITextField *passWordTextField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}
- (void)addSubViews {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(154*ScalePpth, statusHeight + 63*ScalePpth, 67*ScalePpth, 67*ScalePpth)];
    imageView.image = [UIImage imageNamed:@"register_logo"];
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 7 *ScalePpth;
    [self.view addSubview:imageView];
    
    UIImageView *reflectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(154*ScalePpth,  statusHeight + 130*ScalePpth, 67*ScalePpth, 67*ScalePpth)];
    reflectedImageView.image = [UIImage imageNamed:@"register_logo_shadow"];
    reflectedImageView.clipsToBounds = YES;
    reflectedImageView.layer.masksToBounds = YES;
    reflectedImageView.layer.cornerRadius = 7 *ScalePpth;
    [reflectedImageView sizeToFit];
    [self.view addSubview:reflectedImageView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView.image = [UIImage imageNamed:@"register_phone"];
    [imgView sizeToFit];
    [view1 addSubview:imgView];
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 246*ScalePpth +statusHeight, 300, 30)];
    phoneTextField.leftView = view1;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.font = FontSize(15);
    phoneTextField.delegate = self;
    phoneTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneTextField];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 283*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineOne.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineOne];
    
    UIView *view2 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_password"]];
    [imgView2 sizeToFit];
    [view2 addSubview:imgView2];
    passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 315*ScalePpth +statusHeight, 300, 30)];
    passWordTextField.leftView = view2;
    passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTextField.borderStyle = UITextBorderStyleNone;
    passWordTextField.font = FontSize(15);
    passWordTextField.delegate = self;
    passWordTextField.placeholder = @"请输入密码";
    [self.view addSubview:passWordTextField];
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 348*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineTwo.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineTwo];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 397*ScalePpth +statusHeight, 300*ScalePpth, 45*ScalePpth)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    loginButton.titleLabel.font = FontSize(17);
    loginButton.backgroundColor = RGBHex(0xFFD301);
    loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
    loginButton.layer.masksToBounds = YES;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 455*ScalePpth +statusHeight, 60*ScalePpth, 13*ScalePpth)];
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    registerButton.titleLabel.font = FontSize(13);
    [registerButton addTarget:self action:@selector(toRegisters:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(272*ScalePpth, 455*ScalePpth +statusHeight, 60*ScalePpth, 13*ScalePpth)];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    forgetButton.titleLabel.font = FontSize(13);
    [forgetButton addTarget:self action:@selector(forgetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
}
- (void)forgetButtonAction:(UIButton *)button {
    ForgetPasswordController *fvc = [ForgetPasswordController new];
    fvc.isPresent = YES;
    LBNavigationController *lbnavi = [[LBNavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:lbnavi animated:YES completion:nil];
}
- (void)toRegisters:(UIButton *)button {
    [self presentViewController:[[RegisterController alloc] init] animated:YES completion:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    CGRect frame = self.view.frame;
    if (frame.origin.y == 0) {(frame.origin.y -= 110);frame.size.height += 110;};
    self.view.frame = frame;
    return YES;
}
- (void)loginButtonAction:(UIButton *)button {
    if (![self isMobileNumberOnly:phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if (passWordTextField.text.length < 6) {
        [WHToast showErrorWithMessage:@"请输入6位数以上密码"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking putWithUrl:[rootUrl stringByAppendingString:@"/login"]params:@{
                                                                       @"username":phoneTextField.text,
                                                                       @"password":passWordTextField.text,
                                                                       } success:^(id  _Nonnull response) {
                                                                           if (response && [response[@"code"] intValue] == 0) {
                                                                               [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"login_state"];
                                                                               [[NSUserDefaults standardUserDefaults] setObject:response[@"data"][@"userId"] forKey:@"userId"];
                                                                               if (weakSelf.isRe_visit) {
                                                                                   [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                                                                   return ;
                                                                               }
                                                                               LBTabBarController *tabbarVc = [LBTabBarController new];
                                                                                [weakSelf presentViewController:tabbarVc animated:YES completion:nil];
                                                                           } else {
                                                                               [WHToast showErrorWithMessage:@"登录失败"];
                                                                           }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.view.frame = CGRectMake(0, 0,  ScreenWidth,ScreenHeight);
    [textField endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.frame = CGRectMake(0, 0,  ScreenWidth,ScreenHeight);
    [phoneTextField endEditing:YES];
    [passWordTextField endEditing:YES];
}

@end


