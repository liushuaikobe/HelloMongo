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
        
        // 初始化一些实例变量
        self.buf = [[NSMutableData alloc] initWithLength:0];
    }
    return self;
}

// 用浏览器直接访问serverStatusd
- (void)goSafari
{
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/serverStatus?text=1", [MMUtils getUrlBase]];
    [MMUtils openUrlViaBrowser:urlStr];
}

// 刷新当前数据
- (void)refresh
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/serverStatus", [MMUtils getUrlBase]];
    NSLog(@"Request: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

// 加载html模板
- (NSString *)loadHtmlTemplate:(NSString *)htmlFileName
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:htmlFileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    return htmlString;
}

// 渲染html模板
- (NSString *)renderHtmlTemplate:(NSDictionary *)data
{
    NSString *template = [self loadHtmlTemplate:@"status"];
    
    NSString *newStr = [template stringByReplacingOccurrencesOfString:@"{{ current }}" withString:[MMUtils toNSString:[[data objectForKey:@"connections"] objectForKey:@"current"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ available }}" withString:[MMUtils toNSString:[[data objectForKey:@"connections"] objectForKey:@"available"]]];
    
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ lockTime }}" withString:[MMUtils formatHumanTime:[[data objectForKey:@"globalLock"] objectForKey:@"lockTime"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ totalTime }}" withString:[MMUtils formatHumanTime:[[data objectForKey:@"globalLock"] objectForKey:@"totalTime"]]];

    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ resident }}" withString:[MMUtils formatHumanSize:[[data objectForKey:@"mem"] objectForKey:@"resident"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ mapped }}" withString:[MMUtils formatHumanSize:[[data objectForKey:@"mem"] objectForKey:@"mapped"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ virtual }}" withString:[MMUtils formatHumanSize:[[data objectForKey:@"mem"] objectForKey:@"virtual"]]];

    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ hits }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"indexCounters"] objectForKey:@"hits"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ accesses }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"indexCounters"] objectForKey:@"accesses"]]];

    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ C }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"opcounters"] objectForKey:@"insert"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ R }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"opcounters"] objectForKey:@"query"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ U }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"opcounters"] objectForKey:@"update"]]];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"{{ D }}" withString:[MMUtils formatHumanNumber:[[data objectForKey:@"opcounters"] objectForKey:@"delete"]]];

    return newStr;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Get Responese.");
    // 清空缓冲区
    [self.buf setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.buf appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Request Finished.");
    // 解析数据
    NSDictionary *data = [MMUtils parseJson:self.buf];
    
//    [MMUtils printDict:data];
    
    NSString *htmlString = [self renderHtmlTemplate:data];
    [self.statusWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"HttpRequest Error. %@", [error localizedDescription]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.statusWebView setDataDetectorTypes:UIDataDetectorTypeNone]; // 设置webview不自动检测电话号码、超链接等
    // 刷新一次
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
