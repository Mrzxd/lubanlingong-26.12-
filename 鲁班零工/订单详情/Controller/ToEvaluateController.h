//
//  ToEvaluateController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/24.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderDetailModel.h"
#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToEvaluateController : ZXDBaseViewController

@property (nonatomic, strong) MyOddJobModel * model;
@property (nonatomic, strong) OrderDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
