//
//  MMUtils.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-28.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMUtils : NSObject

+ (NSString *)toNSString:(id)object;

+ (NSString *)formatHumanTime:(id)microsecond;
+ (NSString *)formatHumanSize:(id)mb;
+ (NSString *)formatHumanNumber:(id)number;

+ (void)printDict:(NSDictionary *)dic;
+ (void)openUrlViaBrowser:(NSString *)url;

@end
