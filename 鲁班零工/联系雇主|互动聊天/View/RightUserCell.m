


//
//  RightUserCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "RightUserCell.h"

@interface RightUserCell ()

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *backGroundmageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end
@implementation RightUserCell


- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:AutoFrame(319, 0, 44, 44)];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView.image = [UIImage imageNamed:@"head_img2"];
    }
    return _rightImageView;
}

- (UIImageView *)backGroundmageView {
    if (!_backGroundmageView) {
        _backGroundmageView = [[UIImageView alloc] init];
        _backGroundmageView.image = [[UIImage imageNamed:@"right.9"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 22) resizingMode:UIImageResizingModeStretch];;
    }
    return _backGroundmageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = FontSize(13);
        _contentLabel.textColor = RGBHex(0x333333);
        _contentLabel.text = @"您好，老板，麻烦您同意一下该项服务，谢谢。";
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBHex(0xF7F7F7);
        self.contentView.backgroundColor = RGBHex(0xF7F7F7);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.backGroundmageView];
    [self.backGroundmageView addSubview:self.contentLabel];
    WeakSelf;
    [self.backGroundmageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-56*ScalePpth);
        make.top.equalTo(weakSelf.contentView.mas_top).offset(22*ScalePpth);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-1);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backGroundmageView.mas_right).offset(-20*ScalePpth);
        make.top.equalTo(weakSelf.backGroundmageView.mas_top).offset(9*ScalePpth);
        make.left.equalTo(weakSelf.backGroundmageView.mas_left).offset(15*ScalePpth);
        make.bottom.equalTo(weakSelf.backGroundmageView.mas_bottom).offset(-10*ScalePpth);
        make.width.mas_lessThanOrEqualTo(230*ScalePpth);
    }];
    
}
@end
