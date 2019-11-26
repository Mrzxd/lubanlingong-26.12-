//
//  HomeListModel.m
//  鲁班零工
//
//  Created by 张昊 on 2019/11/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//



@implementation HomeListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idName":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"HomeListModel"};
}

@end
