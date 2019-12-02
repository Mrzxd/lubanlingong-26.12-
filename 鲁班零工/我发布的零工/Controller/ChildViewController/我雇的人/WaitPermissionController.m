
//
//  WaitPermissionController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/26.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderStatusCell.h"
#import "CancleOrderController.h"
#import "WaitPermissionController.h"
#import "OrderDetailsOfMyEmployeesController.h"

@interface WaitPermissionController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;
@property (nonatomic, strong) MyOddJobModel * model;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *grayView;

@end

@implementation WaitPermissionController {
     UIView *bottomCoverView;
}


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
        @"type":@"-1"
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0 && response[@"data"]) {
            weakSelf.jobModelArray = [MyOddJobModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}
- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubViews];
    }
    return _grayView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- KNavigationHeight-34*ScalePpth) style:UITableViewStyleGrouped];
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
- (void)addSubViews {
    CGFloat space = ScreenHeight - 258 *ScalePpth;
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, space, ScreenWidth, 258 *ScalePpth)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    [_grayView addSubview:whiteView];;
    
    UILabel *reasonsForRefusalLabel = [[UILabel alloc] initWithFrame:AutoFrame(150, 23, 75, 16)];
    reasonsForRefusalLabel.textColor = RGBHex(0x000000);
    reasonsForRefusalLabel.font = FontSize(16);
    reasonsForRefusalLabel.text = @"拒绝原因";
    [whiteView addSubview:reasonsForRefusalLabel];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:AutoFrame(330, 15, 30, 34)];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14 *ScalePpth];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [closeButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:closeButton];
    
    NSArray *typeArray = @[@"工种不匹配",@"价格低",@"时间冲突",@"其他"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame(12, (84 + i *48), 100, 14)];
        typeLabel.textColor = RGBHex(0x000000);
        typeLabel.font = FontSize(14);
        typeLabel.text = typeArray[i];
        [whiteView addSubview:typeLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0,(113.5 + i *48), 375, 0.65)];
        line.backgroundColor = RGBHex(0xE7E7E7);
        [whiteView addSubview:line];
       
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(328, (66.5 + i *48), 47, 47)];
        button.userInteractionEnabled = YES;
        button.tag = 100 +i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:button];
        if (i == 0) {
            _lastButton = button;
            [button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
        }
    }
}
- (UILabel *)typeLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, height, 100, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x333333);
    label.text = text;
    return label;
}

- (UILabel *)rightLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(200, height, 145, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x999999);
    label.text = text;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}
- (void)closeButtonAction:(UIButton *)button {
    [button removeFromSuperview];
}
- (void)buttonAction:(UIButton *)button {
    NSArray *reasonArray = @[@"工种不匹配",@"价格低",@"时间冲突",@"其他"];
    NSString *reason = reasonArray[button.tag - 100];
    [_lastButton setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    _lastButton = button;
    bottomCoverView.frame = AutoFrame(7.5, 280, 360, 161.5);
    [bottomCoverView addSubview:[self typeLabel:@"拒绝原因" :135.5]];
    [bottomCoverView addSubview:[self rightLabel:@"工种不匹配" :135.5]];
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/refuseButtonEmp"] params:@{
        @"id":NoneNull(_model.idName),
        @"refuseCause":reason,
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
            // 拒绝
            (void)weakSelf.grayView.removeFromSuperview;
            [weakSelf netWorking];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
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
    cell.timeLabel.text = @"保险销售";
    cell.saleLabel.text = @"接单人";
    cell.timeCTLabel.text = @"300元/天";
    cell.saleCTLabel.text = @"李四";
     cell.jobModel = _jobModelArray[indexPath.section];
     if (cell.jobModel.orderStatusGz.intValue == 1) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"等待同意";
        [cell.MiddleButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"同意" forState:UIControlStateNormal];
   } else  if (cell.jobModel.orderStatusGz.intValue == 2)  {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"已拒绝";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
   } else  if (cell.jobModel.orderStatusGz.intValue == 0) {
         cell.startWorkButton.hidden = YES;
         cell.MiddleButton.hidden = YES;
         cell.waitLabel.text = @"等待雇员同意";
         [cell.stateButton setTitle:@"取消订单" forState:UIControlStateNormal];
   }
    WeakCell;
       WeakSelf;
       cell.cellBlock = ^(MyOddJobModel * model) {
       if ([weakCell.stateButton.currentTitle isEqual:@"取消订单"]) {
           CancleOrderController *coc = [[CancleOrderController alloc] init];
           coc.jobModel = model;coc.isEmployer = YES;
           [weakSelf.navigationController pushViewController:coc animated:YES];
           } else if ([weakCell.stateButton.currentTitle isEqual:@"同意"]) {
                      [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/AgreeButtonEmp"] params:@{
                          @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                          @"id":NoneNull(model.idName)
                      } success:^(id  _Nonnull response) {
                          if (response && [response[@"code"] intValue] == 0) {
                              [weakSelf netWorking];
                          }
                      } fail:^(NSError * _Nonnull error) {
                          [WHToast showErrorWithMessage:@"网络错误"];
                      } showHUD:YES];
            } else if ([weakCell.stateButton.currentTitle isEqual:@"删除订单"]) {
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
    cell.middlleButtonBlock = ^(MyOddJobModel * model) {
     if ([weakCell.MiddleButton.currentTitle isEqual:@"拒绝"]) {
         weakSelf.model = model;
        [[GlobalSingleton gS_ShareInstance].systemWindow addSubview:self.grayView];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailsOfMyEmployeesController *odvc = [OrderDetailsOfMyEmployeesController new];
    NSString *idName = [_jobModelArray[indexPath.section] idName];
    odvc.idName = NoneNull(idName);
    [self.navigationController pushViewController:odvc animated:YES];
}

@end
