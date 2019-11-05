
//
//  PublishTextViewTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PublishTextViewTableCell.h"

@implementation PublishTextViewTableCell

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
    
    _textView = [[UITextView alloc] initWithFrame:AutoFrame(15, 15, 345, 127)];
    _textView.clipsToBounds = YES;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 2 *ScalePpth;
    _textView.backgroundColor = RGBHex(0xFAFAFA);
    _textView.text = @"用明确清晰的语言描述你的需求";
    _textView.textColor = RGBHex(0xCCCCCC);
    [self.contentView addSubview:_textView];
}

@end
