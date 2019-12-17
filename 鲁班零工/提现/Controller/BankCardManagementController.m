//  BankCardManagementController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/12/3.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ManageBankCardsCell.h"
#import "AddCardController.h"
#import "BankCardManagementController.h"

@interface BankCardManagementController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation BankCardManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡管理";
    [self.view addSubview:self.tableView];
}
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 345, 115)];
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(23*ScalePpth, 50*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [loginButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [loginButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.titleLabel.font = FontSize(17);
        loginButton.backgroundColor = RGBHex(0xFFD301);
        loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        loginButton.layer.masksToBounds = YES;
        [_footerView addSubview:loginButton];
    }
    return _footerView;
}
- (UITableView *)tableView {
if (!_tableView) {
    CGFloat height = ScreenHeight - KNavigationHeight;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15*ScalePpth, 0, 345*ScalePpth, height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[ManageBankCardsCell class] forCellReuseIdentifier:@"ManageBankCardsCell"];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
    _tableView.backgroundColor = RGBHex(0xffffff);
    _tableView.tableFooterView = self.footerView;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark ------ UITableViewDelegate


- (void)addAction:(UIButton *)button {
  AddCardController *addCardVc = [AddCardController new];
  [self.navigationController pushViewController:addCardVc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _bankCardModelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManageBankCardsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManageBankCardsCell" forIndexPath:indexPath];
    cell.backgroundColor = @[RGBHex(0x0C69F4),RGBHex(0x0ED362E),RGBHex(0x039B4E)][indexPath.section%3];
    cell.model = _bankCardModelArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_block && _bankCardModelArray[indexPath.section]) {
        _block(_bankCardModelArray[indexPath.section]);
        [self netWorking:_bankCardModelArray[indexPath.section]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)netWorking:(QueryBoundBankCardModel *)model {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/apiBank/select"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
        if (response && response[@"code"] && [response[@"code"] intValue] == 0) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}


@end
