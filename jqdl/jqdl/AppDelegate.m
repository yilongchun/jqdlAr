//
//  AppDelegate.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/17.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURLCache *cathe = [[NSURLCache alloc] initWithMemoryCapacity:4*1024*1024 diskCapacity:20*1024*1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cathe];
    
    //修改导航栏颜色
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [[UINavigationBar appearance] setBarTintColor:NAVIGATION_BAR_COLOR];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [UINavigationBar appearance].translucent = YES;
    }
    
    //统一修改返回按钮
    UIImage *backImage = [UIImage imageNamed:@"navi_back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)]                                                       forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-233, -230) forBarMetrics:UIBarMetricsDefault];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
