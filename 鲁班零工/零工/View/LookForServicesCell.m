

//
//  LookForServicesCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "LookForServicesCell.h"

@implementation LookForServicesCell {
    UILabel *dayPriceLabel;
    NSDictionary *diction;
    NSMutableArray *dayArray;
}

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
    
    dayArray = [NSMutableArray new];
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 200, 15)];
    _nameLabel.text =  @"服务员";
    _nameLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_nameLabel];
    
    dayPriceLabel = [[UILabel alloc] initWithFrame:AutoFrame(240, 18, 100, 12)];
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
    
    NSArray *titleArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    diction = @{
        @"1":@"周一",
        @"2":@"周二",
        @"3":@"周三",
        @"4":@"周四",
        @"5":@"周五",
        @"6":@"周六",
        @"7":@"周日"
    };
    
    for (NSInteger i = 0; i < 7; i ++) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame((15+i*40), 63, 30, 15)];
           timeLabel.text = titleArray[i];
           timeLabel.backgroundColor = RGBHex(0xDAF6FF);
           timeLabel.clipsToBounds = YES;
           timeLabel.layer.masksToBounds = YES;
           timeLabel.hidden = YES;
           timeLabel.layer.cornerRadius = 2*ScalePpth;
           timeLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
           timeLabel.textAlignment = NSTextAlignmentCenter;
           timeLabel.textColor = RGBHex(0x009CE0);
           [contentView addSubview:timeLabel];
        [dayArray addObject:timeLabel];
    }
}

- (void)setListModel:(LookingForListModel *)listModel {
    _listModel = listModel;
    if (_listModel) {
        _nameLabel.text = NoneNull(listModel.skillName);
        dayPriceLabel.text = [NSString stringWithFormat:@"%@元/%@",NoneNull(listModel.skillSalary),NoneNull(listModel.skillSalaryDay)];
        NSArray *array = [NoneNull(listModel.skillDate) componentsSeparatedByString:@","];
        [array enumerateObjectsUsingBlock:^(NSString * day, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *timeLabel = dayArray[idx];
            timeLabel.hidden = NO;
            timeLabel.text = diction[day];
        }];
    }
}

@end
