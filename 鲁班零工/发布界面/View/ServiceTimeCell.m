//
//  ServiceTimeCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ServiceTimeCell.h"

@interface ServiceTimeCell ()

@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation ServiceTimeCell

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
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 150, 15)];
    nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"服务时段（可多选）";
    [self.contentView addSubview:nameLabel];
    NSArray *timeArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (NSInteger i = 0; i < timeArray.count; i ++) {
        UIButton *weekButton = [[UIButton alloc] initWithFrame:AutoFrame((15+(i%4)*85), (47+i/4*35), 65, 25)];
        [weekButton setTitle:timeArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            weekButton.backgroundColor = RGBHex(0xFFD301);
            _lastButton = weekButton;
            weekButton.selected = YES;
            weekButton.layer.borderColor = RGBHex(0xFFD301).CGColor;
            weekButton.layer.borderWidth = 0;
        } else {
            weekButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
            weekButton.layer.borderWidth = 0.4;
            weekButton.backgroundColor = UIColor.whiteColor;
        }
        [weekButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        weekButton.titleLabel.font = FontSize(13);
        
        weekButton.layer.cornerRadius = 12.5*ScalePpth;
        weekButton.layer.masksToBounds = YES;
        weekButton.clipsToBounds = YES;
        [weekButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:weekButton];
    }
}
- (void)sureButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (!button.selected) {
            button.backgroundColor = UIColor.whiteColor;
            button.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
            button.layer.borderWidth = 0.4;
            button.backgroundColor = UIColor.whiteColor;
    } else {
        button.backgroundColor = RGBHex(0xFFD301);
        button.backgroundColor = RGBHex(0xFFD301);
        button.layer.borderColor = RGBHex(0xFFD301).CGColor;
        button.layer.borderWidth = 0;
    }
   
    _lastButton = button;
}

@end
