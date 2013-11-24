//
//  HMFirstViewController.m
//  HelloMongo
//
//  Created by Shuai Liu on 13-11-24.
//  Copyright (c) 2013年 liushuaikobe. All rights reserved.
//

#import "HMFirstViewController.h"

@interface HMFirstViewController ()

@end

@implementation HMFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad.");
}

- (void)bgTap:(id)sender
{
    [[self ipAddrTF] resignFirstResponder];
    [[self portTF] resignFirstResponder];
}

- (IBAction)connectBtnPressed:(id)sender
{
    [self setIpAddr:[[self ipAddrTF] text]];
    [self setPort:[[self portTF] text]];
    NSString *url = [[NSString alloc] initWithFormat:@"http://%@:%@/serverStatus?text=1", self.ipAddr, self.port];

    self.buf = [[NSMutableData alloc] initWithLength:0];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

// HttpRequest
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Get Responese.");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self buf] appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"HttpRequest Error. %@", [error localizedDescription]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Request Finished.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
