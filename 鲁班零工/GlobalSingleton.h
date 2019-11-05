//
//  GlobalSingleton.h
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/7.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalSingleton : NSObject
@property (nonatomic, strong) UIWindow *systemWindow;
@property (nonatomic, assign) NSInteger times;

+ (instancetype)gS_ShareInstance;
@end

NS_ASSUME_NONNULL_END
