//
//  EmployerCenterOrderDetailCell2.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCenterOrderDetailCell2.h"

@implementation EmployerCenterOrderDetailCell2

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
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 0, 360, 120)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    [self.contentView addSubview:contentView];
    
    _typelabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 100, 14)];
    _typelabel.font = [UIFont boldSystemFontOfSize:14 *ScalePpth];
    _typelabel.textColor = RGBHex(0x333333);
    _typelabel.text = @"工作要求";
    [contentView addSubview:_typelabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 44, 325, 60)];
    _contentLabel.font = [UIFont systemFontOfSize:12 *ScalePpth];
    _contentLabel.textColor = RGBHex(0x999999);
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _contentLabel.text = @"1.制定测试计划、编写测试报告、设计测试用例\n2.搭建测试环境，执行测试用例\n3.根据bug不同种类进行归类总结，提交bug报告\n4.输出文档(测试报告/测试方案/使用手册";
    [contentView addSubview:_contentLabel];
}

@end
