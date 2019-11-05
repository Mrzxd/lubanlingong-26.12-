
//
//  OddJobCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/14.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "OddJobCell.h"

@implementation OddJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    

    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(10, 0, 355, 117)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    contentView.layer.shadowColor = RGBHex(0x333333).CGColor;//阴影颜色
    contentView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    contentView.layer.shadowOpacity = 0.25;//不透明度
    contentView.layer.shadowRadius = 4;//半径
    [self.contentView addSubview:contentView];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 200, 15)];
    nameLabel.text =  @"济南市区外卖配送员";
    nameLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    nameLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:nameLabel];
    
    UILabel *dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(240, 18, 100, 12)];
    dayPriceLabel.text =  @"25元/天";
    dayPriceLabel.textAlignment = NSTextAlignmentRight;
    dayPriceLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dayPriceLabel.textColor = RGBHex(0xE50000);
    [contentView addSubview:dayPriceLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(15, 41, 10, 12)];
    imageView.image = [UIImage imageNamed:@"home_location"];
    [contentView addSubview:imageView];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:AutoFrame(31, 42, 200, 12)];
    locationLabel.text =  @"天桥区纬北路街道济南站";
    locationLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    locationLabel.textColor = RGBHex(0x999999);
    [contentView addSubview:locationLabel];
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:AutoFrame(240, 43, 100, 10)];
    rateLabel.text =  @"好评率：88%";
    rateLabel.textAlignment = NSTextAlignmentRight;
    rateLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    rateLabel.textColor = RGBHex(0xcccccc);
    [contentView addSubview:rateLabel];
    
    UILabel *personLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 68, 100, 12)];
    personLabel.text =  @"苏辉秉";
    personLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    personLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:personLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 87, 30, 15)];
    timeLabel.text =  @"计时";
    timeLabel.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel.clipsToBounds = YES;
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 2*ScalePpth;
    timeLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = RGBHex(0x009CE0);
    [contentView addSubview:timeLabel];
    
    _button = [[UIButton alloc] initWithFrame:AutoFrame(261, 81, 84, 26)];
    _button.clipsToBounds = YES;
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 5*ScalePpth;
    _button.backgroundColor = RGBHex(0xFFD301);
    _button.titleLabel.font  = FontSize(12);
    [_button setTitle:@"立即抢单"forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
}

- (void)buttonAction:(UIButton *)button {
    if (_detailBlock) {
        id model;
        _detailBlock(model);
    }
}

@end
