//
//  ThreeViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//
#import "OrderStatusCell.h"
#import "FiveViewController.h"
#import "OrderDetailsController.h"

@interface FiveViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FiveViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakSelf;
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/WorkerCore/AllOrderFromList"] params:@{
                @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                @"type":@"-5"
            } success:^(id  _Nonnull response) {
                if (response && [response[@"code"] intValue] == 0 && response[@"data"]) {
                    weakSelf.jobModelArray = [MyOddJobModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
                    [weakSelf.tableView reloadData];
                }
            } fail:^(NSError * _Nonnull error) {
            } showHUD:YES];
}
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
    cell.jobModel = _jobModelArray[indexPath.section];
    if (cell.jobModel.orderStatusGr.intValue ==  6) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"已完成";
        [cell.MiddleButton setTitle:@"去评价" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue ==  7) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已评价";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    WeakSelf;
      __weak typeof(cell) weakCell = (OrderStatusCell *)cell;
    cell.middlleButtonBlock = ^(MyOddJobModel * model) {
    if ([weakCell.MiddleButton.currentTitle isEqual:@"去评价"]) {
         ToEvaluateController *teec = [ ToEvaluateController new];
          teec.model = model;
          [weakSelf.navigationController pushViewController:teec animated:YES];
        }
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     MyOddJobModel *model = _jobModelArray[indexPath.section];
      if (_orderDetailBlock) {
          _orderDetailBlock(model.idName);
      }
}

@end



