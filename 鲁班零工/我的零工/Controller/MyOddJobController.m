//
//  MyOddJobController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "YTSegmentBarVC.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "MyOddJobController.h"
#import "OrderDetailsController.h"


@interface MyOddJobController ()

@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@end

@implementation MyOddJobController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的零工";
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.segmentVC.segmentBar.showIndicator = YES;
    self.segmentVC.segmentBar.space = 0;
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"全部", @"有人邀请", @"进行中",@" 待付款",@"已完成"];
    WeakSelf
    OneViewController *one = [[OneViewController alloc] init];
    one.orderDetailBlock = ^(NSString *idName) {
        OrderDetailsController *orderDc = [OrderDetailsController new];
        orderDc.orderId = idName;
        [weakSelf.navigationController pushViewController:orderDc animated:YES];
    };
    TwoViewController *two = [[TwoViewController alloc] init];
    two.orderDetailBlock = ^(NSString *idName) {
        OrderDetailsController *orderDc = [OrderDetailsController new];
        orderDc.orderId = idName;
        [weakSelf.navigationController pushViewController:orderDc animated:YES];
    };
    ThreeViewController *three = [[ThreeViewController alloc] init];
    three.orderDetailBlock = ^(NSString *idName) {
        OrderDetailsController *orderDc = [OrderDetailsController new];
        orderDc.orderId = idName;
        [weakSelf.navigationController pushViewController:orderDc animated:YES];
    };
    FourViewController *four = [[FourViewController alloc] init];
    four.orderDetailBlock = ^(NSString *idName) {
        OrderDetailsController *orderDc = [OrderDetailsController new];
        orderDc.orderId = idName;
        [weakSelf.navigationController pushViewController:orderDc animated:YES];
    };
    FiveViewController *five = [[FiveViewController alloc] init];
    five.orderDetailBlock = ^(NSString *idName) {
       OrderDetailsController *orderDc = [OrderDetailsController new];
        orderDc.orderId = idName;
       [weakSelf.navigationController pushViewController:orderDc animated:YES];
       };
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
        _segmentVC.block = ^(NSInteger toIndex,NSInteger fromIndex){
            
        };
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}



@end
