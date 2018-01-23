//
//  AppDelegate.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "AppDelegate.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getUniqueString];
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

- (void)getUniqueString {
    NSString *result = [[UICKeyChainStore keyChainStore] stringForKey:@"esunnyuuid"];
    if (result) {
        NSLog(@"获取结果：%@", result);
    } else {
        NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[UICKeyChainStore keyChainStore] setString:uuid forKey:@"esunnyuuid"];
        NSLog(@"存入结果%@", uuid);
    }
    //D6F18701-3F68-4038-AF86-F34226E0E0C4
    //D6F18701-3F68-4038-AF86-F34226E0E0C4
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
