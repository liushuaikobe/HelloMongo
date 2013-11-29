//
//  MMAppDelegate.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-25.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMAppDelegate.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 从主tab的nib中将主TabBar加载
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MainTabBar" owner:nil options:nil];
    self.mainTabBarController =[nibContents objectAtIndex:0];
    // 初始化主TabBar
    [self initTabBars];
    
    self.window.rootViewController = self.mainTabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

// 初始化TabBarController
- (void)initTabBars
{
    // "serverStatus"下的NavigationController
    UINavigationController *serverStatusViewNavigationController = [[self.mainTabBarController viewControllers] objectAtIndex:0];
    serverStatusViewNavigationController.viewControllers = @[[[MMInfoServerStatusViewController alloc] init]];
    
    // 数据库基本信息下的NavigationController
    UINavigationController *dbViewNavigationController = [[self.mainTabBarController viewControllers] objectAtIndex:1];
    dbViewNavigationController.viewControllers = @[[[MMInfoDBViewController alloc] init]];
    
    // Replication页面下的NavigationController
    UINavigationController *replViewNavigationController = [[self.mainTabBarController viewControllers] objectAtIndex:2];
    replViewNavigationController.viewControllers = @[[[MMInfoReplViewController alloc] init]];
    
    // "更多"tab下的NavigationController
    UINavigationController *moreViewNavigationController = [[self.mainTabBarController viewControllers] objectAtIndex:3];
    moreViewNavigationController.viewControllers = @[[[MMInfoMoreViewController alloc] init]];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
