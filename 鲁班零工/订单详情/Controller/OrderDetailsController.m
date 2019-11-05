//
//  OrderDetailsController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ChatController.h"
#import "ToEvaluateController.h"
#import "CancleOrderController.h"
#import "OrderDetailsController.h"

@interface OrderDetailsController ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UILabel *waitLabel;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *grayView2;
@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation OrderDetailsController {
    UIView *bottomCoverView;
    UIView *footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = RGBHex(0xF7F7F7);
    [self setUPUI];
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubViews];
    }
    return _grayView;
}
- (UIView *)grayView2 {
    if (!_grayView2) {
        _grayView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _grayView2.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addGrayView2SubViews];
    }
    return _grayView2;
}
- (void)addGrayView2SubViews {
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(32.5, 230, 310, 232)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 10;
    [_grayView2 addSubview:whiteView];;
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:AutoFrame(120, 19, 75, 18)];
    tipsLabel.textColor = RGBHex(0x333333);
    tipsLabel.font = [UIFont boldSystemFontOfSize:18 *ScalePpth];
    tipsLabel.text = @"温馨提示";
    [whiteView addSubview:tipsLabel];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:AutoFrame(271, 5, 34, 34)];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14 *ScalePpth];
    [closeButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonPaymentAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:closeButton];
    
    UILabel *sureLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 97, 310, 19)];
    sureLabel.textColor = RGBHex(0x333333);
    sureLabel.font = [UIFont systemFontOfSize:19 *ScalePpth];
    sureLabel.text = @"您确认雇主已经付款？";
    sureLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:sureLabel];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:AutoFrame(83, 177, 143.5, 34)];
    sureButton.backgroundColor = RGBHex(0xFFD301);
    sureButton.titleLabel.font  = FontSize(16);
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitleColor: RGBHex(0x333333) forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5;
    [whiteView addSubview:sureButton];
}
- (void)addSubViews {
    CGFloat space = ScreenHeight - 258 *ScalePpth;
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, space, ScreenWidth, 258 *ScalePpth)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    [_grayView addSubview:whiteView];;
    
    UILabel *reasonsForRefusalLabel = [[UILabel alloc] initWithFrame:AutoFrame(150, 23, 75, 16)];
    reasonsForRefusalLabel.textColor = RGBHex(0x000000);
    reasonsForRefusalLabel.font = FontSize(16);
    reasonsForRefusalLabel.text = @"拒绝原因";
    [whiteView addSubview:reasonsForRefusalLabel];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:AutoFrame(330, 15, 30, 34)];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14 *ScalePpth];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [closeButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:closeButton];
    
    NSArray *typeArray = @[@"工种不匹配",@"价格低",@"时间冲突",@"其他"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame(12, (84 + i *48), 100, 14)];
        typeLabel.textColor = RGBHex(0x000000);
        typeLabel.font = FontSize(14);
        typeLabel.text = typeArray[i];
        [whiteView addSubview:typeLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0,(113.5 + i *48), 375, 0.65)];
        line.backgroundColor = RGBHex(0xE7E7E7);
        [whiteView addSubview:line];
       
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(328, (66.5 + i *48), 47, 47)];
        button.userInteractionEnabled = YES;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:button];
        if (i == 0) {
            _lastButton = button;
            [button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
        }
    }
}

- (void)setUPUI {
    
    UIView *topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 80)];
    topView.backgroundColor = RGBHex(0xFFAA1A);
    [self.view addSubview:topView];
    
    UIImageView *dateImageView = [[UIImageView alloc] initWithFrame:AutoFrame(43, 20, 19, 20)];
    dateImageView.image = [UIImage imageNamed:@"icon"];
    [topView addSubview:dateImageView];
    
    _waitLabel = [[UILabel alloc] initWithFrame:AutoFrame(68, 23, 100, 15)];
    _waitLabel.text =  @"等待雇主同意";
    _waitLabel.textAlignment = NSTextAlignmentRight;
    _waitLabel.font = [UIFont systemFontOfSize:15*ScalePpth];
    _waitLabel.textColor = RGBHex(0xFFffff);
    [topView addSubview:_waitLabel];
    
    UIView *coverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 60, 360, 130)];
    coverView.backgroundColor = RGBHex(0xFFffff);
    coverView.layer.cornerRadius = 5;
    [self.view addSubview:coverView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(15, 22, 45, 45)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"details_head"];
    imageView.layer.cornerRadius = 22.5*ScalePpth;
    [coverView addSubview:imageView];
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:AutoFrame(70, 64, 100, 12)];
    rateLabel.text =  @"好评率：88%";
    rateLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    rateLabel.textColor = RGBHex(0xcccccc);
    [coverView addSubview:rateLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(70, 17, 100, 17)];
    nameLabel.text =  @"郑婷婷";
    nameLabel.font = [UIFont boldSystemFontOfSize:17*ScalePpth];
    nameLabel.textColor = RGBHex(0x333333);
    [coverView addSubview:nameLabel];
    
    UILabel *dealLabel = [[UILabel alloc] initWithFrame:AutoFrame(70, 43, 100, 12)];
    dealLabel.text =  @"成交单35单";
    dealLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    dealLabel.textColor = RGBHex(0x333333);
    [coverView addSubview:dealLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 90, 360, 0.5)];
    lineView.backgroundColor = RGBHex(0xEEEEEE);
    [coverView addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:AutoFrame(180, 97.5, 0.5, 25)];
    lineView2.backgroundColor = RGBHex(0xEEEEEE);
    [coverView addSubview:lineView2];
    
    UIButton *contactButton = [[UIButton alloc] initWithFrame:AutoFrame(50, 98.5, 100, 20)];
    [contactButton setImage:[UIImage imageNamed:@"details_relation"] forState:UIControlStateNormal];
    [contactButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15*ScalePpth)];
    [contactButton setTitle:@"联系雇主" forState:UIControlStateNormal];
    contactButton.titleLabel.font = FontSize(13);
    [contactButton addTarget:self action:@selector(contactButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contactButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [coverView addSubview:contactButton];
    
    UIButton *playPhoneButton = [[UIButton alloc] initWithFrame:AutoFrame(230, 98.5, 100, 20)];
    [playPhoneButton setImage:[UIImage imageNamed:@"details_call"] forState:UIControlStateNormal];
    [playPhoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    [playPhoneButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15*ScalePpth)];
    playPhoneButton.titleLabel.font = FontSize(13);
    [playPhoneButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [coverView addSubview:playPhoneButton];
    
    UIView *middlecoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 195, 360, 80)];
    middlecoverView.backgroundColor = RGBHex(0xFFffff);
    middlecoverView.layer.cornerRadius = 5;
    [self.view addSubview:middlecoverView];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, 40, 360, 0.5)];
    lineView3.backgroundColor = RGBHex(0xEEEEEE);
    [middlecoverView addSubview:lineView3];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:AutoFrame(16, 12.5, 12, 15)];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = [UIImage imageNamed:@"details_site"];
    [middlecoverView addSubview:imageView2];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:AutoFrame(39, 14.5, 280, 12)];
    locationLabel.text =  @"历下区燕山街道东源大厦(解放路）";
    locationLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    locationLabel.textColor = RGBHex(0x333333);
    [middlecoverView addSubview:locationLabel];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:AutoFrame(16, 51, 12, 15)];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.image = [UIImage imageNamed:@"details_time"];
    [middlecoverView addSubview:imageView3];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(39, 52, 280, 12)];
    timeLabel.text =  @"8:30:00-10:30:00";
    timeLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    timeLabel.textColor = RGBHex(0x333333);
    [middlecoverView addSubview:timeLabel];
    
    bottomCoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 280, 360, 120)];
    bottomCoverView.backgroundColor = RGBHex(0xFFffff);
    bottomCoverView.layer.cornerRadius = 5;
    [self.view addSubview:bottomCoverView];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, (40+ i*40.5), 360, 0.5)];
        lineView3.backgroundColor = RGBHex(0xEEEEEE);
        [bottomCoverView addSubview:lineView3];
    }
    [bottomCoverView addSubview:[self typeLabel:@"保险销售" :14.5]];
    [bottomCoverView addSubview:[self typeLabel:@"创建时间" :54.5]];
    [bottomCoverView addSubview:[self typeLabel:@"订单编号" :95]];
    
    [bottomCoverView addSubview:[self rightLabel:@"300元/天" :14.5]];
    [bottomCoverView addSubview:[self rightLabel:@"2019-09-25 09:24:39" :55.5]];
    [bottomCoverView addSubview:[self rightLabel:@"25663330032121120" :96]];
    [self addFooterView];
}

- (void)addFooterView {
    
    footerView = [[UIView alloc] initWithFrame:AutoFrame(0, (self.view.bounds.size.height - 47*ScalePpth - KNavigationHeight)/ScalePpth, 375, 47)];
    footerView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:footerView];
    
    _leftButton = [[UIButton alloc] initWithFrame:AutoFrame(121, 10.5, 72, 26)];
    _leftButton.backgroundColor = RGBHex(0xffffff);
    _leftButton.clipsToBounds = YES;
    _leftButton.hidden = YES;
    _leftButton.layer.cornerRadius = 13 *ScalePpth;
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.borderWidth = 0.5;
    _leftButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_leftButton setTitle:@"开工" forState:UIControlStateNormal];
    [_leftButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_leftButton];
    
    _middleButton = [[UIButton alloc] initWithFrame:AutoFrame(204, 10.5, 72, 26)];
    _middleButton.backgroundColor = RGBHex(0xffffff);
    _middleButton.clipsToBounds = YES;
    _middleButton.hidden = YES;
    _middleButton.layer.cornerRadius = 13 *ScalePpth;
    _middleButton.layer.masksToBounds = YES;
    _middleButton.layer.borderWidth = 0.5;
    _middleButton.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    _middleButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [_middleButton setTitle:@"确认完工" forState:UIControlStateNormal];
    [_middleButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_middleButton addTarget:self action:@selector(sureFanishedAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_middleButton];
     [self addStateButton:footerView];
}

- (void)addStateButton:(UIView *)footerView {
    UIButton *_stateButton = [[UIButton alloc] initWithFrame:AutoFrame(287, 10.5, 72, 26)];
    _stateButton.backgroundColor = RGBHex(0xFED452);
    _stateButton.clipsToBounds = YES;
    _stateButton.layer.cornerRadius = 13 *ScalePpth;
    _stateButton.layer.masksToBounds = YES;
    _stateButton.titleLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    if (self.detail_Type == OrderDetail_Type_Cancle) {
        _leftButton.hidden = YES;
        _middleButton.hidden = YES;
        _waitLabel.text = @"等待雇主同意";
        [_stateButton setTitle:@"取消订单" forState:UIControlStateNormal];
    } else if (self.detail_Type == OrderDetail_Type_Agree) {
        _leftButton.hidden = YES;
        _middleButton.hidden = NO;
        _waitLabel.text = @"邀请等待同意";
        [_middleButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [_stateButton setTitle:@"同意" forState:UIControlStateNormal];
    } else if (self.detail_Type == OrderDetail_Type_Navigation) {
        _leftButton.hidden = NO;
        _middleButton.hidden = NO;
        _waitLabel.text = @"进行中";
        [_leftButton setTitle:@"开工" forState:UIControlStateNormal];
        [_middleButton setTitle:@"确认完工" forState:UIControlStateNormal];
        [_stateButton setTitle:@"导航" forState:UIControlStateNormal];
    } else if (self.detail_Type == OrderDetail_Type_CustomerService) {
        _leftButton.hidden = YES;
        _middleButton.hidden = NO;
        _waitLabel.text = @"待付款";
         [_middleButton setTitle:@"确认付款" forState:UIControlStateNormal];
         [_stateButton setTitle:@"联系客服" forState:UIControlStateNormal];
    } else if (self.detail_Type == OrderDetail_Type_Delete) {
        _leftButton.hidden = YES;
        _middleButton.hidden = NO;
        _waitLabel.text = @"已完成";
        [_middleButton setTitle:@"去评价" forState:UIControlStateNormal];
        [_stateButton setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    
    [_stateButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_stateButton];
}

- (UILabel *)typeLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, height, 100, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x333333);
    label.text = text;
    return label;
}

- (UILabel *)rightLabel:(NSString *)text :(CGFloat )height {
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(200, height, 145, 12)];
    label.font = FontSize(12);
    label.textColor = RGBHex(0x999999);
    label.text = text;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

- (void)cancleButtonAction:(UIButton *)button {
    if (self.detail_Type == OrderDetail_Type_Cancle) {
        [self.navigationController pushViewController:[CancleOrderController new] animated:YES];
    } else if (self.detail_Type == OrderDetail_Type_Agree) {
        // 同意
    }
}
- (void)contactButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[ChatController new] animated:YES];
}
- (void)startButtonAction:(UIButton *)button {
}
- (void)sureFanishedAction:(UIButton *)button {
    if (self.detail_Type == OrderDetail_Type_Agree) {
        // 拒绝
        _waitLabel.text =  @"已拒绝";
        [footerView removeFromSuperview];
        [[GlobalSingleton gS_ShareInstance].systemWindow addSubview:self.grayView];
    } else if (self.detail_Type == OrderDetail_Type_CustomerService) {
        [[GlobalSingleton gS_ShareInstance].systemWindow addSubview:self.grayView2];
    } else if (self.detail_Type == OrderDetail_Type_Delete) {
        [self.navigationController pushViewController:[ToEvaluateController new] animated:YES];
    }
}
- (void)closeButtonAction:(UIButton *)button {
    if (self.detail_Type == OrderDetail_Type_Agree) {
        // 拒绝
        [_grayView removeFromSuperview];
    }
}
- (void)buttonAction:(UIButton *)button {
    [_lastButton setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    _lastButton = button;
    bottomCoverView.frame = AutoFrame(7.5, 280, 360, 161.5);
    [bottomCoverView addSubview:[self typeLabel:@"拒绝原因" :135.5]];
    [bottomCoverView addSubview:[self rightLabel:@"工种不匹配" :135.5]];
}
- (void)closeButtonPaymentAction:(UIButton *)button {
    [_grayView2 removeFromSuperview];
}
- (void)sureButtonAction:(UIButton *)button {
    [_grayView2 removeFromSuperview];
}
@end
