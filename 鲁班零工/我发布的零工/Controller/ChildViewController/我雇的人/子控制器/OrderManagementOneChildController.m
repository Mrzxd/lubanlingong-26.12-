

//
//  OrderManagementOneChildController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/26.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderStatusCell.h"
#import "OrderManagementOneChildController.h"

@interface OrderManagementOneChildController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderManagementOneChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- KNavigationHeight-40-34*ScalePpth) style:UITableViewStyleGrouped];
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
    return 4;
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
    cell.timeLabel.text = @"发布时间";
    if (indexPath.section == 0) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"进行中";
        [cell.MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"终止" forState:UIControlStateNormal];
    } else if (indexPath.section == 1) {
        cell.timeLabel.text = @"下架时间";
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"验收中";
        [cell.MiddleButton setTitle:@"确认完成" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"驳回" forState:UIControlStateNormal];
    } else if (indexPath.section == 2) {
        cell.timeLabel.text = @"驳回时间";
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已完成";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    } else if (indexPath.section == 3) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已终止";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
