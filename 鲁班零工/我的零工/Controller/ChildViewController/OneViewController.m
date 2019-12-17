//
//  OneViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OrderStatusCell.h"
#import "ToEvaluateController.h"
#import "CancleOrderController.h"
#import "OneViewController.h"

@interface OneViewController () <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIImageView *nonDataView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyOddJobModel * model;
@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;

@property (nonatomic, strong) CLLocation *clannotation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation OneViewController {
     UIView *bottomCoverView;
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
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/WorkerCore/AllOrderFromList"] params:@{
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
            [WHToast showErrorWithMessage:@"网络错误"];
            weakSelf.tableView.hidden = YES;
            [weakSelf.view addSubview:weakSelf.nonDataView];
    } showHUD:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self startLocation];
}
- (void)startLocation {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.0) {
        // 由于iOS8中定位的授权机制改变, 需要进行手动授权
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        CLLocationDistance distance = 2000;
        _locationManager.distanceFilter = distance;
    }
    return _locationManager;
}

#pragma mark ---------- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    _clannotation = currentLocation;
    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavigationHeight-40*ScalePpth) style:UITableViewStyleGrouped];
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
    [_grayView removeFromSuperview];
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
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/refuseButton"] params:@{
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
    cell.jobModel = _jobModelArray[indexPath.section];
    if (cell.jobModel.orderStatusGr.intValue == 0) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"等待雇主同意";
        [cell.stateButton setTitle:@"取消订单" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue == 1) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"邀请等待同意";
        [cell.MiddleButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"同意" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue == 2) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = YES;
        cell.waitLabel.text = @"拒绝接单";
        [cell.stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue == 3) {
        cell.startWorkButton.hidden = NO;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"进行中";
        [cell.startWorkButton setTitle:@"开工" forState:UIControlStateNormal];
        [cell.MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"导航" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue ==  4) {
        cell.startWorkButton.hidden = YES;
       cell.MiddleButton.hidden = NO;
       cell.waitLabel.text = @"进行中";
       [cell.MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
       [cell.stateButton setTitle:@"导航" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue ==  5) {
        cell.startWorkButton.hidden = YES;
        cell.MiddleButton.hidden = NO;
        cell.waitLabel.text = @"待付款";
        [cell.MiddleButton setTitle:@"确认付款" forState:UIControlStateNormal];
        [cell.stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    } else if (cell.jobModel.orderStatusGr.intValue ==  6) {
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
    cell.firstButtonBlock = ^(MyOddJobModel * model) {
         if ([weakCell.startWorkButton.currentTitle  isEqual: @"开工"]) {
             [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/startWorkButton"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
                 if (response && [response[@"code"] intValue] == 0) {
                     [weakSelf netWorking];
                 } else {
                     if (response[@"msg"]) {
                         [WHToast showErrorWithMessage:response[@"msg"]];
                     } else {
                         [WHToast showErrorWithMessage:@"开工失败"];
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
         } else if ([weakCell.MiddleButton.currentTitle isEqual:@"确认完工"]) {
             [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/confirmWorkButton"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
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
         } else if ([weakCell.MiddleButton.currentTitle isEqual:@"确认付款"]) {
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
         } else if ([weakCell.MiddleButton.currentTitle isEqual:@"去评价"]) {
             ToEvaluateController *teec = [ ToEvaluateController new];
             teec.model = model;
             [weakSelf.navigationController pushViewController:teec animated:YES];
         }
    };
    cell.cellBlock = ^(MyOddJobModel * model) {
        if ([weakCell.stateButton.currentTitle isEqual:@"取消订单"]) {
            CancleOrderController *coc = [[CancleOrderController alloc] init];
            coc.jobModel = model;
            [weakSelf.navigationController pushViewController:coc animated:YES];
        } else if ([weakCell.stateButton.currentTitle isEqual:@"同意"]) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/AgreeButton"] params:@{
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
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/deleteOrder"] params:@{@"id":NoneNull(model.idName)} success:^(id  _Nonnull response) {
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
        } else if ([weakCell.stateButton.currentTitle isEqual:@"联系客服"]) {
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
        } else if ([weakCell.stateButton.currentTitle isEqual:@"导航"]) {
            [weakSelf setMapItemDatas:model];
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



- (void)setMapItemDatas:(MyOddJobModel * )typeModel {
    CLLocationCoordinate2D coords1 = _clannotation.coordinate;
    //目的地位置
    CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = typeModel.orderLocationY.doubleValue;
    coordinate2.longitude = typeModel.orderLocationX.doubleValue;
    //起点
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
    currentLocation.name = @"我的位置";
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate2 addressDictionary:nil]];
    toLocation.name = @"目的地";
    if (NoneNull(typeModel.orderLocation)) {
        toLocation.name = NoneNull(typeModel.orderLocation);
    }
    NSArray *items = @[currentLocation,toLocation];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],MKLaunchOptionsShowsTrafficKey:@YES};
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}


@end
