//
//  GrabdDetailsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "SendTableCell.h"
#import "GrabdTableCell.h"
#import "GrabdDetailsModel.h"
#import "GrabdDetailsImagCell.h"
#import "JobRequirementsCell.h"
#import "GrabdDetailsController.h"
#import "EmployerRecordController.h"
#import "SuccessfulGrabSheetController.h"

@interface GrabdDetailsController () <UITableViewDelegate,UITableViewDataSource,YTSegmentBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) BOOL isJobRequirements;
@property (nonatomic, strong) YTSegmentBar *segmentBar;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) GrabdDetailsModel *detailModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSDictionary *netWork_data;

@end

@implementation GrabdDetailsController {
    UIView *footerView;
    UILabel *sendLabel;
    UILabel *timeLabel;
    UILabel *rateLabel;
    UILabel *dayPriceLabel;
    UIButton *imageButton;
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubView];
    }
    return _grayView;
}
- (void)addSubView {
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(33.5, 225.5, 310, 232)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = YES;
    whiteView.layer.cornerRadius = 10 *ScalePpth;
    [_grayView addSubview:whiteView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 18.5, 310, 18)];
    nameLabel.text = @"服务费";
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = FontSize(18);
    [whiteView addSubview:nameLabel];
    
    UIButton *Xbutton = [[UIButton alloc] initWithFrame:AutoFrame(281, 15, 14, 14)];
    [Xbutton setImage:[UIImage imageNamed:@"xButton.png"] forState:UIControlStateNormal];
    [Xbutton addTarget:self action:@selector(XbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:Xbutton];
    
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 77.5, 310, 19)];
    remindLabel.text = [NSString stringWithFormat:@"请缴纳服务费%@元",_netWork_data[@"GrAmount"]];
    remindLabel.textColor = RGBHex(0x333333);
    remindLabel.textAlignment = NSTextAlignmentCenter;
    remindLabel.font = FontSize(19);
    [whiteView addSubview:remindLabel];
    
    UILabel *quastionLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 109.5, 310, 16)];
    quastionLabel.text = @"如有问题请联系客服";
    quastionLabel.textColor = RGBHex(0x666666);
    quastionLabel.textAlignment = NSTextAlignmentCenter;
    quastionLabel.font = FontSize(16);
    [whiteView addSubview:quastionLabel];
    
    UIButton *immediatelyButton = [[UIButton alloc] initWithFrame:AutoFrame(83.5, 177.5, 143.5, 34)];
    immediatelyButton.backgroundColor = RGBHex(0xFFD301);
    immediatelyButton.clipsToBounds = YES;
    immediatelyButton.layer.cornerRadius = 5 *ScalePpth;
    immediatelyButton.layer.masksToBounds = YES;
    immediatelyButton.titleLabel.font = [UIFont boldSystemFontOfSize:16 *ScalePpth];
    [immediatelyButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [immediatelyButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [immediatelyButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:immediatelyButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抢单详情";
    self.view.backgroundColor = RGBHex(0xffffff);
    [self.view addSubview:self.tableView];
    [self netWorking];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/select/workinfo"] params:@{@"id":_listModel.idName NonNull} success:^(id  _Nonnull response) {
        if (response && response[@"data"]) {
            weakSelf.detailModel = [GrabdDetailsModel mj_objectWithKeyValues:response[@"data"]];
            if (weakSelf.detailModel.timeSelect) {
                [weakSelf.detailModel.timeSelect containsString:@"1"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"1" withString:@"周一"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"2"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"2" withString:@"周二"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"3"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"3" withString:@"周三"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"4"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"4" withString:@"周四"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"5"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"5" withString:@"周五"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"6"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"6" withString:@"周六"]:@"";
                [weakSelf.detailModel.timeSelect containsString:@"7"]? weakSelf.detailModel.timeSelect = [weakSelf.detailModel.timeSelect stringByReplacingOccurrencesOfString:@"7" withString:@"日"]:@"";
            }
            [weakSelf reloadData];
            [weakSelf.tableView reloadData];
        } else {
            [WHToast showErrorWithMessage:@"暂无数据"];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}

- (void)XbuttonAction:(UIButton *)button {
    [_grayView removeFromSuperview];
}
- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:AutoFrame(30, 0, 315, 50)];
        _segmentBar.clipsToBounds = YES;
        _segmentBar.delegate = self;
        _segmentBar.items = @[@"工作环境",@"工作要求"];
        _segmentBar.showIndicator = YES;
        _segmentBar.selectIndex = 0;
        _segmentBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 90)];
        _headerView.backgroundColor = UIColor.whiteColor;
        [self addSubViews];
    }
    return _headerView;
}
- (void)reloadData {
    sendLabel.text = NoneNull(_detailModel.workName);
    timeLabel.text = [@"按" stringByAppendingString:NoneNull(_detailModel.salaryDay)];
    dayPriceLabel.text = [NSString stringWithFormat:@"%@/%@",NoneNull(_detailModel.salary),NoneNull(_detailModel.salaryDay)];
    rateLabel.text = [[NSString stringWithFormat:@"好评率：%@",NoneNull(_detailModel.praise)] stringByAppendingString:@"%"];
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
    
    imageButton = [[UIButton alloc] initWithFrame:AutoFrame(310, 5, 45, 45)];
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
        [_tableView registerClass:[GrabdDetailsImagCell class] forCellReuseIdentifier:@"GrabdDetailsImagCell"];
        [_tableView registerClass:[JobRequirementsCell class] forCellReuseIdentifier:@"JobRequirementsCell"];
        [_tableView registerClass:[SendTableCell class] forCellReuseIdentifier:@"SendTableCell2"];
        [_tableView registerClass:[GrabdTableCell class] forCellReuseIdentifier:@"GrabdTableCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xf0f0f0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    _isJobRequirements = toIndex;
    [self.tableView reloadData];
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_isJobRequirements) {
            return UITableViewAutomaticDimension;
        }
        return _cellHeight;
    }
    return 50*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 47*ScalePpth;
    }
    return 55*ScalePpth;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
       return [self addFooterSubView];
    }
    if (!footerView) {
        footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 55)];
        [footerView addSubview:self.segmentBar];
        footerView.backgroundColor = UIColor.whiteColor;
        UIView *grayView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
        grayView.backgroundColor = RGBHex(0xf0f0f0);
        [footerView addSubview:grayView];
    }
    return footerView;
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
    [immediatelyButton setTitle:@"立即抢单" forState:UIControlStateNormal];
    [immediatelyButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [immediatelyButton addTarget:self action:@selector(immediatelyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:immediatelyButton];
    [footerView addSubview:starLabel];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_isJobRequirements) {
            JobRequirementsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobRequirementsCell" forIndexPath:indexPath];
            if (!cell.detailModel) {
                cell.detailModel = _detailModel;
            }
            return cell;
        } else {
            WeakSelf;
            GrabdDetailsImagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GrabdDetailsImagCell" forIndexPath:indexPath];
            !cell.detailModel? (cell.detailModel = self.detailModel):nil;
            cell.imageBlock = ^(CGFloat cellHeight) {
                weakSelf.cellHeight = cellHeight;
                [weakSelf.tableView reloadData];
            };
            return cell;
        }
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        SendTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendTableCell2" forIndexPath:indexPath];
        cell.detailModel = self.detailModel;
        cell.sendLabel.text = @"上班地点";
        cell.rightLabel.text = NoneNull(self.detailModel.workPositino);
        return cell;
    }
    GrabdTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GrabdTableCell" forIndexPath:indexPath];
    cell.detailModel = self.detailModel;
    cell.sendLabel.text = @[@"抢单有效期",@"上班时间",@"上班地点",@"已抢单人数"][indexPath.row];
    cell.rightLabel.text = @[[NSString stringWithFormat:@"%@-%@",NoneNull(_detailModel.orderStartTime),NoneNull(_detailModel.orderEndTime)],
                             [NSString stringWithFormat:@"%@,%@至%@",NoneNull(_detailModel.timeSelect),NoneNull(_detailModel.startTime),NoneNull(_detailModel.endTime)],
                             @"",
                             NoneNull(_detailModel.workPeople)][indexPath.row];
    
    return cell;
}
- (void)homeButtonAction {
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)imageButtonAction:(UIButton *)button {
    EmployerRecordController *ERVC = [EmployerRecordController new];
    ERVC.releaseId = NoneNull(_detailModel.releaseId);
    [self.navigationController pushViewController:ERVC animated:NO];
}
- (void)immediatelyButtonAction {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/selectServiceCost"] params:@{@"id": NoneNull(_detailModel.idName)} success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
            weakSelf.netWork_data = response[@"data"];
            [[GlobalSingleton gS_ShareInstance].systemWindow addSubview:self.grayView];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (void)payButtonAction:(UIButton *)button {
    [_grayView removeFromSuperview];
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/GrabTheOrder"] params:@{
        @"id":_detailModel.idName NonNull,
        @"amount":weakSelf.netWork_data[@"GrAmount"] NonNull,
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
            if (response[@"data"]) {
                if ([response[@"data"][@"payStatus"] intValue] == 0) {
                    SuccessfulGrabSheetController *successfulVc = [[SuccessfulGrabSheetController alloc] init];
                    successfulVc.orderId = response[@"data"][@"orderId"];
                    successfulVc.phone = response[@"data"][@"phone"];
                    [weakSelf.navigationController pushViewController:successfulVc animated:NO];
                } else {
                    [WHToast showErrorWithMessage:@"余额不足"];
                }
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (void)starButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}


@end
