//
//  MMSettingsViewController.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-27.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMUtils.h"

@interface MMSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
- (IBAction)bgTap:(id)sender;

@end
