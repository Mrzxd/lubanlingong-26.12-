


//
//  SMSVerificationCodeController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "SMSVerificationCodeController.h"

@interface SMSVerificationCodeController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@end

@implementation SMSVerificationCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机短信验证码";
    [self setUPUI];
}
- (void)setUPUI {
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 25, 300, 12)];
    remindLabel.text = @"请输入手机139****3456收到的短信验证码";
    remindLabel.textColor = RGBHex(0x999999);
    remindLabel.font = FontSize(12);
    [self.view addSubview:remindLabel];
    
    UIView *topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
    topView.backgroundColor = RGBHex(0xf0f0f0);
    [self.view addSubview:topView];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 69, 60, 16)];
    codeLabel.text = @"验证码";
    codeLabel.textColor = RGBHex(0x261900);
    codeLabel.font = FontSize(16);
    [self.view addSubview:codeLabel];
    
    _textField = [[UITextField alloc] initWithFrame:AutoFrame(106, 59, 100, 36)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = FontSize(16);
    _textField.delegate = self;
    _textField.placeholder = @"短信验证码";
    [self.view addSubview:_textField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 110, 375, 0.5)];
    lineView.backgroundColor = RGBHex(0xf0f0f0);
    [self.view addSubview:lineView];
    
    UIButton *notRecivtedButton = [[UIButton alloc] initWithFrame:AutoFrame(260, 117, 100, 12)];
    [notRecivtedButton setTitle:@"收不到验证码？" forState:UIControlStateNormal];
    [notRecivtedButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    notRecivtedButton.titleLabel.font = FontSize(12);
    notRecivtedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:notRecivtedButton];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 161*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
    [loginButton setTitle:@"验证信息" forState:UIControlStateNormal];
    [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    loginButton.titleLabel.font = FontSize(17);
    loginButton.backgroundColor = RGBHex(0xFFD301);
    loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
    loginButton.layer.masksToBounds = YES;
    loginButton.clipsToBounds = YES;
//    [loginButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}


@end
