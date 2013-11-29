//
//  MMUtils.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-28.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* IP_DEFAULTS_KEY = @"db_ip_address";
static NSString* PORT_DEFAULTS_KEY = @"db_port_number";

@interface MMUtils : NSObject

+ (NSString *)toNSString:(id)object;

+ (NSString *)formatHumanTime:(id)microsecond;
+ (NSString *)formatHumanSize:(id)mb;
+ (NSString *)formatHumanSizeBytes:(id)bytes;
+ (NSString *)formatHumanNumber:(id)number;

+ (NSDictionary *)parseJson:(NSData *)jsonData;

+ (void)printDict:(NSDictionary *)dic;
+ (void)openUrlViaBrowser:(NSString *)url;

+ (BOOL)isRightIpAddress:(NSString *)ipStr;
+ (BOOL)isRightPortNum:(NSString *)portStr;

+ (NSString *)get_ip_defaults_key;
+ (NSString *)get_port_defaults_key;
+ (NSString *)getUrlBase;

@end
