//
//  OneViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//
#import "OrderStatusCell.h"
#import "OneViewController.h"

@interface OneViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- KNavigationHeight-40*ScalePpth) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[OrderStatusCell class] forCellReuseIdentifier:@"OrderStatusCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 172*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10*ScalePpth;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStatusCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"等待雇主同意";
        [cell.stateButton setTitle:@"取消订单" forState:UIControlStateNormal];
    } else if (indexPath.section == 1) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"邀请等待同意";
        [cell.MiddleButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"同意" forState:UIControlStateNormal];
    } else if (indexPath.section == 2) {
        cell.startWorkButton.hidden = NO;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"进行中";
        [cell.startWorkButton setTitle:@"开工" forState:UIControlStateNormal];
        [cell.MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"导航" forState:UIControlStateNormal];
    } else if (indexPath.section == 3) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"拒绝接单";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    } else if (indexPath.section == 4) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"待付款";
        [cell.MiddleButton setTitle:@"确认付款" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_orderDetailBlock) {
        _orderDetailBlock(indexPath.section);
    }
}

@end
