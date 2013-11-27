//
//  MMSettingsViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-27.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMSettingsViewController.h"

@interface MMSettingsViewController ()

@end

@implementation MMSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
        
        
        self.navigationItem.leftBarButtonItem = cancel;
        self.navigationItem.rightBarButtonItem = save;
        
        self.navigationItem.title = @"Settings";

    }
    return self;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)bgTap:(id)sender
{
    [self.IPTextField resignFirstResponder];
    [self.portTextField resignFirstResponder];
}
@end
