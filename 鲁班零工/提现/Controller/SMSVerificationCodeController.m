


//
//  SMSVerificationCodeController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "AddCardController.h"
#import "CashWithdrawalController.h"
#import "BankCardManagementController.h"
#import "SMSVerificationCodeController.h"

@interface SMSVerificationCodeController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *remindLabel;

@end

@implementation SMSVerificationCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机短信验证码";
    [self getVerificationCode];
    [self setUPUI];
}
- (void)getVerificationCode {
    WeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/apiBank/verificationCode"] params:@{
            @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
            @"bankPhone":weakSelf.cardDictionary[@"bankPhone"]
        } success:^(id  _Nonnull response) {
               if (response && response[@"code"] && [response[@"code"] intValue] == 0 && response[@"data"] && [response[@"data"] count]) {
                   weakSelf.textField.text = response[@"data"][@"Vcode"];
                   weakSelf.remindLabel.text = [NSString stringWithFormat:@"请输入手机%@收到的短信验证码",weakSelf.cardDictionary[@"bankPhone"]];
                   [WHToast showSuccessWithMessage:@"请输入收到的验证码"];
                   
               }
       } fail:^(NSError * _Nonnull error) {
       } showHUD:YES];
    });
}
- (void)netWorking {

}
- (void)setUPUI {
    _remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 25, 300, 12)];
    _remindLabel.textColor = RGBHex(0x999999);
    _remindLabel.font = FontSize(12);
    [self.view addSubview:_remindLabel];

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
    [notRecivtedButton addTarget:self action:@selector(notRecivtedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [loginButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

- (void)cardButtonAction:(UIButton *)button {
    if (_textField.text.length <4) {
        [WHToast showErrorWithMessage:@"请输入正确的验证码"];
        return;
    }
    WeakSelf;
    NSMutableDictionary *dic1 = [NSDictionary dictionaryWithDictionary:_cardDictionary].mutableCopy;
    [dic1 setValue:NoneNull(_textField.text) forKey:@"Vcode"];
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/apiBank/add"] params:dic1 success:^(id  _Nonnull response) {
        if (response && response[@"code"] && [response[@"code"] intValue] == 0) {
            [weakSelf.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([controller isKindOfClass:[ CashWithdrawalController class]]) {
                    CashWithdrawalController *cvc = controller;
                    [cvc netWorking];
                    [weakSelf.navigationController popToViewController:controller animated:YES];
                }
            }];
        } else {
            if (response[@"msg"]) {
                [WHToast showErrorWithMessage:response[@"msg"]];
            } else {
                [WHToast showErrorWithMessage:@"绑定银行卡失败"];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}

- (void)notRecivtedButtonAction:(UIButton *)button {
    [self getVerificationCode];
}



@end
