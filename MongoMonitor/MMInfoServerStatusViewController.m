//
//  MMInfoServerStatusViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMInfoServerStatusViewController.h"

@interface MMInfoServerStatusViewController ()

@end

@implementation MMInfoServerStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 记住此时各种输出口还都是nil！！！
        self.navigationItem.title = @"Server Status";
        
        UIBarButtonItem *goSafari = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(goSafari)];
        UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
        
        
        self.navigationItem.leftBarButtonItem = goSafari;
        self.navigationItem.rightBarButtonItem = refresh;
    }
    return self;
}

// 从本地html中加载status数据
- (void)loadStatusFromLocalHtml:(NSString *)htmlFileName
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:htmlFileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.statusWebView loadHTMLString:htmlString baseURL:nil];
}

// 用浏览器直接访问serverStatus
- (void)goSafari
{
    
}

// 刷新当前数据
- (void)refresh
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadStatusFromLocalHtml:@"main"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
