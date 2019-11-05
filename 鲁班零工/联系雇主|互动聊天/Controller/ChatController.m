
//
//  ChatController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "LeftUserCell.h"
#import "RightUserCell.h"
#import "ChatController.h"

@interface ChatController ()  <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雇主郑婷婷";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat space = KNavigationHeight > 64 ? 70 : 50;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.bounds.size.height - KNavigationHeight - space*ScalePpth) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[LeftUserCell class] forCellReuseIdentifier:@"LeftUserCell"];
        [_tableView registerClass:[RightUserCell class] forCellReuseIdentifier:@"RightUserCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.backgroundColor = RGBHex(0xF7F7F7);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        CGFloat space = KNavigationHeight > 64 ? 70 : 50;
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - space*ScalePpth - KNavigationHeight, ScreenWidth, space*ScalePpth)];
        [self addSubViews];
    }
    return _footerView;
}

- (void)addSubViews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(12, 15.5, 25, 20)];
    imageView.image = [UIImage imageNamed:@"uploading"];
    [_footerView addSubview:imageView];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:AutoFrame(344, 17, 21, 18)];
    imageView2.image = [UIImage imageNamed:@"send"];
    [_footerView addSubview:imageView2];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(49*ScalePpth, 10.5*ScalePpth, 295*ScalePpth, 30*ScalePpth)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = FontSize(12);
    _textField.delegate = self;
    _textField.placeholder = @"输入消息";
    [_footerView addSubview:_textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   [_textField endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 12;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 11) {
        return 20*ScalePpth;
    }
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section % 2 == 0) {
        RightUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightUserCell" forIndexPath:indexPath];
        return cell;
    } else {
        LeftUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftUserCell" forIndexPath:indexPath];
        return cell;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_textField endEditing:YES];
}
@end
