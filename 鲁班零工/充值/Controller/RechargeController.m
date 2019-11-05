



//
//  RechargeController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "PayModeTableCell.h"
#import "RechargeController.h"


@interface RechargeController ()  <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *lastModeButton;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation RechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"充值";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = ScreenHeight - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[PayModeTableCell class] forCellReuseIdentifier:@"PayModeTableCell"];
        _tableView.tableHeaderView = self.mineheaderView;
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIView *)mineheaderView {
    if (!_mineheaderView) {
        _mineheaderView = [[UIView alloc] init];
        _mineheaderView.userInteractionEnabled = YES;
        _mineheaderView.frame = CGRectMake(0, 0, ScreenWidth, 300*ScalePpth);
        [self addSubView];
    }
    return _mineheaderView;

}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 100)];
        _footerView.backgroundColor = UIColor.whiteColor;
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 43*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [loginButton setTitle:@"立即充值" forState:UIControlStateNormal];
        [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        loginButton.titleLabel.font = FontSize(17);
        loginButton.backgroundColor = RGBHex(0xFFD301);
        loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        loginButton.layer.masksToBounds = YES;
        loginButton.clipsToBounds = YES;
        [_footerView addSubview:loginButton];
    }
    return _footerView;
}

- (void)addSubView {
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 20, 100, 17)];
    amountLabel.text = @"充值金额";
    amountLabel.textColor = RGBHex(0x261900);
    amountLabel.font = FontSize(17);
    [_mineheaderView addSubview:amountLabel];
    
    UILabel *symbolLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 72, 100, 19)];
    symbolLabel.text = @"¥";
    symbolLabel.textColor = RGBHex(0x333333);
    symbolLabel.font = FontSize(19);
    [_mineheaderView addSubview:symbolLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15*ScalePpth, 66*ScalePpth, 340*ScalePpth, 30*ScalePpth)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = FontSize(16);
    _textField.delegate = self;
    _textField.placeholder = @"请输入充值金额";
    [_mineheaderView addSubview:_textField];
    
    UIView *topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
    topView.backgroundColor = RGBHex(0xf0f0f0);
    [_mineheaderView addSubview:topView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(15, 105, 360, 0.6/ScalePpth)];
    lineView.backgroundColor = RGBHex(0xeeeeee);
    [_mineheaderView addSubview:lineView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 295, 375, 5)];
    bottomView.backgroundColor = RGBHex(0xf0f0f0);
    [_mineheaderView addSubview:bottomView];
    
    NSArray *titleArray = @[@"充1000元",@"充500元",@"充300元",@"充100元"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame((16 + (i%2)*178), (120 + i/2 *85), 165, 70)];
        button.backgroundColor = RGBHex(0xFFD301);
        button.clipsToBounds = YES;
        if (i == 0) {
            button.backgroundColor = RGBHex(0xFFD301);
            _lastButton = button;
        } else {
            button.backgroundColor = UIColor.whiteColor;
        }
        button.layer.cornerRadius = 10 *ScalePpth;
        button.layer.masksToBounds = YES;
        button.layer.borderColor =  RGBHex(0xFFD301).CGColor;
        button.layer.borderWidth = 0.8;
        button.titleLabel.font = FontSize(18);
        [button setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mineheaderView addSubview:button];
    }
    
}
- (void)buttonAction:(UIButton *)button {
    _lastButton.backgroundColor = UIColor.whiteColor;
    button.backgroundColor = RGBHex(0xffd301);
    _lastButton = button;
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *modeLabel = [[UILabel alloc] initWithFrame:AutoFrame(17, 16, 375, 17)];
    modeLabel.text = @"    选择支付方式";
    modeLabel.textColor = RGBHex(0x261900);
    modeLabel.font = FontSize(17);
    return modeLabel;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayModeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayModeTableCell" forIndexPath:indexPath];
    cell.modeImageView.image = [UIImage imageNamed:@[@"alipay",@"wechat"][indexPath.row]];
    cell.modeLabel.text = @[@"支付宝支付",@"微信支付"][indexPath.row];
    if (indexPath.row == 0) {
        _lastModeButton = cell.modeButton;
    }
    [cell.modeButton setImage:[UIImage imageNamed:@[@"check",@"no_checked"][indexPath.row]] forState:UIControlStateNormal];
    [cell.modeButton addTarget:self action:@selector(modeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)modeButtonAction:(UIButton *)button {
    [_lastModeButton setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    _lastModeButton = button;
}


@end
