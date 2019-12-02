//
//  OffShelfController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//
//  已下架
#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OrderDetailBlock)(NSInteger type);

@interface OffShelfController : ZXDBaseViewController
@property (nonatomic, strong) OrderDetailBlock orderDetailBlock;
@property (nonatomic, assign) BOOL isService;

@end

NS_ASSUME_NONNULL_END
