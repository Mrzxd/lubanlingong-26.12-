//
//  PublishingServiceTextViewCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PublishingServiceTextViewCell.h"

@implementation PublishingServiceTextViewCell

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
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 80, 15)];
    _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"我的优势";
    [self.contentView addSubview:_nameLabel];
    _textView = [[UITextView alloc] initWithFrame:AutoFrame(15, 42, 345, 127)];
    _textView.clipsToBounds = YES;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 2 *ScalePpth;
    _textView.backgroundColor = RGBHex(0xFAFAFA);
    _textView.textColor = RGBHex(0xCCCCCC);
    [self.contentView addSubview:_textView];
}
@end
