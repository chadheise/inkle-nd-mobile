//
//  SetMyInklingViewController.m
//  Inkle
//
//  Created by Chad Heise on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetMyInklingViewController.h"
#import "AppDelegateProtocol.h"
#import "OthersInklingsDate.h"
#import "SingletonManager.h"

@interface SetMyInklingViewController ()

@end

@implementation SetMyInklingViewController
@synthesize myInklingWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (OthersInklingsDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDate *theDataObject2 = (OthersInklingsDate*) theDelegate.theAppDataObject2;
    
    return theDataObject2;
}
- (void)loadView
{
    [super loadView];
    
    // Do any additional setup after loading the view.
    OthersInklingsDate *theAppDataObject2 = [self theAppDataObject2];
    SingletonManager* sharedSingleton = [SingletonManager sharedInstance];
    NSLog(@"inklingType in viewDidLoad of SetMyInklingViewController is %@",sharedSingleton.inklingType);
    NSLog(@"myInklingType in viewDidLoad of SetMyInklingViewController is %@",theAppDataObject2.myInklingType);
    
    self.myInklingWebView.scalesPageToFit = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/setMyInkling/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<inklingType>%@</inklingType>", theAppDataObject2.myInklingType] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    [self.myInklingWebView loadRequest:request];
    
    [self.view addSubview:myInklingWebView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];    

}

- (void)viewDidUnload
{
    [self setMyInklingWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
