//
//  BankCardManagementController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/12/3.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ZXDBaseViewController.h"
#import "QueryBoundBankCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankCardManagementController : ZXDBaseViewController

@property (nonatomic, strong) OrderStatusCellBlock block;
@property (nonatomic, strong) NSArray <QueryBoundBankCardModel*>*bankCardModelArray;

@end

NS_ASSUME_NONNULL_END
