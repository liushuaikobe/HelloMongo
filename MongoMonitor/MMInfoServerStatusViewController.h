//
//  MMInfoServerStatusViewController.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMInfoServerStatusViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *statusWebView;

- (void)loadStatusFromLocalHtml:(NSString *)htmlFileName;

@end
