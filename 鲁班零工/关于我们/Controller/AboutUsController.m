//
//  AboutUsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "PrivacyProtocolController.h"
#import "UserAgreementController.h"
#import "AboutUsController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController {
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}
- (void)addSubViews {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(152.5*ScalePpth, statusHeight + 94*ScalePpth, 70*ScalePpth, 70*ScalePpth)];
    imageView.image = [UIImage imageNamed:@"register_logo"];
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 7 *ScalePpth;
    [self.view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 194, 375, 16)];
    nameLabel.text = @"鲁班零工";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.font = FontSize(16);
    [self.view addSubview:nameLabel];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 214, 375, 11)];
    versionLabel.text = @"v1.0.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = RGBHex(0x999999);
    versionLabel.font = FontSize(11);
    [self.view addSubview:versionLabel];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:AutoFrame(20, (312*ScalePpth +statusHeight)/ScalePpth, 100, 14)];
    userLabel.text = @"用户协议";
    userLabel.textColor = RGBHex(0x333333);
    userLabel.font = FontSize(14);
    [self.view addSubview:userLabel];
    
    UILabel *privacyLabel = [[UILabel alloc] initWithFrame:AutoFrame(20, (362*ScalePpth +statusHeight)/ScalePpth, 100, 14)];
    privacyLabel.text = @"隐私协议";
    privacyLabel.textColor = RGBHex(0x333333);
    privacyLabel.font = FontSize(14);
    [self.view addSubview:privacyLabel];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, (343.5*ScalePpth +statusHeight + i *50)/ScalePpth, 375, 0.6)];
        line.backgroundColor = RGBHex(0xF0F0F0);
        [self.view addSubview:line];
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(300, (304*ScalePpth +statusHeight + i *50)/ScalePpth, 28, 31)];
        [button setImage:[UIImage imageNamed:@"issue_arrows"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 75 *ScalePpth, 0, 0)];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:button];
        UIButton *buttons = [[UIButton alloc] initWithFrame:AutoFrame(0, (299*ScalePpth +statusHeight + i *50)/ScalePpth, 375, 41)];
        [buttons addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        buttons.tag = 100 + i;
        [self.view addSubview:buttons];
    }
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, (ScreenHeight - 22*ScalePpth-KNavigationHeight)/ScalePpth, 375, 10)];
    companyLabel.text = @"慧族网络科技发展有限公司技术支持";
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.textColor = RGBHex(0xCCCCCC);
    companyLabel.font = FontSize(10);
    [self.view addSubview:companyLabel];
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {
        UserAgreementController *uac = [UserAgreementController new];
        [self.navigationController pushViewController:uac animated:YES];
    } else {
        PrivacyProtocolController*uac = [PrivacyProtocolController new];
        [self.navigationController pushViewController:uac animated:YES];
    }
}

@end
