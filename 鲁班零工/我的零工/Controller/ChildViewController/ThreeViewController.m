//
//  ThreeViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OrderStatusCell.h"
#import "ThreeViewController.h"
#import "OrderDetailsController.h"

@interface ThreeViewController () <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray <MyOddJobModel *>*jobModelArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CLLocation *clannotation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ThreeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
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
#pragma mark ---------- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    _clannotation = currentLocation;
    
}
- (void)netWorking {
    WeakSelf;
   [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/WorkerCore/AllOrderFromList"] params:@{
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
    if (cell.jobModel.orderStatusGr.intValue == 3) {
         cell.startWorkButton.hidden = NO;
    } else {
         cell.startWorkButton.hidden = YES;
    }
    cell.MiddleButton.hidden = NO;
    cell.waitLabel.text = @"进行中";
    [cell.startWorkButton setTitle:@"开工" forState:UIControlStateNormal];
    [cell.MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
    [cell.stateButton setTitle:@"导航" forState:UIControlStateNormal];
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
    if ([weakCell.MiddleButton.currentTitle isEqual:@"确认完工"]) {
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
            }
       };
    cell.cellBlock = ^(MyOddJobModel * model) {
    if ([weakCell.stateButton.currentTitle isEqual:@"导航"]) {
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



@end

