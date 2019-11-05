
//
//  VerificationCardController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "SMSVerificationCodeController.h"
#import "VerificationCardController.h"

@interface VerificationCardController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation VerificationCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    [self.view addSubview:self.mineheaderView];
    [self.view addSubview:self.footerView];
    
}

- (UIView *)mineheaderView {
    if (!_mineheaderView) {
        _mineheaderView = [[UIView alloc] init];
        _mineheaderView.userInteractionEnabled = YES;
        _mineheaderView.frame = CGRectMake(0, 0, ScreenWidth, 216*ScalePpth);
        [self addSubView];
    }
    return _mineheaderView;
    
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 266, 375, 100)];
        _footerView.backgroundColor = UIColor.whiteColor;
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 43*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [loginButton setTitle:@"同意协议并验证" forState:UIControlStateNormal];
        [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        loginButton.titleLabel.font = FontSize(17);
        loginButton.backgroundColor = RGBHex(0xFFD301);
        loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        loginButton.layer.masksToBounds = YES;
        loginButton.clipsToBounds = YES;
        [loginButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:loginButton];
    }
    return _footerView;
}
- (void)addSubView {
    
    
    UILabel *cashLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 20, 60, 40)];
    cashLabel.text = @"银行卡";
    cashLabel.textColor = RGBHex(0x261900);
    cashLabel.font = FontSize(17);
    [_mineheaderView addSubview:cashLabel];
    
    UILabel *cashDetailLabel = [[UILabel alloc] initWithFrame:AutoFrame(90, 32.5, 190, 16)];
    cashDetailLabel.text = @"中国建设银行储蓄卡";
    cashDetailLabel.textColor = RGBHex(0x999999);
    cashDetailLabel.font = FontSize(16);
    [_mineheaderView addSubview:cashDetailLabel];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 102, 100, 17)];
    amountLabel.text = @"卡号";
    amountLabel.textColor = RGBHex(0x261900);
    amountLabel.font = FontSize(17);
    [_mineheaderView addSubview:amountLabel];
    
    UILabel *amountDetailLabel = [[UILabel alloc] initWithFrame:AutoFrame(90, 104, 230, 16)];
    amountDetailLabel.text = @"6245 8595 5141 7894 238";
    amountDetailLabel.textColor = RGBHex(0x999999);
    amountDetailLabel.font = FontSize(16);
    [_mineheaderView addSubview:amountDetailLabel];
    
    UILabel *identityLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 173, 100, 17)];
    identityLabel.text = @"手机号";
    identityLabel.textColor = RGBHex(0x261900);
    identityLabel.font = FontSize(17);
    [_mineheaderView addSubview:identityLabel];
    
    UIView *topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
    topView.backgroundColor = RGBHex(0xf0f0f0);
    [_mineheaderView addSubview:topView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 75, 375, 0.6/ScalePpth)];
    lineView.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:AutoFrame(0, 145, 375, 0.6/ScalePpth)];
    lineView2.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, 216, 375, 0.6/ScalePpth)];
    lineView3.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView3];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(90*ScalePpth, 167*ScalePpth, 340*ScalePpth, 30*ScalePpth)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = FontSize(16);
    _textField.delegate = self;
    _textField.placeholder = @"银行卡预留手机号";
    [_mineheaderView addSubview:_textField];
    
}

- (void)cardButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[SMSVerificationCodeController new] animated:YES];
}

@end
