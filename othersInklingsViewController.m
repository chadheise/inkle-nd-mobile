//
//  othersInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "othersInklingsViewController.h"
#import "Inklings.h"
#import "RXMLElement.h"

@implementation othersInklingsViewController {
    NSMutableArray *othersInklings;
}

@synthesize inklings;

- (IBAction)sessionTest:(id)sender {
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
 /*   UIScrollView *tempScrollView = (UIScrollView *)self.view;
    tempScrollView.contentSize = CGSizeMake(320,758);
    tempScrollView.contentInset = UIEdgeInsetsMake(64.0, 0.0, 44.0, 0.0);
    tempScrollView.scrollIndicatorInsets = UIEdgeInsetsMake (64.0, 0.0, 44.0, 0.0);*/
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/othersInklings/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<date>02/24/2012</date>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<peopleType>network</peopleType>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<peopleId>1</peopleId>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<inklingType>all</inklingType>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    
    NSString *numLocationsString = [[responseXML child:@"locations"] attribute:@"number"];
    NSInteger numLocations = [numLocationsString integerValue];
    
    othersInklings = [NSMutableArray arrayWithCapacity:numLocations];
    /*Inklings *inkling = [[Inklings alloc] init];
     inkling.address = @"222 S Michigan St.\nSouth Bend, IN";
     inkling.location = @"Club Fever";
     inkling.attendees = @"102";*/
    
    [responseXML iterate:@"location" with: ^(RXMLElement *l) {
        /*NSLog([NSString stringWithFormat: @"%@", [l child:@"count"]]);
         NSLog([NSString stringWithFormat: @"%@", [l child:@"name"]]);
         NSLog([NSString stringWithFormat: @"%@", [l child:@"street"]]);
         NSLog([NSString stringWithFormat: @"%@", [l child:@"citystate"]]);
         NSLog([NSString stringWithFormat: @"-----------------"]);*/
        Inklings *inkling = [[Inklings alloc] init];
        inkling = [[Inklings alloc] init];
        inkling.address = [NSString stringWithFormat: @"%@\n%@", [l child:@"street"], [l child:@"citystate"]];
        inkling.location = [NSString stringWithFormat: @"%@", [l child:@"name"]];
        inkling.attendees = [NSString stringWithFormat: @"%@", [l child:@"count"]];
        [othersInklings addObject:inkling];
        
    }];
    
    //NSLog([NSString stringWithFormat: @"othersInklings"]);
    //NSLog(othersInklings);
    //Inklings *myInkle = [othersInklings objectAtIndex:0];
    //NSLog(myInkle.location);
    //NSLog([NSString stringWithFormat: @"%@", othersInklings]);
    
    //[self.tableView reloadData];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //The next line uses the array from the AppDelegate
    //return [self.inklings count];
    return [othersInklings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InklingCell"];
    //The next line uses the array from the AppDelegate
    //Inklings *inkling = [self.inklings objectAtIndex:indexPath.row];
    Inklings *inkling = [othersInklings objectAtIndex:indexPath.row];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:100];
    locationLabel.text = inkling.location;
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    nameLabel.text = inkling.address;
    UILabel *attendeesLabel = (UILabel *)[cell viewWithTag:102];
    attendeesLabel.text = inkling.attendees;
    //  UIImageView * ratingImageView = (UIImageView *)[cell viewWithTag:102];
    //  ratingImageView.image = [self imageForRating:inkling.attendees];
    return cell;
    
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
