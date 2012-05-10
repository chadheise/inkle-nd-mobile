//
//  LocationViewController.m
//  Inkle
//
//  Created by Chad Heise on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "RXMLElement.h"
#import "AppDelegateProtocol.h"
#import "OthersInklingsDate.h"
#import "OthersInklingsDataObject.h"
#import "Member.h"
#import "asyncimageview.h"

@interface LocationViewController ()

@end

@implementation LocationViewController {
    NSMutableArray *dinnerPeople;
    NSMutableArray *pregamePeople;
    NSMutableArray *mainEventPeople;
}


/*Custom helper functions*/
- (OthersInklingsDataObject *) theAppDataObject
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDataObject *theDataObject = (OthersInklingsDataObject*) theDelegate.theAppDataObject;
    
    return theDataObject;
}

- (OthersInklingsDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDate *theDataObject2 = (OthersInklingsDate*) theDelegate.theAppDataObject2;
    
    return theDataObject2;
}

- (void) updatePeople
{
    OthersInklingsDate *theAppDataObject2 = [self theAppDataObject2];
    
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/location/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>%@</date>", theAppDataObject2.dateString] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<locationId>%@</locationId>", theDataObject.locationId] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<locationType>%@</locationType>", theDataObject.locationType] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(responseString);
    
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    
    //Load the dinner people into their array
    RXMLElement *dinnerXML = [responseXML child:@"dinner"];
    NSString *numDinnerPeopleString = [dinnerXML attribute:@"number"];
    NSInteger numDinnerPeople = [numDinnerPeopleString integerValue];
    dinnerPeople = [NSMutableArray arrayWithCapacity:numDinnerPeople];
    [dinnerXML iterate:@"member" with: ^(RXMLElement *m) {
        Member *member = [[Member alloc] init];
        member.name = [NSString stringWithFormat: @"%@", [m child:@"name"]];
        member.memberID = [NSString stringWithFormat: @"%@", [m child:@"id"]];
        [dinnerPeople addObject: member ];
    }];
    
    //Load the pregame people into their array
    RXMLElement *pregameXML = [responseXML child:@"pregame"];
    NSString *numPregamePeopleString = [pregameXML attribute:@"number"];
    NSInteger numPregamePeople = [numPregamePeopleString integerValue];
    pregamePeople = [NSMutableArray arrayWithCapacity:numPregamePeople];
    [pregameXML iterate:@"member" with: ^(RXMLElement *m) {
        Member *member = [[Member alloc] init];
        member.name = [NSString stringWithFormat: @"%@", [m child:@"name"]];
        member.memberID = [NSString stringWithFormat: @"%@", [m child:@"id"]];
        [pregamePeople addObject: member ];
    }];
        
    //Load the main event people into their array
    RXMLElement *mainEventXML = [responseXML child:@"main_event"];
    NSString *numMainEventPeopleString = [mainEventXML attribute:@"number"];
    NSInteger numMainEventPeople = [numMainEventPeopleString integerValue];
    mainEventPeople = [NSMutableArray arrayWithCapacity:numMainEventPeople];
    [mainEventXML iterate:@"member" with: ^(RXMLElement *m) {
        Member *member = [[Member alloc] init];
        member.name = [NSString stringWithFormat: @"%@", [m child:@"name"]];
        member.memberID = [NSString stringWithFormat: @"%@", [m child:@"id"]];
        [mainEventPeople addObject: member ];
    }];
        
    [[self tableView] reloadData];
}

/*------------------------------------------*/

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title =@"Location Name";
    
    [self updatePeople];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void) viewDidAppear:(BOOL)animated
{
    [self updatePeople];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. (One section each for dinner, pregame, main event)
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        if (dinnerPeople == nil)
            return 0;
        return [dinnerPeople count];
    }
    else if (section == 1) {
        if (pregamePeople == nil)
            return 0;
        return [pregamePeople count];
    }
    else if (section == 2) {
        if (mainEventPeople == nil)
            return 0;
        return [mainEventPeople count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"locationInklingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Member *member = nil;
    if (indexPath.section == 0 && dinnerPeople != nil) {
        member = [dinnerPeople objectAtIndex:indexPath.row]; // The first section is for dinner inklings
    }
    else if (indexPath.section == 1 && pregamePeople != nil) { // The second section is for pregame inklings
        member = [pregamePeople objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 2 && mainEventPeople != nil) { // The third section is for main event inklings
        member = [mainEventPeople objectAtIndex:indexPath.row];
    }
    
    if (member != nil) {
        UILabel *memberLabel = (UILabel *)[cell viewWithTag:300];
        memberLabel.text = member.name;
    

        //Get invite image
        if (cell != nil) {
            AsyncImageView* oldImage = (AsyncImageView*)
            [cell.contentView viewWithTag:999];
            [oldImage removeFromSuperview];
        }
    
        CGRect frame;
        frame.size.width=50; frame.size.height=50;
        frame.origin.x=10; frame.origin.y=10;
        AsyncImageView* asyncImage = [[AsyncImageView alloc]
                                  initWithFrame:frame];
        asyncImage.tag = 301;
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.inkleit.com/static/media/images/members/%@.jpg", member.memberID]];
        [asyncImage loadImageFromURL:url];
    
        [cell.contentView addSubview:asyncImage];
        //End image
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if(section == 0)
        return @"Dinner";
    else if (section == 1)
        return @"Pregame";
    else if (section == 2)
        return @"Main Event";
    return @"Section out of Range";
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
