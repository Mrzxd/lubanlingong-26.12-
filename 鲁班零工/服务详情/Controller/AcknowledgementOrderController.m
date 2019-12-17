
//  AcknowledgementOrderController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/28.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "WorkPlaceMapController.h"
#import "EmployerCertificationOneCell.h"
#import "EmployerCertificationTexyfieldCell.h"
#import "AcknowledgementOrderController.h"
#import "RequestSuccessfulController.h"

@interface AcknowledgementOrderController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker *dateView;
@property (strong, nonatomic) UIDatePicker *dateView2;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIView *selectTimeView;
@property (strong, nonatomic) UIView *grayView;
@property (nonatomic, strong) UITextField *textField;
@property (strong, nonatomic) EmployerCertificationOneCell *cell;
@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, strong) NSArray *locationArray;

@property (nonatomic, strong) NSString *selectStart;
@property (nonatomic, strong) NSString *selectEnd;

@end

@implementation AcknowledgementOrderController {
    UILabel *seperateLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self.view addSubview:self.tableView];
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 302*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    submitButton.titleLabel.font = FontSize(17);
    submitButton.backgroundColor = RGBHex(0xFFD301);
    submitButton.layer.cornerRadius = 45.0/2*ScalePpth;
    submitButton.layer.masksToBounds = YES;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [self.view addSubview:self.grayView];;
    self.grayView.hidden = YES;
    _cellArray = [[NSMutableArray alloc] init];
}
- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [_grayView addSubview:self.selectTimeView];
    }
    return _grayView;
}
- (UIDatePicker *)dateView {
    if (!_dateView) {
        _dateView = [ [ UIDatePicker alloc] initWithFrame:AutoFrame(0, 0, 168, 200)];
        _dateView.datePickerMode = UIDatePickerModeDate;
        _dateView.backgroundColor = [UIColor whiteColor];
        _dateView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_dateView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView;
}
- (UIDatePicker *)dateView2 {
    if (!_dateView2) {
        _dateView2 = [ [ UIDatePicker alloc] initWithFrame:AutoFrame(187.5, 0, 168, 200)];
        _dateView2.datePickerMode = UIDatePickerModeDate;
        _dateView2.backgroundColor = [UIColor whiteColor];
        _dateView2.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_dateView2 addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView2;
}
- (UIView *)selectTimeView {
    if (!_selectTimeView) {
        _selectTimeView = [[UIView alloc] initWithFrame:AutoFrame(0, 200, 375, 230)];
        _selectTimeView.backgroundColor = RGBHex(0xf0f0f0);
        [_selectTimeView addSubview:self.dateView];
        [_selectTimeView addSubview:self.dateView2];
        
        seperateLabel  = [[UILabel alloc] initWithFrame:AutoFrame(168, 90, 19.5, 20)];
        seperateLabel.font = FontSize(18);
        seperateLabel.textColor = RGBHex(0x333333);
        seperateLabel.text = @"至";
        seperateLabel.textAlignment = NSTextAlignmentCenter;
        [_selectTimeView addSubview:seperateLabel];
        
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(275.0/2*ScalePpth, 200*ScalePpth, 100*ScalePpth, 30*ScalePpth)];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        sureButton.titleLabel.font = FontSize(17);
        sureButton.backgroundColor = RGBHex(0xFFD301);
        sureButton.layer.cornerRadius = 15*ScalePpth;
        sureButton.layer.masksToBounds = YES;
        sureButton.clipsToBounds = YES;
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectTimeView addSubview:sureButton];
    }
    return _selectTimeView;
}
- (void)sureButtonAction:(UIButton *)button {
    NSDate *theDate = _dateView.date;
    NSDate *theDate2 = _dateView2.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *_selectString;
    if (_cell == _cellArray[2]) {
        dateFormatter.dateFormat = @"HH-mm";
        _dateView.datePickerMode = UIDatePickerModeTime;
        _dateView2.datePickerMode = UIDatePickerModeTime;
        _selectString = [dateFormatter stringFromDate:theDate];
        _selectStart = _selectString;
        _selectEnd = [dateFormatter stringFromDate:theDate2];
    } else {
        dateFormatter.dateFormat = @"YYYY-MM-dd";
        _dateView.datePickerMode = UIDatePickerModeDate;
        _selectString = [dateFormatter stringFromDate:theDate];
    }
    _cell.rightLabel.text = [NSString stringWithFormat:@"%@至%@",_selectStart,_selectEnd];
    if (_dateView2.isHidden) {
        _cell.rightLabel.text = _selectString;
    }
    _cell.rightLabel.textColor = RGBHex(0x333333);
    self.grayView.hidden = YES;
}
- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDate *theDate = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_cell == _cellArray[2]) {
        dateFormatter.dateFormat = @"HH-mm";
       
        _dateView.datePickerMode = UIDatePickerModeTime;
    } else {
        dateFormatter.dateFormat = @"YYYY-MM-dd";
        _dateView.frame = AutoFrame(0, 0, 375, 200);
        _dateView.datePickerMode = UIDatePickerModeDate;
    }
     NSString *_selectString = [dateFormatter stringFromDate:theDate];
    if (datePicker == _dateView) {
        _selectStart = _selectString;
    } else {
        _selectEnd = _selectString;
    }
}
- (void)submitAction:(UIButton *)button {
   
    if ([[_cellArray[0] rightLabel].text containsString:@"请"]) {
             [WHToast showErrorWithMessage:@"请选择开始日期"];
        return;
    }
    if ([[_cellArray[1] rightLabel].text containsString:@"请"]) {
             [WHToast showErrorWithMessage:@"请选择结束日期"];
           return;
    }
    if (!_selectStart) {
             [WHToast showErrorWithMessage:@"请选择服务时间"];
             return;
      }
    if (!_locationArray) {
            [WHToast showErrorWithMessage:@"请选择服务地点"];
           return;
       }
    if (!_textField.text || _textField.text.length == 0) {
            [WHToast showErrorWithMessage:@"请输入详情地址"];
                  return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseSkill/GrabTheOrder"] params:@{
        @"id":_idName NonNull,
        @"location":_locationArray[0],
        @"locationx":_locationArray[1],
        @"locationy":_locationArray[2],
        @"Filed3":[_cellArray[0] rightLabel].text,
        @"Filed4":[_cellArray[1] rightLabel].text,
        @"Filed5":NoneNull(_selectStart),
        @"Filed2":NoneNull(_selectEnd),
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
           RequestSuccessfulController *rsc = [RequestSuccessfulController new];
            rsc.idName = response[@"data"][@"id"];
            rsc.phone = response[@"data"][@"phone"];
            [weakSelf.navigationController pushViewController:rsc animated:YES];
        } else if (response && [response[@"code"] intValue] == 1) {
            [WHToast showErrorWithMessage:@"尚未进行雇主实名认证，请去实名认证!"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
    
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        [_tableView registerClass:[EmployerCertificationTexyfieldCell class] forCellReuseIdentifier:@"EmployerCertificationTexyfieldCell"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell"];
        _tableView.tableHeaderView =  [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationTexyfieldCell" forIndexPath:indexPath];
        cell.nameLabel.text = @"详细地址";
        cell.textField.delegate = self;
        _textField = cell.textField;
        cell.textField.placeholder = @"请输入详情地址";
        return cell;
    }
    EmployerCertificationOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell" forIndexPath:indexPath];
    cell.nameLabel.text = @[@"开始日期",@"结束日期",@"服务时间",@"服务地点",@"详细地址"][indexPath.row];
    cell.rightLabel.text = @[@"请选择开始日期",@"请选择结束日期",@"请选择服务时间",@"请选择服务地点",@"请输入详情地址"][indexPath.row];
    if (_cellArray.count < 3) {
        [_cellArray addObject:cell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 3) {
        _cell = _cellArray[indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (indexPath.row == 2) {
            dateFormatter.dateFormat = @"HH-mm";
            _dateView2.datePickerMode = UIDatePickerModeTime;
            _dateView.datePickerMode = UIDatePickerModeTime;
            _dateView.frame = AutoFrame(0, 0, 168, 200);
            seperateLabel.hidden = NO;
            _dateView2.hidden = NO;
        } else {
            dateFormatter.dateFormat = @"YYYY-MM-dd";
            seperateLabel.hidden = YES;
            _dateView.datePickerMode = UIDatePickerModeDate;
            _dateView.frame = AutoFrame(0, 0, 375, 200);
            _dateView2.hidden = YES;
        }
        self.grayView.hidden = NO;
    } else if (indexPath.row == 3) {
        EmployerCertificationOneCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       __weak typeof(cell) weakCell = cell;
        WeakSelf;
        WorkPlaceMapController *wpmc = [WorkPlaceMapController new];
        wpmc.adressBlock = ^(NSString * _Nonnull address, NSString * _Nonnull longitude, NSString * _Nonnull latitude) {
            weakSelf.locationArray = @[address,longitude,latitude];
            weakCell.rightLabel.text = address;
            weakCell.rightLabel.textColor = RGBHex(0x333333);
        };
        [self.navigationController pushViewController:wpmc animated:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
