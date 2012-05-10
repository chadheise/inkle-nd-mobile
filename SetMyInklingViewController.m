//
//  SetMyInklingViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetMyInklingViewController.h"
#import "AppDelegateProtocol.h"
#import "InklingDate.h"
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
- (InklingDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    InklingDate *theDataObject2 = (InklingDate*) theDelegate.theAppDataObject2;
    
    return theDataObject2;
}
- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:myInklingWebView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    SingletonManager* myInklingSingleton = [SingletonManager sharedInstance];
    
    self.myInklingWebView.scalesPageToFit = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/setMyInkling/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<inklingType>%@</inklingType>", myInklingSingleton.inklingType] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    [self.myInklingWebView loadRequest:request];
    
    if ([myInklingSingleton.inklingType isEqualToString:@"dinner"]) {
        self.navigationItem.title = @"Dinner";
    }
    else if ([myInklingSingleton.inklingType isEqualToString:@"pregame"]) {
        self.navigationItem.title = @"Pregame";
    }
    else {
        self.navigationItem.title = @"Main Event";
    }

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
