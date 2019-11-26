
//
//  RequestSuccessfulController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/29.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "OddJobCell.h"
#import "OrderDetailsOfMyEmployeesController.h"
#import "RequestSuccessfulController.h"

@interface RequestSuccessfulController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation RequestSuccessfulController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请求成功";
    [self.view addSubview:self.tableView];
   
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 266)];
        _headerView.backgroundColor = RGBHex(0xFFffff);
        [self addSubViews];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, ScreenHeight - KNavigationHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[OddJobCell class] forCellReuseIdentifier:@"OddJobCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xFfffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)addSubViews {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(163, 40, 50, 50)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 25*ScalePpth;
    [imageView setImage:[UIImage imageNamed:@"successful.png"]];
    [_headerView addSubview:imageView];
    
    UILabel * stateLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 101, 175, 18)];
    stateLabel.text = @"请求成功";
    stateLabel.font = FontSize(18);
    stateLabel.textColor = UIColor.blackColor;
    stateLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:stateLabel];
    
    UILabel * nowLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 132, 175, 14)];
    nowLabel.text = @"立即给雇员打电话催他确认";
    nowLabel.font = FontSize(14);
    nowLabel.textColor = UIColor.blackColor;
    nowLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:nowLabel];
    
    NSArray *titleArray = @[@"查看接单状态",@"拨打电话"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIButton *button  = [[UIButton alloc] initWithFrame:AutoFrame(78 + i *120, 180, 100, 30)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = FontSize(14);
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5*ScalePpth;
        button.tag = 100 +i;
        [button addTarget:self action:@selector(requestButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
            button.layer.borderWidth = 0.5;
            button.backgroundColor = UIColor.whiteColor;
        } else {
            button.backgroundColor = RGBHex(0xFFD301);
        }
        [_headerView addSubview:button];
    }
    
    UILabel * remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(50, 227,275, 9)];
    remindLabel.text = @"温馨提示：凡是要求不通过鲁班零工完成订单的，请当心上当受骗";
    remindLabel.font = FontSize(9);
    remindLabel.textColor = RGBHex(0xFF0000);
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:remindLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 256, 375, 10)];
    bottomView.backgroundColor = RGBHex(0xF0F0F0);
    [_headerView addSubview:bottomView];
}

- (void)requestButtonAction:(UIButton *)button {
    if (button.tag == 100) {
        OrderDetailsOfMyEmployeesController *odvc = [OrderDetailsOfMyEmployeesController new];
        odvc.detail_Type = OrderDetail_Type_Agree_wait;
        odvc.idName = NoneNull(_idName);
        [self.navigationController pushViewController:odvc animated:YES];
    } else {
        NSMutableString *phone=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phone NonNull];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
    }
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 0;
    }
    return 49 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10*ScalePpth;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 49)];
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(10, 15, 100, 18)];
        label.text = @"为你推荐";
        label.textColor = RGBHex(0x333333);
        label.font = [UIFont boldSystemFontOfSize:18*ScalePpth];
        [headerView addSubview:label];
        return headerView;
    }
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OddJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OddJobCell" forIndexPath:indexPath];
    cell.button.hidden = YES;
    return cell;
}

@end

