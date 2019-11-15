
//
//  PublishContentController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "PublishOddJobsController.h"
#import "LBNavigationController.h"
#import "PublishContentController.h"
#import "PublishingServiceController.h"
#import "ServiceAuthenticationController.h"
#import "EmployerCertificationController.h"

@interface PublishContentController ()

@property (nonatomic, strong) UIButton *XButton;

@end

@implementation PublishContentController

- (UIButton *)XButton {
    if (!_XButton) {
          CGFloat space = (ScreenHeight - 74*ScalePpth);
        _XButton = [[UIButton alloc] initWithFrame:AutoFrame(171, space/ScalePpth, 34, 34)];
        [_XButton setImage:[UIImage imageNamed:@"issue_no"] forState:UIControlStateNormal];
        [_XButton addTarget:self action:@selector(XButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _XButton;
}
- (void)XButtonAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBHex(0xf0f0f0);
    [self setUpUI];
}

- (void)setUpUI {
    
    CGFloat space = (statusHeight + 60*ScalePpth);
    UIView*topView = [[UIView alloc] initWithFrame:AutoFrame(10, space/ScalePpth, 355, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    topView.layer.shadowColor = RGBHex(0x333333).CGColor;//阴影颜色
    topView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    topView.layer.shadowOpacity = 0.25;//不透明度
    topView.layer.shadowRadius = 4;//半径
    [self.view addSubview:topView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(30, 23, 55, 55)];
    imageView.layer.cornerRadius  = 27.5 *ScalePpth;
    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"issue_odd"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [topView addSubview:imageView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:AutoFrame(104, 29, 0, 0)];
    topLabel.textColor = RGBHex(0x333333);
    topLabel.text = @"发布零工";
    topLabel.font = [UIFont boldSystemFontOfSize:20 *ScalePpth];
    [topLabel sizeToFit];
    [topView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:AutoFrame(104, 62, 0, 0)];
    bottomLabel.textColor = RGBHex(0x414141);
    bottomLabel.text = @"把您的需求和工作发布出来";
    bottomLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [bottomLabel sizeToFit];
    [topView addSubview:bottomLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:AutoFrame(321, 43, 9, 15)];
    arrowImgView.image = [UIImage imageNamed:@"issue_arrow"];
    [topView addSubview:arrowImgView];
    [topView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewGesture:)]];
    [self addButtonView];
}

- (void)addButtonView {
    
    CGFloat space = (statusHeight + 180*ScalePpth);
    UIView*bottomView = [[UIView alloc] initWithFrame:AutoFrame(10, space/ScalePpth, 355, 100)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5;
    bottomView.layer.shadowColor = RGBHex(0x333333).CGColor;//阴影颜色
    bottomView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    bottomView.layer.shadowOpacity = 0.25;//不透明度
    bottomView.layer.shadowRadius = 4;//半径
    [self.view addSubview:bottomView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(30, 23, 55, 55)];
    imageView.layer.cornerRadius  = 27.5 *ScalePpth;
    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"issue_serve"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:imageView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:AutoFrame(104, 29, 0, 0)];
    topLabel.textColor = RGBHex(0x333333);
    topLabel.text = @"发布服务";
    topLabel.font = [UIFont boldSystemFontOfSize:20 *ScalePpth];
    [topLabel sizeToFit];
    [bottomView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:AutoFrame(104, 62, 0, 0)];
    bottomLabel.textColor = RGBHex(0x414141);
    bottomLabel.text = @"把您的技能和工作经验发布出来";
    bottomLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [bottomLabel sizeToFit];
    [bottomView addSubview:bottomLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:AutoFrame(321, 43, 9, 15)];
    arrowImgView.image = [UIImage imageNamed:@"issue_arrow"];
    [bottomView addSubview:arrowImgView];
    [bottomView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewGesture:)]];
    [self.view addSubview:self.XButton];
}

- (void)topViewGesture:(UITapGestureRecognizer *)gesture {
    [self real_name_authentication_query:@"0"];
}
- (void)bottomViewGesture:(UITapGestureRecognizer *)gesture {
     [self real_name_authentication_query:@"1"];
}
- (void)real_name_authentication_query:(NSString *)type {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/CardId"] params:@{@"type":type NonNull} success:^(id  _Nonnull response) {
        switch ([response[@"code"] intValue]) {
            case 0: {
                [WHToast showMessage:@"未上传身份证,请上传身份证照片" duration:1.5 finishHandler:^{
                    if (type.intValue == 0) {
                        [weakSelf toEmployerCertificationController];
                    } else {
                        [weakSelf toServiceAuthenticationController];
                    }
                }];
            }
                break;
            case 1: {
                if (type.intValue == 0) {
                    PublishOddJobsController *publishOddJobsontroller = [PublishOddJobsController new];
                    publishOddJobsontroller.isPresent = YES;
                    LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:publishOddJobsontroller];
                    [weakSelf presentViewController:navi animated:YES completion:nil];
                } else {
                    PublishingServiceController *publishingServiceController = [PublishingServiceController new];
                    publishingServiceController.isPresent = YES;
                    LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:publishingServiceController];
                    [weakSelf presentViewController:navi animated:YES completion:nil];
                }
            }
                break;
            case 2: {
                [WHToast showErrorWithMessage:@"审核失败,请重新上传身份证等资料" duration:1.5 finishHandler:^{
                    if (type.intValue == 0) {
                        [weakSelf toEmployerCertificationController];
                    } else {
                        [weakSelf toServiceAuthenticationController];
                    }
                }];
            }
                break;
            case 3: {
                [WHToast showErrorWithMessage:@"已上传身份证没审核,请等待审核通过" duration:1.5 finishHandler:^{
                    if (type.intValue == 0) {
                        [weakSelf toEmployerCertificationController];
                    } else {
                        [weakSelf toServiceAuthenticationController];
                    }
                }];
            }
                break;
            default:
                break;
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES];
}

- (void)toEmployerCertificationController {
        EmployerCertificationController *employerCertificationController = [EmployerCertificationController new];
        employerCertificationController.isPresent = YES;
        LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:employerCertificationController];
        [self presentViewController:navi animated:YES completion:nil];
}
- (void)toServiceAuthenticationController {
        ServiceAuthenticationController *serviceAuthenticationvc = [ServiceAuthenticationController new];
        serviceAuthenticationvc.isPresent = YES;
        LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:serviceAuthenticationvc];
        [self presentViewController:navi animated:YES completion:nil];
}
@end
