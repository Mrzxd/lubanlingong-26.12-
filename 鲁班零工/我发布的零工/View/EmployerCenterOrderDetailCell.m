



//
//  EmployerCenterOrderDetailCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCenterOrderDetailCell.h"

@implementation EmployerCenterOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBHex(0xF7F7F7);
        self.contentView.backgroundColor = RGBHex(0xF7F7F7);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 0, 360, 109)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    [self.contentView addSubview:contentView];
    
    _typelabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 100, 14)];
    _typelabel.font = [UIFont boldSystemFontOfSize:14 *ScalePpth];
    _typelabel.textColor = RGBHex(0x333333);
    _typelabel.text = @"报酬";
    [contentView addSubview:_typelabel];
    
    _leftLabel = [self typeLabel:@"计算方式" :43];
    _rightLabel =[self rightLabel:@"计时" :43];
    
    _leftLabel2 = [self typeLabel:@"报酬" :83];
    _rightLabel2 = [self rightLabel:@"5元/时" :83];
    [contentView addSubview:_leftLabel];
    [contentView addSubview:_rightLabel];
    [contentView addSubview:_leftLabel2];
    [contentView addSubview:_rightLabel2];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 68.5, 360, 0.5)];
    lineView.backgroundColor = RGBHex(0xEEEEEE);
    [contentView addSubview:lineView];
}

- (UILabel *)typeLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, height, 100, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x333333);
    label.text = text;
    return label;
}

- (UILabel *)rightLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(200, height, 145, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x999999);
    label.text = text;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}
@end
