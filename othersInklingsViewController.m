//
//  othersInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OthersInklingsViewController.h"
#import "Inkling.h"
#import "RXMLElement.h"
#import "OthersInklingsDataObject.h"
#import "AppDelegateProtocol.h"
#import "peopleGroups.h"
#import "InklingDate.h"


@implementation OthersInklingsViewController {
    NSMutableArray *othersInklings;
    
    NSDate *inklingDate;//previous inklingDate
    NSString *inklingType;
    NSString *peopleType;
    NSString *peopleId;
    NSString *bNSelection;//text of the blot/network selection i.e. "University of Notre Dame" or "Pizza Group"
}

@synthesize inklings;
@synthesize inklingTable;
@synthesize inklingTypeSegment;
@synthesize dateButton;
@synthesize navigationItem;
@synthesize peopleButton;
@synthesize bNButton;


/*------------CUSTOM FUNCTIONS--------------*/

- (OthersInklingsDataObject *) theAppDataObject
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDataObject *theDataObject = (OthersInklingsDataObject*) theDelegate.theAppDataObject;
    
    return theDataObject;
}
- (InklingDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    InklingDate *theDataObject2 = (InklingDate*) theDelegate.theAppDataObject2;
    
    return theDataObject2;
}

- (void) updateInklings
{

    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    
    //Update date button text to display new date
    [dateButton setTitle:theAppDataObject2.dateString forState:UIControlStateNormal]; 
    
    bNSelection = @"None";
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    if (theDataObject.selection == nil)
    {
        [peopleButton setTitle:@"Select a Blot or Network" forState:UIControlStateNormal];
    }
    else
    {
        bNSelection = theDataObject.selection;
        peopleType = theDataObject.type;
        peopleId = theDataObject.pid;
        [peopleButton setTitle:theDataObject.selection forState:UIControlStateNormal];
    }
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/othersInklings/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<peopleType>%@</peopleType>", peopleType] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<peopleId>%@</peopleId>", peopleId] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<inklingType>%@</inklingType>", inklingType] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    //Remove encoding for special characters
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSMutableString *mutableResponseString = [NSMutableString stringWithString:responseString];
    
    NSRange apostrophe = [mutableResponseString rangeOfString:@"&#39;"];
    while (apostrophe.location != NSNotFound) {
        [mutableResponseString replaceCharactersInRange:apostrophe withString:@"\'"];
        apostrophe = [mutableResponseString rangeOfString:@"&#39;"];
    }
    
    NSRange ampersand = [mutableResponseString rangeOfString:@"&amp;"];
    while (ampersand.location != NSNotFound) {
        [mutableResponseString replaceCharactersInRange:ampersand withString:@"&"];
        ampersand = [mutableResponseString rangeOfString:@"&amp;"];
    }
    
    responseData = [mutableResponseString dataUsingEncoding: NSASCIIStringEncoding];
    //----------------------------------------
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numLocationsString = [[responseXML child:@"locations"] attribute:@"number"];
    NSInteger numLocations = [numLocationsString integerValue];
    
    othersInklings = [NSMutableArray arrayWithCapacity:numLocations];
    
        [responseXML iterate:@"location" with: ^(RXMLElement *l) {
            Inkling *inkling = [[Inkling alloc] init];
            inkling.address = [NSString stringWithFormat: @"%@\n%@", [l child:@"street"], [l child:@"citystate"]];
            inkling.location = [NSString stringWithFormat: @"%@", [l child:@"name"]];
            inkling.attendees = [NSString stringWithFormat: @"%@", [l child:@"count"]];
            inkling.locationID = [NSString stringWithFormat: @"%@", [l child:@"id"]];
            inkling.locationType = [NSString stringWithFormat: @"%@", [l child:@"type"]];
            [othersInklings addObject:inkling];
        }];
        
    [inklingTable reloadData];
}



/*------------------------------------------*/
- (IBAction)segmentSelect:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        inklingType = @"all";
    }
    else if (sender.selectedSegmentIndex == 1) {
        inklingType = @"dinner";
    }
    else if (sender.selectedSegmentIndex == 2) {
        inklingType = @"pregame";
    }
    else if (sender.selectedSegmentIndex == 3) {
        inklingType = @"mainEvent";
    }
    
    [self updateInklings];
}
- (IBAction)pickBN:(id)sender{
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    bNSelection = theDataObject.selection;
    [self updateInklings];
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView
{
    
}*/

- (void) viewDidAppear:(BOOL)animated
{
    [self updateInklings];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize inklingDate to today
    inklingDate = [NSDate date]; 
    
    peopleType = @"network";
    peopleId = @"1";
    inklingType = @"all";
    [self updateInklings];
    
    //Update the date button
    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    [dateButton setTitle:theAppDataObject2.dateString forState:UIControlStateNormal];

}

- (void)viewDidUnload
{
    [self setInklingTypeSegment:nil];
    [self setInklingTypeSegment:nil];
    [self setDateButton:nil];
    [self setNavigationItem:nil];
    [self setPeopleButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setInklingTable:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*---TABLE VIEW FUNCTIONS*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //The next line uses the array from the AppDelegate
    //return [self.inklings count];
    return [othersInklings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InklingCell"];

    Inkling *inkling = [othersInklings objectAtIndex:indexPath.row];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:100];
    locationLabel.text = inkling.location;
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    nameLabel.text = inkling.address;
    UILabel *attendeesLabel = (UILabel *)[cell viewWithTag:102];
    attendeesLabel.text = inkling.attendees;

    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    //Set the inkling type that will be sent to the setMyInkling webview
    
    Inkling *inkling = [othersInklings objectAtIndex:indexPath.row]; //Get the current inkling object
    
    //Set the global location variable information
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    theDataObject.locationId = inkling.locationID;
    theDataObject.locationName = inkling.location;
    theDataObject.locationType = inkling.locationType;
    
    [self performSegueWithIdentifier: @"locationSegue" sender: self];

}
@end
