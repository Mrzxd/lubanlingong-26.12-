//
//  ListRecordModel.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/27.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListRecordModel : NSObject

@property (nonatomic, strong) NSString *orderOrderName;
@property (nonatomic, strong) NSString *orderSalary;
@property (nonatomic, strong) NSString *orderSalaryDay;
@property (nonatomic, strong) NSString *overWorkTime;
@property (nonatomic, strong) NSString *startWorkTime;

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *Evaluations;

@end

NS_ASSUME_NONNULL_END
