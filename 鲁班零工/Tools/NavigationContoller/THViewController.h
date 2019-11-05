//
//  THViewController.h
//  ZoweeSale
//
//  Created by wanglj on 16/2/17.
//  Copyright © 2016年 TH. All rights reserved.
//
#import "FJSlidingController.h"
#import <UIKit/UIKit.h>

@interface THViewController : UIViewController

@property (strong, nonatomic) UIButton* backBtn;
- (void)changeTextTowhite;
/**
 *  点击返回按钮触发的方法(子类可以重写)
 */
-(void)clickedBackBtn;
/**
 *  设置返回按钮可见
 *
 *  @param hidden 是否可见
 */
-(void)setBackBtnHidden:(BOOL)hidden;
/**
 *  设置右边的按钮
 *
 *  @param Btn 右按钮
 */
-(void)setRightBtn:(UIButton *)Btn;
/**
 *  设置返回按钮有效
 *
 *  @param enable 按钮有效
 */
-(void)setBackBtnEnable:(BOOL)enable;

@end
