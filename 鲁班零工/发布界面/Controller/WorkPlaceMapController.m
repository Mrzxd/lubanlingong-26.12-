
//
//  WorkPlaceMapController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapTableCell.h"
#import "CalloutMapAnnotation.h"
#import "WorkPlaceMapController.h"
#import "CallOutAnnotationView.h"
#import "CalloutMapAnnotation.h"

@interface WorkPlaceMapController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocation *clannotation;
@property (nonatomic, strong) NSArray *placeArray;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation WorkPlaceMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上班地点";
    [self startLocation];
    [self.view addSubview:self.tableView];
    [self.mapView setShowsUserLocation:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_clannotation.coordinate,3000,3000);
    //初始化一个检索请求对象
    MKLocalSearchRequest * req = [[MKLocalSearchRequest alloc]init];
    //设置检索参数
    req.region=region;
    NSString *naturalLanguageQuery = searchBar.text NonNull;
    //兴趣点关键字
    req.naturalLanguageQuery = naturalLanguageQuery;
    //初始化检索
    MKLocalSearch * ser = [[MKLocalSearch alloc]initWithRequest:req];
    //开始检索，结果返回在block中
        [ser startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            //兴趣点节点数组
            NSArray * array = [NSArray arrayWithArray:response.mapItems];
            self.placeArray = array;
            [self.mapView removeAnnotations:self.mapView.annotations];
            for (int i=0; i<array.count; i++) {
                MKMapItem * item=array[i];
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.title=item.name;
                point.subtitle=item.phoneNumber;
                point.coordinate=item.placemark.coordinate;
                MKCoordinateRegion region2 =MKCoordinateRegionMakeWithDistance(point.coordinate,3000,3000);
//                [self.mapView setCenterCoordinate: point.coordinate animated:YES];
                [self.mapView setRegion:region2 animated:YES];
                [self.mapView addAnnotation:point];
                if (i == 0) {
                    NSLog(@"addressDictionary======= name is ---->>>>>%@",item.placemark.name);
                    NSLog(@"addressDictionary======= FormattedAddressLines is ---->>>>>%@",item.placemark.addressDictionary[@"FormattedAddressLines"][0]);
                }
            }
                [self.tableView reloadData];
        }];
    //初期化目的地的位置信息
    
//    CLLocationCoordinate2D coords = _clannotation.coordinate;
//
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords addressDictionary:nil]];
//
//    toLocation.name = @"我的目的地";
//
//    NSArray *items = [NSArray arrayWithObjects:toLocation, nil];
//
//    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
//
//    //打开苹果自身地图应用，并呈现item
//
//    [MKMapItem openMapsWithItems:items launchOptions:options];
               [searchBar endEditing:YES];
}
- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:AutoFrame(0, 58, 375, 250)];
        _mapView.delegate = self;
        _mapView.mapType = MKMapTypeStandard;
    }
    return _mapView;
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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 得到当前位置
    CLLocation *currentLocation = locations.lastObject;
    // 位置   此对象已经采用了 MK 协议
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = currentLocation.coordinate;
    annotation.title = @"当前位置";
    // 地址解析
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark*place = placemarks.lastObject;
        annotation.subtitle= place.name;
    }];
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    if (!_clannotation && userLocation.location) {
//            MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//            MKCoordinateRegion regin = MKCoordinateRegionMake(userLocation.location.coordinate, span);
             MKCoordinateRegion regin = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,3000,3000);
            MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
            point.coordinate=userLocation.location.coordinate;
            [mapView setRegion:regin animated:YES];
//            [mapView addAnnotation:point];
//            userLocation -> MKUserLocation ->大头针数据模型（用户）->遵守
//            MKAnnotation协议 ->经纬度  标题  副标题
//             MKUserLocation 经纬度  标题  副标题 航向 location
//          userLocation.title = @"当前位置";
            _clannotation = userLocation.location;
//           [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    }
}

//设置锚点样式

- (MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id)annotation{
   
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if(!pin) {
        pin = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    }
        pin.draggable = YES;
        pin.canShowCallout = YES;
        pin.image = [UIImage imageNamed:@"星2"];
    return pin;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:AutoFrame(73, 8, 292, 38)];
        _searchBar.placeholder = @"请输入小区、大厦或写字楼名称";
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        UIImage * searchBarBg = [self GetImageWithColor:RGBHex(0xF5F5F5) andHeight:38.0 *ScalePpth];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:RGBHex(0xF5F5F5)];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //更改输入框圆角
        _searchBar.layer.cornerRadius = 19.0f*ScalePpth;
        _searchBar.layer.masksToBounds = YES;
        //更改输入框字号
        UITextField  *seachTextFild = (UITextField*)[self subViewOfClassName:@"UISearchBarTextField" view:_searchBar];
        seachTextFild.font = [UIFont systemFontOfSize:12 *ScalePpth];
    }
    return _searchBar;
}
- (UIView*)subViewOfClassName:(NSString*)className view:(UIView *)view{
    for (UIView* subView in view.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView* resultFound = [self subViewOfClassName:className view:subView];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, (58 + 260))];
        _headerView.backgroundColor = UIColor.whiteColor;
        UIButton *addressButton =  [[UIButton alloc] initWithFrame:CGRectMake(15*ScalePpth,  22*ScalePpth, 60*ScalePpth, 18.1*ScalePpth)];
        [addressButton setTitle:@"济南" forState:UIControlStateNormal];
        [addressButton setImage:[UIImage imageNamed:@"home_arrow_bottom"] forState:UIControlStateNormal];
        [addressButton setImageEdgeInsets:UIEdgeInsetsMake(0, 43*ScalePpth, 0, 0)];
        [addressButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20*ScalePpth, 0,13*ScalePpth)];
        addressButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [addressButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        [_headerView addSubview:addressButton];
        [_headerView addSubview:self.searchBar];
        [_headerView addSubview:self.mapView];
        [self addLineView];
    }
    return _headerView;
}

- (void)addLineView {
  
    UIView *view = [[UIView alloc] initWithFrame:AutoFrame(0, 308, 375, 10)];
    view.backgroundColor = RGBHex(0xf0f0f0);
    [_headerView addSubview:view];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        [_tableView registerClass:[MapTableCell class] forCellReuseIdentifier:@"MapTableCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xf0f0f0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return _placeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0*ScalePpth;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapTableCell" forIndexPath:indexPath];
    cell.pointView.backgroundColor = indexPath.row == 0?RGBHex(0xEA4B32):RGBHex(0xDEDEDE);
      MKMapItem *item = _placeArray[indexPath.row];
    cell.nameLabel.text = item.placemark.name;
    cell.nameLabel.textColor = indexPath.row == 0?RGBHex(0x333333):RGBHex(0x999999);
    cell.stressLabel.text = item.placemark.addressDictionary[@"FormattedAddressLines"][0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     MKMapItem *item = _placeArray[indexPath.row];
    if (_adressBlock) {
        _adressBlock(item.placemark.addressDictionary[@"FormattedAddressLines"][0] NonNull,[NSString stringWithFormat:@"%lf",item.placemark.coordinate.longitude],[NSString stringWithFormat:@"%lf",item.placemark.coordinate.latitude]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}





@end
