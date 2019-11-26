//
//  HomeListModel.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *typeWork;
@property (nonatomic, strong) NSArray <HomeListModel*>*list;

@end

NS_ASSUME_NONNULL_END
