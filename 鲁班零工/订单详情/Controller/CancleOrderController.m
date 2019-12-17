
//
//  CancleOrderController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "CancleOrderController.h"
#import "UIViewController+ImagePicker.h"

@interface CancleOrderController () <UITextViewDelegate>

@property  UITextView *textView;

@property (nonatomic, strong) UIButton *imageButton1;
@property (nonatomic, strong) UIButton *imageButton2;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) NSMutableArray *mutableStringBase64Array;

@end

@implementation CancleOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"取消订单";
    _mutableStringBase64Array = NSMutableArray.array;
    self.view.backgroundColor = RGBHex(0xf0f0f0);
    
    UIView *topCoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 10, 360, 120)];
    topCoverView.backgroundColor = RGBHex(0xFfffff);
    topCoverView.layer.cornerRadius = 5;
    [self.view addSubview:topCoverView];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, (40+ i*40.5), 360, 0.5)];
        lineView3.backgroundColor = RGBHex(0xEEEEEE);
        [topCoverView addSubview:lineView3];
    }
    NSString *orderOrderName =_jobModel.orderOrderName?:_detailModel.orderOrderName;
    NSString *orderSalary =_jobModel.orderSalary?:_detailModel.orderSalary;
    NSString *orderSalaryDay =_jobModel.orderSalaryDay?:_detailModel.orderSalaryDay;
    NSString *orderNumbering =_jobModel.orderNumbering?:_detailModel.orderNumbering;
    NSString *creatOrderTime =_jobModel.creatOrderTime?:_detailModel.creatOrderTime;
    [topCoverView addSubview:[self typeLabel:NoneNull(orderOrderName) :14.5]];
    [topCoverView addSubview:[self typeLabel:@"创建时间" :54.5]];
    [topCoverView addSubview:[self typeLabel:@"订单编号" :95]];
    
    [topCoverView addSubview:[self rightLabel:[NSString stringWithFormat:@"%@/%@",NoneNull(orderSalary),NoneNull(orderSalaryDay)] :14.5]];
    [topCoverView addSubview:[self rightLabel:[self getTimeFromTimestamp:NoneNull(creatOrderTime)] :55.5]];
    [topCoverView addSubview:[self rightLabel:NoneNull(orderNumbering) :96]];
    
    [self addSubViews];
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

- (void)addSubViews {
    
    UIView *coverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 134, 360, 347)];
    coverView.backgroundColor = RGBHex(0xFfffff);
    coverView.layer.cornerRadius = 5;
    [self.view addSubview:coverView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, 13, 100, 14)];
    label.font = [UIFont boldSystemFontOfSize:14 *ScalePpth];
    label.textColor = RGBHex(0x333333);
    label.text = @"取消原因";
    [coverView addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 40, 360, 0.5)];
    lineView.backgroundColor = RGBHex(0xEEEEEE);
    [coverView addSubview:lineView];
    
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15.5, 55.5, 80, 12)];
    _nameLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"原因描述";
    [coverView addSubview:_nameLabel];
    
    _textView = [[UITextView alloc] initWithFrame:AutoFrame(7.5, 72.5, 345, 127)];
    _textView.clipsToBounds = YES;
    _textView.delegate = self;
    _textView.text = @"用明确清晰的语言描述你的需求";
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 2 *ScalePpth;
    _textView.backgroundColor = RGBHex(0xFAFAFA);
    _textView.textColor = RGBHex(0xCCCCCC);
    [coverView addSubview:_textView];
    
    UILabel *uploadLabel = [[UILabel alloc] initWithFrame:AutoFrame(15.5, 209.5, 80, 12)];
    uploadLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
    uploadLabel.textColor = RGBHex(0x333333);
    uploadLabel.text = @"上传照片";
    [coverView addSubview:uploadLabel];
    
    [self setUpimageButton:coverView];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, self.view.frame.size.height - 102*ScalePpth - KNavigationHeight, 300*ScalePpth, 45*ScalePpth)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    submitButton.titleLabel.font = FontSize(17);
    submitButton.backgroundColor = RGBHex(0xFFD301);
    submitButton.layer.cornerRadius = 45.0/2*ScalePpth;
    submitButton.layer.masksToBounds = YES;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}
- (void)submit:(UIButton *)button {
    WeakSelf;
         NSString *idName = _jobModel.idName?:_detailModel.idName;
    if (_isEmployer) {
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/employerCore/CancelSkill"] params:@{
            @"id":NoneNull(idName),
            @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
            @"msg":NoneNull(_textView.text),
            @"database":_mutableStringBase64Array
        } success:^(id  _Nonnull response) {
            if (response && [response[@"code"] intValue] == 0) {
                [WHToast showSuccessWithMessage:@"取消成功" duration:1 finishHandler:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                if (response[@"msg"]) {
                    [WHToast showErrorWithMessage:response[@"msg"]];
                } else {
                    [WHToast showErrorWithMessage:@"取消失败"];
                }
            }
        } fail:^(NSError * _Nonnull error) {
            [WHToast showErrorWithMessage:@"网络错误"];
        } showHUD:YES];
        
        return;
    }
  
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/CancelWork"] params:@{
        @"id":NoneNull(idName),
        @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
        @"msg":NoneNull(_textView.text),
        @"database":_mutableStringBase64Array
    } success:^(id  _Nonnull response) {
        if (response && [response[@"code"] intValue] == 0) {
            [WHToast showSuccessWithMessage:@"取消成功" duration:1 finishHandler:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            if (response[@"msg"]) {
                [WHToast showErrorWithMessage:response[@"msg"]];
            } else {
                [WHToast showErrorWithMessage:@"取消失败"];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (void)setUpimageButton:(UIView *)coverView {
    _imageButton = [[UIButton alloc] initWithFrame:AutoFrame(7.5, 233.5, 100, 100)];
    [_imageButton setImage:[UIImage imageNamed:@"uploading(1)"] forState:UIControlStateNormal];
    _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageButton.tag = 300;
    [_imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:_imageButton];
    
    _imageButton1 = [[UIButton alloc] initWithFrame:AutoFrame(129.5, 233.5, 100, 100)];
    _imageButton1.hidden = YES;
    _imageButton1.tag = 301;
    [_imageButton1 setImage:[UIImage imageNamed:@"uploading(1)"] forState:UIControlStateNormal];
    [_imageButton1 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [coverView addSubview:_imageButton1];
    
    _imageButton2 = [[UIButton alloc] initWithFrame:AutoFrame(251.5, 233.5, 100, 100)];
    _imageButton2.hidden = YES;
    _imageButton2.tag = 302;
    [_imageButton2 setImage:[UIImage imageNamed:@"uploading(1)"] forState:UIControlStateNormal];
    [_imageButton2 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [coverView addSubview:_imageButton2];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textView endEditing:YES];
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"用明确清晰的语言描述你的需求"]) {
        textView.text = @"";
        textView.textColor = RGBHex(0x333333);
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"用明确清晰的语言描述你的需求"]) {
        textView.textColor = RGBHex(0xcccccc);
    }
    if (textView.text.length == 0 ||([textView.text containsString:@"用明确"])) {
        textView.text = @"用明确清晰的语言描述你的需求";
        textView.textColor = RGBHex(0xcccccc);
    }
}
- (void)imageButtonAction:(UIButton *)button {
    WeakSelf;
    [self pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
        NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        if (image) {
            [weakSelf.mutableStringBase64Array addObject:base64String];
            [button setImage:image forState:UIControlStateNormal];
            if (button.tag == 300) {
                weakSelf.imageButton1.hidden = NO;
            } else if (button.tag == 301) {
                weakSelf.imageButton2.hidden = NO;
            } else {
                
            }
                button.userInteractionEnabled = NO;
        }
    }];
}


@end
