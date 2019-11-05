//
//  OddJobsReleasedByWoController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "YTSegmentBarVC.h"
#import "AllViewController.h"
#import "ToBeAuditedController.h"
#import "OnShelvesViewController.h"
#import "OffShelfController.h"
#import "RejectedController.h"
#import "TheOddJobsIReleasedController.h"
#import "EmployerCenterOrderDetailController.h"

@interface TheOddJobsIReleasedController ()

@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@end

@implementation TheOddJobsIReleasedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titles;
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.segmentVC.segmentBar.showIndicator = YES;
    self.segmentVC.segmentBar.space = 0;
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"全部", @"待审核", @"已上架",@" 已下架",@"已驳回"];
    AllViewController *one = [[AllViewController alloc] init];
    one.orderDetailBlock = ^(NSInteger type) {
        [self.navigationController pushViewController:[EmployerCenterOrderDetailController new] animated:YES];
    };
    ToBeAuditedController *two = [[ToBeAuditedController alloc] init];

    OnShelvesViewController *three = [[OnShelvesViewController alloc] init];

    OffShelfController *four = [[OffShelfController alloc] init];
    RejectedController *five = [[RejectedController alloc] init];
    [self.segmentVC setUpWithItems:items ChildVCs:@[one,two,three,four,five]];
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
        _segmentVC.block = ^(NSInteger toIndex,NSInteger fromIndex) {
            
        };
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}



@end
