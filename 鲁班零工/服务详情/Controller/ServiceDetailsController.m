
//
//  ServiceDetailsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/28.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GrabdTableCell.h"
#import "ServiceTimeCell.h"
#import "MyAdvantageCell.h"
#import "ServiceContentCell.h"
#import "ServiceDetailModel.h"
#import "EmployerRecordController.h"
#import "EmployeeRecordsController.h"
#import "ServiceDetailsController.h"
#import "AcknowledgementOrderController.h"

@interface ServiceDetailsController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) ServiceDetailModel *detailModel;

@end

@implementation ServiceDetailsController {
    UILabel *sendLabel;
    UILabel *timeLabel;
    UILabel *dayPriceLabel;
    UILabel *rateLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务详情";
    [self.view addSubview:self.tableView];
    [self netWorking];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseSkill/select/skillinfo"] params:@{@"id":NoneNull(_idName)} success:^(id  _Nonnull response) {
        if (response && response[@"data"] && [response[@"code"] intValue] == 0) {
            weakSelf.detailModel = [ServiceDetailModel mj_objectWithKeyValues:response[@"data"]];
            [weakSelf reloadData];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (void)reloadData {
    sendLabel.text = NoneNull(_detailModel.skillName);
    timeLabel.text = [NSString stringWithFormat:@"按%@",NoneNull(_detailModel.skillSalaryDay)];
    dayPriceLabel.text = [NSString stringWithFormat:@"%@元/%@",NoneNull(_detailModel.skillSalary),NoneNull(_detailModel.skillSalaryDay)];
    rateLabel.text = [NSString stringWithFormat:@"好评率：%@%@",NoneNull(_detailModel.praise),@"%"];
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 90)];
        _headerView.backgroundColor = UIColor.whiteColor;
        [self addSubViews];
    }
    return _headerView;
}
- (void)addSubViews {
    sendLabel = [[UILabel alloc] initWithFrame:AutoFrame(16, 15, 220, 14)];
    sendLabel.text = @"济南市外卖配送员";
    sendLabel.font  = [UIFont boldSystemFontOfSize:14*ScalePpth];
    sendLabel.textColor = UIColor.blackColor;
    [_headerView addSubview:sendLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(16, 37, 30, 15)];
    timeLabel.text =  @"计时";
    timeLabel.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel.clipsToBounds = YES;
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 2*ScalePpth;
    timeLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = RGBHex(0x009CE0);
    [_headerView addSubview:timeLabel];
    
    dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 60, 100, 12)];
    dayPriceLabel.text =  @"25元/天";
    dayPriceLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dayPriceLabel.textColor = RGBHex(0xE50000);
    [_headerView addSubview:dayPriceLabel];
    
    rateLabel = [[UILabel alloc] initWithFrame:AutoFrame(250, 61, 100, 10)];
    rateLabel.text =  @"好评率：88%";
    rateLabel.textAlignment = NSTextAlignmentRight;
    rateLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    rateLabel.textColor = RGBHex(0xcccccc);
    [_headerView addSubview:rateLabel];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:AutoFrame(310, 5, 45, 45)];
    [imageButton setImage:[UIImage imageNamed:@"details_head"] forState:UIControlStateNormal];
    imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:imageButton];
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ServiceContentCell class] forCellReuseIdentifier:@"ServiceContentCell"];
        [_tableView registerClass:[MyAdvantageCell class] forCellReuseIdentifier:@"MyAdvantageCell"];
        [_tableView registerClass:[ServiceTimeCell class] forCellReuseIdentifier:@"ServiceTimeCell"];
        [_tableView registerClass:[GrabdTableCell class] forCellReuseIdentifier:@"GrabdTableCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xf0f0f0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (void)homeButtonAction {
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)imageButtonAction:(UIButton *)button {
//    EmployeeRecordsController *ERVC = [EmployeeRecordsController new];
   
    EmployerRecordController *ERVC = [EmployerRecordController new];
    ERVC.releaseId = _detailModel.releaseId NonNull;ERVC.isService = YES;
    [self.navigationController pushViewController:ERVC animated:NO];
}
- (void)immediatelyButtonAction {
    AcknowledgementOrderController *adoc = [AcknowledgementOrderController new];
    adoc.idName = _detailModel.idName NonNull;
    [self.navigationController pushViewController:adoc animated:YES];
}
- (void)starButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    
}
#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row== 2) {
            return 127*ScalePpth;
        } else {
            return 50*ScalePpth;
        }
    } else if (indexPath.section == 1) {
         return 80*ScalePpth;
    } else {
        return 143.5*ScalePpth;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 47*ScalePpth;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return [self addFooterSubView];
    }
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)addFooterSubView{
    UIView *footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 47)];
    footerView.backgroundColor = RGBHex(0xeeeeee);
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:AutoFrame(31, 9, 20, 19)];
    [homeButton setImage:[UIImage imageNamed:@"index"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:homeButton];
    
    UIButton *starButton = [[UIButton alloc] initWithFrame:AutoFrame(101, 8, 20, 20)];
    [starButton setImage:[UIImage imageNamed:@"not_to_collect"] forState:UIControlStateNormal];
    [starButton setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateSelected];
    [starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:starButton];
    //    [starButton addTarget:self action:@selector(homeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *homeLabel = [[UILabel alloc] initWithFrame:AutoFrame(31, 32, 40, 10)];
    homeLabel.textColor = RGBHex(0xB3B3B3);
    homeLabel.font = FontSize(10);
    homeLabel.text = @"首页";
    [footerView addSubview:homeLabel];
    UILabel *starLabel = [[UILabel alloc] initWithFrame:AutoFrame(96, 32, 40, 10)];
    starLabel.textColor = RGBHex(0xB3B3B3);
    starLabel.font = FontSize(10);
    starLabel.text = @"已收藏";
    
    UIButton *immediatelyButton = [[UIButton alloc] initWithFrame:AutoFrame(155, 0, 220, 47)];
    immediatelyButton.backgroundColor = RGBHex(0xFFD301);
    immediatelyButton.titleLabel.font = [UIFont boldSystemFontOfSize:17 *ScalePpth];
    [immediatelyButton setTitle:@"雇他" forState:UIControlStateNormal];
    [immediatelyButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [immediatelyButton addTarget:self action:@selector(immediatelyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:immediatelyButton];
    [footerView addSubview:starLabel];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row < 2) {
            GrabdTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GrabdTableCell" forIndexPath:indexPath];
            cell.sendLabel.text = @[@"服务方式",@"服务时间"][indexPath.row];
            cell.rightLabel.text = @[@"...",[NSString stringWithFormat:@"%@至%@",NoneNull(_detailModel.skillTimeStart),NoneNull(_detailModel.skillTimeEnd)]][indexPath.row];
            return cell;
        } else {
            ServiceTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTimeCell" forIndexPath:indexPath];
            [cell closeButtonEnabledWithString:NoneNull(_detailModel.skillDate)];
            return cell;
        }
    } else if (indexPath.section == 1) {
        MyAdvantageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAdvantageCell" forIndexPath:indexPath];
        cell.detailModel = _detailModel;
        return cell;
    } else {
        ServiceContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceContentCell" forIndexPath:indexPath];
        cell.detailModel = _detailModel;
        return cell;
    }
}
@end
