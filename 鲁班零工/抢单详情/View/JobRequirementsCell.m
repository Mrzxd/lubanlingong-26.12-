//
//  JobRequirementsCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/16.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "JobRequirementsCell.h"

@implementation JobRequirementsCell {
    UILabel *remindContentLabel;
    UILabel *timeContentLabel;
    UILabel *placeContentLabel;
    UILabel *timeLabel;
    UILabel *placeLabel;
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
    
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(8, 15, 100, 14)];
    remindLabel.textColor = UIColor.blackColor;
    remindLabel.font = FontSize(14);
    remindLabel.text = @"【工作内容】";
    [self.contentView addSubview:remindLabel];
    
    remindContentLabel = [[UILabel alloc] initWithFrame:AutoFrame(14, 43, 0, 0)];
    remindContentLabel.numberOfLines = 0;
    remindContentLabel.textColor = RGBHex(0x999999);
    remindContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    remindContentLabel.text = @"1.必须满18周岁\n2.需自备电动车\n3.工作地点在市区，在郊区或者县区的就不要报名了";
    remindContentLabel.font = FontSize(12);
    [self.contentView addSubview:remindContentLabel];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(8, 15, 100, 14)];
    timeLabel.textColor = UIColor.blackColor;
    timeLabel.font = FontSize(14);
    timeLabel.text = @"【员工要求】";
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8*ScalePpth);
        make.top.equalTo(remindContentLabel.mas_bottom).offset(14*ScalePpth);
    }];
    
    timeContentLabel = [[UILabel alloc] initWithFrame:AutoFrame(14, 136, 0, 0)];
    timeContentLabel.numberOfLines = 0;
    timeContentLabel.textColor= RGBHex(0x999999);
    timeContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    timeContentLabel.font = FontSize(12);
    [self.contentView addSubview:timeContentLabel];
    
    placeLabel = [[UILabel alloc] initWithFrame:AutoFrame(8, 15, 100, 14)];
    placeLabel.textColor = UIColor.blackColor;
    placeLabel.font = FontSize(14);
    placeLabel.text = @"【工作地点】";
    [self.contentView addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8*ScalePpth);
        make.top.equalTo(timeContentLabel.mas_bottom).offset(14*ScalePpth);
    }];
    
    placeContentLabel = [[UILabel alloc] initWithFrame:AutoFrame(14, 136, 0, 0)];
    placeContentLabel.numberOfLines = 0;
    placeContentLabel.textColor = RGBHex(0x999999);
    placeContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    placeContentLabel.font = FontSize(12);
    [self.contentView addSubview:placeContentLabel];
}

- (void)setDetailModel:(GrabdDetailsModel *)detailModel {
    _detailModel = detailModel;
    if (detailModel) {
        remindContentLabel.text = NoneNull(detailModel.workContent);
        [remindContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14*ScalePpth);
            make.top.mas_equalTo(43*ScalePpth);
            make.width.mas_equalTo((375-28)*ScalePpth);
        }];
        timeContentLabel.text = NoneNull(detailModel.personnelClaim);
        [timeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14*ScalePpth);
            make.top.equalTo(timeLabel.mas_bottom).offset(15*ScalePpth);
            make.width.mas_equalTo((375-28)*ScalePpth);
        }];
         placeContentLabel.text = NoneNull(detailModel.workPositino);
        [placeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(14*ScalePpth);
               make.top.equalTo(placeLabel.mas_bottom).offset(15*ScalePpth);
               make.width.mas_equalTo((375-28)*ScalePpth);
               make.bottom.mas_equalTo(-15*ScalePpth);
           }];
    }
}






@end
