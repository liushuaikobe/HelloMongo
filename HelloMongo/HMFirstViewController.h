//
//  HMFirstViewController.h
//  HelloMongo
//
//  Created by Shuai Liu on 13-11-24.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFirstViewController : UIViewController <NSURLConnectionDelegate>

@property (nonatomic, retain) IBOutlet UITextField *ipAddrTF;
@property (nonatomic, retain) IBOutlet UITextField *portTF;
@property (nonatomic, retain) IBOutlet UIButton *connectBtn;

@property (nonatomic, retain) NSString *ipAddr;
@property (nonatomic, retain) NSString *port;

@property (retain) NSMutableData *buf;

- (IBAction)bgTap:(id)sender;

- (IBAction)connectBtnPressed:(id)sender;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
