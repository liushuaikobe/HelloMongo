//
//  MMInfoDBViewController.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMInfoDBViewController.h"

@interface MMInfoDBViewController ()

@end

@implementation MMInfoDBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Databases";
        
        UIBarButtonItem *goSafari = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(goSafari)];
        UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
        
        
        self.navigationItem.leftBarButtonItem = goSafari;
        self.navigationItem.rightBarButtonItem = refresh;
        
        // 初始化一些实例变量
        self.buf = [[NSMutableData alloc] initWithLength:0];
        self.refreshControl = [[UIRefreshControl alloc] init];
    }
    return self;
}

// 用浏览器直接访问serverStatus
- (void)goSafari
{
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/listDatabases?text=1", [MMUtils getUrlBase]];
    [MMUtils openUrlViaBrowser:urlStr];
}

// 刷新当前数据
- (void)refresh
{
//    [self.refreshControl beginRefreshing];
    NSString *url = [[NSString alloc] initWithFormat:@"%@/listDatabases", [MMUtils getUrlBase]];
    NSLog(@"Request: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

// 处理从服务器返回的DB数据
- (void) setDbsAndSizes:(NSDictionary *)data
{
    NSArray *dbArr = [data objectForKey:@"databases"];
    long count = [dbArr count];
    self.dbs = [[NSMutableArray alloc] initWithCapacity:count];
    self.sizes = [[NSMutableArray alloc] initWithCapacity:count];
    NSDictionary *db;
    for (int i = 0; i < count; i++)
    {
        db = (NSDictionary *)[dbArr objectAtIndex:i];
        [self.dbs insertObject:[db objectForKey:@"name"] atIndex:i];
        [self.sizes insertObject:[db objectForKey:@"sizeOnDisk"] atIndex:i];
    }
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
    // 设置数据源
    [self setDbsAndSizes:data];
    // 更新UI
    [self.dbTableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"HttpRequest Error. %@", [error localizedDescription]);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dbs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableId = @"ItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableId];
    }
    cell.textLabel.text = [self.dbs objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [MMUtils formatHumanSizeBytes:[self.sizes objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Do nothing...
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dbTableView.dataSource = self;
    self.dbTableView.delegate = self;
    // 刷新一次
    [self refresh];
    
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.dbTableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
