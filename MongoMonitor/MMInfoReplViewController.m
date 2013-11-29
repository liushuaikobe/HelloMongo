//
//  MMInfoReplViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMInfoReplViewController.h"

@interface MMInfoReplViewController ()

@end

@implementation MMInfoReplViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Replication Set";
        
        UIBarButtonItem *goSafari = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(goSafari)];
        UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
        
        
        self.navigationItem.leftBarButtonItem = goSafari;
        self.navigationItem.rightBarButtonItem = refresh;

    }
    return self;
}

    // 用浏览器直接访问serverStatusd
- (void)goSafari
{
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/replSetGetStatus?text=1", [MMUtils getUrlBase]];
    [MMUtils openUrlViaBrowser:urlStr];
}
    
    // 刷新当前数据
- (void)refresh
{
    NSLog(@"Refresh.");
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
