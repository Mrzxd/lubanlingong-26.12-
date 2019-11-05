



//
//  PayModeTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/21.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PayModeTableCell.h"

@implementation PayModeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    _modeImageView = [[UIImageView alloc] initWithFrame:AutoFrame(17, 12.5, 25, 25)];
    _modeImageView.image = [UIImage imageNamed:@"alipay.png"];
    [self.contentView addSubview:_modeImageView];
    
    _modeLabel = [[UILabel alloc] initWithFrame:AutoFrame(51, 17.5, 100, 16)];
    _modeLabel.text = @"支付宝支付";
    _modeLabel.textColor = RGBHex(0x261900);
    _modeLabel.font = FontSize(16);
    [self.contentView addSubview:_modeLabel];
    
    _modeButton = [[UIButton alloc] initWithFrame:AutoFrame(338, 14, 22, 22)];
    [_modeButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:_modeButton];
}

@end
