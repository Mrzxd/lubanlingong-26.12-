



//
//  EmployeeRecordsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/29.
//  Copyright © 2019 张兴栋. All rights reserved.
//



#import "EmployerRecordCell.h"
#import "EmployeeRecordsController.h"

@interface EmployeeRecordsController ()  <UITableViewDelegate,UITableViewDataSource,YTSegmentBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) YTSegmentBar *segmentBar;

@end

@implementation EmployeeRecordsController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGBHex(0xFFB924);
    self.navigationController.navigationBar.tintColor = RGBHex(0xFFB924);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _array = [[NSMutableArray alloc] init];
    [_array addObject:[[NSMutableArray alloc] init]];
    [_array addObject:[[NSMutableArray alloc] init]];
    [self.view addSubview:self.tableView];
}
- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:AutoFrame(30, 33, 315, 43)];
        _segmentBar.clipsToBounds = YES;
        _segmentBar.delegate = self;
        _segmentBar.items = @[@"发布服务",@"接单记录"];
        _segmentBar.showIndicator = YES;
        _segmentBar.selectIndex = 0;
        _segmentBar.backgroundColor = [UIColor clearColor];
    }
    return _segmentBar;
}
- (UIView *)headerView {
    if (!_headerView) {
        CGFloat height = 203 + 43 - 64 + 43;
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, height)];
        _headerView.backgroundColor = RGBHex(0xFFB924);
        [self addSubViews];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375*ScalePpth, ScreenHeight - KNavigationHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[EmployerRecordCell class] forCellReuseIdentifier:@"EmployerRecordCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xF3F3F3);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)addSubViews {
    UIButton *userBtn = [[UIButton alloc] initWithFrame:AutoFrame(18, 7, 57, 57)];
    [userBtn setImage:[UIImage imageNamed:@"userbtn.png"] forState:UIControlStateNormal];
    userBtn.clipsToBounds = YES;
    userBtn.layer.cornerRadius = 57.0/2*ScalePpth;
    userBtn.layer.masksToBounds = YES;
    [_headerView addSubview:userBtn];
    UILabel * userLabel = [[UILabel alloc] initWithFrame:AutoFrame(87, 13, 0, 0)];
    userLabel.text = @"用户名名称";
    userLabel.font = FontSize(18);
    userLabel.textColor = UIColor.whiteColor;
    [userLabel sizeToFit];
    [_headerView addSubview:userLabel];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:AutoFrame(87, 39, 104, 19)];
    phoneLabel.text = @"130 5642 2255";
    phoneLabel.backgroundColor = RGBHexAlpha(0x000000, 0.16);
    phoneLabel.font = FontSize(12);
    phoneLabel.clipsToBounds = YES;
    phoneLabel.layer.cornerRadius = 19.0/2*ScalePpth;
    phoneLabel.layer.masksToBounds = YES;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = UIColor.whiteColor;
    [_headerView addSubview:phoneLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 139, 375, 96)];
    bottomView.backgroundColor = RGBHex(0xF3F3F3);
    [bottomView addSubview:self.segmentBar];
    [_headerView addSubview:bottomView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(10, 82, 355, 90)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.layer.cornerRadius = 5 *ScalePpth;
    whiteView.layer.masksToBounds = YES;
    whiteView.clipsToBounds = YES;
    [_headerView addSubview:whiteView];
    
    NSArray *numberArray = @[@"89",@"21",@"12",@"89%"];
    NSArray *nameArray = @[@"发布服务",@"接单记录",@"服务记录",@"好评率"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel * numberLabel = [[UILabel alloc] initWithFrame:AutoFrame(355.0 * i/4, 28, 355.0/4, 18)];
        numberLabel.text = numberArray[i];
        numberLabel.font = FontSize(18);
        numberLabel.textColor = RGBHex(0x333333);
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:numberLabel];
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(355.0 * i/4, 51, 355.0/4, 13)];
        nameLabel.text = nameArray[i];
        nameLabel.font = FontSize(13);
        nameLabel.textColor = RGBHex(0x999999);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:nameLabel];
    }
    
}
- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    _selectIndex = toIndex;
    [self.tableView reloadData];
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else{
        return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 38*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }
    return 5*ScalePpth;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 40)];
    header.backgroundColor = UIColor.whiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 0, 0)];
    label.textColor = RGBHex(0x999999);
    label.font = FontSize(13);
    label.text = @[@"发布服务（3）",@"接单记录（2）"][_selectIndex];
    [label sizeToFit];
    [header addSubview:label];
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(15, 39.5, 365, 0.4/ScalePpth)];
    line.backgroundColor = RGBHexAlpha(0x999999, 0.6);
    [header addSubview:line];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EmployerRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerRecordCell" forIndexPath:indexPath];
    cell.leftLabel.text = @[@"电焊工  280/天",@"外卖配送员  280/天",@"外卖配送员  280/天"][indexPath.row];
    cell.rightLabel.text = @[@"2019-09-21-2019-09-30",@"2019-09-21-2019-09-30",@"2019-09-21-2019-09-30"][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}


@end
