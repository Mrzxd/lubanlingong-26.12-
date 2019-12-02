//
//  OneViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//
#import "OrderStatusCell.h"
#import "AllViewController.h"


@interface AllViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <ReleasedJobsModel *>*jobModelArray;

@end

@implementation AllViewController

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
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat: _isService?@"/CoreInfo/MyReleaseSkill":@"/CoreInfo/MyReleaseWork"] params:@{
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
        @"type":@"0"
    } success:^(id  _Nonnull response) {
        if (response[@"code"] && [response[@"code"] intValue] == 0) {
            weakSelf.jobModelArray = [ReleasedJobsModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
    } showHUD:YES];
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
    cell.timeLabel.text = @"发布时间";
    cell.releasedJobsModel = _jobModelArray[indexPath.section];
    if (cell.releasedJobsModel.workStatus.intValue == 0) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"待审核";
        [cell.MiddleButton setTitle:@"取消发布" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"查看详情" forState:UIControlStateNormal];
    } else if (cell.releasedJobsModel.workStatus.intValue == 1) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"已上架";
        [cell.MiddleButton setTitle:@"下架" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"查看详情" forState:UIControlStateNormal];
    } else if (cell.releasedJobsModel.workStatus.intValue == 2) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已下架";
        cell.timeLabel.text = @"下架时间";
        [cell.stateButton setTitle:@"查看详情" forState:UIControlStateNormal];
    } else if (cell.releasedJobsModel.workStatus.intValue == 3) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"已驳回";
        cell.timeLabel.text = @"驳回时间";
//        [cell.startWorkButton setTitle:@"删除" forState:UIControlStateNormal];
        [cell.MiddleButton setTitle:@"删除" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"查看详情" forState:UIControlStateNormal];
    }
    WeakSelf;
    WeakCell;
    cell.middlleButtonBlock = ^(ReleasedJobsModel * model) {
        if ([weakCell.MiddleButton.currentTitle isEqual:@"取消发布"]) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:(weakSelf.isService?@"/CoreInfo/CancelReleaseSkill":@"/CoreInfo/CancelReleaseWork")] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response){
                if (response && [response[@"code"] intValue] == 0) {
                                                  [weakSelf netWorking];
                                              } else {
                                                  if (response[@"msg"]) {
                                                      [WHToast showErrorWithMessage:response[@"msg"]];
                                                  } else {
                                                      [WHToast showErrorWithMessage:@"取消发布失败"];
                                                  }
                                              }
            } fail:^(NSError * _Nonnull error) {
                
            } showHUD:YES];
        } else if ([weakCell.MiddleButton.currentTitle isEqual:@"下架"]) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/takeOf":@"/CoreInfo/takeOffWork"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response){
                if (response && [response[@"code"] intValue] == 0) {
                                                  [weakSelf netWorking];
                                              } else {
                                                  if (response[@"msg"]) {
                                                      [WHToast showErrorWithMessage:response[@"msg"]];
                                                  } else {
                                                      [WHToast showErrorWithMessage:@"下架失败"];
                                                  }
                                              }
            } fail:^(NSError * _Nonnull error) {
                
            } showHUD:YES];
        } else if ([weakCell.MiddleButton.currentTitle isEqual:@"修改"]) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/UpdataSkill":@"/CoreInfo/UpdataWork"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response){
                if (response && [response[@"code"] intValue] == 0) {
                                                  [weakSelf netWorking];
                                              } else {
                                                  if (response[@"msg"]) {
                                                      [WHToast showErrorWithMessage:response[@"msg"]];
                                                  } else {
                                                      [WHToast showErrorWithMessage:@"修改失败"];
                                                  }
                                              }
            } fail:^(NSError * _Nonnull error) {
                
            } showHUD:YES];
        } else if ([weakCell.MiddleButton.currentTitle  isEqual: @"删除"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/DeleteSkill":@"/CoreInfo/DeleteWork"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                   if (response && [response[@"code"] intValue] == 0) {
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
    
    cell.firstButtonBlock = ^(ReleasedJobsModel * model) {
    
      };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   EmployerCenterOrderDetailController *vc = [EmployerCenterOrderDetailController new];
    vc.idName = [_jobModelArray[indexPath.section] idName];
    vc.isService = _isService;
   [self.navigationController pushViewController:vc animated:YES];
}

@end

