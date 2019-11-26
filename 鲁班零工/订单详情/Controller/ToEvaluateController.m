//
//  ToEvaluateController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/24.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "HCRatingView.h"
#import "ToEvaluateController.h"

@interface ToEvaluateController () <HCRatingViewDelegate,UITextViewDelegate>

@property  UITextView *textView;

@property (nonatomic, strong)HCRatingView *ratingView1;
@property (nonatomic, strong)HCRatingView *ratingView2;

@end

@implementation ToEvaluateController {
    NSInteger rating1;
    NSInteger rating2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"去评价";
    self.view.backgroundColor = RGBHex(0xf0f0f0);
    rating1 = rating2 = 5;
    UIView *topCoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 10, 360, 120)];
    topCoverView.backgroundColor = RGBHex(0xFfffff);
    topCoverView.layer.cornerRadius = 5;
    [self.view addSubview:topCoverView];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *lineView3 = [[UIView alloc] initWithFrame:AutoFrame(0, (40+ i*40.5), 360, 0.5)];
        lineView3.backgroundColor = RGBHex(0xEEEEEE);
        [topCoverView addSubview:lineView3];
    }
    
    [topCoverView addSubview:[self typeLabel:@"雇主姓名" :14.5]];
    [topCoverView addSubview:[self typeLabel:@"工作名称" :54.5]];
    [topCoverView addSubview:[self typeLabel:@"工资" :95]];
    NSString *name = _model.name?:_detailModel.name;
    NSString *orderOrderName = _model.orderOrderName?:_detailModel.workName;
    NSString *orderSalary = _model.orderSalary?:_detailModel.salary;
    NSString *orderSalaryDay = _model.orderSalaryDay?:_detailModel.salaryDay;
    [topCoverView addSubview:[self rightLabel:NoneNull(name) :14.5]];
    [topCoverView addSubview:[self rightLabel:orderOrderName :55.5]];
    [topCoverView addSubview:[self rightLabel:[NSString stringWithFormat:@"%@/%@",orderSalary,orderSalaryDay] :96]];
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
    UIView *bottomCoverView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 135, 360, 226)];
    bottomCoverView.backgroundColor = RGBHex(0xFfffff);
    bottomCoverView.layer.cornerRadius = 5;
    [self.view addSubview:bottomCoverView];
    [bottomCoverView addSubview:[self typeLabel:@"工作评价" :18.5]];
    [bottomCoverView addSubview:[self typeLabel:@"雇主评价" :51.5]];
    _ratingView1 = [self addHCRatingView:9];
    [bottomCoverView addSubview:_ratingView1];
    _ratingView2 = [self addHCRatingView:42];
    [bottomCoverView addSubview:_ratingView2];
    
    _textView = [[UITextView alloc] initWithFrame:AutoFrame(7.5, 79, 345, 127)];
    _textView.clipsToBounds = YES;
    _textView.delegate = self;
    _textView.text = @"请输入您的评价内容";
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 2 *ScalePpth;
    _textView.backgroundColor = RGBHex(0xFAFAFA);
    _textView.textColor = RGBHex(0xCCCCCC);
    [bottomCoverView addSubview:_textView];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, self.view.bounds.size.height - 193*ScalePpth - KNavigationHeight, 300*ScalePpth, 45*ScalePpth)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    submitButton.titleLabel.font = FontSize(17);
    submitButton.backgroundColor = RGBHex(0xFFD301);
    submitButton.layer.cornerRadius = 45.0/2*ScalePpth;
    submitButton.layer.masksToBounds = YES;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}
- (void)submitButtonAction:(UIButton *)button {
    NSString *idName = _model.idName?:_detailModel.idName;
    NSString *result = _textView.text;
    if ([result containsString:@"请输"]) {
        result = @"";
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingFormat:@"/WorkerCore/EvaluationButton"] params:@{
        @"id":NoneNull(idName),
        @"workEvaluation":@(rating1),
        @"workerEvaluation":@(rating2),
        @"EvaluationInfo":NoneNull(result),
    } success:^(id  _Nonnull response) {
        if (response && response[@"code"] && [response[@"code"] intValue] == 0) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            if (response[@"msg"]) {
               [WHToast showErrorWithMessage:response[@"msg"]];
            } else {
               [WHToast showErrorWithMessage:@"评价失败"];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES];
}
- (HCRatingView *)addHCRatingView:(CGFloat)height {
    HCRatingView *ratingView = [[HCRatingView alloc] initWithFrame:AutoFrame(230, height, 140, 30)];
    ratingView.isFull = NO; //设置是否允许半颗星
    WeakSelf;
    [ratingView setImagesDeselected:@"details_no_collected" partlySelected:@"星3" fullSelected:@"details_collected" userInteractionEnabled:YES andDelegate:weakSelf];
    [ratingView disPlayRating:5];//设置默认分数    
    return ratingView;
}
-(void) ratingChanged:(float)newRating :(NSObject *)ratingView {
    if (ratingView == _ratingView1) {
        rating1 = newRating;
    } else {
        rating2 = newRating;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textView endEditing:YES];
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入您的评价内容"]) {
        textView.text = @"";
        textView.textColor = RGBHex(0x333333);
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入您的评价内容"]) {
        textView.textColor = RGBHex(0xcccccc);
    }
    if (textView.text.length == 0 ||([textView.text containsString:@"请输入"])) {
        textView.text = @"请输入您的评价内容";
        textView.textColor = RGBHex(0xcccccc);
    }
}

@end
