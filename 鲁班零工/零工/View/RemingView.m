//
//  RemingView.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/13.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "RemingView.h"

@interface RemingView ()
{
    CGPoint _startPoint;
    CGPoint _middlePoint;
    CGPoint _endPoint;
    UIColor  *_color;
}
@end

@implementation RemingView


- (instancetype)init {
    if (self = [super init]) {
        [self startPoint];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapgesture];
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews {
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(245, (KNavigationHeight + 8.0)/ScalePpth, 120, 160)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 6*ScalePpth;
    [self addSubview:whiteView];
    
    NSArray *imageArray = @[@"right_sweep",@"right_news",@"right_release",@"right_employer"];
    NSArray *infoArray = @[@"扫一扫",@"消息",@"发布求雇",@"雇主中心"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(16, (13+i*40), 15, 15)];
        leftImageView.image = [UIImage imageNamed:imageArray[i]];
        [leftImageView sizeToFit];
        [whiteView addSubview:leftImageView];
        
        UIButton *infoButton = [[UIButton alloc] initWithFrame:AutoFrame(43, (4+i*40), 100, 34)];
        [infoButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        infoButton.titleLabel.font  = FontSize(14);
        infoButton.tag = i + 100;
        infoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [infoButton setTitle:infoArray[i] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:infoButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, (40.3+i*40), 120, 0.7)];
        lineView.backgroundColor = RGBHex(0xcccccc);
        [whiteView addSubview:lineView];
    }
}

#pragma mark - method

- (void)startPoint
{
    _startPoint = CGPointMake(344*ScalePpth, 1*ScalePpth+KNavigationHeight);
    _middlePoint = CGPointMake(338*ScalePpth, 9*ScalePpth+KNavigationHeight);
    _endPoint = CGPointMake(351*ScalePpth, 9*ScalePpth+KNavigationHeight);
    _color = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);
    CGContextAddLineToPoint(context,_middlePoint.x, _middlePoint.y);
    CGContextAddLineToPoint(context,_endPoint.x, _endPoint.y);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [_color setFill]; //设置填充色
    [_color setStroke];//边框也设置为_color，否则为默认的黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}
- (void)infoButtonAction:(UIButton *)button {
    !_block ?:(_block(button.tag - 100));
}
- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
    [self removeFromSuperview];
}

@end
