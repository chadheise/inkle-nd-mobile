//
//  loginViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "RXMLElement.h"

@implementation LoginViewController
@synthesize email = _email;
@synthesize password = _password;
@synthesize errorLabel = _errorLabel;

- (IBAction)LoginPress:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/login/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<email>%@</email>", [_email text] ] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<password>%@</password>", [_password text] ] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    
    if ( [[NSString stringWithFormat:@"%@", [responseXML child: @"valid"]] isEqualToString:[NSString stringWithFormat:@"True"]]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    else {
        _errorLabel.text = [NSString stringWithFormat:@"%@", [responseXML child:@"error"]];
        [responseXML iterate:@"errors.error" with: ^(RXMLElement *error) {
            //NSLog(_errorLabel.text);
            _errorLabel.text = [NSString stringWithFormat: @"%@ \n %@", _errorLabel.text, error];
        }];
    }
    
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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setEmail:nil];
    [self setPassword:nil];
    [self setErrorLabel:nil];
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
