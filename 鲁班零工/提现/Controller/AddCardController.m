//
//  AddCardController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "AddCardController.h"
#import "VerificationCardController.h"

@interface AddCardController ()
@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation AddCardController

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
    [self.navigationController pushViewController:[VerificationCardController new] animated:YES];
}

@end
