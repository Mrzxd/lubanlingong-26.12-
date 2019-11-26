//
//  LookingForServicesController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/12.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "LookingForServicesModel.h"
#import "LookForServicesCell.h"
#import "DetailTableCell.h"
#import "ServiceDetailsController.h"
#import "LookingForServicesController.h"
#import <CoreLocation/CoreLocation.h>

@interface LookingForServicesController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIView *alphaGrayView;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UIButton *selectRemunerationButton;
@property (nonatomic, strong) UIButton *selectSexButton;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSMutableArray *cellArray2;
@property (nonatomic, strong) UITableViewCell *lastSelectCell;
@property (nonatomic, strong) DetailTableCell *lastSelectCell2;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray <HomeListModel *>*homeListModelArray;
@property (nonatomic, strong) NSString *select_Classification_ID;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *pay;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) LookingForServicesModel*pageListModel;
@property (assign, nonatomic) NSInteger pageIndex;

@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UITextField *priceTextField2;

@property (nonatomic, strong) CLLocation *clannotation;
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation LookingForServicesController {
    UIView *segmentView;
    UIButton *firstButton;
    UIView *lineView;
    UIButton *secondButton;
    UIButton *newButton;
    UIButton *yesButton;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocation];
    _cellArray = [[NSMutableArray alloc] init];
    _cellArray2 = [[NSMutableArray alloc] init];
    self.view.backgroundColor = RGBHex(0xf0f0f0);
    _sort = @"";
    _pay = @"";
    _sex = @"";
    _homeListModelArray = [HomeListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeListModelArray"]];
    _select_Classification_ID = @"";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    [self netWorking];
}

- (UIView *)alphaGrayView {
    if (!_alphaGrayView) {
        CGFloat space = 231 *ScalePpth +statusHeight;
        CGFloat height = ScreenHeight - space;
        _alphaGrayView = [[UIView alloc] initWithFrame:AutoFrame(0, space/ScalePpth, 375, height/ScalePpth)];
        _alphaGrayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    return _alphaGrayView;
}

- (UIView *)screenView {
    if (!_screenView) {
        _screenView = [[UIView alloc] initWithFrame:AutoFrame(0, 50, 375, 348)];
        _screenView.backgroundColor = UIColor.whiteColor;
        [self addSubViews];
    }
    return _screenView;
}

- (UITextField *)priceTextField {
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc] initWithFrame:AutoFrame(21, 39, 113, 26)];
        _priceTextField.delegate = self;
        _priceTextField.keyboardType = UIKeyboardTypeNumberPad;
        _priceTextField.backgroundColor = RGBHex(0xF5F5F5);
        _priceTextField.placeholder = @"输入最低价格";
        _priceTextField.font = FontSize(11);
        _priceTextField.textAlignment = NSTextAlignmentCenter;
        _priceTextField.borderStyle = UITextBorderStyleNone;
        _priceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _priceTextField.layer.cornerRadius = 3*ScalePpth;
        _priceTextField.layer.masksToBounds = YES;
    }
    return _priceTextField;
}
- (UITextField *)priceTextField2 {
    if (!_priceTextField2) {
        _priceTextField2 = [[UITextField alloc] initWithFrame:AutoFrame(163, 39, 113, 26)];
        _priceTextField2.delegate = self;
        _priceTextField2.keyboardType = UIKeyboardTypeNumberPad;
        _priceTextField2.backgroundColor = RGBHex(0xF5F5F5);
        _priceTextField2.placeholder = @"输入最高价格";
        _priceTextField2.font = FontSize(11);
        _priceTextField2.textAlignment = NSTextAlignmentCenter;
        _priceTextField2.borderStyle = UITextBorderStyleNone;
        _priceTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
        _priceTextField2.layer.cornerRadius = 3*ScalePpth;
        _priceTextField2.layer.masksToBounds = YES;
    }
    return _priceTextField2;
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
- (void)addSubViews {
   
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, (73+i*78), 360, 0.4)];
        lineView.backgroundColor = RGBHex(0xEEEEEE);
        [_screenView addSubview:lineView];
    }
    
    UILabel *priceSectionLabel = [[UILabel alloc] initWithFrame:AutoFrame(19, 12, 100, 13)];
    priceSectionLabel.text = @"价格区间";
    priceSectionLabel.textColor = UIColor.blackColor;
    priceSectionLabel.font = FontSize(13);
    [_screenView addSubview:priceSectionLabel];
    [_screenView addSubview:self.priceTextField];
    [_screenView addSubview:self.priceTextField2];
    
    UIView *priceSectionLineView = [[UIView alloc] initWithFrame:AutoFrame(139, 53, 18, 1)];
    priceSectionLineView.backgroundColor = RGBHex(0xB3B3B3);
    [_screenView addSubview:priceSectionLineView];

    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:AutoFrame(284, 48, 100, 11)];
    moneyLabel.text = @"元";
    moneyLabel.textColor = UIColor.blackColor;
    moneyLabel.font = FontSize(11);
    [_screenView addSubview:moneyLabel];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:AutoFrame(19, 92, 100, 13)];
    sexLabel.text = @"性别要求";
    sexLabel.textColor = UIColor.blackColor;
    sexLabel.font = FontSize(13);
    [_screenView addSubview:sexLabel];
    
    NSArray *sexArray = @[@"全部",@"男",@"女"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *sexButton  = [[UIButton alloc] initWithFrame:AutoFrame((20+i *75), 117, 60, 26)];
        [sexButton setTitle:sexArray[i] forState:UIControlStateNormal];
        sexButton.titleLabel.font = FontSize(11);
        sexButton.clipsToBounds= YES;
        sexButton.layer.masksToBounds = YES;
        sexButton.layer.cornerRadius = 3*ScalePpth;
        i == 0?(_selectSexButton = sexButton):0;
        sexButton.tag = 500 +i;
        [sexButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        i == 0?([sexButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal]):([sexButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal]);
        i == 0?(sexButton.backgroundColor = RGBHex(0xFFD301)):(sexButton.backgroundColor = RGBHex(0xEEEEEE));
        [_screenView addSubview:sexButton];
    }
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 152, 188, 40)];
    [newButton setTitle:@"重置" forState:UIControlStateNormal];
    [newButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    newButton.titleLabel.font = FontSize(17);
    newButton.backgroundColor = RGBHex(0xffffff);
    [newButton addTarget:self action:@selector(screenViewNewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_screenView addSubview:newButton];
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:AutoFrame(188, 152, 189, 40)];
    [yesButton setTitle:@"完成" forState:UIControlStateNormal];
    [yesButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    yesButton.tag = 101;
    [yesButton addTarget:self action:@selector(yesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    yesButton.backgroundColor = RGBHex(0xFFD301);
    yesButton.titleLabel.font = FontSize(17);
    [_screenView addSubview:yesButton];
}
- (void)remunerationButtonAction:(UIButton *)button {
    [_selectRemunerationButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    _selectRemunerationButton.backgroundColor = RGBHex(0xEEEEEE);
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.backgroundColor = RGBHex(0xFFD301);
    _selectRemunerationButton = button;
    if (button.tag == 400) {
        _pay = @"";
    } else if (button.tag == 401) {
        _pay = @"1";
    } else {
        _pay = @"2";
    }
}
- (void)sexButtonAction:(UIButton *)button {
    [_selectSexButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    _selectSexButton.backgroundColor = RGBHex(0xEEEEEE);
    
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.backgroundColor = RGBHex(0xFFD301);
    _selectSexButton = button;
    if (button.tag == 500) {
        _sex = @"";
    } else if (button.tag == 501) {
        _sex = @"1";
    } else
    {
        _sex = @"2";
    }
}
- (void)screenViewNewButtonAction:(UIButton *)button {
    [_screenView removeFromSuperview];
    _screenView  = nil;
    [segmentView addSubview:self.screenView];
    _pay = @"";
    _priceTextField.text = @"";
    _priceTextField2.text = @"";
    _sex = @"";
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = ScreenHeight - KTabBarHeight -statusHeight - 141*ScalePpth;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusHeight + 141*ScalePpth, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tag = 1000;
        [_tableView registerClass:[LookForServicesCell class] forCellReuseIdentifier:@"LookForServicesCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WeakSelf;
        [_tableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
            weakSelf.pageIndex = pageIndex;
            [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseSkill/select/skillListSolr"] params:@{
                   @"page":@"1",
                   @"pageSize":@"10",
                   @"Sort":weakSelf.sort,
                   @"workTypeId":weakSelf.select_Classification_ID,
                   @"solr":NoneNull(weakSelf.searchBar.text),
                   @"filter":@{
                            @"pay":weakSelf.pay,
                            @"price":@{@"low":NoneNull(weakSelf.priceTextField.text),@"hig":NoneNull(weakSelf.priceTextField2.text)},
                            @"sex":weakSelf.sex,
//                            @"location":[NSString stringWithFormat:@"%lf,%lf",weakSelf.clannotation.coordinate.longitude,weakSelf.clannotation.coordinate.latitude],
                   }
               } success:^(id  _Nonnull response) {
                weakSelf.pageListModel = [LookingForServicesModel mj_objectWithKeyValues:response[@"data"]];
                [weakSelf.tableView reloadData];
               } fail:^(NSError * _Nonnull error) {
                   
               } showHUD:YES];
        }];
        [_tableView addFooterWithWithHeaderWithAutomaticallyRefresh:YES loadMoreBlock:^(NSInteger pageIndex) {
            weakSelf.pageIndex = pageIndex;
            [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseSkill/select/skillListSolr"] params:@{
                                  @"page":@(pageIndex),
                                  @"pageSize":@"10",
                                  @"Sort":weakSelf.sort,
                                  @"workTypeId":weakSelf.select_Classification_ID,
                                  @"solr":NoneNull(weakSelf.searchBar.text),
                                  @"filter":@{
                                           @"pay":weakSelf.pay,
                                           @"price":@{@"low":NoneNull(weakSelf.priceTextField.text),@"hig":NoneNull(weakSelf.priceTextField2.text)},
                                           @"sex":weakSelf.sex,
//                                           @"location":[NSString stringWithFormat:@"%lf,%lf",weakSelf.clannotation.coordinate.longitude,weakSelf.clannotation.coordinate.latitude],
                                  }
               } success:^(id  _Nonnull response) {
                if (response) {
                    if ([response[@"data"][@"pageNum"] isEqual:response[@"data"][@"pages"]]) {
                        [weakSelf.tableView endFooterNoMoreData];
                    }
                }
                [weakSelf.tableView endFooterRefresh];
                if (weakSelf.pageIndex <= [response[@"data"][@"pages"] integerValue] && weakSelf.pageIndex > 1) {
                    
                    NSMutableArray *listArray = weakSelf.pageListModel.list.mutableCopy ?:[NSMutableArray new];
                        weakSelf.pageListModel = [LookingForServicesModel mj_objectWithKeyValues:response[@"data"]];
                    [weakSelf.pageListModel.list enumerateObjectsUsingBlock:^(LookingForListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [listArray addObject:obj];
                    }];
                    weakSelf.pageListModel.list = listArray;
                    [weakSelf.tableView reloadData];
                }
               } fail:^(NSError * _Nonnull error) {

               } showHUD:YES];
        }];
    }
    return _tableView;
}

- (UITableView *)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:AutoFrame(0, 49, 88, 222) style:UITableViewStyleGrouped];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView.tag = 2000;
        _tableView2.scrollEnabled = YES;
        _tableView2.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView2.backgroundColor = RGBHex(0xF6F6F6);
        _tableView2.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView2;
}
- (UITableView *)tableView3 {
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc] initWithFrame:AutoFrame(88, 49,(375 - 88), 222) style:UITableViewStylePlain];
        _tableView3.dataSource = self;
        _tableView3.delegate = self;
        _tableView3.tag = 3000;
        _tableView3.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView3.backgroundColor = RGBHex(0xffffff);
        _tableView3.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView3.showsVerticalScrollIndicator = NO;
        _tableView3.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView3;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0,statusHeight/ScalePpth, 375, 141)];
        _headerView.backgroundColor = RGBHex(0xf0f0f0);
        _headerView.clipsToBounds = YES;
        UIButton *addressButton =  [[UIButton alloc] initWithFrame:CGRectMake(25*ScalePpth,  15*ScalePpth, 60*ScalePpth, 18.1*ScalePpth)];
        [addressButton setTitle:@"济南" forState:UIControlStateNormal];
        [addressButton setImage:[UIImage imageNamed:@"home_arrow_bottom"] forState:UIControlStateNormal];
        [addressButton setImageEdgeInsets:UIEdgeInsetsMake(0, 43*ScalePpth, 0, 0)];
        [addressButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20*ScalePpth, 0,13*ScalePpth)];
        addressButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [addressButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        [_headerView addSubview:addressButton];
        UIButton *addButton =  [[UIButton alloc] initWithFrame:CGRectMake(334*ScalePpth, 15*ScalePpth, 16*ScalePpth, 16*ScalePpth)];
        [addButton setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addButton];
        [_headerView addSubview:self.searchBar];
        [self addHeaderSegmentView];
    }
    return _headerView;
}

- (void)addHeaderSegmentView {
    
    segmentView = [[UIView alloc] initWithFrame:AutoFrame(0, 92, 375, 49)];
    segmentView.backgroundColor = UIColor.whiteColor;
    segmentView.clipsToBounds= YES;
    [segmentView addSubview:self.tableView2];
    [segmentView addSubview:self.tableView3];
    _tableView2.hidden = YES;
    _tableView3.hidden = YES;
    
    UIView *backView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 10)];
    backView.backgroundColor = RGBHex(0xf0f0f0);
    [segmentView addSubview:backView];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 10)];
    backView2.backgroundColor = RGBHex(0xffffff);
    
    CGRect bounds = backView2.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = backView2.bounds;
    maskLayer.path = maskPath.CGPath;
    backView2.layer.mask = maskLayer;
    [backView addSubview:backView2];
    [_headerView addSubview:segmentView];
    firstButton = [[UIButton alloc] initWithFrame:AutoFrame(25, 51, 330, 31)];
    [firstButton setTitle:@"离我最近" forState:UIControlStateNormal];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    firstButton.titleLabel.font = FontSize(11);
    [firstButton addTarget:self action:@selector(firstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:firstButton];
    
    lineView = [[UIView alloc] initWithFrame:AutoFrame(25, 89, 325, 0.4)];
    lineView.backgroundColor = RGBHex(0xeeeeee);
    [segmentView addSubview:lineView];
   
    secondButton = [[UIButton alloc] initWithFrame:AutoFrame(25, 98, 330, 31)];
    [secondButton setTitle:@"最新发布" forState:UIControlStateNormal];
    secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [secondButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    secondButton.titleLabel.font = FontSize(11);
    [segmentView addSubview:secondButton];
    
    NSArray *titleArr = @[@"默认排序",@"零工类型",@"筛选"];
    for (NSInteger i  = 0; i < 3; i ++) {
        CGFloat space;
        if (i == 0) {
            space = 19;
       
        } else if (i == 1) {
            space = 140;
        } else {
            space = 261;
        }
        
        UIButton *typeButton = [[UIButton alloc] initWithFrame:AutoFrame(space, 10, 95, 29)];
        typeButton.tag = 300 +i;
        [typeButton setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
        [typeButton setImage:[UIImage imageNamed:@"upward"] forState:UIControlStateSelected];
        [typeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 74*ScalePpth, 0, 0)];
        [typeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15*ScalePpth)];
        typeButton.backgroundColor = RGBHex(0xFFD301);
        if (i > 0) {
            typeButton.backgroundColor = UIColor.whiteColor;
        } else {
            _lastButton = typeButton;
        }
        typeButton.clipsToBounds = YES;
        typeButton.layer.masksToBounds = YES;
 
        typeButton.layer.cornerRadius = 14.5 *ScalePpth;
        [typeButton setTitle:titleArr[i] forState:UIControlStateNormal];
        [typeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        typeButton.titleLabel.font = FontSize(13);
        [segmentView addSubview:typeButton];
    }
    
    newButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 271, 188, 40)];
    [newButton setTitle:@"重置" forState:UIControlStateNormal];
    [newButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    newButton.titleLabel.font = FontSize(17);
    newButton.backgroundColor = RGBHex(0xffffff);
    [newButton addTarget:self action:@selector(newButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:newButton];
    yesButton = [[UIButton alloc] initWithFrame:AutoFrame(188, 271, 189, 40)];
    [yesButton setTitle:@"完成" forState:UIControlStateNormal];
    [yesButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    yesButton.tag = 100;
    [yesButton addTarget:self action:@selector(yesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    yesButton.backgroundColor = RGBHex(0xFFD301);
    yesButton.titleLabel.font = FontSize(17);
    [segmentView addSubview:yesButton];
}
//离我最近
- (void)firstButtonAction:(UIButton *)button {
    _sort = @"1";
    [self netWorking];
}
//最新发布
- (void)secondButtonAction:(UIButton *)button {
    _sort = @"2";
    [self netWorking];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseSkill/select/skillListSolr"] params:@{
        @"page":@"1",
        @"pageSize":@"10",
        @"Sort":_sort,
        @"workTypeId":_select_Classification_ID,
        @"solr":NoneNull(_searchBar.text),
        @"filter":@{
                 @"pay":_pay,
                 @"price":@{@"low":NoneNull(_priceTextField.text),@"hig":NoneNull(_priceTextField2.text)},
                 @"sex":_sex,
        },
    } success:^(id  _Nonnull response) {
        if (response && response[@"data"]) {
            weakSelf.pageListModel = [LookingForServicesModel mj_objectWithKeyValues:response[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
            [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}

- (void)newButtonAction:(UIButton *)button {
    [_tableView2 removeFromSuperview];
    [_tableView3 removeFromSuperview];
    _tableView2 = nil;
    _tableView3 = nil;
    _lastSelectCell = nil;
    _lastSelectCell2 = nil;
    _cellArray = nil;
    _cellArray2 = nil;
    _cellArray = [[NSMutableArray alloc] init];
    _cellArray2 = [[NSMutableArray alloc] init];
    [segmentView addSubview:self.tableView2];
    [segmentView addSubview:self.tableView3];
    [_tableView2 reloadData];
    [_tableView3 reloadData];
    _select_Classification_ID = @"";
}
- (void)yesButtonAction:(UIButton *)button {
    _lastButton.selected = !_lastButton.selected;
    segmentView.frame = AutoFrame(0, 92, 375, 49);
    _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 141);
    [_alphaGrayView removeFromSuperview];
    [self netWorking];
}
- (void)typeButtonAction:(UIButton *)button {
    if (_lastButton != button) {
        _lastButton.selected = NO;
    }
    
    [_lastButton setBackgroundColor:UIColor.whiteColor];
    button.backgroundColor = RGBHex(0xFFD301);
    yesButton.hidden = YES;
    newButton.hidden = YES;
    if (_alphaGrayView) {
        [_alphaGrayView removeFromSuperview];
        _alphaGrayView = nil;
    }
    [_screenView removeFromSuperview];
    if (button.tag == 300) {
        firstButton.hidden  = NO;
        lineView.hidden = NO;
        secondButton.hidden = NO;
        _tableView2.hidden = YES;
        _tableView3.hidden = YES;
         button.selected = !button.selected;
        if (_lastButton != button) {
            button.selected = YES;
        }
        if (button.isSelected) {
            segmentView.frame = AutoFrame(0, 92, 375, 145);
             _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, (92+145));
            [GlobalSingleton.gS_ShareInstance.systemWindow addSubview:self.alphaGrayView];
        } else {
             _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 141);
             segmentView.frame = AutoFrame(0, 92, 375, 49);
            [_alphaGrayView removeFromSuperview];
        }
    } else if (button.tag == 301) {
        _tableView2.scrollEnabled = YES;
        _tableView2.hidden = NO;
        _tableView3.hidden = NO;
        yesButton.hidden = NO;
        newButton.hidden = NO;
        firstButton.hidden  = YES;
        lineView.hidden = YES;
        secondButton.hidden = YES;
          button.selected = !button.selected;
        if (_lastButton != button) {
            button.selected = YES;
        }
        if (button.isSelected) {
            segmentView.frame = AutoFrame(0, 92, 375, 311);
            _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 403);
            CGFloat space = 403 *ScalePpth +statusHeight;
            CGFloat height = ScreenHeight - space;
            self.alphaGrayView.frame = AutoFrame(0, space/ScalePpth, 375, height/ScalePpth);
            [GlobalSingleton.gS_ShareInstance.systemWindow addSubview:self.alphaGrayView];
        } else {
            segmentView.frame = AutoFrame(0, 92, 375, 49);
            _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 141);
            [_alphaGrayView removeFromSuperview];
        }
    } else {
        firstButton.hidden  = YES;
        lineView.hidden = YES;
        secondButton.hidden = YES;
        _tableView2.hidden = YES;
        _tableView3.hidden = YES;
        button.selected = !button.selected;
        if (_lastButton != button) {
            button.selected = YES;
        }
        if (button.isSelected) {
            segmentView.frame = AutoFrame(0, 92, 375, 242);
            _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 334);
            [segmentView addSubview:self.screenView];
            CGFloat space = 334 *ScalePpth +statusHeight;
            CGFloat height = ScreenHeight - space;
            self.alphaGrayView.frame = AutoFrame(0, space/ScalePpth, 375, height/ScalePpth);
            [GlobalSingleton.gS_ShareInstance.systemWindow addSubview:self.alphaGrayView];
        } else {
            segmentView.frame = AutoFrame(0, 92, 375, 49);
            _headerView.frame = AutoFrame(0,statusHeight/ScalePpth, 375, 141);
            [_alphaGrayView removeFromSuperview];
        }
    }
     _lastButton = button;
}
#pragma mark ---- addbutton

- (void)addAction:(UIButton *)button {
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_priceTextField endEditing:YES];
    [_priceTextField2 endEditing:YES];
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:AutoFrame(10, 44, 355, 38)];
        _searchBar.placeholder = @"输入您要搜索的内容";
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        UIImage * searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:38.0 *ScalePpth];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
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
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tableView2) {
         return _homeListModelArray.count;
     } else if (tableView == _tableView3) {
         return [_homeListModelArray[_selectIndex] list].count;
     } else {
         return _pageListModel.list.count;
     }
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView2) {
        return 31.71 *ScalePpth;
    } else if (tableView == _tableView3) {
        return 31.71*ScalePpth;
    }
    return 93*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView  == _tableView) {
        return 10*ScalePpth;
    }
    return 0;
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
    
    if (tableView == _tableView2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"TableViewCell%ld",(long)indexPath.section]];
        if (indexPath.section < _cellArray2.count) {
            cell = _cellArray2[indexPath.section];
            return cell;
        }
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"TableViewCell%ld",(long)indexPath.section]];
            cell.textLabel.font = FontSize(13);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = RGBHex(0xf6f6f6);
            cell.textLabel.text = [_homeListModelArray[indexPath.section] typeWork];
            if (indexPath.section == 0) {
                _lastSelectCell = cell;
                cell.textLabel.textColor = UIColor.blackColor;
            } else {
                cell.textLabel.textColor = RGBHex(0x999999);
            }
            if (_cellArray2.count < 8) {
                [_cellArray2 addObject:cell];
            }
        }
        return cell;
    }
    else if (tableView == _tableView3) {
        DetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"DetailTableCell%ld",(long)indexPath.section]];
        if (indexPath.section < _cellArray.count) {
            cell = _cellArray[indexPath.section];
            cell.textContent = [[_homeListModelArray[_selectIndex] list][indexPath.section] typeWork];
            return cell;
        }
        if (!cell) {
            cell = [[DetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailTableCell%ld"];
            cell.textContent = [[_homeListModelArray[_selectIndex] list][indexPath.section] typeWork];
            if (indexPath.section == 0) {
                cell.label.textColor = UIColor.blackColor;
                _lastSelectCell2 = cell;
            }
            if (_cellArray.count < 8) {
                [_cellArray addObject:cell];
            }
        }
        return cell;
    }
    LookForServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookForServicesCell" forIndexPath:indexPath];
//    cell.nameLabel.text = @[@"服务员",@"装卸工",@"钟点工或长期兼职工"][indexPath.section];
    cell.listModel = _pageListModel.list[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableView2 == tableView) {
        _lastSelectCell.textLabel.textColor = RGBHex(0x999999);
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = UIColor.blackColor;
        _lastSelectCell = cell;
        _selectIndex = indexPath.section;
        [_tableView3 reloadData];
    } else if (_tableView3 == tableView) {
        DetailTableCell *cell = (DetailTableCell *)[tableView cellForRowAtIndexPath:indexPath];
        _lastSelectCell2.label.textColor = RGBHex(0x999999);
        cell.label.textColor = RGBHex(0x333333);
        _lastSelectCell2 = cell;
    } else {
        ServiceDetailsController *sdc = [[ServiceDetailsController alloc] init];
        sdc.idName = [_pageListModel.list[indexPath.section] idName];
        [self.navigationController pushViewController:sdc animated:YES];
    }
}


@end







