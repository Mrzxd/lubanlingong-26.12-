//
//  OrderDetailsOfMyEmployeesController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//  我雇的人订单详情

#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^OrderBlock)(id model);
@interface OrderDetailsOfMyEmployeesController : ZXDBaseViewController
@property (nonatomic, strong) OrderBlock orderBlock;
@property (nonatomic, strong) NSString *idName;
@property (nonatomic, assign) OrderDetail_Type detail_Type;
@end

NS_ASSUME_NONNULL_END
