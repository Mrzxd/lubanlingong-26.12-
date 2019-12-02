//
//  CashWithdrawalController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "QueryBoundBankCardModel.h"
#import "AddCardController.h"
#import "CashWithdrawalController.h"

@interface CashWithdrawalController ()  <UITextFieldDelegate>

@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray <QueryBoundBankCardModel*>*bankCardModelArray;

@end

@implementation CashWithdrawalController {
    UIButton *cardButton;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    [self.view addSubview:self.mineheaderView];
    [self.view addSubview:self.footerView];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/apiBank/list"] params:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]} success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0 && response[@"data"] && [response[@"data"] count]) {
            weakSelf.bankCardModelArray = [QueryBoundBankCardModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}
- (void)reloadData {
    [cardButton setTitle:[_bankCardModelArray[0] bank] forState:UIControlStateNormal];
}
- (UIView *)mineheaderView {
    if (!_mineheaderView) {
        _mineheaderView = [[UIView alloc] init];
        _mineheaderView.userInteractionEnabled = YES;
        _mineheaderView.frame = CGRectMake(0, 0, ScreenWidth, 186*ScalePpth);
        [self addSubView];
    }
    return _mineheaderView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 236, 375, 100)];
        _footerView.backgroundColor = UIColor.whiteColor;
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 43*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [loginButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
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
    cashLabel.text = @"提现至";
    cashLabel.textColor = RGBHex(0x261900);
    cashLabel.font = FontSize(17);
    [_mineheaderView addSubview:cashLabel];
    
    cardButton = [[UIButton alloc] initWithFrame:AutoFrame(75, 18, 280, 45)];
    cardButton.titleLabel.font = FontSize(14);
    [cardButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [cardButton setTitle:@"暂无银行卡" forState:UIControlStateNormal];
    cardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cardButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mineheaderView addSubview:cardButton];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:AutoFrame(0, 75, 375, 0.6/ScalePpth)];
    lineView2.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView2];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 100, 100, 17)];
    amountLabel.text = @"提现金额";
    amountLabel.textColor = RGBHex(0x261900);
    amountLabel.font = FontSize(17);
    [_mineheaderView addSubview:amountLabel];
    
    UILabel *symbolLabel = [[UILabel alloc] initWithFrame:AutoFrame(20, 152, 19, 19)];
    symbolLabel.text = @"¥";
    symbolLabel.textColor = RGBHex(0x333333);
    symbolLabel.font = FontSize(19);
    [_mineheaderView addSubview:symbolLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15*ScalePpth, 146*ScalePpth, 340*ScalePpth, 30*ScalePpth)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = FontSize(16);
    _textField.delegate = self;
    _textField.placeholder = @"请输入提现金额";
    [_mineheaderView addSubview:_textField];
    
    UIView *topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
    topView.backgroundColor = RGBHex(0xf0f0f0);
    [_mineheaderView addSubview:topView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(15, 185, 360, 0.6/ScalePpth)];
    lineView.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView];
}

- (void)cardButtonAction:(UIButton *)button {
    AddCardController *addCardVc = [AddCardController new];
    [self.navigationController pushViewController:addCardVc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
