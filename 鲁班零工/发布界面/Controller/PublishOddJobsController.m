
//
//  ReleaseOddJobsontroller.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "UIViewController+ImagePicker.h"
#import "PublishImageTableCell.h"
#import "ServiceTimeCell.h"
#import "PublishTextViewTableCell.h"
#import "EmployerCertificationOneCell.h"
#import "EmployerCertificationTexyfieldCell.h"
#import "PublishOddJobsController.h"
#import "WorkPlaceMapController.h"


@interface PublishOddJobsController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *footerView;

@property (strong, nonatomic) UIView *pickerSuperView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIView *selectTimeView;
@property (strong, nonatomic) UIView *selectDateView;
@property (strong, nonatomic) UIDatePicker *dateView;
@property (strong, nonatomic) UIDatePicker *dateView2;
@property (strong, nonatomic) UIDatePicker *dateView3;
@property (nonatomic, strong) NSArray *JobArray;
@property (nonatomic, strong) NSMutableArray *selectTimeArray;

@property (nonatomic, strong) ServiceTimeCell *timeCell;
@property (nonatomic, strong) EmployerCertificationOneCell * cell;
@property (nonatomic, strong) EmployerCertificationTexyfieldCell *texyfieldCell;

@property (nonatomic, strong) NSMutableArray *selectCellArray;
@property (nonatomic, strong) NSIndexPath *indexpath;
@property (nonatomic, strong) NSMutableArray *textViewCellArray;
@property (nonatomic, strong) NSArray <HomeListModel *>*homeListModelArray;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSMutableArray *mutableIDArray;
@property (nonatomic, strong) NSString *selectID;
@property (nonatomic, strong) NSMutableArray *textFieldCellArray;
@property (nonatomic, strong) NSString *workPlace;//上班地点
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSMutableArray *encodedBase64ImageArray;

@end
@implementation PublishOddJobsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布零工";
    [self setAllDatas];
    [self.view addSubview:self.tableView];
    self.pickerView.hidden = NO;
    [self.view addSubview:self.pickerSuperView];
    [self.view addSubview:self.selectTimeView];
    [self.view addSubview:self.selectDateView];
    self.pickerSuperView.hidden = YES;
    self.selectTimeView.hidden = YES;
    self.selectDateView.hidden = YES;
}

- (void)setAllDatas {
    _JobArray = @[@"零工1",@"零工2",@"零工3"];
    _selectCellArray = [[NSMutableArray alloc] init];
    _selectTimeArray = [[NSMutableArray alloc] init];
    _textViewCellArray = [[NSMutableArray alloc] init];
    _textFieldCellArray = [[NSMutableArray alloc] init];
    [_selectTimeArray addObject:@""];
    [_selectTimeArray addObject:@""];
    _encodedBase64ImageArray = @[@"",@"",@""].mutableCopy;
    NSMutableDictionary *mutdic1 = [[NSMutableDictionary alloc] init];
    mutdic1[@"section_0_row_2"] = nil;
    [_selectCellArray addObject:mutdic1];
    NSMutableDictionary *mutdic2 = [[NSMutableDictionary alloc] init];
    mutdic2[@"section_0_row_4"] = nil;
    [_selectCellArray addObject:mutdic2];
    NSMutableDictionary *mutdic_5 = [[NSMutableDictionary alloc] init];
    mutdic2[@"section_0_row_5"] = nil;
    [_selectCellArray addObject:mutdic_5];
    NSMutableDictionary *mutdic3 = [[NSMutableDictionary alloc] init];
    mutdic3[@"section_1_row_1"] = nil;
    [_selectCellArray addObject:mutdic3];
    NSMutableDictionary *mutdic4 = [[NSMutableDictionary alloc] init];
    mutdic4[@"section_2_row_2"] = nil;
    [_selectCellArray addObject:mutdic4];
    NSMutableDictionary *mutdic5 = [[NSMutableDictionary alloc] init];
    mutdic5[@"section_2_row_3"] = nil;
    [_selectCellArray addObject:mutdic5];
    NSMutableDictionary *mutdic6 = [[NSMutableDictionary alloc] init];
    mutdic6[@"section_7_row_0"] = nil;
    [_selectCellArray addObject:mutdic6];
    NSMutableDictionary *mutdic7 = [[NSMutableDictionary alloc] init];
    mutdic7[@"section_0_row_6"] = nil;
    [_selectCellArray addObject:mutdic7];
    NSMutableDictionary *mutdic8 = [[NSMutableDictionary alloc] init];
    mutdic8[@"section_0_row_7"] = nil;
    [_selectCellArray addObject:mutdic8];
    _homeListModelArray = [HomeListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeListModelArray"]];
    _mutableArray = [[NSMutableArray alloc] init];
    _mutableIDArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _homeListModelArray.count; i ++) {
        for (NSInteger j = 0; j < [_homeListModelArray[i] list].count; j ++) {
            [_mutableArray addObject:[[_homeListModelArray[i] list][j] typeWork]];
            [_mutableIDArray addObject:[[_homeListModelArray[i] list][j] idName]];
        }
    }
}

- (UIView *)selectDateView {
    if (!_selectDateView) {
        _selectDateView = [[UIView alloc] initWithFrame:self.view.bounds];
        _selectDateView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
         [_selectDateView addSubview:self.dateView3];
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(275.0/2*ScalePpth, 450*ScalePpth, 100*ScalePpth, 30*ScalePpth)];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        sureButton.titleLabel.font = FontSize(17);
        sureButton.backgroundColor = RGBHex(0xFFD301);
        sureButton.layer.cornerRadius = 15*ScalePpth;
        sureButton.layer.masksToBounds = YES;
        sureButton.clipsToBounds = YES;
        [sureButton addTarget:self action:@selector(selectDateViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectDateView addSubview:sureButton];
    }
    return _selectDateView;
}
- (UIView *)selectTimeView {
    if (!_selectTimeView) {
        _selectTimeView = [[UIView alloc] initWithFrame:self.view.bounds];
        _selectTimeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [_selectTimeView addSubview:self.dateView];
        [_selectTimeView addSubview:self.dateView2];
        
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(175, 285, 25, 30)];
        label.text = @"至";
        label.font  =FontSize(24);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGBHex(0x333333);
        [_selectTimeView addSubview:label];
        
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(275.0/2*ScalePpth, 410*ScalePpth, 100*ScalePpth, 30*ScalePpth)];
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
- (void)selectDateViewButtonAction:(UIButton *)button {
    NSDate *theDate = _dateView3.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    _cell.rightLabel.text = [dateFormatter stringFromDate:theDate] NonNull;
    _cell.rightLabel.textColor = RGBHex(0x333333);
    self.selectDateView.hidden = YES;
}
- (void)sureButtonAction:(UIButton *)button {
    NSDate *theDate = _dateView.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH-mm";
//    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    _selectTimeArray[0] = [dateFormatter stringFromDate:theDate];
    NSDate *theDate2 = _dateView2.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    dateFormatter2.dateFormat = @"HH-mm";
//    NSLog(@"%@",[dateFormatter2 stringFromDate:theDate]);
    _selectTimeArray[1] = [dateFormatter2 stringFromDate:theDate2];
    [_selectTimeView setHidden:YES];
    _cell.rightLabel.text = [NSString stringWithFormat:@"%@至%@",_selectTimeArray[0],_selectTimeArray[1]];
    _cell.rightLabel.textColor = RGBHex(0x333333);
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerSuperView =  [[UIView alloc] initWithFrame:self.view.bounds];
        _pickerView = [[UIPickerView alloc] initWithFrame:AutoFrame(0, 200, 375, 200)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerSuperView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [_pickerSuperView addSubview:_pickerView];
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(275.0/2*ScalePpth, 410*ScalePpth, 100*ScalePpth, 30*ScalePpth)];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        sureButton.titleLabel.font = FontSize(17);
        sureButton.backgroundColor = RGBHex(0xFFD301);
        sureButton.layer.cornerRadius = 15*ScalePpth;
        sureButton.layer.masksToBounds = YES;
        sureButton.clipsToBounds = YES;
        [sureButton addTarget:self action:@selector(surePickerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerSuperView addSubview:sureButton];
    }
    return _pickerView;
}
- (UIDatePicker *)dateView {
    if (!_dateView) {
        _dateView = [ [ UIDatePicker alloc] initWithFrame:AutoFrame(0, 200, 175, 200)];
        _dateView.datePickerMode = UIDatePickerModeTime;
        _dateView.backgroundColor = [UIColor whiteColor];
        _dateView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_dateView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView;
}
- (UIDatePicker *)dateView2 {
    if (!_dateView2) {
        _dateView2 = [ [ UIDatePicker alloc] initWithFrame:AutoFrame(200, 200, 175, 200)];
        _dateView2.datePickerMode = UIDatePickerModeTime;
        _dateView2.backgroundColor = [UIColor whiteColor];
        _dateView2.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_dateView2 addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView2;
}
- (UIDatePicker *)dateView3 {
    if (!_dateView3) {
        _dateView3 = [ [ UIDatePicker alloc] initWithFrame:AutoFrame(0, 150, 375, 300)];
        _dateView3.datePickerMode = UIDatePickerModeDate;
        _dateView3.backgroundColor = [UIColor whiteColor];
        _dateView3.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_dateView3 addTarget:self action:@selector(dateViewChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView3;
}
- (void)dateViewChange:(UIDatePicker *)datePicker {
    NSDate *theDate = datePicker.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    _cell.rightLabel.textColor = RGBHex(0x333333);
    _cell.rightLabel.text = [dateFormatter stringFromDate:theDate] NonNull;
}
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 95)];
        UIButton *publishButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, 20*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [publishButton setTitle:@"马上发布" forState:UIControlStateNormal];
        [publishButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        publishButton.titleLabel.font = FontSize(17);
        publishButton.backgroundColor = RGBHex(0xFFD301);
        publishButton.layer.cornerRadius = 45.0/2*ScalePpth;
        publishButton.layer.masksToBounds = YES;
        publishButton.clipsToBounds = YES;
        [publishButton addTarget:self action:@selector(publishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:publishButton];
    }
    return _footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStyleGrouped];
        [_tableView registerClass:[PublishImageTableCell class] forCellReuseIdentifier:@"PublishImageTableCell"];
        [_tableView registerClass:[ServiceTimeCell class] forCellReuseIdentifier:@"ServiceTimeCell"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell1"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell2"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell3"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell33"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell4"];
        [_tableView registerClass:[PublishTextViewTableCell class] forCellReuseIdentifier:@"PublishTextViewTableCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView =[[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.backgroundColor = RGBHex(0xf0f0f0);
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDate *theDate = datePicker.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH-mm";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
  
    NSString *selectString = [dateFormatter stringFromDate:theDate];
    if ([datePicker isEqual:_dateView]) {
        _selectTimeArray[0] = selectString;
    } else {
        _selectTimeArray[1] = selectString;
    }
}
- (void)surePickerButtonAction:(UIButton *)button {
    [_pickerSuperView setHidden:YES];
}

#pragma mark ------------- 马上发布(零工发布)

- (void)publishButtonAction:(UIButton *)button {
    WeakSelf;
    if ([self detectLoginStatusIsNoLogined]) {
          [self toLoginWithInfo:@"因为涉及到您的核心用户信息，您需要登录才能发布零工或发布服务"];
          return;
      }
    if ([[_textFieldCellArray[0] textField].text NonNull length] == 0) {
        [WHToast showErrorWithMessage:@"请输入需求名称"];
        return;
    }
    if ([[[_selectCellArray[0][@"section_0_row_2"] rightLabel] text] containsString:@"请"]) {
         [WHToast showErrorWithMessage:@"请选择零工类型"];
        return;
    }
    if ([[_textFieldCellArray[1] textField].text NonNull length] == 0) {
        [WHToast showErrorWithMessage:@"请输入需求人数"];
        return;
    }
    if ([[[ _selectCellArray[1][@"section_0_row_4"] rightLabel] text] containsString:@"请"]) {
         [WHToast showErrorWithMessage:@"请选择性别"];
        return;
    }
    if ([[[_selectCellArray[7][@"section_0_row_6"] rightLabel] text] containsString:@"请"]) {
            [WHToast showErrorWithMessage:@"请选择抢单开始时间"];
           return;
       }
    if ([[[_selectCellArray[8][@"section_0_row_7"] rightLabel] text] containsString:@"请"]) {
               [WHToast showErrorWithMessage:@"请选择抢单结束时间"];
              return;
          }
   if ([[_textFieldCellArray[2] textField].text NonNull length] == 0) {
          [WHToast showErrorWithMessage:@"请输入报酬金额"];
          return;
      }
    __block NSString *weekTime;
    [_timeCell.weekButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull timeButton, NSUInteger idx, BOOL * _Nonnull stop) {
        if (timeButton.isSelected) {
            if (!weekTime) {
                weekTime = [NSString stringWithFormat:@"%u",idx+1];
            } else {
                weekTime = [weekTime stringByAppendingString:[NSString stringWithFormat:@",%u",idx+1]];
            }
        }
    }];
    if (!weekTime) {
        [WHToast showErrorWithMessage:@"请选择周一至周日的服务时间段"];
        return;
    }
    if ([_selectTimeArray[0] length] == 0) {
        [WHToast showErrorWithMessage:@"请选择上班起止时间"];
        return;
    }
    if ([[_textViewCellArray[0] textView].text containsString:@"用明确"]) {
        [WHToast showErrorWithMessage:@"请输入工作内容"];
        return;
    }
    if ([[_textViewCellArray[1] textView].text containsString:@"请输入"]) {
        [WHToast showErrorWithMessage:@"请输入员工要求"];
        return;
    }
    if ([[_textFieldCellArray[3] textField].text NonNull length] == 0) {
           [WHToast showErrorWithMessage:@"请输入联系人姓名"];
           return;
    }
    if (![self isMobileNumberOnly:[_textFieldCellArray[4] textField].text NonNull]) {
           [WHToast showErrorWithMessage:@"请输入正确的联系人电话"];
           return;
    }
    if ([[_textFieldCellArray[5] textField].text NonNull length] == 0) {
           [WHToast showErrorWithMessage:@"请输入工资金额"];
           return;
    }
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/add/work"] params:@{
              @"workName":[_textFieldCellArray[0] textField].text NonNull,
              @"workType":[[_selectCellArray[0][@"section_0_row_2"] rightLabel] text],
              @"workTypeId":NoneNull(_selectID),
              @"workNumber":[_textFieldCellArray[1] textField].text NonNull,
              @"sex":[[ _selectCellArray[1][@"section_0_row_4"] rightLabel] text],
              @"gradOrder":[[[ _selectCellArray[2][@"section_0_row_5"] rightLabel] text] containsString:@"否"]?@"0":@"1",
              @"orderEndTime":[[_selectCellArray[8][@"section_0_row_7"] rightLabel] text],
              @"orderStartTime":[[_selectCellArray[7][@"section_0_row_6"] rightLabel] text],
              @"salaryDay":[[_selectCellArray[3][@"section_1_row_1"] rightLabel] text],
              @"salary":[_textFieldCellArray[2] textField].text,
              @"timeSelect":weekTime,
              @"endTime":_selectTimeArray[1],
              @"startTime":_selectTimeArray[0],
              @"workPositino":NoneNull(_workPlace),
              @"workPositinox":NoneNull(_longitude),
              @"workPositinoy":NoneNull(_latitude),
              @"workContent":[_textViewCellArray[0] textView].text,
              @"personnelClaim":[_textViewCellArray[1] textView].text,
              @"contactPeople":[_textFieldCellArray[3] textField].text,
              @"contactPhone":[_textFieldCellArray[4] textField].text,
              @"imgLink":_encodedBase64ImageArray[0],
              @"imgLink2":_encodedBase64ImageArray[1],
              @"imgLink3":_encodedBase64ImageArray[2],
              @"imgLinkBase64":@"data:image/png;base64,",
              @"imgLink2Base64":@"data:image/png;base64,",
              @"imgLink3Base64":@"data:image/png;base64,",
              
              @"insteadSalary":[_selectCellArray[6][@"section_7_row_0"] rightLabel].text,
              @"salaryAmount":[_textFieldCellArray[5] textField].text,
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
            [WHToast showSuccessWithMessage:@"发布成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
        }
    } fail:^(NSError * _Nonnull error) {
    } showHUD:YES];
}
#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _textView = textView;
    if ([textView.text isEqualToString:@"用明确清晰的语言描述你的需求"] || [textView.text isEqualToString:@"请输入对员工的要求"]) {
        textView.text = @"";
        textView.textColor = RGBHex(0x333333);
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"用明确清晰的语言描述你的需求"] || [textView.text isEqualToString:@"请输入对员工的要求"]) {
         textView.textColor = RGBHex(0xcccccc);
    }
    if (textView.text.length == 0 ||([textView.text containsString:@"请输入"])) {
        if (textView.tag == 1003) {
            textView.text = @"用明确清晰的语言描述你的需求";
        } else {
            textView.text = @"请输入对员工的要求";
        }
        textView.textColor = RGBHex(0xcccccc);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    return YES;
}

#pragma mark -------- UIPickerViewDelegate

//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _JobArray.count;
}
//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f *ScalePpth;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   return _JobArray[row];
}

//被选择的行

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_cell) {
        [_cell rightLabel].text = _JobArray[row];
        _selectID = _mutableIDArray[row];
        _cell.rightLabel.textColor = RGBHex(0x333333);
        if (_indexpath.section == 1 && _indexpath.row == 1) {
            _texyfieldCell.textField.placeholder = [NSString stringWithFormat:@"请输入报酬金额（元）| %@",_JobArray[row]];
        }
    }
    [pickerView reloadAllComponents];
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    } else  if (section == 1) {
        return 3;
    } else  if (section == 2) {
        return 4;
    } else  if (section == 3) {
        return 2;
    } else  if (section == 4) {
        return 2;
    } else  if (section == 5) {
        return 3;
    } else  if (section == 6) {
        return 2;
    } else  if (section == 7) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 || (indexPath.section == 4)) {
        if (indexPath.row == 0) {
            return 50*ScalePpth;
        }
            return 157*ScalePpth;
    } else if (indexPath.section == 6 && indexPath.row == 1) {
            return 130 *ScalePpth;
    } else if (indexPath.section == 2 && indexPath.row ==1) {
            return 122 *ScalePpth;
    }
            return 50*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5 *ScalePpth;
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
    
    if (indexPath.row > 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 1 || indexPath.row == 3) {
                EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                if (!cell) {
                    cell = [[EmployerCertificationTexyfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                }
                cell.nameLabel.text = @[@"",@"名称",@"",@"人数"][indexPath.row ];
                cell.textField.placeholder =  @[@"",@"请输入需求名称",@"",@"请输入零工需求数量"][indexPath.row ];
                cell.textField.delegate = self;
                if (indexPath.row == 3) {
                    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                if (_textFieldCellArray.count < 2 && ![_textFieldCellArray containsObject:cell]) {
                    [_textFieldCellArray addObject:cell];
                }
                return cell;
            } else {
                EmployerCertificationOneCell *cell;
                if (indexPath.row == 2 &&_selectCellArray[0][@"section_0_row_2"]) {
                    cell = _selectCellArray[0][@"section_0_row_2"];
                    return cell;
                }
                if (indexPath.row == 4 && _selectCellArray[1][@"section_0_row_4"]) {
                    cell = _selectCellArray[1][@"section_0_row_4"];
                    return cell;
                }
                if (indexPath.row == 5 && _selectCellArray[2][@"section_0_row_5"]) {
                    cell = _selectCellArray[2][@"section_0_row_5"];
                    return cell;
                }
                if (indexPath.row == 6 && _selectCellArray[7][@"section_0_row_6"]) {
                    cell = _selectCellArray[7][@"section_0_row_6"];
                    return cell;
                }
                if (indexPath.row == 7 && _selectCellArray[8][@"section_0_row_7"]) {
                    cell = _selectCellArray[8][@"section_0_row_7"];
                    return cell;
                }
                cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell1" forIndexPath:indexPath];
                cell.nameLabel.text = @"类型";
                cell.rightLabel.text = @"请选择零工类型";
                if (indexPath.row == 2) {
                    if (!_selectCellArray[0][@"section_0_row_2"]) {
                         [_selectCellArray[0] setValue:cell forKey:@"section_0_row_2"];
                    }
                }
                if (indexPath.row == 4) {
                    cell.nameLabel.text = @"性别";
                    cell.rightLabel.text = @"请选择";
                    if (!_selectCellArray[1][@"section_0_row_4"]) {
                        [_selectCellArray[1] setValue:cell forKey:@"section_0_row_4"];
                    }
                } else if (indexPath.row == 5) {
                    cell.nameLabel.text = @"是否抢单";
                    cell.rightLabel.textColor = RGBHex(0x333333);
                    cell.rightLabel.text = @"否";
                    if (!_selectCellArray[2][@"section_0_row_5"]) {
                        [_selectCellArray[2] setValue:cell forKey:@"section_0_row_5"];
                    }
                } else if (indexPath.row == 6) {
                    cell.nameLabel.text = @"抢单开始时间";
                    cell.rightLabel.text = @"请添加抢单开始时间";
                    if (!_selectCellArray[7][@"section_0_row_6"]) {
                        [_selectCellArray[7] setValue:cell forKey:@"section_0_row_6"];
                    }
                } else if (indexPath.row == 7) {
                    cell.nameLabel.text = @"抢单结束时间";
                    cell.rightLabel.text = @"请添加抢单结束时间";
                    if (!_selectCellArray[8][@"section_0_row_7"]) {
                        [_selectCellArray[8] setValue:cell forKey:@"section_0_row_7"];
                    }
                }
                return cell;
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 1) {
                EmployerCertificationOneCell *cell;
                if (_selectCellArray[3][@"section_1_row_1"]) {
                    cell = _selectCellArray[3][@"section_1_row_1"];
                    return cell;
                }
                cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell2" forIndexPath:indexPath];
                cell.nameLabel.text = @"工资单位";
                cell.rightLabel.textColor = RGBHex(0x333333);
                cell.rightLabel.text = @"天";
                if (!_selectCellArray[3][@"section_1_row_1"]) {
                    [_selectCellArray[3] setValue:cell forKey:@"section_1_row_1"];
                }
                return cell;
            } else {
                EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                               if (!cell) {
                                   cell = [[EmployerCertificationTexyfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                               }
                cell.nameLabel.text = @"工资";
                cell.textField.placeholder =  @"请输入报酬金额（元）| 天  ";
                cell.textField.delegate = self;
                _texyfieldCell = cell;
               if (_textFieldCellArray.count < 3 && ![_textFieldCellArray containsObject:cell]) {
                    [_textFieldCellArray addObject:cell];
                }
                return cell;
            }
   
        } else if (indexPath.section == 2) {
            EmployerCertificationOneCell *cell;
            if (indexPath.row == 2) {
                if (_selectCellArray[4][@"section_2_row_2"]) {
                    cell = _selectCellArray[4][@"section_2_row_2"];
                    return cell;
                }
            } else  if (indexPath.row == 3)  {// indexPath.row ==2
                if (_selectCellArray[5][@"section_2_row_3"]) {
                    cell = _selectCellArray[5][@"section_2_row_3"];
                    return cell;
                }
            }
     
                if (indexPath.row == 1) {
                    ServiceTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTimeCell" forIndexPath:indexPath];
                    _timeCell = cell;
                    return cell;
                }
            
            if (indexPath.row == 2) {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell3" forIndexPath:indexPath];
                if (!_selectCellArray[4][@"section_2_row_2"]) {
                    [_selectCellArray[4] setValue:cell forKey:@"section_2_row_2"];
                }
            } else {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell33" forIndexPath:indexPath];
                if (!_selectCellArray[5][@"section_2_row_3"]) {
                    [_selectCellArray[5] setValue:cell forKey:@"section_2_row_3"];
                }
            }
           
            cell.nameLabel.text = @[@"",@"",@"上班起止时间",@"上班地点"][indexPath.row];
            cell.rightLabel.text = @"请选择";
            
            return cell;
        } else if (indexPath.section == 3 || (indexPath.section == 4)) {
            PublishTextViewTableCell *cell;
            if (_textViewCellArray.count == 2) {
                cell = _textViewCellArray[indexPath.section - 3];
                return cell;
            }
               cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"PublishTextViewTableCell%ld",(long)indexPath.section]];
            if (!cell) {
                cell = [[PublishTextViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"PublishTextViewTableCell%ld",(long)indexPath.section]];
            }
            if (indexPath.section ==3) {
                cell.textView.text =@"用明确清晰的语言描述你的需求";
            } else {
                cell.textView.text = @"请输入对员工的要求";
            }
                cell.textView.delegate = self;
                cell.textView.tag = 1000 + indexPath.section;
            if (_textViewCellArray.count< 2) {
                if (![_textViewCellArray containsObject:cell]) {
                     [_textViewCellArray addObject:cell];
                }
            }
            return cell;
        } else if (indexPath.section == 5) {
            EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                           if (!cell) {
                               cell = [[EmployerCertificationTexyfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                           }
            cell.nameLabel.text = @[@"",@"联系人",@"联系电话"][indexPath.row];
            cell.textField.delegate = self;
            cell.textField.placeholder =  @[@"",@"请输入联系人姓名",@"请输入联系人电话"][indexPath.row ];
            if (_textFieldCellArray.count < 5 && ![_textFieldCellArray containsObject:cell]) {
                               [_textFieldCellArray addObject:cell];
                           }
            return cell;
        } else if (indexPath.section == 6) {
            PublishImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishImageTableCell" forIndexPath:indexPath];
            WeakSelf;
            __weak typeof(cell) weakCell = cell;
            cell.buttonBlock = ^(UIButton * _Nonnull button) {
              
                [weakSelf pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
                    if (imageData) {
                        [button setImage:image forState:UIControlStateNormal];
                        if (button.tag == 300) {
                            weakSelf.encodedBase64ImageArray[0] = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                            weakCell.imageButton1.hidden = NO;
                        } else if (button.tag == 301) {
                             weakSelf.encodedBase64ImageArray[1] = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                             weakCell.imageButton2.hidden = NO;
                        } else {
                             weakSelf.encodedBase64ImageArray[2] = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                        }
                            button.userInteractionEnabled = NO;
                    }
                }];
            };
            return cell;
        } else {
            EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                               if (!cell) {
                                   cell = [[EmployerCertificationTexyfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"EmployerCertificationTexyfieldCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                               }
                cell.nameLabel.text = @"工资金额";
                cell.textField.placeholder = @"请输入";
                cell.textField.delegate = self;
            if (_textFieldCellArray.count < 6 && ![_textFieldCellArray containsObject:cell]) {
                                          [_textFieldCellArray addObject:cell];
                                      }
                return cell;
        }
    } else {
        if (indexPath.section == 7) {
            EmployerCertificationOneCell *cell;
            if (_selectCellArray[6][@"section_7_row_0"]) {
                cell = _selectCellArray[6][@"section_7_row_0"];
                return cell;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell4" forIndexPath:indexPath];
            cell.nameLabel.text = @"委托代发工资";
            cell.rightLabel.textColor = RGBHex(0x333333);
            cell.rightLabel.text = @"是";
            if (!_selectCellArray[6][@"section_7_row_0"]) {
                [_selectCellArray[6] setValue:cell forKey:@"section_7_row_0"];
            }
            return cell;
        } else {
            UITableViewCell *sectionOneCell = [tableView dequeueReusableCellWithIdentifier:@"sectionOneCell"];
            if (!sectionOneCell) {
                sectionOneCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sectionOneCell"];
                sectionOneCell.textLabel.font = [UIFont boldSystemFontOfSize:18];
                sectionOneCell.textLabel.textColor = RGBHex(0x333333);
                sectionOneCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            sectionOneCell.textLabel.text = @[@"基本信息",@"报酬",@"上班时间",@"工作内容",@"员工要求",@"联系方式",@"添加图片",@"",@""][indexPath.section];
            if (indexPath.section == 6 && indexPath.row == 0) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"添加图片  (选填，最多三张)"];
                [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(0, 4)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xCCCCCC) range:NSMakeRange(6, 9)];
                [attributedString addAttribute:NSFontAttributeName value:FontSize(18) range:NSMakeRange(0, 4)];
                [attributedString addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(6, 9)];
                sectionOneCell.textLabel.attributedText = attributedString;
            }
            return sectionOneCell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_textView endEditing:YES];
    [_textFieldCellArray enumerateObjectsUsingBlock:^(EmployerCertificationTexyfieldCell  * cell, NSUInteger idx, BOOL * _Nonnull stop) {
          [cell.textField endEditing:YES];
    }];
    _indexpath = indexPath;
    if (indexPath.section == 0 && indexPath.row == 2) {
        _JobArray = _mutableArray;
       _cell = _selectCellArray[0][@"section_0_row_2"];
        self.pickerSuperView.hidden = NO;
    } else if (indexPath.section == 0 && indexPath.row == 4) {
         _JobArray = @[@"男",@"女"];
        _cell = _selectCellArray[1][@"section_0_row_4"];
        self.pickerSuperView.hidden = NO;
    } else if (indexPath.section == 0 && indexPath.row == 5) {
         _JobArray = @[@"是",@"否"];
        _cell = _selectCellArray[2][@"section_0_row_5"];
        self.pickerSuperView.hidden = NO;
    } else if (indexPath.section == 1 && indexPath.row == 1) {
         _JobArray = @[@"天",@"小时"];
        _cell = _selectCellArray[3][@"section_1_row_1"];
        self.pickerSuperView.hidden = NO;
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        _selectTimeView.hidden = NO;
        _cell = _selectCellArray[4][@"section_2_row_2"];
    } else if (indexPath.section == 2 && indexPath.row == 3) {
        _cell = _selectCellArray[5][@"section_2_row_3"];
    // 上班地点
        WeakSelf;
        __weak typeof(_cell) weakCell = _cell;
        WorkPlaceMapController *wpmc = [WorkPlaceMapController new];
        wpmc.adressBlock = ^(NSString * _Nonnull address, NSString * _Nonnull longitude, NSString * _Nonnull latitude) {
            weakSelf.workPlace = address;
            weakSelf.longitude = longitude;
            weakSelf.latitude = latitude;
            weakCell.rightLabel.text = address;
            weakCell.rightLabel.textColor = RGBHex(0x333333);
        };
        [self.navigationController pushViewController:wpmc animated:NO];
    } else if (indexPath.section == 7 && indexPath.row == 0) {
        _cell = _selectCellArray[6][@"section_7_row_0"];
        _JobArray = @[@"是",@"否"];
         self.pickerSuperView.hidden = NO;
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        _selectDateView.hidden = NO;
        _cell = _selectCellArray[7][@"section_0_row_6"];
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        _selectDateView.hidden = NO;
        _cell = _selectCellArray[8][@"section_0_row_7"];
    }
    if (!_pickerSuperView.hidden) {
        [_pickerView reloadAllComponents];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_textView endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textFieldCellArray enumerateObjectsUsingBlock:^(EmployerCertificationTexyfieldCell  * cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell.textField endEditing:YES];
    }];
}

@end


