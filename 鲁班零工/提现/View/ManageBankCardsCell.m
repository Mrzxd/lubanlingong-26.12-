//
//  ManageBankCardsCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/12/3.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ManageBankCardsCell.h"

@interface ManageBankCardsCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *carNumberLabel;

@end

@implementation ManageBankCardsCell {
    UIView *contentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 24, 300, 18)];
        _nameLabel.text = @"建设银行储蓄卡";
        _nameLabel.font = FontSize(18);
        _nameLabel.textColor = UIColor.whiteColor;
    }
    return _nameLabel;
}

- (UILabel *)carNumberLabel {
    if (!_carNumberLabel) {
        _carNumberLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 66, 345, 20)];
        _carNumberLabel.text = @"622622000000000002";
        _carNumberLabel.font = FontSize(25);
        _carNumberLabel.textColor = UIColor.whiteColor;
    }
    return _carNumberLabel;
}
 
- (void)setUpUI {
    contentView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 345, 100)];
    contentView.backgroundColor = self.backgroundColor;
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 5*ScalePpth;
    [self.contentView addSubview:contentView];
    [contentView addSubview:self.nameLabel];
    [contentView addSubview:self.carNumberLabel];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    contentView.backgroundColor = backgroundColor;
}

- (void)setModel:(QueryBoundBankCardModel *)model {
    _model = model;
    if (model) {
        _nameLabel.text = NoneNull(model.bank);
        _carNumberLabel.text = NoneNull(model.bankCard);
    }
}

@end
