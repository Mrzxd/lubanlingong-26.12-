//
//  MineViewController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/12.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "MineTableCell.h"
#import "MineController.h"
#import "AboutUsController.h"
#import "RechargeController.h"
#import "LBTabBarController.h"
#import "LoginViewController.h"
#import "EmployeeCentreController.h"
#import "EmployerCenterController.h"
#import "CashWithdrawalController.h"
#import "TransactionDetailsController.h"
#import "RealNameAuthenticationController.h"
#import "SignInReceiveRedEnvelopesController.h"

@interface MineController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *mineheaderView;

@end

@implementation MineController

- (UIView *)mineheaderView {
    if (!_mineheaderView) {
        _mineheaderView = [[UIView alloc] init];
        _mineheaderView.userInteractionEnabled = YES;
        _mineheaderView.frame = CGRectMake(0, 0, ScreenWidth, 259*ScalePpth);
        [self addSubView];
    }
    return _mineheaderView;
}
- (void)addSubView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(20, 13, 28, 28)];
    imageView.backgroundColor = RGBHex(0xDADADA);
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = 14*ScalePpth;
    imageView.layer.masksToBounds = YES;
    [_mineheaderView addSubview:imageView];
    
    UILabel *myNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(59, 19, 0, 16)];
    myNameLabel.text = @"鲁班";
    myNameLabel.font = FontSize(16);
    myNameLabel.textColor = [UIColor blackColor];
    [myNameLabel sizeToFit];
    [_mineheaderView addSubview:myNameLabel];
    
    UIButton *infoBtn = [[UIButton alloc] initWithFrame:CGRectMake(14*ScalePpth+CGRectGetMaxX(myNameLabel.frame), 20*ScalePpth, 85*ScalePpth, 15*ScalePpth)];
    infoBtn.backgroundColor = RGBHex(0xEEEEEE);
    infoBtn.clipsToBounds = YES;
    infoBtn.layer.cornerRadius = 7.5*ScalePpth;
    infoBtn.layer.masksToBounds = YES;
    infoBtn.titleLabel.font = FontSize(10);
    [infoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6*ScalePpth)];
    [infoBtn setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    infoBtn.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
    [infoBtn setTitle:@"编辑个人资料" forState:UIControlStateNormal];
    [_mineheaderView addSubview:infoBtn];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 15, 15)];
    leftImageView.clipsToBounds = YES;
    leftImageView.image = [UIImage imageNamed:@"edit_yellow"];
    leftImageView.layer.masksToBounds = YES;
    leftImageView.layer.cornerRadius = 7.5*ScalePpth;
    [infoBtn addSubview:leftImageView];
    
    UIButton *QRCodeButton = [[UIButton alloc] initWithFrame:AutoFrame(330, 20, 16, 16)];
    [QRCodeButton setImage:[UIImage imageNamed:@"my_qrcode"] forState:UIControlStateNormal];
    [_mineheaderView addSubview:QRCodeButton];
    [self addSubViews];
}
- (void)addSubViews {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:AutoFrame(14, 55, 348, 129)];
    backGroundView.backgroundColor = RGBHex(0xFFB924);
    backGroundView.clipsToBounds = YES;
    backGroundView.userInteractionEnabled = YES;
    backGroundView.layer.masksToBounds = YES;
    backGroundView.layer.cornerRadius = 10*ScalePpth;
    [_mineheaderView addSubview:backGroundView];
    
    UILabel *mybalanceLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 15, 0, 0)];
    mybalanceLabel.text = @"我的余额（元）";
    mybalanceLabel.font = [UIFont boldSystemFontOfSize:11*ScalePpth];
    mybalanceLabel.textColor = [UIColor whiteColor];
    [mybalanceLabel sizeToFit];
    [backGroundView addSubview:mybalanceLabel];
    
    UILabel *balanceLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 41, 0, 0)];
    balanceLabel.text = @"88.66";
    balanceLabel.font = [UIFont boldSystemFontOfSize:38*ScalePpth];
    balanceLabel.textColor = [UIColor whiteColor];
    [balanceLabel sizeToFit];
    [backGroundView addSubview:balanceLabel];
    
    UIButton *signButton = [[UIButton alloc] initWithFrame:AutoFrame(232, 30, 130, 22)];
    [signButton setTitle:@"签到领红包" forState:UIControlStateNormal];
    signButton.titleLabel.font = FontSize(13);
    signButton.clipsToBounds = YES;
    signButton.layer.masksToBounds = YES;
    signButton.layer.cornerRadius = 11*ScalePpth;
    signButton.backgroundColor = RGBHex(0xFFC344);
    [signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signButton addTarget:self action:@selector(signButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mineheaderView addSubview:signButton];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(9, 4, 14, 15)];
    leftImageView.image = [UIImage imageNamed:@"sign"];

    [signButton addSubview:leftImageView];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:AutoFrame(101, 7, 7, 10)];
    [rightImageView setImage:[UIImage imageNamed:@"sign_arrow"]];
    [signButton addSubview:rightImageView];
    [backGroundView addSubview:signButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 89, 348, 0.3)];
    lineView.backgroundColor = UIColor.whiteColor;
    [backGroundView addSubview:lineView];
    
    UIButton *rechargeButton = [[UIButton alloc] initWithFrame:AutoFrame(20, 99, 50, 20)];
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rechargeButton.titleLabel.font = FontSize(11);
    rechargeButton.clipsToBounds = YES;
    rechargeButton.layer.borderColor = UIColor.whiteColor.CGColor;
    rechargeButton.layer.borderWidth = 0.8 *ScalePpth;
    rechargeButton.layer.masksToBounds = YES;
    rechargeButton.layer.cornerRadius = 2*ScalePpth;
    [rechargeButton addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:rechargeButton];
    
    UIButton *cashWithdrawalButton = [[UIButton alloc] initWithFrame:AutoFrame(80, 99, 50, 20)];
    [cashWithdrawalButton setTitle:@"提现" forState:UIControlStateNormal];
    [cashWithdrawalButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    cashWithdrawalButton.titleLabel.font = FontSize(11);
    cashWithdrawalButton.clipsToBounds = YES;
    cashWithdrawalButton.layer.borderColor = UIColor.whiteColor.CGColor;
    cashWithdrawalButton.layer.borderWidth = 0.8 *ScalePpth;
    cashWithdrawalButton.layer.masksToBounds = YES;
    cashWithdrawalButton.layer.cornerRadius = 2*ScalePpth;
    [cashWithdrawalButton addTarget:self action:@selector(cashWithdrawalButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:cashWithdrawalButton];
    
    UIButton *cashWithdrawalDetailButton = [[UIButton alloc] initWithFrame:AutoFrame(282, 104, 70, 20)];
    [cashWithdrawalDetailButton setTitle:@"交易明细" forState:UIControlStateNormal];
    cashWithdrawalDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cashWithdrawalDetailButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [cashWithdrawalDetailButton addTarget:self action:@selector(cashWithdrawalDetailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cashWithdrawalDetailButton.titleLabel.font = FontSize(11);
    [backGroundView addSubview:cashWithdrawalDetailButton];
    
    UIImageView *arrIMg = [[UIImageView alloc] initWithFrame:AutoFrame(47, 5.5, 7, 10)];
    [arrIMg setImage:[UIImage imageNamed:@"sign_detailed"]];
    [cashWithdrawalDetailButton addSubview:arrIMg];
    
    UILabel *leftNumLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 204, 375.0/3, 18)];
    leftNumLabel.text = @"89.5";
    leftNumLabel.textAlignment = NSTextAlignmentCenter;
    leftNumLabel.font = [UIFont systemFontOfSize:18*ScalePpth];
    leftNumLabel.textColor = [UIColor blackColor];
    [_mineheaderView addSubview:leftNumLabel];
    
    UILabel *centerNumLabel = [[UILabel alloc] initWithFrame:AutoFrame(375.0/3, 204, 375.0/3, 18)];
    centerNumLabel.text = @"38";
    centerNumLabel.textAlignment = NSTextAlignmentCenter;
    centerNumLabel.font = [UIFont systemFontOfSize:18*ScalePpth];
    centerNumLabel.textColor = [UIColor blackColor];
    [_mineheaderView addSubview:centerNumLabel];
    
    UILabel *rightNumLabel = [[UILabel alloc] initWithFrame:AutoFrame(375.0 *2/3, 204, 375.0/3, 18)];
    rightNumLabel.text = @"3";
    rightNumLabel.textAlignment = NSTextAlignmentCenter;
    rightNumLabel.font = [UIFont systemFontOfSize:18*ScalePpth];
    rightNumLabel.textColor = [UIColor blackColor];
    [_mineheaderView addSubview:rightNumLabel];
    
    UILabel *leftNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 227, 375.0/3, 13)];
    leftNameLabel.text = @"好评率";
    leftNameLabel.textAlignment = NSTextAlignmentCenter;
    leftNameLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
    leftNameLabel.textColor = RGBHex(0x999999);
    [_mineheaderView addSubview:leftNameLabel];
    
    UILabel *centerNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(375.0/3, 227, 375.0/3, 13)];
    centerNameLabel.text = @"零工数";
    centerNameLabel.textAlignment = NSTextAlignmentCenter;
    centerNameLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
    centerNameLabel.textColor = RGBHex(0x999999);
    [_mineheaderView addSubview:centerNameLabel];
    
    UILabel *rightNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(375.0*2/3, 227, 375.0/3, 13)];
    rightNameLabel.text = @"我的收藏";
    rightNameLabel.textAlignment = NSTextAlignmentCenter;
    rightNameLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
    rightNameLabel.textColor = RGBHex(0x999999);
    [_mineheaderView addSubview:rightNameLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 254, 375, 5)];
    bottomView.backgroundColor = RGBHex(0xf0f0f0);
    [_mineheaderView addSubview:bottomView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat space = (statusHeight > 20)?30:0;
        CGFloat height = ScreenHeight - KTabBarHeight - statusHeight -space;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusHeight +space, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MineTableCell class] forCellReuseIdentifier:@"MineTableCell"];
        _tableView.tableHeaderView = self.mineheaderView;
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = RGBHex(0xffffff);
    [self.view addSubview:self.tableView];
}

- (void)cashWithdrawalDetailButtonAction:(UIButton *)button {
    TransactionDetailsController *transationDetailVc = [TransactionDetailsController new];
    [self.navigationController pushViewController:transationDetailVc animated:YES];
}
- (void)rechargeAction:(UIButton *)button {
    RechargeController *rvc = [[RechargeController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)cashWithdrawalButtonAction:(UIButton *)button {
    CashWithdrawalController *cashWithdrawalController = [CashWithdrawalController new];
     [self.navigationController pushViewController:cashWithdrawalController animated:YES];
}
- (void)signButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[SignInReceiveRedEnvelopesController new] animated:YES];
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00000001*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (MineTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineTableCell"];
    }
    cell.textLabels.text = @[@"我的服务",@"雇主中心",@"分享有奖",@"实名认证",@"客服电话",@"关于我们",@"安全退出"][indexPath.row];
    cell.images = @[@"my_job",@"my_core",@"my_share",@"my_realname",@"my_customer",@"my_about",@"my_exit"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        RealNameAuthenticationController *rnac = [RealNameAuthenticationController new];
        [self.navigationController pushViewController:rnac animated:YES];
    } else if (indexPath.row == 5) {
        [self.navigationController pushViewController:[AboutUsController new] animated:YES];
    } else if (indexPath.row == 0) {
        [self.navigationController pushViewController:[EmployeeCentreController new] animated:YES];
    } else if (indexPath.row == 6) {
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"login_state"];
        if (GlobalSingleton.gS_ShareInstance.state == 1) {
            LoginViewController *loginController = [LoginViewController new];
            GlobalSingleton.gS_ShareInstance.systemWindow.rootViewController = loginController;
        } else {
            LBTabBarController *lbtabbarController = (LBTabBarController *)self.tabBarController;
            [lbtabbarController dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[EmployerCenterController new] animated:YES];
    }
}


@end
