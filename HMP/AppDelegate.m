//
//  AppDelegate.m
//  HMP
//
//  Created by hcb on 2019/1/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "CBBaseTabbarVc.h"
#import <HyphenateLite/HyphenateLite.h>

@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTintColor:[UIColor darkGrayColor]];
    //无token，去登录；登录后保存token
    [[UITabBar appearance] setTranslucent:NO];
    BOOL goLogin = ![CBUser share].token;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (goLogin) {
        UIViewController *vc = [AppManager getVCInBoard:@"Login" ID:@"loginNav"];
        self.window.rootViewController = vc;
    }else{
        self.window.rootViewController = [[CBBaseTabbarVc alloc]init];        
    }
    [self.window makeKeyAndVisible];
    
    //环信
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1114190110181664#0dbb17f5117bcf7ebfb860180f91c1fb"];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];

    //用户登录app后同步登录环信
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginEM:) name:@"loginEM" object:nil];
    
    return YES;
}

- (void)loginEM:(NSNotification *)noti{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //调用登录时，未设置自动登录，则登录，登录成功设置自动登录
        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
        if (!isAutoLogin) {
            EMError *error = [[EMClient sharedClient] loginWithUsername:[noti.object stringValue] password:[noti.object stringValue]];
            if (error) {
                NSLog(@"环信登录出错L：%@",error.errorDescription);
            }else{
                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }
        }
    });
}

/*!
 *  自动登录返回结果
 *
 *  @param error 错误信息
 */
- (void)autoLoginDidCompleteWithError:(EMError *)error{
    NSLog(@"环信自动登录完成:%@",error);
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
