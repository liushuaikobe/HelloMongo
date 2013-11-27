//
//  MMInfoMoreViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMInfoMoreViewController.h"

@interface MMInfoMoreViewController ()

@end

@implementation MMInfoMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *rightSettingBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsViewControler)];
        self.navigationItem.rightBarButtonItem = rightSettingBtn;
        
        self.navigationItem.title = @"More";
        
        
    }
    return self;
}

- (void)presentSettingsViewControler
{
    UINavigationController *settingsNavagationController = [[UINavigationController alloc] initWithRootViewController:[[MMSettingsViewController alloc] init]];
    [self.navigationController presentViewController:settingsNavagationController animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
