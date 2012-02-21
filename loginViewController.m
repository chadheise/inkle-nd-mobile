//
//  loginViewController.m
//  Inkle
//
//  Created by Chad Heise on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"

@implementation loginViewController
@synthesize email;
@synthesize password;
@synthesize loginLabel;

- (IBAction)LoginPress:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/login/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    /*NSString *msgLength = [NSString stringWithFormat:@"%d", [loginData length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/CelsiusToFahrenheit" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];*/
    
    //[request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //[request addRequestHeader:@"Accept" value:@"application/xml"];
    //[request addRequestHeader:@"Content-Type" value:@"application/xml"];
    
    //[request setHTTPMethod:@"POST"];
    //[request setHTTPBody: [loginData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    //Need '=' after version and encoding (= won't send correctly)
    [postData appendData: [[NSString stringWithFormat: @"<?xml version\"1.0\" encoding\"UTF-8\" ?>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<email>%@</email>", [email text] ] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<password>%@</password>", [password text] ] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"responseData: %@", string);
    loginLabel.text = string;
    //[NSString stringWithFormat: @"%@", string];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setLoginLabel:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Login:(id)sender {
}
@end
