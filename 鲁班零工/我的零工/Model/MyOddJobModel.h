//
//  MyOddJobModel.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOddJobModel : NSObject

@property (nonatomic, strong) NSString *creatOrderTime;
@property (nonatomic, strong) NSString *orderLocation;
@property (nonatomic, strong) NSString *orderOrderName;
@property (nonatomic, strong) NSString *orderSalary;
@property (nonatomic, strong) NSString *orderSalaryDay;
@property (nonatomic, strong) NSString *orderStatusGr;
@property (nonatomic, strong) NSString *orderStatusGz;
@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderNumbering;

@property (nonatomic, strong) NSString *orderLocationX;
@property (nonatomic, strong) NSString *orderLocationY;

@end

NS_ASSUME_NONNULL_END
