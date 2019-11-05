//
//  TransactionDetailsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "TransactionDetailsCell.h"
#import "TransactionDetailsController.h"

@interface TransactionDetailsController ()  <UITableViewDelegate,UITableViewDataSource,YTSegmentBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) YTSegmentBar *segmentBar;

@end

@implementation TransactionDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易明细";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TransactionDetailsCell class] forCellReuseIdentifier:@"TransactionDetailsCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 46)];
        _headerView.backgroundColor = RGBHex(0xffffff);
        [self addsegmentBar];
    }
    return _headerView;
}
- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:AutoFrame(40, -6, 295, 46)];
        _segmentBar.clipsToBounds = YES;
        _segmentBar.delegate = self;
        _segmentBar.backgroundColor = [UIColor whiteColor];
    }
    return _segmentBar;
}
- (void)addsegmentBar {
    self.segmentBar.items = @[@"全部",@"充值明细",@"提现明细"];
    self.segmentBar.showIndicator = YES;
    self.segmentBar.backgroundColor = [UIColor clearColor];
    self.segmentBar.selectIndex = 0;
    [_headerView addSubview:self.segmentBar];
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 139*ScalePpth;
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
    TransactionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionDetailsCell" forIndexPath:indexPath];
    cell.nameLabel.text = @[@"提现金额",@"充值金额",@"提现金额"][indexPath.section];
    return cell;
}

@end
