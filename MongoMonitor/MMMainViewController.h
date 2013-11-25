//
//  MMMainViewController.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-25.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMMainViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *ipAddrTF;
@property (nonatomic, retain) IBOutlet UITextField *portTF;
@property (nonatomic, retain) IBOutlet UIButton *connectBtn;
- (IBAction)connectBtnPressed:(id)sender;
- (IBAction)bgTap:(id)sender;

@end
