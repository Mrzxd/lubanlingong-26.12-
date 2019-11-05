//
//  ForgetPasswordController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/24.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController () <UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *phoneTextField;
    UITextField *verificationCodeField;
    UITextField *_passWordTextField;
    UITextField *_scPassWordTextField;
    UIButton *lastButton;
}
@end

@implementation ForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubViews];
}
- (void)addSubViews {
    
    UIView *view1 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView.image = [UIImage imageNamed:@"register_phone"];
    [imgView sizeToFit];
    [view1 addSubview:imgView];
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 64*ScalePpth +KNavigationHeight, 300, 30)];
    phoneTextField.leftView = view1;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.font = FontSize(15);
    phoneTextField.delegate = self;
    phoneTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneTextField];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 100*ScalePpth +KNavigationHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineOne.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineOne];
    
    UIView *view2 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView2.image = [UIImage imageNamed:@"register_verification"];
    [imgView2 sizeToFit];
    [view2 addSubview:imgView2];
    verificationCodeField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 124.5*ScalePpth +KNavigationHeight, 300, 30)];
    verificationCodeField.leftView = view2;
    verificationCodeField.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeField.leftViewMode = UITextFieldViewModeAlways;
    verificationCodeField.borderStyle = UITextBorderStyleNone;
    verificationCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationCodeField.font = FontSize(15);
    verificationCodeField.delegate = self;
    verificationCodeField.placeholder = @"请输入验证码";
    [self.view addSubview:verificationCodeField];
    
    UIButton *getVerificationCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(248*ScalePpth, 115.5*ScalePpth +KNavigationHeight, 90*ScalePpth, 30*ScalePpth)];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerificationCodeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    getVerificationCodeButton.titleLabel.font = FontSize(13);
    getVerificationCodeButton.backgroundColor = RGBHex(0xFFD301);
    getVerificationCodeButton.layer.cornerRadius = 30.0/2*ScalePpth;
    getVerificationCodeButton.layer.masksToBounds = YES;
    getVerificationCodeButton.clipsToBounds = YES;
    [self.view addSubview:getVerificationCodeButton];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 160.5*ScalePpth +KNavigationHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineTwo.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineTwo];
    
    UIView *view3 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView3.image = [UIImage imageNamed:@"register_password"];
    [imgView3 sizeToFit];
    [view3 addSubview:imgView3];
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 185*ScalePpth +KNavigationHeight, 300, 30)];
    _passWordTextField.leftView = view3;
    _passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passWordTextField.borderStyle = UITextBorderStyleNone;
    _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWordTextField.font = FontSize(15);
    _passWordTextField.delegate = self;
    _passWordTextField.placeholder = @"请输入密码";
    [self.view addSubview:_passWordTextField];
    
    UIView *view4 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView4.image = [UIImage imageNamed:@"register_password"];
    [imgView4 sizeToFit];
    [view4 addSubview:imgView4];
    _scPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 248*ScalePpth +KNavigationHeight, 300, 30)];
    _scPassWordTextField.leftView = view4;
    _scPassWordTextField.leftViewMode = UITextFieldViewModeAlways;
    _scPassWordTextField.borderStyle = UITextBorderStyleNone;
    _scPassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _scPassWordTextField.font = FontSize(15);
    _scPassWordTextField.delegate = self;
    _scPassWordTextField.placeholder = @"请再次输入密码";
    [self.view addSubview:_scPassWordTextField];
    
    UIView *lineThree = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 221*ScalePpth +KNavigationHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineThree.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineThree];
    UIView *linef = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 281.5*ScalePpth +KNavigationHeight, 300*ScalePpth, 0.8*ScalePpth)];
    linef.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:linef];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 330.5*ScalePpth +KNavigationHeight, 300*ScalePpth, 45*ScalePpth)];
    [loginButton setTitle:@"提交" forState:UIControlStateNormal];
    [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    loginButton.titleLabel.font = FontSize(17);
    loginButton.backgroundColor = RGBHex(0xFFD301);
    loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
    loginButton.layer.masksToBounds = YES;
    loginButton.clipsToBounds = YES;
    [self.view addSubview:loginButton];

    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 298*ScalePpth +KNavigationHeight, 11*ScalePpth, 11*ScalePpth)];
    [yesButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    lastButton = yesButton;
    yesButton.tag = 200;
    [yesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesButton];
    
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 314.5*ScalePpth +KNavigationHeight, 11*ScalePpth, 11*ScalePpth)];
    [noButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
    noButton.tag = 201;
    [noButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noButton];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(66*ScalePpth, 298*ScalePpth +KNavigationHeight, 250*ScalePpth, 10*ScalePpth)];
    explainLabel.font = FontSize(10);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并接受鲁班零工注册协议、用户隐私政策"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x378EEF) range:NSMakeRange(7, 15)];
    explainLabel.attributedText = attributedString;
    [self.view addSubview:explainLabel];
    
}
- (void)buttonAction:(UIButton *)button {
    if (lastButton != button) {
        [lastButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        lastButton = button;
    }
}
- (void)tologin:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)toRegister:(UIButton *)button {
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.view.frame = CGRectMake(0, 0,  ScreenWidth,ScreenHeight);
    [phoneTextField endEditing:YES];
    [verificationCodeField endEditing:YES];
    [_passWordTextField endEditing:YES];
    [_scPassWordTextField endEditing:YES];
}

@end
