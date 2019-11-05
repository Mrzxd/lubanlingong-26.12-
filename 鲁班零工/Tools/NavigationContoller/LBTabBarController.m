//
//  LBTabBarController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBarController.h"
#import "LBNavigationController.h"

#import "HomeController.h"
#import "MineController.h"
#import "PublishContentController.h"
#import "OddJobController.h"
#import "LookingForServicesController.h"

#import "LBTabBar.h"
#import "UIImage+Image.h"


@interface LBTabBarController ()<LBTabBarDelegate>

@end

@implementation LBTabBarController


#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)){
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UITabBar class]]) {
                //x的位置不变 y的位置你自己调调到UI满意 宽不变 高也不能变      最终只是改变一下y的相对位置
                 if (KNavigationHeight > 80) {
                     view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-64, view.frame.size.width, 83);
                 }
            }
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (KNavigationHeight > 80) {
        if (@available(iOS 11.0, *)){
            // 修改tabBra的frame
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y = [UIScreen mainScreen].bounds.size.height -64;
            self.navigationController.tabBarController.tabBar.frame = frame;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
       [super viewWillAppear:animated];
    if (KNavigationHeight > 80) {
        if (@available(iOS 11.0, *)){
            // 修改tabBra的frame
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y = [UIScreen mainScreen].bounds.size.height -64;
            self.navigationController.tabBarController.tabBar.frame = frame;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildVc];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    HomeController *HomeVC = [[HomeController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"index_" selectedImage:@"index_fill" title:@"首页"];

    OddJobController *jobVC = [[OddJobController alloc] init];
    [self setUpOneChildVcWithVc:jobVC Image:@"job" selectedImage:@"job_fill" title:@"零工"];

    LookingForServicesController *lookingVC = [[LookingForServicesController alloc] init];
    [self setUpOneChildVcWithVc:lookingVC Image:@"look" selectedImage:@"look_fill" title:@"找服务"];

    MineController *MineVC = [[MineController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"my" selectedImage:@"my_fill" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    LBNavigationController *nav = [[LBNavigationController alloc] initWithRootViewController:Vc];

    nav.navigationBarHidden = YES;
//    Vc.view.backgroundColor = UIColor.whiteColor;//[self randomColor];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;

    [self addChildViewController:nav];
    
}

#pragma mark - LBTabBarDelegate

//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    PublishContentController *plusVC = [[PublishContentController alloc] init];
//    plusVC.view.backgroundColor = [self randomColor];
    plusVC.view.backgroundColor = UIColor.whiteColor;
//    LBNavigationController *navVc = [[LBNavigationController alloc] initWithRootViewController:plusVC];
    [self presentViewController:plusVC animated:YES completion:nil];
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
