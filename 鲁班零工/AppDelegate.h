//
//  AppDelegate.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,JMessageDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic)BOOL isDBMigrating;

@end

      
