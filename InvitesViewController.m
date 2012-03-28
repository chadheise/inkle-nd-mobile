//
//  InvitesViewController.m
//  Inkle
//
//  Created by mobiapps on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InvitesViewController.h"
#import "Invites.h"
#import "RXMLElement.h"

@implementation InvitesViewController{
    NSMutableArray *invites;
}
@synthesize invitesTable;

/*---------CUSTOM FUNCTIONS-------------*/
- (void) updateInvites
{
    //Get invite data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/invites/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numInvitesString = [[responseXML child:@"invitations"] attribute:@"number"];
    NSInteger numInvites = [numInvitesString integerValue];
    
    invites = [NSMutableArray arrayWithCapacity:numInvites];
    
    [responseXML iterate:@"invite" with:^(RXMLElement *i) {
        Invites *invite = [[Invites alloc] init];
        invite = [[Invites alloc] init];
        invite.location = [NSString stringWithFormat:@"%@\n%@", [i child:@"location"]];
        invite.description = [NSString stringWithFormat:@"%@\n%@",[i child:@"inviter"], [i child:@"inviteType"], [i child:@"date"]];
        invite.message = [NSString stringWithFormat:@"%@\n%@",[i child:@"message"]];
        [invites addObject:invite];
        
    }];
    
    [invitesTable reloadData];
}
/*-------------------------------------*/
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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateInvites];
}


- (void)viewDidUnload
{
    [self setInvitesTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnAccept:(id)sender {
    //need to figure out what to do here:
        //-send the information to the server for accept
        //-update the table
}

- (IBAction)btnDecline:(id)sender {
    //need to figure out what to do here:
    //-send the information to the server for accept
    //-update the table
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
    return [invites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
    Invites *invite = [invites objectAtIndex:indexPath.row];
    
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:100];
    locationLabel.text = invite.location;
    
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:101];
    descriptionLabel.text = invite.description;
    
    UILabel *messageLabel = (UILabel *)[cell viewWithTag:102];
    messageLabel.text = invite.message;

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
