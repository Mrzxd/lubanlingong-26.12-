//
//  EmployerCertificationController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "EmployerCertificationOneCell.h"
#import "EmployerCertificationTexyfieldCell.h"
#import "EmployerCertificationThreeCell.h"
#import "EmployerCertificationController.h"
#import "EmployerCertificationFourCell.h"

@interface EmployerCertificationController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) EmployerCertificationOneCell *cell;
@property (nonatomic, strong) NSString *fullfaceEncodedImageStr;
@property (nonatomic, strong) NSString *negativeEncodedImageStr;
@property (nonatomic, strong) NSString *businessLicenseEncodedImageStr;

@property (nonatomic, strong) NSMutableArray *textFieldArray;

@end

@implementation EmployerCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雇主认证";
    [self.view addSubview:self.tableView];
    _textFieldArray = [NSMutableArray new];
    [self toNetWork];
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 30)];
        _headerView.backgroundColor = RGBHex(0xFFFBE5);
        [self addSubViews];
    }
    return _headerView;
}
- (void)addSubViews {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(25, 9, 325, 12)];
    label.textColor = RGBHex(0xFFD301);
    label.text = @"请填写您的真实姓名，通过后将不能修改";
    label.font = FontSize(12);
    [_headerView addSubview:label];
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, height) style:UITableViewStylePlain];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell"];
        [_tableView registerClass:[EmployerCertificationTexyfieldCell class] forCellReuseIdentifier:@"EmployerCertificationTexyfieldCell"];
        [_tableView registerClass:[EmployerCertificationThreeCell class] forCellReuseIdentifier:@"EmployerCertificationThreeCell"];
        [_tableView registerClass:[EmployerCertificationFourCell class] forCellReuseIdentifier:@"EmployerCertificationFourCell"];
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

- (void)toNetWork {
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/updateMemberNews/updatEmployerNewsCaredId"] params:@{} success:^(id  _Nonnull response) {
        
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else{
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50*ScalePpth;
    } else if (indexPath.section == 1) {
        return 410*ScalePpth;
    } else {
        return 310*ScalePpth;
    }
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
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            EmployerCertificationOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell" forIndexPath:indexPath];
            _cell = cell;
            return cell;
        } else {
            if (_textFieldArray.count == 2) {
                EmployerCertificationTexyfieldCell *cell = _textFieldArray[indexPath.row - 1];
                return cell;
            }
            EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationTexyfieldCell" forIndexPath:indexPath];
            if (_textFieldArray.count < 2) {
                [_textFieldArray addObject:cell];
            }
            cell.textField.delegate = self;
            cell.nameLabel.text = @[@"",@"真实姓名",@" 身份证号"][indexPath.row];
            cell.textField.placeholder =  @[@"",@"请输入真实姓名",@"请输入身份证号"][indexPath.row];
            return cell;
        }
    } else if (indexPath.section == 1) {
        
        EmployerCertificationThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationThreeCell" forIndexPath:indexPath];
       
        WeakSelf;
        __weak typeof(cell) weakCell = cell;
        cell.photoBlock = ^(NSInteger index) {
             [weakSelf pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
            if (index == 0) {
                 weakSelf.fullfaceEncodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                 [weakCell.fullfacePhoto setImage:image forState:UIControlStateNormal];
             } else {
                 weakSelf.negativeEncodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                 [weakCell.negativePhoto setImage:image forState:UIControlStateNormal];
             }
           }];
        };
        return cell;
    } else {
        WeakSelf;
        EmployerCertificationFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationFourCell" forIndexPath:indexPath];
        __weak typeof(cell) weakCell = cell;
        [cell.loginButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.photoBlock = ^(NSInteger index) {
            [weakSelf pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
            weakSelf.businessLicenseEncodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [weakCell.fullfacePhoto setImage:image forState:UIControlStateNormal];
        }];
        };
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WeakSelf;
        UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"公司" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.cell.rightLabel.text = @"公司";
            weakSelf.cell.rightLabel.textColor = RGBHex(0x333333);
        }];
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"个人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.cell.rightLabel.text = @"个人";
            weakSelf.cell.rightLabel.textColor = RGBHex(0x333333);
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"请选择雇主类型" preferredStyle:UIAlertControllerStyleActionSheet];
        [controller addAction:alertAction1];
        [controller addAction:alertAction2];
        [self presentViewController:controller animated:YES completion:nil];
    }
}
- (void)submitAction:(UIButton *)button {
    if ([_cell.rightLabel.text isEqualToString:@"请选择"]) {
        [WHToast showErrorWithMessage:@"请先选择雇主类型"];
        return;
    }
    if ([_cell.rightLabel.text isEqualToString:@"公司"] && (NoneNull(_businessLicenseEncodedImageStr).length == 0)) {
        [WHToast showErrorWithMessage:@"请选择营业执照"];
        return;
    }
    EmployerCertificationTexyfieldCell *cell1 = _textFieldArray[0];
    EmployerCertificationTexyfieldCell *cell2 = _textFieldArray[1];
    if (cell1.textField.text.length == 0) {
        [WHToast showErrorWithMessage:@"请填写姓名"];
        return;
    }
    if (![self verifyIDCardNumber:NoneNull(cell2.textField.text)]) {
        [WHToast showErrorWithMessage:@"请填写正确的身份证号"];
        return;
    }
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/updateMemberNews/updatEmployerNewsCaredId"] params:@{
                                                                                                                         @"cardImagez":_fullfaceEncodedImageStr NonNull,
                                                                                                                         @"base64z":@"data:image/png;base64,",
                                                                                                                         @"cardImageb":_negativeEncodedImageStr NonNull,
                                                                                                                         @"base64b":@"data:image/png;base64,",
                                                                                                                         @"Licensez":_businessLicenseEncodedImageStr NonNull,
                                                                                                                         @"base64lz":@"data:image/png;base64,",
                                                                                                                         @"name":cell1.textField.text NonNull,
                                                                                                                         @"cardId":NoneNull(cell2.textField.text),
                                                                                                                         } success:^(id  _Nonnull response) {
                                                                                                                             if (response && [response[@"code"] intValue] == 0) {
                                                                                                                                 [WHToast showSuccessWithMessage:@"上传成功"];
                                                                                                                             } else {
                                                                                                                                 [WHToast showErrorWithMessage:@"上传失败"];
                                                                                                                             }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}

@end
