//
//  EvaluationDetailsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/16.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "EvaluationCell.h"
#import "StarTableCell.h"
#import "PersonTableCell.h"
#import "EvaluationDetailsController.h"

@interface EvaluationDetailsController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation EvaluationDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    [self.view addSubview:self.tableView];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 60)];
        _headerView.backgroundColor = UIColor.whiteColor;
        [self addSubViews];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, ScreenHeight - KNavigationHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[PersonTableCell class] forCellReuseIdentifier:@"PersonTableCell"];
        [_tableView registerClass:[StarTableCell class] forCellReuseIdentifier:@"StarTableCell"];
        [_tableView registerClass:[EvaluationCell class] forCellReuseIdentifier:@"EvaluationCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xF0f0f0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)addSubViews {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(22, 8, 45, 45)];
    imageView.backgroundColor = RGBHex(0xEEEEEE);
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 22.5*ScalePpth;
    imageView.layer.masksToBounds = YES;
    [_headerView addSubview:imageView];
    
    UILabel *myNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(82, 15, 0, 14)];
    myNameLabel.text = @"济南市外卖配送员";
    myNameLabel.font = FontSize(14);
    myNameLabel.textColor = RGBHex(0x333333);
    [myNameLabel sizeToFit];
    [_headerView addSubview:myNameLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(82, 37, 210, 11)];
    timeLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    timeLabel.textColor = RGBHex(0x999999);
    timeLabel.text = @"2019-09-21-2019-09-30";
    [_headerView addSubview:timeLabel];
    
    UILabel *dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(259, 17, 100, 12)];
    dayPriceLabel.text =  @"25元/天";
    dayPriceLabel.textAlignment = NSTextAlignmentRight;
    dayPriceLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dayPriceLabel.textColor = RGBHex(0xE50000);
    [_headerView addSubview:dayPriceLabel];
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
        return 0.00;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return  [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 5)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PersonTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableCell" forIndexPath:indexPath];
        cell.nameLabel.text = @[@"张豪天",@"张杰",@"李三"][indexPath.section];
        cell.rightLabel.text = @"2019-09-21-2019-09-30";
        return cell;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        StarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarTableCell" forIndexPath:indexPath];
        cell.nameLabel.text = @[@"",@"雇主态度",@"工作内容",@""][indexPath.row];
        return cell;
    } else {
        EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell" forIndexPath:indexPath];
        cell.nameLabel.text =@[@"",@"雇主态度",@"工作内容",@"评价内容"][indexPath.row];
        cell.rightLabel.text = @"老板人很好，结账很快";
        return cell;
    }
}
@end
