//
//  AppDelegate.m
//  JJSDWebImage
//
//  Created by xiazhongchong on 23/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <SDWebImage/SDImageCache.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


/**
 断点
 network ->线程  每个线程从下网上
 从start开始，libdyld.dylib start:->main
 */
//@synthesize ios 4.5以前使用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //添加缓存路径 add a custom read-only path
//    NSString *bundledPath = [[NSBundle mainBundle] resourcePath];
//    [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
