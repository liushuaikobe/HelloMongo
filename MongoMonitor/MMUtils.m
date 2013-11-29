//
//  MMUtils.m
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-28.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "MMUtils.h"

@implementation MMUtils

// 将object转成String
+ (NSString *)toNSString:(id)object
{
    return [[NSString alloc] initWithFormat:@"%@", object];
}

// 将微秒转为对人友好的时间
+ (NSString *)formatHumanTime:(id)microsecond
{
    long long us = [[MMUtils toNSString:microsecond] longLongValue];
    double s = ((float)us) / 1000000.0;
    
//    NSLog(@"%f", s);
    
    if (s < 60) // 秒
    {
        return [[NSString alloc] initWithFormat:@"%.2fs", s];
    }
    else if (s < 3600) // 分钟
    {
        return [[NSString alloc] initWithFormat:@"%.2fmin", s / 60.0];
        
    }
    else if (s < 86400) // 小时
    {
        return [[NSString alloc] initWithFormat:@"%.2fh", s / (60.0 * 60.0)];
    }
    else // 天
    {
        return [[NSString alloc] initWithFormat:@"%.2fD", s / (24.0 * 60.0 * 60.0)];
    }
}


// 将MB转为对人友好的大小
+ (NSString *)formatHumanSize:(id)mb
{
    int m = [[MMUtils toNSString:mb] intValue];
    
    if (m < 1000) // MB
    {
        return [[NSString alloc] initWithFormat:@"%dM", m];
    }
    else if (m < 1024 * 1024) // GB
    {
        return [[NSString alloc] initWithFormat:@"%.2fG", ((double)m) / 1024.0];
    }
    else // TB
    {
        return [[NSString alloc] initWithFormat:@"%.2fT", ((double)m) / (1024.0 * 1024.0)];
    }
}

// 将字节转为对人友好的大小
+ (NSString *)formatHumanSizeBytes:(id)bytes
{
    int B = [[MMUtils toNSString:bytes] intValue];
    
    if (B < 1000) // bytes
    {
        return [[NSString alloc] initWithFormat:@"%dB", B];
    }
    else if (B < 1024 * 1024) // KB
    {
        return [[NSString alloc] initWithFormat:@"%.2fK", ((double)B)/ (1024.0)];
    }
    else if (B < 1024 * 1024 * 1024) // MB
    {
        return [[NSString alloc] initWithFormat:@"%.2fM", ((double)B)/ (1024.0 * 1024.0)];
    }
    else // GB
    {
        return [[NSString alloc] initWithFormat:@"%.2fG", ((double)B)/ (1024.0 * 1024.0 * 1024.0)];
    }
}


// 将数字转为对人友好的表示方法
+ (NSString *)formatHumanNumber:(id)number
{
    int num = [[MMUtils toNSString:number] intValue];
    
    if (num < 1000)
    {
        return [[NSString alloc] initWithFormat:@"%d", num];
    }
    else if (num < 100 * 1000) // K，千
    {
        return [[NSString alloc] initWithFormat:@"%.2fK", ((double) num) / 1000.0];
    }
    else // M，百万
    {
        return [[NSString alloc] initWithFormat:@"%.2fM", ((double) num) / 1000000.0];
    }
}

// 解析ServerStatus的数据
+ (NSDictionary *)parseJson:(NSData *)jsonData
{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    return dic;
}

// 将一个字典以NSLog的形式打印
+ (void)printDict:(NSDictionary *)dic
{
    id key, val;
    NSArray *keys = [dic allKeys];
    for (int i = 0; i < [keys count]; i++) {
        key = [keys objectAtIndex:i];
        val = [dic objectForKey:key];
        NSLog(@"%@ => %@", key, val);
    }
}

// 调用系统默认浏览器打开URL
+ (void)openUrlViaBrowser:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

// 加载html模板
+ (NSString *)loadHtmlTemplate:(NSString *)htmlFileName
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:htmlFileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    return htmlString;
}


// 判断IP地址是否合法
+ (BOOL)isRightIpAddress:(NSString *)ipStr
{
    return YES;
}

// 判断一个端口号是否合法
+ (BOOL)isRightPortNum:(NSString *)portStr
{
    return YES;
}

// 返回类变量
+ (NSString *)get_ip_defaults_key
{
    return IP_DEFAULTS_KEY;
}

+ (NSString *)get_port_defaults_key
{
    return PORT_DEFAULTS_KEY;
}

// 获取数据库的主机名+端口号
+ (NSString *)getUrlBase
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *ipAddr = (NSString *)[userDefaults objectForKey:[MMUtils get_ip_defaults_key]];
    NSString *port = (NSString *)[userDefaults objectForKey:[MMUtils get_port_defaults_key]];
    
    if (ipAddr && port) {
        return [[NSString alloc] initWithFormat:@"http://%@:%@", ipAddr, port];
    }
    return nil;
}

@end
