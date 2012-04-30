//
//  MyInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyInklingsViewController.h"
#import "Inklings.h"
#import "RXMLElement.h"
#import "asyncimageview.h"
#import "OthersInklingsDate.h"
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

@synthesize inklingTable;
@synthesize myInklingDate;

//*****************CUSTOM FUNCTIONS********************//
- (OthersInklingsDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDate *theDataObject2 = (OthersInklingsDate*) theDelegate.theAppDataObject2;
    
    return theDataObject2;
}

- (void) updateMyInklings
{    
    //Update date button text to display new date
    OthersInklingsDate *theAppDataObject2 = [self theAppDataObject2];
    myInklingDate.titleLabel.text = theAppDataObject2.dateString;
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getMyInklings/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
//[postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", stringDate] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];    
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str);
    
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    myInklings = [NSMutableArray arrayWithCapacity:3]; //Empty myInklings array to store new data
    inklingLocationIDs = [NSMutableArray arrayWithCapacity:3]; //Empty array of location IDs
    
    RXMLElement *dinnerXML = [responseXML child:@"dinner"];
    Inklings *dinnerInkling = [[Inklings alloc] init];
    dinnerInkling.address = [NSString stringWithFormat: @"%@\n%@", [dinnerXML child:@"address1"], [dinnerXML child:@"address2"]];
    dinnerInkling.location = [NSString stringWithFormat: @"%@", [dinnerXML child:@"location"]];
    dinnerInkling.attendees = [NSString stringWithFormat: @""];
    dinnerInkling.locationType = [NSString stringWithFormat: @"%@", [dinnerXML child:@"locationType"]];
    dinnerInkling.locationID = [NSString stringWithFormat: @"%@", [dinnerXML child:@"locationID"]];
    [myInklings addObject:dinnerInkling];
    
    RXMLElement *pregameXML = [responseXML child:@"pregame"];
    Inklings *pregameInkling = [[Inklings alloc] init];
    pregameInkling.address = [NSString stringWithFormat: @"%@\n%@", [pregameXML child:@"address1"], [pregameXML child:@"address2"]];
    pregameInkling.location = [NSString stringWithFormat: @"%@", [pregameXML child:@"location"]];
    pregameInkling.attendees = [NSString stringWithFormat: @""];
    pregameInkling.locationType = [NSString stringWithFormat: @"%@", [pregameXML child:@"locationType"]];
    pregameInkling.locationID = [NSString stringWithFormat: @"%@", [pregameXML child:@"locationID"]];
    [myInklings addObject:pregameInkling];
    
    RXMLElement *main_eventXML = [responseXML child:@"main_event"];
    Inklings *main_eventInkling = [[Inklings alloc] init];
    main_eventInkling.address = [NSString stringWithFormat: @"%@\n%@", [main_eventXML child:@"address1"], [main_eventXML child:@"address2"]];
    main_eventInkling.location = [NSString stringWithFormat: @"%@", [main_eventXML child:@"location"]];
    main_eventInkling.attendees = [NSString stringWithFormat: @""];
    main_eventInkling.locationType = [NSString stringWithFormat: @"%@", [main_eventXML child:@"locationType"]];
    main_eventInkling.locationID = [NSString stringWithFormat: @"%@", [main_eventXML child:@"locationID"]];
    [myInklings addObject:main_eventInkling];
    //NSLog(@"before table reload");
    //Inklings *temp = [myInklings objectAtIndex:0];
    //NSLog(temp.location);
    [inklingTable reloadData];
    //[inklingTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //NSLog(@"reloaded data");
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

- (void)pushAnotherView;
{
    SetMyInklingViewController *setMyInklings = [[SetMyInklingViewController alloc] init];
    [self.navigationController pushViewController:setMyInklings animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    inklingTypes = [NSMutableArray arrayWithObjects:@"Dinner", @"Pregame", @"Main Event", nil];
    
    inklingDate = [NSDate date]; //Initialize date to today
    //theDelegate.myInklingsDate = [NSDate date]; //Initialize date to today
    //NSLog(@"viewDidLoad");
    [self updateMyInklings];
    //NSLog(@" end viewDidLoad");
}

- (void)viewDidUnload
{
    [self setMyInklingDate:nil];
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
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:200]; //Get the inkling type label 
    typeLabel.text = [inklingTypes objectAtIndex:indexPath.row]; //Set the label (dinner, pregame, or main event)
    
    Inklings *inkling = [myInklings objectAtIndex:indexPath.row];
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
    // Navigation logic may go here. Create and push another view controller.
    SingletonManager *sharedSingleton = [SingletonManager sharedInstance];
    OthersInklingsDate *theAppDataObject2 = [self theAppDataObject2]; 
    if (indexPath.row == 0)
    {
        sharedSingleton.inklingType = @"dinner"; 
        theAppDataObject2.myInklingType = @"dinner";
    }
    
    else if (indexPath.row == 1)
    {
        sharedSingleton.inklingType = @"pregame";
        theAppDataObject2.myInklingType = @"pregame";
    }
    else if (indexPath.row == 2)
    {
        sharedSingleton.inklingType = @"main_event";
        theAppDataObject2.myInklingType = @"main_event";
    }
    NSLog(@"in didSelectRowAtIndexPath inklingType is set to %@",sharedSingleton.inklingType);
    NSLog(@"in didSelectRowAtIndexPath myInklingType is set to %@",theAppDataObject2.myInklingType);
    [self pushAnotherView];
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}




@end
