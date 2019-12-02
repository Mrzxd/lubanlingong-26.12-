//
//  OddJobsReleasedByWoController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^OrderDetailBlock)(NSInteger type);

@interface TheOddJobsIReleasedController : ZXDBaseViewController
@property (nonatomic, strong) NSString *titles;
@property (nonatomic, strong) OrderDetailBlock orderDetailBlock;
@end

NS_ASSUME_NONNULL_END
