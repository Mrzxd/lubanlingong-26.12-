
//
//  PersonTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/16.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PersonTableCell.h"

@implementation PersonTableCell


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
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(16, 18, 80, 15)];
    _nameLabel.font  = [UIFont boldSystemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    [self.contentView addSubview:_nameLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(149, 23, 210, 11)];
    _rightLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    _rightLabel.textColor = RGBHex(0x999999);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
}

@end
