

//
//  OrderManagementOneChildController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/26.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderStatusCell.h"
#import "ToEvaluateEmployerController.h"
#import "OrderManagementOneChildController.h"
#import "OrderDetailsOfMyEmployeesController.h"

@interface OrderManagementOneChildController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *nonDataView;
@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;

@end

@implementation OrderManagementOneChildController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (UIImageView *)nonDataView {
    if (!_nonDataView) {
        _nonDataView = [[UIImageView alloc] initWithFrame:AutoFrame(50, 94, 275, 200)];
        _nonDataView.image = [UIImage imageNamed:@"indent_null"];
        UILabel *nonLabel = [[UILabel alloc] initWithFrame:AutoFrame(15/2.0, 39+136, 260, 14)];
        nonLabel.font = FontSize(14);
        nonLabel.textAlignment = NSTextAlignmentCenter;
        nonLabel.textColor = RGBHexAlpha(0x9999999, 1);
        nonLabel.text = @"当前暂无订单";
        [_nonDataView addSubview:nonLabel];
    }
    return _nonDataView;
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/employerCore/employerCore"] params:@{
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] NonNull,
        @"type":@"0"
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0 && response[@"data"] && [response[@"data"] count]) {
            weakSelf.jobModelArray = [MyOddJobModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.tableView reloadData];
        } else {
            weakSelf.tableView.hidden = YES;
            [WHToast showErrorWithMessage:@"暂无数据"];
            [weakSelf.view addSubview:weakSelf.nonDataView];
        }
    } fail:^(NSError * _Nonnull error) {
            weakSelf.tableView.hidden = YES;
            [WHToast showErrorWithMessage:@"暂无数据"];
            [weakSelf.view addSubview:weakSelf.nonDataView];
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
    if (cell.jobModel.orderStatusGz.intValue == 3 || cell.jobModel.orderStatusGz.intValue == 4) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"进行中";
        [cell.stateButton setTitle:@"确认完工" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGz.intValue == 5) {
        cell.timeLabel.text = @"下架时间";
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"验收中";
        [cell.MiddleButton setTitle:@"驳回" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"确认完工" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGz.intValue == 6) {
        cell.timeLabel.text = @"驳回时间";
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"已完成";
        [cell.MiddleButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"去评价" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGz.intValue == 7) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已评价";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    
    WeakCell;
    WeakSelf;
    cell.cellBlock = ^(MyOddJobModel * model) {
    if ([weakCell.stateButton.currentTitle isEqual:@"删除订单"]) {
             [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/deleteOrder"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                 if (response[@"code"] && [response[@"code"] intValue] == 0) {
                     [weakSelf netWorking];
                 } else {
                     if (response[@"msg"]) {
                         [WHToast showErrorWithMessage:response[@"msg"]];
                     } else {
                         [WHToast showErrorWithMessage:@"删除失败"];
                     }
                 }
             } fail:^(NSError * _Nonnull error) {
                 
             } showHUD:YES];
         } else if ([weakCell.stateButton.currentTitle isEqual:@"确认完工"]) {
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
         } else if ([weakCell.stateButton.currentTitle isEqual:@"去评价"]) {
             ToEvaluateEmployerController *teec = [ ToEvaluateEmployerController new];
             teec.model = model;
             [weakSelf.navigationController pushViewController:teec animated:YES];
         }
    };
   cell.middlleButtonBlock = ^(MyOddJobModel * model) {
       if ([weakCell.MiddleButton.currentTitle isEqual:@"驳回"]) {
           [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/TurnDown"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                   if (response && [response[@"code"] intValue] == 0) {
                                     [weakSelf netWorking];
                                 } else {
                                     if (response[@"msg"]) {
                                         [WHToast showErrorWithMessage:response[@"msg"]];
                                     } else {
                                         [WHToast showErrorWithMessage:@"驳回失败"];
                                     }
                                 }
               } fail:^(NSError * _Nonnull error) {
                   
               } showHUD:YES];
       } else if ([weakCell.MiddleButton.currentTitle isEqual:@"删除订单"]) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/deleteOrder"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                if (response[@"code"] && [response[@"code"] intValue] == 0) {
                    [weakSelf netWorking];
                } else {
                    if (response[@"msg"]) {
                        [WHToast showErrorWithMessage:response[@"msg"]];
                    } else {
                        [WHToast showErrorWithMessage:@"删除失败"];
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
