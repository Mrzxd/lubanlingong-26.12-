
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


@end

@implementation CancleOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"取消订单";
    
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
    
    [topCoverView addSubview:[self typeLabel:@"保险销售" :14.5]];
    [topCoverView addSubview:[self typeLabel:@"创建时间" :54.5]];
    [topCoverView addSubview:[self typeLabel:@"订单编号" :95]];
    
    [topCoverView addSubview:[self rightLabel:@"300元/天" :14.5]];
    [topCoverView addSubview:[self rightLabel:@"2019-09-25 09:24:39" :55.5]];
    [topCoverView addSubview:[self rightLabel:@"25663330032121120" :96]];
    
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
    [self.view addSubview:submitButton];
}
- (void)setUpimageButton:(UIView *)coverView {
    _imageButton = [[UIButton alloc] initWithFrame:AutoFrame(7.5, 233.5, 100, 100)];
    [_imageButton setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
    _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageButton.tag = 300;
    [_imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:_imageButton];
    
    _imageButton1 = [[UIButton alloc] initWithFrame:AutoFrame(129.5, 233.5, 100, 100)];
    _imageButton1.hidden = YES;
    _imageButton1.tag = 301;
    [_imageButton1 setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
    [_imageButton1 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [coverView addSubview:_imageButton1];
    
    _imageButton2 = [[UIButton alloc] initWithFrame:AutoFrame(251.5, 233.5, 100, 100)];
    _imageButton2.hidden = YES;
    _imageButton2.tag = 302;
    [_imageButton2 setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
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
        if (image) {
            [button setImage:image forState:UIControlStateNormal];
            if (button.tag == 300) {
                weakSelf.imageButton1.hidden = NO;
            } else if (button.tag == 301) {
                weakSelf.imageButton2.hidden = NO;
            }
                button.enabled = NO;
        }
    }];
}


@end
