//
//  RegisterController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/13.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController () <UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *phoneTextField;
    UITextField *verificationCodeField;
    UITextField *_passWordTextField;
    UITextField *_scPassWordTextField;
    UIButton *lastButton;
}
@property (nonatomic, strong) UITextField *invitationTextField;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    [self addSubViews];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
 // 键盘监听事件
 - (void)keyboardAction:(NSNotification*)sender {
     // 通过通知对象获取键盘frame: [value CGRectValue]
//     NSDictionary *useInfo = [sender userInfo];
//     NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
     // <注意>具有约束的控件通过改变约束值进行frame的改变处理
     if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
         CGRect frame = self.view.frame;
         if (frame.origin.y == 0) {(frame.origin.y -= 160);frame.size.height += 160;};
         self.view.frame = frame;
     }else{
         self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, ScreenHeight);
     }
 }
//获取验证码
- (void)connectToInternet {
    if (![self isMobileNumberOnly:NoneNull(phoneTextField.text)]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/updateMemberNews/verificationCode"] params:@{@"phone":phoneTextField.text NonNull} success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0 && [response[@"data"] isKindOfClass:[NSDictionary class]] && [response[@"data"] count]) {
            StrongSelf;
            strongSelf->verificationCodeField.text = response[@"data"][@"verificationCode"];
        } else {
            if (response && response[@"msg"]) {
                [WHToast showErrorWithMessage:response[@"msg"]];
            } else {
                [WHToast showErrorWithMessage:@"获取邀请码失败"];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
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
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 196*ScalePpth +statusHeight, 300, 30)];
    phoneTextField.leftView = view1;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.font = FontSize(15);
    phoneTextField.delegate = self;
    phoneTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneTextField];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 234*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineOne.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineOne];
    
    UIView *view2 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView2.image = [UIImage imageNamed:@"register_verification"];
    [imgView2 sizeToFit];
    [view2 addSubview:imgView2];
    verificationCodeField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 258*ScalePpth +statusHeight, 300, 30)];
    verificationCodeField.leftView = view2;
    verificationCodeField.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeField.leftViewMode = UITextFieldViewModeAlways;
    verificationCodeField.borderStyle = UITextBorderStyleNone;
    verificationCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationCodeField.font = FontSize(15);
    verificationCodeField.delegate = self;
    verificationCodeField.placeholder = @"请输入验证码";
    [self.view addSubview:verificationCodeField];
    
    UIButton *getVerificationCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(248*ScalePpth, 249*ScalePpth +statusHeight, 90*ScalePpth, 30*ScalePpth)];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerificationCodeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    getVerificationCodeButton.titleLabel.font = FontSize(13);
    getVerificationCodeButton.backgroundColor = RGBHex(0xFFD301);
    getVerificationCodeButton.layer.cornerRadius = 30.0/2*ScalePpth;
    getVerificationCodeButton.layer.masksToBounds = YES;
    getVerificationCodeButton.clipsToBounds = YES;
    [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerificationCodeButton];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 294*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineTwo.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineTwo];
    
    UIView *view3 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView3.image = [UIImage imageNamed:@"register_password"];
    [imgView3 sizeToFit];
    [view3 addSubview:imgView3];
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 319*ScalePpth +statusHeight, 300, 30)];
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
    
    _scPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 382*ScalePpth +statusHeight, 300, 30)];
    _scPassWordTextField.leftView = view4;
    _scPassWordTextField.leftViewMode = UITextFieldViewModeAlways;
    _scPassWordTextField.borderStyle = UITextBorderStyleNone;
    _scPassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _scPassWordTextField.font = FontSize(15);
    _scPassWordTextField.delegate = self;
    _scPassWordTextField.placeholder = @"请再次输入密码";
    [self.view addSubview:_scPassWordTextField];
    
    UIView *lineThree = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 355*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lineThree.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lineThree];
    UIView *linef = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 415*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    linef.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:linef];
    UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(38*ScalePpth, 475*ScalePpth +statusHeight, 300*ScalePpth, 0.8*ScalePpth)];
    lines.backgroundColor = RGBHex(0xeeeeee);
    [self.view addSubview:lines];
    
    UIView *view5= [[UIView alloc] initWithFrame:AutoFrame(0, 0, 29, 17)];
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 12, 17)];
    imgView5.image = [UIImage imageNamed:@"register_verification"];
    [imgView5 sizeToFit];
    [view5 addSubview:imgView5];
    
    _invitationTextField = [[UITextField alloc] initWithFrame:CGRectMake(53*ScalePpth, 442*ScalePpth +statusHeight, 300, 30)];
    _invitationTextField.leftView = view5;
    _invitationTextField.keyboardType = UIKeyboardTypeNumberPad;
    _invitationTextField.leftViewMode = UITextFieldViewModeAlways;
    _invitationTextField.borderStyle = UITextBorderStyleNone;
    _invitationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _invitationTextField.font = FontSize(15);
    _invitationTextField.delegate = self;
    _invitationTextField.placeholder = @"（选填）请输入邀请码(可选)";
    [self.view addSubview:_invitationTextField];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 524*ScalePpth +statusHeight, 300*ScalePpth, 45*ScalePpth)];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = FontSize(17);
    loginButton.backgroundColor = RGBHex(0xFFD301);
    loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
    loginButton.layer.masksToBounds = YES;
    loginButton.clipsToBounds = YES;
    [self.view addSubview:loginButton];
    UIButton *toLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(233*ScalePpth, 522*ScalePpth +statusHeight, 100*ScalePpth, 13*ScalePpth)];
    [self.view addSubview:toLoginButton];
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 491*ScalePpth +statusHeight, 11*ScalePpth, 11*ScalePpth)];
    [yesButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    lastButton = yesButton;
    yesButton.tag = 200;
    [yesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesButton];
    
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 507*ScalePpth +statusHeight, 11*ScalePpth, 11*ScalePpth)];
    [noButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
    noButton.tag = 201;
    [noButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noButton];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(66*ScalePpth, 492*ScalePpth +statusHeight, 250*ScalePpth, 10*ScalePpth)];
    explainLabel.font = FontSize(10);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并接受鲁班零工注册协议、用户隐私政策"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x378EEF) range:NSMakeRange(7, 15)];
    explainLabel.attributedText = attributedString;
    [self.view addSubview:explainLabel];
    
    UIButton *tologinButton = [[UIButton alloc] initWithFrame:CGRectMake(233*ScalePpth, 582*ScalePpth +statusHeight, 100*ScalePpth, 13*ScalePpth)];
    [tologinButton setTitle:@"已有账号去登录" forState:UIControlStateNormal];
    [tologinButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [tologinButton addTarget:self action:@selector(tologin:) forControlEvents:UIControlEventTouchUpInside];
    tologinButton.titleLabel.font = FontSize(13);
    [self.view addSubview:tologinButton];
}
- (void)getVerificationCodeButtonAction:(UIButton *)button {
    [self connectToInternet];
}
- (void)loginAction:(UIButton *)button {
    [self toRegister];
}
- (void)buttonAction:(UIButton *)button {
    if (lastButton != button) {
        [lastButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        lastButton = button;
    }
}
- (void)toRegister {
    if (_passWordTextField.text && _scPassWordTextField.text) {
        if (![_passWordTextField.text isEqualToString:_scPassWordTextField.text]) {
            [WHToast showErrorWithMessage:@"两次输入密码不一致!"];
            return;
        }
    }
    if (![self isMobileNumberOnly:phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_scPassWordTextField.text.length < 6) {
        [WHToast showErrorWithMessage:@"请输入6位数以上密码"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/updateMemberNews/registeredMembers"] params:@{
                                                                                                     @"phone":phoneTextField.text NonNull,
                                                                                                     @"password":_passWordTextField.text NonNull,
                                                                                                     @"code":verificationCodeField.text NonNull,
                                                                                                     @"verCode":NoneNull(_invitationTextField.text)
                                                                                                     } success:^(id  _Nonnull response) {
                                                                                                         if (response && [response[@"code"] intValue] == 0) {
                                                                                                             [WHToast showSuccessWithMessage:@"注册成功"];
                                                                                                              [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                                                                                         } else {
                                                                                                             [WHToast showErrorWithMessage:@"注册失败"];
                                                                                                         }
    } fail:^(NSError * _Nonnull error) {
         [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
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
//    self.view.frame = CGRectMake(0, 0,  ScreenWidth,ScreenHeight);
    [textField endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//     self.view.frame = CGRectMake(0, 0,  ScreenWidth,ScreenHeight);
    [phoneTextField endEditing:YES];
    [verificationCodeField endEditing:YES];
    [_passWordTextField endEditing:YES];
    [_scPassWordTextField endEditing:YES];
    [_invitationTextField endEditing:YES];
}

@end
