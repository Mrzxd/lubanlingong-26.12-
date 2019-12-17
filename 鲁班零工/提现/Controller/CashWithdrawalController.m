//
//  CashWithdrawalController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "BankCardManagementController.h"
#import "QueryBoundBankCardModel.h"
#import "AddCardController.h"
#import "CashWithdrawalController.h"

@interface CashWithdrawalController ()  <UITextFieldDelegate>

@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *cardButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) QueryBoundBankCardModel *cashWithdrawalModel;
@property (nonatomic, strong) NSArray <QueryBoundBankCardModel*>*bankCardModelArray;

@end

@implementation CashWithdrawalController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    [self netWorking];
    [self.view addSubview:self.mineheaderView];
    [self.view addSubview:self.footerView];
}
- (void)netWorking {
    WeakSelf;
    _bankCardModelArray = nil;
    [_cardButton setTitle:@"暂无银行卡" forState:UIControlStateNormal];
    [_addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/apiBank/list"] params:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] NonNull} success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0 && response[@"data"] && [response[@"data"] count]) {
            weakSelf.bankCardModelArray = [QueryBoundBankCardModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            weakSelf.cashWithdrawalModel = weakSelf.bankCardModelArray[0];
            [weakSelf reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}
- (void)reloadData {
    if ([[_bankCardModelArray[0] bank] NonNull length]) {
        [_addButton setTitle:@"立即提现" forState:UIControlStateNormal];
        if ([_bankCardModelArray[0] bankCard].length > 4) {
            [_cardButton setTitle:[[_bankCardModelArray[0] bank] stringByAppendingFormat:@"（%@）",[[_bankCardModelArray[0] bankCard] substringFromIndex:[_bankCardModelArray[0] bankCard].length-4]] forState:UIControlStateNormal];
        }
    }
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
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 43*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [_addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [_addButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _addButton.titleLabel.font = FontSize(17);
        _addButton.backgroundColor = RGBHex(0xFFD301);
        _addButton.layer.cornerRadius = 45.0/2*ScalePpth;
        _addButton.layer.masksToBounds = YES;
        _addButton.clipsToBounds = YES;
        _addButton.tag = 100;
        [_addButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_addButton];
    }
    return _footerView;
}
- (void)addSubView {
    
    UILabel *cashLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 20, 60, 40)];
    cashLabel.text = @"提现至";
    cashLabel.textColor = RGBHex(0x261900);
    cashLabel.font = FontSize(17);
    [_mineheaderView addSubview:cashLabel];
    
    _cardButton = [[UIButton alloc] initWithFrame:AutoFrame(75, 18, 280, 45)];
    _cardButton.titleLabel.font = FontSize(14);
    [_cardButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [_cardButton setTitle:@"暂无银行卡" forState:UIControlStateNormal];
    _cardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _cardButton.tag = 200;
    [_cardButton addTarget:self action:@selector(cardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mineheaderView addSubview:_cardButton];
    
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
    [_textField resignFirstResponder];
    if (button.tag == 200) {
         if (!_bankCardModelArray) {
          [WHToast showErrorWithMessage:@"等待数据加载完成"];
          return;
       }
        WeakSelf;
        BankCardManagementController *bcvc = [BankCardManagementController new];
        bcvc.bankCardModelArray = _bankCardModelArray;
        bcvc.block = ^(QueryBoundBankCardModel *model) {
            weakSelf.cashWithdrawalModel = model;
            [weakSelf.cardButton setTitle:NoneNull(model.bank) forState:UIControlStateNormal];
            [weakSelf.cardButton setTitle:[NoneNull(model.bank) stringByAppendingFormat:@"（%@）",[NoneNull(model.bankCard) substringFromIndex:NoneNull(model.bankCard).length - 4]] forState:UIControlStateNormal];
        };
        [self.navigationController pushViewController:bcvc animated:YES];
    } else {
        if ([button.currentTitle isEqual:@"添加银行卡"]) {
            AddCardController *addCardVc = [AddCardController new];
            [self.navigationController pushViewController:addCardVc animated:YES];
        } else {// 立即提现
            
            if (_textField.text.length == 0) {
                [WHToast showErrorWithMessage:@"请输入提现金额"];
                return;
            }
            WeakSelf;
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/apiBank/withdrawMoney"] params:@{
                @"amount":_textField.text,
                @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] NonNull,
                @"bankId":NoneNull(_cashWithdrawalModel.cardId),
                @"bankCard":NoneNull(_cashWithdrawalModel.bankCard),
            } success:^(id  _Nonnull response) {
                if (response && response[@"code"] && [response[@"code"] intValue] == 0) {
                    weakSelf.textField.text = @"";
                    [WHToast showSuccessWithMessage:@"提现成功"];
                }else if (response[@"msg"]) {
                    [WHToast showErrorWithMessage:response[@"msg"]];
                }
            } fail:^(NSError * _Nonnull error) {
                [WHToast showErrorWithMessage:@"网络错误"];
            } showHUD:YES];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
