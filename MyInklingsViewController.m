//
//  MyInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyInklingsViewController.h"
#import "Inkling.h"
#import "RXMLElement.h"
#import "asyncimageview.h"
#import "InklingDate.h"
#import "AppDelegateProtocol.h"
#import "SingletonManager.h"
#import "SetMyInklingViewController.h"

@interface MyInklingsViewController ()

@end

@implementation MyInklingsViewController {
    NSDate *inklingDate;
    NSMutableArray *inklingTypes;
    NSMutableArray *myInklings;
    NSMutableArray *inklingLocationIDs;
}

@synthesize myInklingDate;
@synthesize myInklingTable;

//*****************CUSTOM FUNCTIONS********************//
- (InklingDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    InklingDate *theDataObject2 = (InklingDate*) theDelegate.globalInklingDate;
    
    return theDataObject2;
}

- (void) updateMyInklings
{    
    //Update date button text to display new date
    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    [myInklingDate setTitle:theAppDataObject2.dateString forState:UIControlStateNormal];
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getMyInklings/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];    
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
    myInklings = [NSMutableArray arrayWithCapacity:3]; //Empty myInklings array to store new data
    inklingLocationIDs = [NSMutableArray arrayWithCapacity:3]; //Empty array of location IDs
    
    RXMLElement *dinnerXML = [responseXML child:@"dinner"];
    Inkling *dinnerInkling = [[Inkling alloc] init];
    dinnerInkling.address = [NSString stringWithFormat: @"%@\n%@", [dinnerXML child:@"address1"], [dinnerXML child:@"address2"]];
    dinnerInkling.location = [NSString stringWithFormat: @"%@", [dinnerXML child:@"location"]];
    dinnerInkling.attendees = [NSString stringWithFormat: @""];
    dinnerInkling.locationType = [NSString stringWithFormat: @"%@", [dinnerXML child:@"locationType"]];
    dinnerInkling.locationID = [NSString stringWithFormat: @"%@", [dinnerXML child:@"locationID"]];
    [myInklings addObject:dinnerInkling];
    
    RXMLElement *pregameXML = [responseXML child:@"pregame"];
    Inkling *pregameInkling = [[Inkling alloc] init];
    pregameInkling.address = [NSString stringWithFormat: @"%@\n%@", [pregameXML child:@"address1"], [pregameXML child:@"address2"]];
    pregameInkling.location = [NSString stringWithFormat: @"%@", [pregameXML child:@"location"]];
    pregameInkling.attendees = [NSString stringWithFormat: @""];
    pregameInkling.locationType = [NSString stringWithFormat: @"%@", [pregameXML child:@"locationType"]];
    pregameInkling.locationID = [NSString stringWithFormat: @"%@", [pregameXML child:@"locationID"]];
    [myInklings addObject:pregameInkling];
    
    RXMLElement *main_eventXML = [responseXML child:@"main_event"];
    Inkling *main_eventInkling = [[Inkling alloc] init];
    main_eventInkling.address = [NSString stringWithFormat: @"%@\n%@", [main_eventXML child:@"address1"], [main_eventXML child:@"address2"]];
    main_eventInkling.location = [NSString stringWithFormat: @"%@", [main_eventXML child:@"location"]];
    main_eventInkling.attendees = [NSString stringWithFormat: @""];
    main_eventInkling.locationType = [NSString stringWithFormat: @"%@", [main_eventXML child:@"locationType"]];
    main_eventInkling.locationID = [NSString stringWithFormat: @"%@", [main_eventXML child:@"locationID"]];
    [myInklings addObject:main_eventInkling];

    [myInklingTable reloadData];
}
//**************************************************************//

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
    inklingTypes = [NSMutableArray arrayWithObjects:@"Dinner", @"Pregame", @"Main Event", nil];
    
    inklingDate = [NSDate date]; //Initialize date to today

    [self updateMyInklings];
}

- (void)viewDidUnload
{
    [self setMyInklingDate:nil];
    [self setMyInklingTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateMyInklings];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*---TABLE VIEW FUNCTIONS*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3; //There are always 3 items in the table (dinner, pregame, main event)
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myInklingCell"];
    
    /* Only display detail discloser indicator if the date is today or in the future */
    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    
    NSDateComponents *date1Components = [calendar components:comps 
                                                    fromDate: theAppDataObject2.date];
    NSDateComponents *date2Components = [calendar components:comps 
                                                    fromDate: [NSDate date]];
    
    NSDate *selectedDate = [calendar dateFromComponents:date1Components];
    NSDate *today = [calendar dateFromComponents:date2Components];
    
    if ([selectedDate compare:today] != NSOrderedAscending) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]; //Display the detail indicator
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray]; //Set the selection style to gray
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone]; //Do not display the detail indicator
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //Disable row selection
    }
    /*---------------------------------------------------------------------------------- */
    
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:200]; //Get the inkling type label 
    typeLabel.text = [inklingTypes objectAtIndex:indexPath.row]; //Set the label (dinner, pregame, or main event)
    
    Inkling *inkling = [myInklings objectAtIndex:indexPath.row];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:201];
    locationLabel.text = inkling.location;
    UILabel *addressLabel = (UILabel *)[cell viewWithTag:202];
    addressLabel.text = inkling.address;
    
    //Get invite image
    if (cell != nil) {
        AsyncImageView* oldImage = (AsyncImageView*)
        [cell.contentView viewWithTag:999];
        [oldImage removeFromSuperview];
    }
    
	CGRect frame;
	frame.size.width=70; frame.size.height=70;
	frame.origin.x=15; frame.origin.y=30;
	AsyncImageView* asyncImage = [[AsyncImageView alloc]
                                  initWithFrame:frame];
	asyncImage.tag = 999;
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.inkleit.com/static/media/images/locations/%@.jpg", inkling.locationID]];
    if ([inkling.locationType isEqualToString:@"member"]) {
        url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.inkleit.com/static/media/images/members/%@.jpg", inkling.locationID]];
    }
    [asyncImage loadImageFromURL:url];
    
	[cell.contentView addSubview:asyncImage];
    //End image

    
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* Only perform the segue if the date is today or in the future */
    
    InklingDate *theAppDataObject2 = [self theAppDataObject2];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    
    NSDateComponents *date1Components = [calendar components:comps 
                                                    fromDate: theAppDataObject2.date];
    NSDateComponents *date2Components = [calendar components:comps 
                                                    fromDate: [NSDate date]];
    
    NSDate *selectedDate = [calendar dateFromComponents:date1Components];
    NSDate *today = [calendar dateFromComponents:date2Components];
    
    if ([selectedDate compare:today] != NSOrderedAscending) {
        //Set the inkling type that will be sent to the setMyInkling webview
        SingletonManager *myInklingSingleton = [SingletonManager sharedInstance];
            
        if (indexPath.row == 0) {
            myInklingSingleton.inklingType = @"dinner"; 
        }
            
        else if (indexPath.row == 1) {
            myInklingSingleton.inklingType = @"pregame";
        }
        else if (indexPath.row == 2) {
            myInklingSingleton.inklingType = @"main_event";
        }
        [self performSegueWithIdentifier: @"setMyInklingSegue" sender: self];
    }
}


@end
