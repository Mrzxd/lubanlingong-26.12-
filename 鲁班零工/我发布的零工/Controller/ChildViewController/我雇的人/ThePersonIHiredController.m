



//
//  ThePersonIHiredController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "YTSegmentBarVC.h"
#import "WaitPermissionController.h"
#import "OrderManagementController.h"
#import "ThePersonIHiredController.h"


@interface ThePersonIHiredController ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@property (nonatomic, assign) BOOL isClicked;

@end

@implementation ThePersonIHiredController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我雇的人";
    [self.view addSubview:self.backgroundView];
    [self addSegmentBarVC];
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:AutoFrame(95, 0, 185, 34)];
        _backgroundView.backgroundColor = RGBHex(0xF0F0F0);
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.layer.cornerRadius = 17*ScalePpth;
        [self addSubViews];
    }
    return _backgroundView;
}

- (void)addSubViews {
    UIButton *backgroundbutton1 = [[UIButton alloc] initWithFrame:AutoFrame(3.5, 2.5, 92, 29)];
    backgroundbutton1.layer.masksToBounds = YES;
    backgroundbutton1.layer.cornerRadius = 14.5*ScalePpth;
    backgroundbutton1.titleLabel.font = FontSize(15);
    [backgroundbutton1 setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [backgroundbutton1 setTitle:@"等待同意" forState:UIControlStateNormal];
    [backgroundbutton1 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:backgroundbutton1];
    
    UIButton *backgroundbutton2 = [[UIButton alloc] initWithFrame:AutoFrame(89.5, 2.5, 92, 29)];
    backgroundbutton2.layer.masksToBounds = YES;
    backgroundbutton2.layer.cornerRadius = 14.5*ScalePpth;
    backgroundbutton2.titleLabel.font = FontSize(15);
    [backgroundbutton2 setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [backgroundbutton2 setTitle:@"订单管理" forState:UIControlStateNormal];
    [backgroundbutton2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:backgroundbutton2];
    
    _selectedButton = [[UIButton alloc] initWithFrame:AutoFrame(3.5, 2.5, 92, 29)];
    _selectedButton.backgroundColor = RGBHex(0xFED452);
    _selectedButton.layer.masksToBounds = YES;
    _selectedButton.layer.cornerRadius = 14.5*ScalePpth;
    _selectedButton.titleLabel.font = FontSize(15);
    [_selectedButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [_selectedButton setTitle:@"等待同意" forState:UIControlStateNormal];
    [_selectedButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_selectedButton];
}
- (void)buttonAction:(UIButton *)button {
    
    
}
- (void)buttonAction2:(UIButton *)button {
    _isClicked = YES;
    [self changePage];
}

- (void)addSegmentBarVC {
    self.segmentVC.segmentBar.frame = CGRectMake(0, 34*ScalePpth, ScreenWidth, 0);
    self.segmentVC.segmentBar.space = 0;
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    [self.view sendSubviewToBack:self.segmentVC.view];
    NSArray *items = @[@"", @""];
    WaitPermissionController *one = [[WaitPermissionController alloc] init];
    OrderManagementController *two = [[OrderManagementController alloc] init];
    [self.segmentVC setUpWithItems:items ChildVCs:@[one,two]];
    self.segmentVC.segmentBar.selectIndex = 0;
    [self.segmentVC.segmentBar updateWithConfig:^(YTSegmentBarConfig *config) {
        config.itemNormalColor (RGBHex(0x999999))
        .itemSelectColor (RGBHex(0x333333))
        .indicatorColor  (RGBHex(0xFED452));
    }];
}

- (YTSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        _segmentVC = [[YTSegmentBarVC alloc] init];
        WeakSelf;
        _segmentVC.block = ^(NSInteger toIndex,NSInteger fromIndex){
            weakSelf.isClicked = NO;
            toIndex != fromIndex ? [weakSelf changePage]:0;
        };
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}

- (void)changePage {
    WeakSelf;
    if (_selectedButton.frame.origin.x <= 3.5) {
        _isClicked ? self.segmentVC.segmentBar.selectIndex = 1:0;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.selectedButton.frame = AutoFrame(89.5, 2.5, 92, 29);
            [weakSelf.selectedButton setTitle:@"订单管理" forState:UIControlStateNormal];
        }];
    } else {
        _isClicked ? self.segmentVC.segmentBar.selectIndex = 0:0;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.selectedButton.frame = AutoFrame(3.5, 2.5, 92, 29);
            [weakSelf.selectedButton setTitle:@"等待同意" forState:UIControlStateNormal];
        }];
    }
}
@end
