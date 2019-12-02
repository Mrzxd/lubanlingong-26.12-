//
//  OrderDetailModel.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *orderLocationX;
@property (nonatomic, strong) NSString *orderLocationY;
@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *orderLocation;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderNumbering;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *orderSalary;
@property (nonatomic, strong) NSString *praise;
@property (nonatomic, strong) NSString *orderSalaryDay;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *orderStatusGr;
@property (nonatomic, strong) NSString *orderOrderName;
@property (nonatomic, strong) NSString *transactionNum;
@property (nonatomic, strong) NSString *creatOrderTime;
// 0 等待同意 取消订单
// 1 有人邀请 同意 拒绝 
//2 已拒绝
//3进行中
// 4 进行中
//5待付款
//6已完成
//7已评价
// 8 以删除


@end

NS_ASSUME_NONNULL_END
