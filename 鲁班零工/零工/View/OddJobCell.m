
//
//  OddJobCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/14.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "OddJobCell.h"

@implementation OddJobCell {
   UILabel *nameLabel;
    UILabel *dayPriceLabel;
    UILabel *locationLabel;
    UILabel *rateLabel;
    UILabel *personLabel;
    UILabel *timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    
    nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(25, 15, 200, 15)];
    nameLabel.text =  @"济南市区外卖配送员";
    nameLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    nameLabel.textColor = RGBHex(0x333333);
    [self.contentView addSubview:nameLabel];
    
    dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(250, 18, 100, 12)];
    dayPriceLabel.text =  @"25元/天";
    dayPriceLabel.textAlignment = NSTextAlignmentRight;
    dayPriceLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dayPriceLabel.textColor = RGBHex(0xE50000);
    [self.contentView addSubview:dayPriceLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(25, 41, 10, 12)];
    imageView.image = [UIImage imageNamed:@"home_location"];
    [self.contentView addSubview:imageView];
    
    locationLabel = [[UILabel alloc] initWithFrame:AutoFrame(41, 42, 200, 12)];
    locationLabel.text =  @"天桥区纬北路街道济南站";
    locationLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    locationLabel.textColor = RGBHex(0x999999);
    [self.contentView addSubview:locationLabel];
    
    rateLabel = [[UILabel alloc] initWithFrame:AutoFrame(250, 43, 100, 10)];
    rateLabel.text =  @"好评率：88%";
    rateLabel.textAlignment = NSTextAlignmentRight;
    rateLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    rateLabel.textColor = RGBHex(0xcccccc);
    [self.contentView addSubview:rateLabel];
    
    personLabel = [[UILabel alloc] initWithFrame:AutoFrame(25, 68, 100, 12)];
    personLabel.text =  @"苏辉秉";
    personLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    personLabel.textColor = RGBHex(0x333333);
    [self.contentView addSubview:personLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(25, 87, 30, 15)];
    timeLabel.text =  @"计时";
    timeLabel.backgroundColor = RGBHex(0xDAF6FF);
    timeLabel.clipsToBounds = YES;
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 2*ScalePpth;
    timeLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = RGBHex(0x009CE0);
    [self.contentView addSubview:timeLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(271, 81, 84, 26)];
    button.clipsToBounds = YES;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5*ScalePpth;
    button.backgroundColor = RGBHex(0xFFD301);
    button.titleLabel.font  = FontSize(12);
    [button setTitle:@"立即抢单"forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [self.contentView addSubview:button];
}
- (void)setListModel:(PageContentListModel *)listModel {
    _listModel = listModel;
    if (listModel) {
        nameLabel.text = NoneNull(listModel.workName);
        NSString *price = [NSString stringWithFormat:@"%@/%@", listModel.salary, listModel.salaryDay];
        dayPriceLabel.text = NoneNull(price);
        locationLabel.text = NoneNull(listModel.workPositino);
        rateLabel.text = [[NSString stringWithFormat:@"好评率：%@",NoneNull(listModel.praise)] stringByAppendingString:@"%"];
        personLabel.text = NoneNull(listModel.contactPeople);
        timeLabel.text = [NSString stringWithFormat:@"按%@",NoneNull(listModel.salaryDay)];
    }
}
- (void)buttonAction:(UIButton *)button {
    if (_detailBlock &&_listModel) {
        _detailBlock(_listModel);
    }
}

@end
