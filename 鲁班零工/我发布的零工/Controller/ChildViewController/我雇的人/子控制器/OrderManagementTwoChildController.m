
//
//  OrderManagementTwoChildController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/26.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderStatusCell.h"
#import "OrderDetailsOfMyEmployeesController.h"
#import "OrderManagementTwoChildController.h"

@interface OrderManagementTwoChildController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;

@end

@implementation OrderManagementTwoChildController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/employerCore/employerCore"] params:@{
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
        @"type":@"-3"
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0 && response[@"data"]) {
            weakSelf.jobModelArray = [MyOddJobModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
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
    return _jobModelArray.count;
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
    cell.jobModel = _jobModelArray[indexPath.section];
    cell.startWorkButton.hidden = YES;
    cell.MiddleButton.hidden = YES;
    cell.waitLabel.text = @"进行中";
    [cell.stateButton setTitle:@"确认完工" forState:UIControlStateNormal];
    WeakSelf;
    WeakCell;
    cell.cellBlock = ^(MyOddJobModel * model) {    
    if ([weakCell.stateButton.currentTitle isEqual:@"确认完工"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/confirmWorkButton"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                    if (response && [response[@"code"] intValue] == 0) {
                                      [weakSelf netWorking];
                                  } else {
                                      if (response[@"msg"]) {
                                          [WHToast showErrorWithMessage:response[@"msg"]];
                                      } else {
                                          [WHToast showErrorWithMessage:@"确认完工失败"];
                                      }
                                  }
                } fail:^(NSError * _Nonnull error) {
                    
                } showHUD:YES];
            }
       };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *idName = [_jobModelArray[indexPath.section] idName];
       OrderDetailsOfMyEmployeesController *odvc = [OrderDetailsOfMyEmployeesController new];
       odvc.idName = NoneNull(idName);
       [self.navigationController pushViewController:odvc animated:YES];
}

@end
