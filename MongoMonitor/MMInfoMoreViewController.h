//
//  MMInfoMoreViewController.h
//  MongoMonitor
//
//  Created by Shuai Liu on 13-11-26.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSettingsViewController.h"

@interface MMInfoMoreViewController : UIViewController<NSURLConnectionDelegate>
    
@property (weak, nonatomic) IBOutlet UIWebView *moreInfoWebView;
    
@property (retain) NSMutableData *buf;
    
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end
