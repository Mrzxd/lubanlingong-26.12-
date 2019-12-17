
//
//  OffShelfController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderStatusCell.h"
#import "OffShelfController.h"

@interface OffShelfController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <ReleasedJobsModel *>*jobModelArray;

@end

@implementation OffShelfController

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
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:_isService?@"/CoreInfo/MyReleaseSkill":@"/CoreInfo/MyReleaseWork"] params:@{
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] NonNull,
        @"type":@"3"
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
  
    cell.startWorkButton.hidden = YES;
    cell.MiddleButton.hidden = YES;
    cell.waitLabel.text = @"已下架";
    cell.timeLabel.text = @"下架时间";
    [cell.stateButton setTitle:@"查看详情" forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      EmployerCenterOrderDetailController *vc = [EmployerCenterOrderDetailController new];
     vc.idName = [_jobModelArray[indexPath.section] idName];
    vc.isService = _isService;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

