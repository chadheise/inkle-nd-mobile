//
//  SetMyInklingViewController.m
//  Inkle
//
//  Created by Chad Heise on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetMyInklingViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.myInklingWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.inkleit.com/mobile/setMyInkling"]]];
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
