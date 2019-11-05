

//
//  LookForServicesCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "LookForServicesCell.h"

@implementation LookForServicesCell

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
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(10, 0, 355, 93)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    contentView.layer.shadowColor = RGBHex(0x333333).CGColor;//阴影颜色
    contentView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    contentView.layer.shadowOpacity = 0.25;//不透明度
    contentView.layer.shadowRadius = 4;//半径
    [self.contentView addSubview:contentView];
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 200, 15)];
    _nameLabel.text =  @"服务员";
    _nameLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_nameLabel];
    
    UILabel *dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(240, 18, 100, 12)];
    dayPriceLabel.text =  @"25元/天";
    dayPriceLabel.textAlignment = NSTextAlignmentRight;
    dayPriceLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dayPriceLabel.textColor = RGBHex(0xE50000);
    [contentView addSubview:dayPriceLabel];
   
    _modeLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 42, 200, 12)];
    _modeLabel.text =  @"服务方式：去你那";
    _modeLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    _modeLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_modeLabel];
    
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 63, 30, 15)];
    timeLabel.text =  @"周一";
    timeLabel.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel.clipsToBounds = YES;
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 2*ScalePpth;
    timeLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = RGBHex(0x009CE0);
    [contentView addSubview:timeLabel];
    
    
    UILabel *timeLabel2 = [[UILabel alloc] initWithFrame:AutoFrame(55, 63, 30, 15)];
    timeLabel2.text =  @"周二";
    timeLabel2.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel2.clipsToBounds = YES;
    timeLabel2.layer.masksToBounds = YES;
    timeLabel2.layer.cornerRadius = 2*ScalePpth;
    timeLabel2.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel2.textAlignment = NSTextAlignmentCenter;
    timeLabel2.textColor = RGBHex(0x009CE0);
    [contentView addSubview:timeLabel2];
    
    UILabel *timeLabel3 = [[UILabel alloc] initWithFrame:AutoFrame(95, 63, 30, 15)];
    timeLabel3.text =  @"周三";
    timeLabel3.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel3.clipsToBounds = YES;
    timeLabel3.layer.masksToBounds = YES;
    timeLabel3.layer.cornerRadius = 2*ScalePpth;
    timeLabel3.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel3.textAlignment = NSTextAlignmentCenter;
    timeLabel3.textColor = RGBHex(0x009CE0);
    [contentView addSubview:timeLabel3];
}

@end
