//
//  EvaluateCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/16.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EvaluateCell.h"

@implementation EvaluateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _leftLabel = [[UILabel alloc] initWithFrame:AutoFrame(16, 14, 130, 13)];
    _leftLabel.font  = [UIFont systemFontOfSize:13*ScalePpth];
    _leftLabel.textColor = RGBHex(0x0C0D0D);
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(196, 13.5, 150, 11)];
    _rightLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    _rightLabel.textColor = RGBHex(0x999999);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
}

@end
