


//
//  GrabdTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "GrabdTableCell.h"

@implementation GrabdTableCell

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
    
    _sendLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 19, 80, 14)];
    _sendLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _sendLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:_sendLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(149, 23, 210, 11)];
    _rightLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    _rightLabel.textColor = RGBHex(0x999999);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
}

@end
