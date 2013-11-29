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
        
        UIBarButtonItem *goSafari = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(goSafari)];
        UIBarButtonItem *rightSettingBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsViewControler)];
        
        self.navigationItem.leftBarButtonItem = goSafari;
        self.navigationItem.rightBarButtonItem = rightSettingBtn;
        
        self.navigationItem.title = @"More";
        
        // 初始化一些实例变量
        self.buf = [[NSMutableData alloc] initWithLength:0];
        
    }
    return self;
}

// 用浏览器直接访问serverStatusd
- (void)goSafari
{
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/hostInfo?text=1", [MMUtils getUrlBase]];
    [MMUtils openUrlViaBrowser:urlStr];
}
    
// 显示设置页面
- (void)presentSettingsViewControler
{
    UINavigationController *settingsNavagationController = [[UINavigationController alloc] initWithRootViewController:[[MMSettingsViewController alloc] init]];
    [self.navigationController presentViewController:settingsNavagationController animated:YES completion:nil];
}

// 向服务器请求更多数据
- (void) requestMoreInfo
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/hostInfo", [MMUtils getUrlBase]];
    NSLog(@"Request: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
    
// 渲染html模板
- (NSString *)renderHtmlTemplate:(NSDictionary *)data
{
    NSString *template = [MMUtils loadHtmlTemplate:@"hosts"];
    
    NSArray *keys = [data allKeys];
    
    id key, val;
    NSString *keyInTemplate, *valStr;
    
    for (int i = 0; i < [keys count]; i++) {
        key = [keys objectAtIndex:i];
        val = [data objectForKey:key];
        valStr = [MMUtils toNSString:val];
        keyInTemplate = [[NSString alloc] initWithFormat:@"{{ %@ }}", key];
        template = [template stringByReplacingOccurrencesOfString:keyInTemplate withString:valStr];
    }
    
    return template;
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
    
    // [MMUtils printDict:data];
    
    // 要在WebView上显示的信息
    NSMutableDictionary *usefulData = [[NSMutableDictionary alloc] initWithCapacity:15];
    
    NSDictionary *tmp = [data objectForKey:@"system"];
    [usefulData setObject:[tmp objectForKey:@"hostname"] forKey:@"hostname"];
    [usefulData setObject:[tmp objectForKey:@"cpuAddrSize"] forKey:@"cpuAddrSize"];
    [usefulData setObject:[tmp objectForKey:@"memSizeMB"] forKey:@"memSizeMB"];
    [usefulData setObject:[tmp objectForKey:@"numCores"] forKey:@"numCores"];
    [usefulData setObject:[tmp objectForKey:@"cpuArch"] forKey:@"cpuArch"];
    [usefulData setObject:[tmp objectForKey:@"numaEnabled"] forKey:@"numaEnabled"];
    
    tmp = [data objectForKey:@"os"];
    [usefulData setObject:[tmp objectForKey:@"type"] forKey:@"type"];
    [usefulData setObject:[tmp objectForKey:@"name"] forKey:@"name"];
    [usefulData setObject:[tmp objectForKey:@"version"] forKey:@"version"];
    
    tmp = [data objectForKey:@"extra"];
    [usefulData setObject:[MMUtils formatHumanSizeBytes:[tmp objectForKey:@"pageSize"]] forKey:@"pageSize"];
    
    // 渲染html并在WebView上显示
    NSString *htmlString = [self renderHtmlTemplate:usefulData];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];

    [self.moreInfoWebView loadHTMLString:htmlString baseURL:baseURL];
}
    
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"HttpRequest Error. %@", [error localizedDescription]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self requestMoreInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
