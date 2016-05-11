//
//  AppDelegate.m
//  JJFlyViewTransitions
//
//  Created by John on 5/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
/*
 NSLayoutConstraint
 
 1.必须设置 translatesAutoresizingMaskIntoConstraints为NO。
 
 2.如果是viewController则AutoLayout适配写在[- updateViewConstraints]中；
 
 3.如果是view则AutoLayout适配写在[- updateConstraints]中
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
