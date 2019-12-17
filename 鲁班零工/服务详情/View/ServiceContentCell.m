//
//  ServiceContentCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/28.
//  Copyright © 2019 张兴栋. All rights reserved.


#import "ServiceContentCell.h"

@implementation ServiceContentCell {
    UILabel *contentLabel;
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

- (void)setUpUI {
    
    UILabel *_sendLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 19, 100, 14)];
    _sendLabel.font  = [UIFont boldSystemFontOfSize:14*ScalePpth];
    _sendLabel.textColor = RGBHex(0x333333);
    _sendLabel.text = @"【服务内容】";
    [self.contentView addSubview:_sendLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:AutoFrame(13.5, 45, 348, 60)];
    contentLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
    contentLabel.textColor = RGBHex(0x999999);
    contentLabel.numberOfLines = 0;
    contentLabel.text = @"专业擦玻璃，瓷砖美缝，开荒保洁，除甲醛，地板打蜡";
    [self.contentView addSubview:contentLabel];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:AutoFrame(13.5, 110, 348, 10)];
    tipsLabel.font  = [UIFont systemFontOfSize:10*ScalePpth];
    tipsLabel.textColor = RGBHex(0xFF0000);
    tipsLabel.numberOfLines = 0;
    tipsLabel.text = @"警惕：要求跳过平台交易和先交钱的均涉嫌欺诈";
    [self.contentView addSubview:tipsLabel];
}
- (void)setDetailModel:(ServiceDetailModel *)detailModel {
    _detailModel = detailModel;
    if (detailModel) {
        contentLabel.text = NoneNull(detailModel.skillVirtue);
    }
}
@end
