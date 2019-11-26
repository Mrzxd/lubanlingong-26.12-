//
//  LookingForListModel.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LookingForListModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *skillDate;
@property (nonatomic, strong) NSString *skillName;
@property (nonatomic, strong) NSString *skillSalary;
@property (nonatomic, strong) NSString *skillSalaryDay;

@end

NS_ASSUME_NONNULL_END
