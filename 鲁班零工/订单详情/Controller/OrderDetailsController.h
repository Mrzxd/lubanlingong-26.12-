//
//  OrderDetailsController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderBlock)(id model);


@interface OrderDetailsController : ZXDBaseViewController

@property (nonatomic, strong) OrderBlock orderBlock;

@property (nonatomic, assign) OrderDetail_Type detail_Type;

@end

NS_ASSUME_NONNULL_END
