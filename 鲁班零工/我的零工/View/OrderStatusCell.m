

//
//  OrderStatusCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "OrderStatusCell.h"

@implementation OrderStatusCell {
    UILabel *adressCTLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(10, 0, 355, 172)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    contentView.layer.shadowColor = RGBHex(0xC6C6C6).CGColor;//阴影颜色
    contentView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    contentView.layer.shadowOpacity = 0.7;//不透明度
    contentView.layer.shadowRadius = 4;//半径
    [self.contentView addSubview:contentView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(13, 14, 70, 14)];
    nameLabel.text =  @"订单状态";
    nameLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
    nameLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:nameLabel];
    
    _waitLabel = [[UILabel alloc] initWithFrame:AutoFrame(243, 14, 100, 14)];
    _waitLabel.text =  @"等待雇主同意";
    _waitLabel.textAlignment = NSTextAlignmentRight;
    _waitLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
    _waitLabel.textColor = RGBHex(0xFF0000);
    [contentView addSubview:_waitLabel];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, (40+i *86), 355, 0.5)];
        lineView.backgroundColor = RGBHex(0xEEEEEE);
        [contentView addSubview:lineView];
    }
    
    _timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(13, 50, 70, 12)];
    _timeLabel.text =  @"订单时间";
    _timeLabel.font = [UIFont boldSystemFontOfSize:12*ScalePpth];
    _timeLabel.textColor = RGBHex(0x999999);
    [contentView addSubview:_timeLabel];
    
    _timeCTLabel = [[UILabel alloc] initWithFrame:AutoFrame(145, 50, 200, 12)];
    _timeCTLabel.text =  @"2019-01-28 10:20:23";
    _timeCTLabel.textAlignment = NSTextAlignmentRight;
    _timeCTLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    _timeCTLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_timeCTLabel];
    
    _saleLabel = [[UILabel alloc] initWithFrame:AutoFrame(13, 77, 70, 12)];
    _saleLabel.text =  @"保险销售";
    _saleLabel.font = [UIFont boldSystemFontOfSize:12*ScalePpth];
    _saleLabel.textColor = RGBHex(0x999999);
    [contentView addSubview:_saleLabel];
    
    _saleCTLabel = [[UILabel alloc] initWithFrame:AutoFrame(145, 77, 200, 12)];
    _saleCTLabel.text =  @"300元/天";
    _saleCTLabel.textAlignment = NSTextAlignmentRight;
    _saleCTLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    _saleCTLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_saleCTLabel];
    
    UILabel *adressLabel = [[UILabel alloc] initWithFrame:AutoFrame(13, 104, 70, 12)];
    adressLabel.text =  @"地址";
    adressLabel.font = [UIFont boldSystemFontOfSize:12*ScalePpth];
    adressLabel.textColor = RGBHex(0x999999);
    [contentView addSubview:adressLabel];
    
    
    adressCTLabel = [[UILabel alloc] initWithFrame:AutoFrame(45, 104, 300, 12)];
    adressCTLabel.text =  @"历下区燕山街道东源大厦";
    adressCTLabel.textAlignment = NSTextAlignmentRight;
    adressCTLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    adressCTLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:adressCTLabel];
    
    _stateButton = [[UIButton alloc] initWithFrame:AutoFrame(275, 136, 72, 26)];
    _stateButton.backgroundColor = RGBHex(0xFED452);
    _stateButton.clipsToBounds = YES;
    _stateButton.layer.cornerRadius = 13 *ScalePpth;
    _stateButton.layer.masksToBounds = YES;
    _stateButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_stateButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [_stateButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(immediatelyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_stateButton];
    
    _startWorkButton = [[UIButton alloc] initWithFrame:AutoFrame(109, 136, 72, 26)];
    _startWorkButton.backgroundColor = RGBHex(0xffffff);
    _startWorkButton.clipsToBounds = YES;
    _startWorkButton.layer.cornerRadius = 13 *ScalePpth;
    _startWorkButton.layer.masksToBounds = YES;
    _startWorkButton.layer.borderWidth = 0.5;
    _startWorkButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _startWorkButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_startWorkButton setTitle:@"开工" forState:UIControlStateNormal];
    [_startWorkButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_startWorkButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_startWorkButton];
    
    _MiddleButton = [[UIButton alloc] initWithFrame:AutoFrame(192, 136, 72, 26)];
    _MiddleButton.backgroundColor = RGBHex(0xffffff);
    _MiddleButton.clipsToBounds = YES;
    _MiddleButton.layer.cornerRadius = 13 *ScalePpth;
    _MiddleButton.layer.masksToBounds = YES;
    _MiddleButton.layer.borderWidth = 0.5;
    _MiddleButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _MiddleButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_MiddleButton setTitle:@"确认完工" forState:UIControlStateNormal];
    [_MiddleButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_MiddleButton addTarget:self action:@selector(sureFanishedAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_MiddleButton];
}
//  取消订单
- (void)immediatelyButtonAction:(UIButton *)button {
    if (_cellBlock) {
        _cellBlock(_jobModel?_jobModel:_releasedJobsModel);
    }
}
- (void)startButtonAction:(UIButton *)button {
        if (_firstButtonBlock) {
            _firstButtonBlock(_jobModel?_jobModel:_releasedJobsModel);
        }
}
- (void)sureFanishedAction:(UIButton *)button {
    if (_middlleButtonBlock) {
        _middlleButtonBlock(_jobModel?_jobModel:_releasedJobsModel);
    }
}
- (void)setJobModel:(MyOddJobModel *)jobModel {
    _jobModel = jobModel;
    if (jobModel) {
        _timeCTLabel.text = [self getTimeFromTimestamp:NoneNull(jobModel.creatOrderTime)];
        _saleCTLabel.text = [NSString stringWithFormat:@"%@/%@",NoneNull(jobModel.orderSalary),NoneNull(jobModel.orderSalaryDay)];
        adressCTLabel.text = NoneNull(jobModel.orderLocation);
        _saleLabel.text = NoneNull(jobModel.orderOrderName);
    }
}

- (void)setReleasedJobsModel:(ReleasedJobsModel *)releasedJobsModel {
    _releasedJobsModel= releasedJobsModel;
    if (releasedJobsModel) {
        _timeCTLabel.text = [self getTimeFromTimestamp:NoneNull(releasedJobsModel.releaseTime)];
        _saleCTLabel.text = [NSString stringWithFormat:@"%@/%@",NoneNull(releasedJobsModel.salary),NoneNull(releasedJobsModel.salaryDay)];
        adressCTLabel.text = NoneNull(releasedJobsModel.workPositino);
        _saleLabel.text = NoneNull(releasedJobsModel.workName);
    }
}

@end
