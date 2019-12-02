//
//  AppDelegate.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatController.h"
#import "LBNavigationController.h"
#import "PublishContentController.h"
#import "GrabdDetailsController.h"
#import "LBTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    GlobalSingleton.gS_ShareInstance.systemWindow = self.window;
    NSString *login_state = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_state"];
    if (login_state && [login_state isEqualToString:@"yes"]) {
        GlobalSingleton.gS_ShareInstance.state = 1;
        self.window.rootViewController = [LBTabBarController new];
    } else {
        GlobalSingleton.gS_ShareInstance.state = 2;
        LoginViewController *loginController = [LoginViewController new];
        self.window.rootViewController = loginController;
    }
    // Required - 启动 JMessage SDK
    [JMessage addDelegate:self withConversation:nil];
    [JMessage setupJMessage:launchOptions appKey:App_Key channel:nil apsForProduction:NO category:nil messageRoaming:NO];
    // Required - 注册 APNs 通知
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
//    }
//    else {
//        //categories 必须为nil
//        [JMessage registerForRemoteNotificationTypes:(    UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
    [JMessage setBadge:YES];//设置角标
    [self registerJPushStatusNotification];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)registerJPushStatusNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJMSGNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkIsConnecting:)
                          name:kJMSGNetworkIsConnectingNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJMSGNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJMSGNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJMSGNetworkDidLoginNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(receivePushMessage:)
                          name:kJMSGNetworkDidReceiveMessageNotification
                        object:nil];
    
}
- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"Event - networkDidSetup");
}

- (void)networkIsConnecting:(NSNotification *)notification {
    NSLog(@"Event - networkIsConnecting");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"Event - networkDidClose");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"Event - networkDidRegister");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"Event - networkDidLogin");
}

- (void)receivePushMessage:(NSNotification *)notification {
    NSLog(@"Event - receivePushMessage");
    
    NSDictionary *info = notification.userInfo;
    if (info) {
        NSLog(@"The message - %@", info);
    } else {
        NSLog(@"Unexpected - no user info in jpush mesasge");
    }
}
//在线消息:逐条下发，每次都触发
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您收到了新消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if ([GlobalSingleton.gS_ShareInstance.currentViewController isKindOfClass:[PublishContentController class]]) {
            ChatController *chatVc = [ChatController new];
            chatVc.isPresent = YES;
            LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:chatVc];
            [GlobalSingleton.gS_ShareInstance.currentViewController presentViewController:navi animated:YES completion:nil];
        } else {
            [GlobalSingleton.gS_ShareInstance.currentViewController.navigationController pushViewController:[ChatController new] animated:YES];
        }
    }
}
- (void)onDBMigrateStart {
  NSLog(@"onDBmigrateStart in appdelegate");
  _isDBMigrating = YES;
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [JMessage resetBadge];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Action - applicationDidEnterBackground");
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Action - applicationWillEnterForeground");
    
    [application cancelAllLocalNotifications];
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"Action - didReceiveRemoteNotification:fetchCompletionHandler:");
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Action - didFailToRegisterForRemoteNotificationsWithError - %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册token
    [JMessage registerDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
