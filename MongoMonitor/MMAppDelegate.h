//
//  MMAppDelegate.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-25.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMInfoServerStatusViewController.h"
#import "MMInfoMoreViewController.h"
#import "MMSettingsViewController.h"

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UINavigationController *moreViewNavigationController;
@property (strong, nonatomic) UITabBarController *mainTabBarController;

- (void)initTabBars;


@end
