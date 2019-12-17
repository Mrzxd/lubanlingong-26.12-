
//
//  ServiceAuthenticationController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "EmployerCertificationTexyfieldCell.h"
#import "EmployerCertificationThreeCell.h"
#import "EmployerCertificationController.h"
#import "EmployerCertificationFourCell.h"
#import "ServiceAuthenticationController.h"

@interface ServiceAuthenticationController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSString *fullfaceEncodedImageStr;
@property (nonatomic, strong) NSString *negativeEncodedImageStr;
@property (nonatomic, strong) NSMutableArray *textFieldArray;

@end

@implementation ServiceAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
     _textFieldArray = [NSMutableArray new];
    [self.view addSubview:self.tableView];
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
        [_tableView registerClass:[EmployerCertificationTexyfieldCell class] forCellReuseIdentifier:@"EmployerCertificationTexyfieldCell"];
        [_tableView registerClass:[EmployerCertificationThreeCell class] forCellReuseIdentifier:@"EmployerCertificationThreeCell"];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else{
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50*ScalePpth;
    } else
        return (tableView.frame.size.height -  150*ScalePpth);
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
        if (_textFieldArray.count == 2) {
            EmployerCertificationTexyfieldCell *cell = _textFieldArray[indexPath.row];
            return cell;
       }
            EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationTexyfieldCell" forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.nameLabel.text = @[@"真实姓名",@" 身份证号"][indexPath.row];
            cell.textField.placeholder =  @[@"请输入真实姓名",@"请输入身份证号"][indexPath.row];
            if (_textFieldArray.count < 2) {
                [_textFieldArray addObject:cell];
            }
            return cell;
    } else {
        EmployerCertificationThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationThreeCell" forIndexPath:indexPath];
        cell.isServiceAuthenticationController = YES;
        WeakSelf;
        cell.cellBlock = ^(id model) {
            [weakSelf submitAction];
        };
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
    }
}

- (void)submitAction {

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
 if (!_fullfaceEncodedImageStr) {
      [WHToast showErrorWithMessage:@"请选择身份证正面照片"];
      return;
 }
  if (!_negativeEncodedImageStr) {
       [WHToast showErrorWithMessage:@"请选择身份证反面照片"];
      return;
 }
    
 [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/updateMemberNews/updateMemberNewsCaredId"] params:@{
                                                                                                                      @"cardImagez":_fullfaceEncodedImageStr NonNull,
                                                                                                                      @"base64z":@"data:image/png;base64,",
                                                                                                                      @"cardImageb":_negativeEncodedImageStr NonNull,
                                                                                                                      @"base64b":@"data:image/png;base64,",
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

