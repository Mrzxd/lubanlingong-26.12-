//
//  WorkPlaceMapController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AdressInMapBlock)(NSString *address,NSString *longitude,NSString *latitude);

@interface WorkPlaceMapController : ZXDBaseViewController

@property (nonatomic, strong) AdressInMapBlock adressBlock;

@end

NS_ASSUME_NONNULL_END
