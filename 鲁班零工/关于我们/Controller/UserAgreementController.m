//
//  UserAgreementController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/12/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "UserAgreementController.h"

@interface UserAgreementController ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation UserAgreementController

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 10, 355, (ScreenHeight-KNavigationHeight - 20*ScalePpth)/ScalePpth)];
        _textLabel.textColor = RGBHex(0x333333);
        _textLabel.font = FontSize(13);
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self.view addSubview:self.textLabel];
    [self netWorking];
}

- (void)netWorking {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/Protocol/privacyAgreement"] params:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]NonNull} success:^(id  _Nonnull response) {
        if (response && response[@"code"] && [response[@"code"] intValue] == 0 && response[@"data"] && [response[@"data"] count] && response[@"data"][@"privacyAgreement"]) {
            weakSelf.textLabel.text = response[@"data"][@"privacyAgreement"];
            [weakSelf.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_offset(10);
                make.right.mas_offset(-10);
            }];
        } else {
            if (response[@"msg"]) {
                [WHToast showErrorWithMessage:response[@"msg"]];
            } else {
                [WHToast showErrorWithMessage:@"暂无数据"];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}


@end
