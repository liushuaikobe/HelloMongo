//
//  MMMainViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-25.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMMainViewController.h"
#import "MMStatusItemViewController.h"

@interface MMMainViewController ()

@end

@implementation MMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"MongoMonitor";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectBtnPressed:(id)sender
{

    [self.navigationController pushViewController:[[MMStatusItemViewController alloc] init] animated:YES];
}

- (IBAction)bgTap:(id)sender
{
    [[self ipAddrTF] resignFirstResponder];
    [[self portTF] resignFirstResponder];
}
@end
