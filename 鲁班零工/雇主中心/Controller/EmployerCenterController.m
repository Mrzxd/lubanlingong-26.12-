
//
//  EmployerCenterController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ThePersonIHiredController.h"
#import "EmployerCenterController.h"
#import "TheOddJobsIReleasedController.h"

@interface EmployerCenterController ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation EmployerCenterController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 182)];
        _headerView.backgroundColor = RGBHex(0xFFB924);
        UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 140, 375, 42)];
        bottomView.backgroundColor = RGBHex(0xF3F3F3);
        [_headerView addSubview:bottomView];
        [self addSubView];
    }
    return _headerView;
}
- (void)addSubView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(18, 6.5, 57, 57)];
    imageView.layer.cornerRadius = 28.5*ScalePpth;
    imageView.image = [UIImage imageNamed:@"head"];
    [_headerView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(86.5, 13, 100, 18)];
    nameLabel.font = FontSize(17.7);
    nameLabel.textColor = RGBHex(0xffffff);
    nameLabel.text =@"用户名名称";
    [_headerView addSubview:nameLabel];
    
    UILabel *evalutionLabel = [[UILabel alloc] initWithFrame:AutoFrame(86.5, 39, 105, 19)];
    evalutionLabel.font = FontSize(12.5);
    evalutionLabel.textColor = RGBHex(0xffffff);
    evalutionLabel.text =@"好评率：88.0%";
    evalutionLabel.backgroundColor = RGBHexAlpha(0x000000, 0.16);
    evalutionLabel.layer.cornerRadius = 9.5*ScalePpth;
    evalutionLabel.layer.masksToBounds = YES;
    evalutionLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:evalutionLabel];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(10, 82, 355, 90)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.layer.cornerRadius = 5;
    [_headerView addSubview:whiteView];
    
    NSArray *numArray = @[@"89",@"21",@"12",@"289"];
    NSArray *typeArray =  @[@"待审核",@"已发布",@"进行中",@"已完成"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame((26 + i*(46+42)), 26, 42, 18)];
        numLabel.font = FontSize(18);
        numLabel.textColor = RGBHex(0x999999);
        numLabel.text = numArray[i];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:numLabel];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame((26 + i*(46+42)), 51, 42, 13)];
        typeLabel.font = FontSize(13);
        typeLabel.textColor = RGBHex(0x333333);
        typeLabel.text = typeArray[i];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:typeLabel];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = RGBHex(0xFFB924);
    self.view.backgroundColor = RGBHex(0xffffff);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self addBottomWhiteView];
}

- (void)addBottomWhiteView {
    CGFloat height = ScreenHeight - KNavigationHeight - 182*ScalePpth;
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(0, 182, 375, height)];
    whiteView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:whiteView];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(24, 20, 100, 16)];
    nameLabel.font = FontSize(16);
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text =@"功能应用";
    [whiteView addSubview:nameLabel];
    
    NSArray *imageArray = @[@"employer_publish",@"employer_statistics",@"employer_scan",@"employer_information",@"employer_evaluate",@"employer_workers"];
    for (NSInteger i = 0; i < 6; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame((40+i%3*125), (61+i/3*125), 42.5, 42.5)];
        button.layer.cornerRadius = 42.5*ScalePpth/2;
        button.layer.masksToBounds = YES;
        button.tag = 500 +i;
        [button  setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:button];
        
        NSArray *typeArray = @[@"我发布的零工",@"交易统计",@"扫码付款",@"雇主资料",@"评价管理",@"我雇的人"];
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame((i%3*125), (120+i/3*129.5), 125, 14)];
        typeLabel.font = FontSize(14);
        typeLabel.textColor = RGBHex(0x666666);
        typeLabel.text = typeArray[i];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:typeLabel];
    }
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 500) {
        TheOddJobsIReleasedController *ojrvc = [[TheOddJobsIReleasedController alloc] init];
        ojrvc.titles = @"我发布的零工";
        [self.navigationController pushViewController:ojrvc animated:YES];
    } else if (button.tag == 505) {
        [self.navigationController pushViewController:[ThePersonIHiredController new] animated:YES];
    } else if (button.tag == 503) {
        [self.navigationController pushViewController:[EmployerInformationController new] animated:YES];
    }
}

@end
