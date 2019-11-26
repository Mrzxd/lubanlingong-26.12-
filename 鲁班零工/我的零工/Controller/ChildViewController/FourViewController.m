//
//  ThreeViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//
#import "OrderStatusCell.h"
#import "FourViewController.h"
#import "OrderDetailsController.h"

@interface FourViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FourViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)netWorking {
    WeakSelf;
       [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/WorkerCore/AllOrderFromList"] params:@{
           @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
           @"type":@"-4"
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
    cell.MiddleButton.hidden = NO;
    cell.waitLabel.text = @"待付款";
    cell.startWorkButton.hidden = YES;
    [cell.MiddleButton setTitle:@"确认付款" forState:UIControlStateNormal];
    [cell.stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    WeakSelf;
    __weak typeof(cell) weakCell = (OrderStatusCell *)cell;
     cell.middlleButtonBlock = ^(MyOddJobModel * model) {
    if ([weakCell.MiddleButton.currentTitle isEqual:@"确认付款"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/confirmPayOrderButton"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
            if (response && [response[@"code"] intValue] == 0) {
                [weakSelf netWorking];
            } else {
                if (response[@"msg"]) {
                    [WHToast showErrorWithMessage:response[@"msg"]];
                } else {
                    [WHToast showErrorWithMessage:@"确认付款失败"];
                }
            }
        } fail:^(NSError * _Nonnull error) {
            
        } showHUD:YES];
        }
    };
    
    cell.cellBlock = ^(MyOddJobModel * model) {
           if ([weakCell.stateButton.currentTitle isEqual:@"联系客服"]) {
                [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/contPhone"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                    if (response[@"code"] && [response[@"code"] intValue] == 0) {
                       NSMutableString *phone=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",response[@"data"][@"phone"] NonNull];
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
                    } else {
                        if (response[@"msg"]) {
                            [WHToast showErrorWithMessage:response[@"msg"]];
                        }
                    }
                } fail:^(NSError * _Nonnull error) {
                    
                } showHUD:YES];
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


