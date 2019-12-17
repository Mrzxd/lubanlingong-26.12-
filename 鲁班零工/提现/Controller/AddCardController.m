//
//  AddCardController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "AddCardController.h"
#import "VerificationCardController.h"

@interface AddCardController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray <UITextField *>*textFieldArray;
@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation AddCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    _textFieldArray = [NSMutableArray array];
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
        [loginButton setTitle:@"下一步" forState:UIControlStateNormal];
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

    UILabel *cashLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 32, 60, 40)];
    cashLabel.text = @"持卡人";
    cashLabel.textColor = RGBHex(0x261900);
    cashLabel.font = FontSize(17);
    [_mineheaderView addSubview:cashLabel];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 102, 100, 17)];
    amountLabel.text = @"卡号";
    amountLabel.textColor = RGBHex(0x261900);
    amountLabel.font = FontSize(17);
    [_mineheaderView addSubview:amountLabel];
    
    UILabel *identityLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 173, 100, 17)];
    identityLabel.text = @"身份证号";
    identityLabel.textColor = RGBHex(0x261900);
    identityLabel.font = FontSize(17);
    [_mineheaderView addSubview:identityLabel];
    
    [_mineheaderView addSubview:[self setUpTextFieldWithHeight:32.5 String:@"请输入持卡人姓名"]];
    [_mineheaderView addSubview:[self setUpTextFieldWithHeight:102.5 String:@"请输入银行卡卡号"]];
    [_mineheaderView addSubview:[self setUpTextFieldWithHeight:173.5 String:@"请输入身份证号"]];
    
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
}

- (void)cardButtonAction:(UIButton *)button {
    if ([_textFieldArray[0] text].length == 0) {
        [WHToast showErrorWithMessage:@"请输入持卡人姓名"];
        return;
    }
    if ([_textFieldArray[1] text].length == 0 || ![self checkCardNo:[_textFieldArray[1] text]]) {
        [WHToast showErrorWithMessage:@"请输入正确的银行卡号"];
        return;
    }
    if (![self verifyIDCardNumber:[_textFieldArray[2] text]]) {
        [WHToast showErrorWithMessage:@"请输入正确的身份证号吗"];
        return;
    }
    _infoArray = @[_textFieldArray[0].text,_textFieldArray[1].text,_textFieldArray[2].text];
    VerificationCardController *vcc = [VerificationCardController new];
    vcc.infoArray = _infoArray;
    [self.navigationController pushViewController:vcc animated:YES];
//    WeakSelf;
//    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/apiBank/add"] params:@{
//        @"name":[_textFieldArray[0] text],
//        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
//        @"bankCard":[_textFieldArray[1] text],
//        @"cardId":[_textFieldArray[2] text]
//    } success:^(id  _Nonnull response) {
//        if (response && response[@"code"] && response[@"data"] && [response[@"code"] intValue] == 0) {
//            VerificationCardController *vcc = [VerificationCardController new];
//            vcc.cardDictionary = response[@"data"];
//            [weakSelf.navigationController pushViewController:vcc animated:YES];
//        }
//    } fail:^(NSError * _Nonnull error) {
//            [WHToast showErrorWithMessage:@"网络错误"];
//    } showHUD:YES];
}

- (UITextField *)setUpTextFieldWithHeight:(CGFloat)height String:(NSString *)string {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(76*ScalePpth, height*ScalePpth, 284*ScalePpth, 30*ScalePpth)];
//    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = NSTextAlignmentRight;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = FontSize(16);
    textField.delegate = self;
    textField.placeholder = string;
    [_textFieldArray addObject:textField];
    return textField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
     _textField = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
