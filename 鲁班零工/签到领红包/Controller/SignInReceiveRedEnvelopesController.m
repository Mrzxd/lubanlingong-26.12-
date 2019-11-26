//
//  SignInReceiveRedEnvelopesController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "SignInReceiveCell.h"
#import "SignInReceiveRedEnvelopesController.h"

@interface SignInReceiveRedEnvelopesController ()  <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *mineheaderView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *sectionHeader;
@end

@implementation SignInReceiveRedEnvelopesController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //1。
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置NavigationBar上的title的颜色
    //2.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = RGBHex(0xFFAA1A);
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[SignInReceiveCell class] forCellReuseIdentifier:@"SignInReceiveCell"];
        _tableView.tableHeaderView = self.mineheaderView;
        _tableView.backgroundColor = RGBHex(0xFFAA1A);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIView *)sectionHeader {
    if (!_sectionHeader) {
        _sectionHeader = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 275, 56)];
        UILabel *signInLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 22, 100, 18)];
        signInLabel.textColor = RGBHex(0xffffff);
        signInLabel.text = @"为你推荐";
        signInLabel.font = [UIFont boldSystemFontOfSize:18 *ScalePpth];
        [_sectionHeader addSubview:signInLabel];
    }
    return _sectionHeader;
}
- (UIView *)mineheaderView {
    if (!_mineheaderView) {
        _mineheaderView = [[UIView alloc] init];
        _mineheaderView.backgroundColor = RGBHex(0xFFAA1A);
        _mineheaderView.frame = CGRectMake(0, 0, ScreenWidth, 467*ScalePpth-KNavigationHeight);
        [self addSubView];
    }
    return _mineheaderView;
    
}
- (void)addSubView {
    _imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, -KNavigationHeight/ScalePpth, 375, 267)];
    _imageView.image = [UIImage imageNamed:@"sign_banner"];
    [_mineheaderView addSubview:_imageView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(10, (267*ScalePpth- KNavigationHeight)/ScalePpth, 355, 200)];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 18.5;
    [_mineheaderView addSubview:whiteView];
    
    UILabel *signInLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 19, 355, 18)];
    signInLabel.textColor = RGBHex(0x323232);
    signInLabel.font = FontSize(18);
    signInLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:signInLabel];
    
    NSMutableAttributedString *attibutestr = [[NSMutableAttributedString alloc] initWithString:@"已连续签到3天"];
    [attibutestr addAttribute:NSForegroundColorAttributeName value:RGBHex(0x323232) range:NSMakeRange(0, 5)];
    [attibutestr addAttribute:NSForegroundColorAttributeName value:RGBHex(0x323232) range:NSMakeRange(6, 1)];
    [attibutestr addAttribute:NSForegroundColorAttributeName value:RGBHex(0xED4C4A) range:NSMakeRange(5, 1)];
    signInLabel.attributedText = attibutestr;
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 48, 355, 18)];
    rewardLabel.textColor = RGBHex(0x9C9C9C);
    rewardLabel.font = FontSize(11);
    rewardLabel.text = @"连续签到7天即可享受奖励翻倍";
    rewardLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:rewardLabel];
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:AutoFrame(21.5, 98, 312, 9)];
    backGroundView.backgroundColor = RGBHex(0xFFEFC2);
    backGroundView.clipsToBounds = YES;
    backGroundView.layer.cornerRadius = 4.5*ScalePpth;
    backGroundView.layer.masksToBounds = YES;
    [whiteView addSubview:backGroundView];
    
    UIView *redView = [[UIView alloc] initWithFrame:AutoFrame(21.5, 98, 133, 9)];
    redView.backgroundColor = RGBHex(0xF96F34);
    redView.clipsToBounds = YES;
    redView.layer.cornerRadius = 4.5*ScalePpth;
    redView.layer.masksToBounds = YES;
    [whiteView addSubview:redView];
    
    NSArray *dateArray = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天"];
    for (NSInteger i = 0; i < 7; i ++) {
        UILabel *rewardLabel = [[UILabel alloc] initWithFrame:AutoFrame((44 + 44.5*i), 115, 24, 12)];
        rewardLabel.textColor = RGBHex(0xBABABA);
        rewardLabel.font = FontSize(12);
        rewardLabel.text = dateArray[i];
        [whiteView addSubview:rewardLabel];
    }
  
    NSArray *titleArray = @[@"0.5元",@"1.0元",@"2.0元"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame((122+i *86), 79, 46, 19)];
        imageView.image = [UIImage imageNamed:@"圆角矩形3"];
        [whiteView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(0, 0, 46, 14.8)];
        label.text = titleArray[i];
        label.textColor = RGBHex(0xC09F7A);
        label.font = FontSize(10.44);
        label.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:label];
    }
    
    UIButton *immediatelyButton = [[UIButton alloc] initWithFrame:CGRectMake(126.5*ScalePpth, 150*ScalePpth, 101.5*ScalePpth, 31.5*ScalePpth)];
    [immediatelyButton setTitle:@"签 到" forState:UIControlStateNormal];
    [immediatelyButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    immediatelyButton.titleLabel.font = [UIFont boldSystemFontOfSize:15 *ScalePpth];
    immediatelyButton.backgroundColor = RGBHex(0xFFD301);
    immediatelyButton.layer.cornerRadius = 31.5/2*ScalePpth;
    immediatelyButton.layer.masksToBounds = YES;
    immediatelyButton.clipsToBounds = YES;
    [whiteView addSubview:immediatelyButton];
    
    UILabel *intergrialLabel = [[UILabel alloc] initWithFrame:AutoFrame(247, 167, 110, 12)];
    intergrialLabel.textColor = RGBHex(0xBABABA);
    intergrialLabel.font = [UIFont boldSystemFontOfSize:12 *ScalePpth];
    intergrialLabel.text = @"已经获得4.26元";
    [whiteView addSubview:intergrialLabel];
}
#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 56 *ScalePpth;
    }
    return 10*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.sectionHeader;
    }
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SignInReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignInReceiveCell" forIndexPath:indexPath];
    cell.button.hidden = YES;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
    
}


@end
