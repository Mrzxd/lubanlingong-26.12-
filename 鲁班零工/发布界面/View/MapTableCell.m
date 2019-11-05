//
//  MapTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "MapTableCell.h"

@implementation MapTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(51, 19, 280, 14)];
    _nameLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"海尔时代大厦";
    [self.contentView addSubview:_nameLabel];
    
    _stressLabel = [[UILabel alloc] initWithFrame:AutoFrame(52, 41, 280, 11)];
    _stressLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    _stressLabel.textColor = RGBHex(0x999999);
    _stressLabel.text = @"山东省济南市历下区经十路148380号（燕山立交西南角）";
    [self.contentView addSubview:_stressLabel];
    _pointView = [[UIView alloc] initWithFrame:AutoFrame(25, 32, 7, 7)];
    _pointView.backgroundColor = RGBHex(0xEA4B32);
    _pointView.layer.masksToBounds = YES;
    _pointView.clipsToBounds = YES;
    _pointView.layer.cornerRadius = 3.5 *ScalePpth;
    [self.contentView addSubview:_pointView];
}

@end
