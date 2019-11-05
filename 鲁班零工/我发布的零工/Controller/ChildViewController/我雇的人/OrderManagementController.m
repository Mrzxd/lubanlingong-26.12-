//
//  OrderManagementController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/26.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "YTSegmentBarVC.h"
#import "OrderManagementController.h"
#import "OrderManagementOneChildController.h"
#import "OrderManagementTwoChildController.h"
#import "OrderManagementThreeChildController.h"
#import "OrderManagementFourChildController.h"
#import "OrderManagementFiveChildController.h"


@interface OrderManagementController ()

@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@end

@implementation OrderManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegmentBarVC];
}
- (void)addSegmentBarVC {
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.segmentVC.segmentBar.space = 0;
    self.segmentVC.view.frame = self.view.bounds;
    self.segmentVC.segmentBar.showIndicator = YES;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"全部", @"进行中",@"验收中",@"已完成",@"已终止"];
    OrderManagementOneChildController *one = [[OrderManagementOneChildController alloc] init];
    OrderManagementTwoChildController *two = [[OrderManagementTwoChildController alloc] init];
    OrderManagementThreeChildController *three = [[OrderManagementThreeChildController alloc] init];
    OrderManagementFourChildController *four = [[OrderManagementFourChildController alloc] init];
    OrderManagementFiveChildController *five = [[OrderManagementFiveChildController alloc] init];
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
