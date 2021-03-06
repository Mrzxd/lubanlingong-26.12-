//
//  CancleOrderController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "OrderDetailModel.h"
#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface CancleOrderController : ZXDBaseViewController

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) MyOddJobModel *jobModel;
@property (nonatomic, strong) OrderDetailModel *detailModel;
@property (nonatomic, assign) BOOL isEmployer;

@end

NS_ASSUME_NONNULL_END
