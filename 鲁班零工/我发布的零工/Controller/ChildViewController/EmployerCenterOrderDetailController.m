//
//  EmployerCenterOrderDetailController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.

#import "GrabdDetailsModel.h"
#import "EmployerCenterOrderDetailCell.h"
#import "EmployerCenterOrderDetailCell2.h"
#import "EmployerCenterOrderDetailCell3.h"
#import "EmployerCenterOrderDetailController.h"

@interface EmployerCenterOrderDetailController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *waitLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GrabdDetailsModel *detailModel;

@end

@implementation EmployerCenterOrderDetailController {
    UIButton *_stateButton;
    UIView *topCoverView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/ReleaseWork/select/workinfo"] params:@{@"id":_idName} success:^(id  _Nonnull response) {
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
- (void)reloadData {
    if (_detailModel.workStatus.intValue == 0) {
        _waitLabel.text =  @"待审核";
        _leftButton.hidden = YES;
        _middleButton.hidden = NO;
        _stateButton.hidden = NO;
        [_middleButton setTitle:@"取消发布" forState:UIControlStateNormal];
        [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    } else if (_detailModel.workStatus.intValue == 1) {
        _waitLabel.text =  @"已上架";
        _leftButton.hidden = YES;
        _middleButton.hidden = YES;
        _stateButton.hidden = NO;
        [_middleButton setTitle:@"下架" forState:UIControlStateNormal];
        [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    } else if (_detailModel.workStatus.intValue == 2) {
           _waitLabel.text =  @"已下架";
           _leftButton.hidden = YES;
           _middleButton.hidden = YES;
         [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    } else if (_detailModel.workStatus.intValue == 3) {
        _waitLabel.text =  @"已驳回";
        _leftButton.hidden = YES;
        _middleButton.hidden = NO;
        _stateButton.hidden = NO;
        [_middleButton setTitle:@"删除" forState:UIControlStateNormal];
        [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    [topCoverView addSubview:[self typeLabel:@"名称" :43]];
    [topCoverView addSubview:[self typeLabel:@"类型" :83]];
    [topCoverView addSubview:[self typeLabel:@"人数" :123.5]];
    [topCoverView addSubview:[self typeLabel:@"性别" :164]];
    
    [topCoverView addSubview:[self rightLabel:NoneNull(_detailModel.workName) :43]];
    [topCoverView addSubview:[self rightLabel:NoneNull(_detailModel.workType) :83]];
    [topCoverView addSubview:[self rightLabel:NoneNull(_detailModel.workNumber) :123.5]];
    [topCoverView addSubview:[self rightLabel:NoneNull(_detailModel.sex) :164]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self addFooterView];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 250)];
        _headerView.backgroundColor = RGBHex(0xF7F7F7);
        [self addSubViews];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, ScreenHeight - KNavigationHeight - 47*ScalePpth) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[EmployerCenterOrderDetailCell class] forCellReuseIdentifier:@"EmployerCenterOrderDetailCell"];
        [_tableView registerClass:[EmployerCenterOrderDetailCell2 class] forCellReuseIdentifier:@"EmployerCenterOrderDetailCell2"];
        [_tableView registerClass:[EmployerCenterOrderDetailCell3 class] forCellReuseIdentifier:@"EmployerCenterOrderDetailCell3"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xF7F7F7);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)addSubViews {
    UIView *orangeView = [[UIView alloc] initWithFrame:AutoFrame(0, 0,375, 80)];
    orangeView.backgroundColor = RGBHex(0xFFAA1A);
    [_headerView addSubview:orangeView];
    UIImageView *dateImageView = [[UIImageView alloc] initWithFrame:AutoFrame(43, 20, 19, 20)];
    dateImageView.image = [UIImage imageNamed:@"icon"];
    [orangeView addSubview:dateImageView];
    
    _waitLabel = [[UILabel alloc] initWithFrame:AutoFrame(68, 23, 100, 15)];
    _waitLabel.textAlignment = NSTextAlignmentRight;
    _waitLabel.font = [UIFont systemFontOfSize:15*ScalePpth];
    _waitLabel.textColor = RGBHex(0xFFffff);
    [orangeView addSubview:_waitLabel];
    
    topCoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 60, 360, 190)];
    topCoverView.backgroundColor = RGBHex(0xFfffff);
    topCoverView.layer.cornerRadius = 5;
    [_headerView addSubview:topCoverView];
    
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, (68.5+ i*40.5), 360, 0.5)];
        lineView3.backgroundColor = RGBHex(0xEEEEEE);
        [topCoverView addSubview:lineView3];
    }
    
    UILabel *_typelabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 100, 14)];
    _typelabel.font = [UIFont boldSystemFontOfSize:14 *ScalePpth];
    _typelabel.textColor = RGBHex(0x333333);
    _typelabel.text = @"基本信息";
    [topCoverView addSubview:_typelabel];
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
- (void)addFooterView {
    
    _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, (self.view.bounds.size.height - 47*ScalePpth - KNavigationHeight)/ScalePpth, 375, 47)];
    _footerView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_footerView];
    
    _leftButton = [[UIButton alloc] initWithFrame:AutoFrame(121, 10.5, 72, 26)];
    _leftButton.backgroundColor = RGBHex(0xffffff);
    _leftButton.clipsToBounds = YES;
    _leftButton.hidden = YES;
    _leftButton.layer.cornerRadius = 13 *ScalePpth;
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.borderWidth = 0.5;
    _leftButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_leftButton setTitle:@"删除" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
//    [_leftButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_leftButton];
    
    _middleButton = [[UIButton alloc] initWithFrame:AutoFrame(204, 10.5, 72, 26)];
    _middleButton.backgroundColor = RGBHex(0xffffff);
    _middleButton.clipsToBounds = YES;
    _middleButton.hidden = NO;
    _middleButton.layer.cornerRadius = 13 *ScalePpth;
    _middleButton.layer.masksToBounds = YES;
    _middleButton.layer.borderWidth = 0.5;
    _middleButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _middleButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_middleButton setTitle:@"取消发布" forState:UIControlStateNormal];
    [_middleButton addTarget:self action:@selector(middleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_middleButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
//    [_middleButton addTarget:self action:@selector(sureFanishedAction:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_middleButton];
    [self addStateButton:_footerView];
}
- (void)leftButtonAction:(UIButton *)button {
    
}
- (void)middleButtonAction:(UIButton *)button {
         WeakSelf;
    if ([button.currentTitle isEqual:@"取消发布"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/CancelReleaseSkill":@"/CoreInfo/CancelReleaseWork"] params:@{@"id":NoneNull(_detailModel.idName)} success:^(id  _Nonnull response){
            if (response && [response[@"code"] intValue] == 0) {
                  [weakSelf.navigationController popViewControllerAnimated:YES];
              } else {
                  if (response[@"msg"]) {
                      [WHToast showErrorWithMessage:response[@"msg"]];
                  } else {
                      [WHToast showErrorWithMessage:@"取消发布失败"];
                  }
              }
        } fail:^(NSError * _Nonnull error) {
            
        } showHUD:YES];
    } else if ([button.currentTitle isEqual:@"删除"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/DeleteSkill":@"/CoreInfo/DeleteWork"] params:@{@"id":NoneNull(_detailModel.idName)} success:^(id  _Nonnull response) {
            if (response && [response[@"code"] intValue] == 0) {
                 [weakSelf.navigationController popViewControllerAnimated:YES];
            } else {
                if (response[@"msg"]) {
                    [WHToast showErrorWithMessage:response[@"msg"]];
                } else {
                    [WHToast showErrorWithMessage:@"删除失败"];
                }
            }
        } fail:^(NSError * _Nonnull error) {
            
        } showHUD:YES];
    }  else if ([button.currentTitle isEqual:@"下架"]) {
           [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/takeOf":@"/CoreInfo/takeOffWork"] params:@{@"id":NoneNull(_detailModel.idName)} success:^(id  _Nonnull response){
               if (response && [response[@"code"] intValue] == 0) {
                   [weakSelf.navigationController popViewControllerAnimated:YES];
                 } else {
                     if (response[@"msg"]) {
                         [WHToast showErrorWithMessage:response[@"msg"]];
                     } else {
                         [WHToast showErrorWithMessage:@"取消发布失败"];
                     }
                 }
           } fail:^(NSError * _Nonnull error) {
           } showHUD:YES];
       }
}
- (void)stateButtonAction:(UIButton *)button {
    WeakSelf;
    if ([button.currentTitle isEqual:@"联系客服"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/contPhone"] params:@{@"id":NoneNull(_detailModel.idName)} success:^(id  _Nonnull response) {
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
    } else if ([button.currentTitle isEqual:@"修改"]) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:weakSelf.isService?@"/CoreInfo/UpdataSkill":@"/CoreInfo/UpdataWork"] params:@{@"id":NoneNull(_detailModel.idName)} success:^(id  _Nonnull response){
            if (response && [response[@"code"] intValue] == 0) {
                  [weakSelf.navigationController popViewControllerAnimated:YES];
              } else {
                  if (response[@"msg"]) {
                      [WHToast showErrorWithMessage:response[@"msg"]];
                  } else {
                      [WHToast showErrorWithMessage:@"修改失败"];
                  }
              }
        } fail:^(NSError * _Nonnull error) {
            
        } showHUD:YES];
    }
}
- (void)addStateButton:(UIView *)footerView {
    _stateButton = [[UIButton alloc] initWithFrame:AutoFrame(287, 10.5, 72, 26)];
    _stateButton.backgroundColor = RGBHex(0xFED452);
    _stateButton.clipsToBounds = NO;
    _stateButton.layer.cornerRadius = 13 *ScalePpth;
    _stateButton.layer.masksToBounds = YES;
    _stateButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(stateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_stateButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
//    [_stateButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_stateButton];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        return 160 *ScalePpth;
    }
    if (indexPath.section == 2 || indexPath.section == 3) {
        return 120*ScalePpth;
    }
    return 109*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5*ScalePpth;
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
    if (indexPath.section == 5) {
        EmployerCenterOrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCenterOrderDetailCell3" forIndexPath:indexPath];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:NoneNull(_detailModel.imgLink)]]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:NoneNull(_detailModel.imgLink2)]]];
        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:NoneNull(_detailModel.imgLink3)]]];
        return cell;
    }
    if (indexPath.section == 2 || indexPath.section == 3) {
        EmployerCenterOrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCenterOrderDetailCell2" forIndexPath:indexPath];
        if (indexPath.section == 2) {
            cell.typelabel.text = @"工作要求";
            cell.contentLabel.text = NoneNull(_detailModel.workContent);
        } else {
            cell.typelabel.text = @"员工要求";
            cell.contentLabel.text = NoneNull(_detailModel.personnelClaim);
        }
        return cell;
    }
  
      EmployerCenterOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCenterOrderDetailCell" forIndexPath:indexPath];
            NSArray *typeArray = @[@[@"报酬",@"计算方式",[NSString stringWithFormat:@"按%@",NoneNull(_detailModel.salaryDay)],@"报酬",[NSString stringWithFormat:@"%@/%@",NoneNull(_detailModel.salary),NoneNull(_detailModel.salaryDay)]],
                                   @[@"上班时间",@"上班起止时间",[NSString stringWithFormat:@"%@至%@",NoneNull(_detailModel.startTime),NoneNull(_detailModel.endTime)],@"上班地点",NoneNull(_detailModel.workPositino)],
                                   @[],
                                   @[],
                                   @[@"联系方式",@"联系人",NoneNull(_detailModel.contactPeople),@"联系电话",NoneNull(_detailModel.contactPhone)]];
            cell.typelabel.text =  typeArray[indexPath.section][0];
            cell.leftLabel.text =  typeArray[indexPath.section][1];
            cell.rightLabel.text = typeArray[indexPath.section][2];
            cell.leftLabel2.text = typeArray[indexPath.section][3];
            cell.rightLabel2.text =typeArray[indexPath.section][4];

    return cell;
}

@end
