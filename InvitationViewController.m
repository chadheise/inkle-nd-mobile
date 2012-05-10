//
//  InvitesViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InvitationViewController.h"
#import "Invitation.h"
#import "RXMLElement.h"
#import "asyncimageview.h"

@implementation InvitationViewController{
    NSMutableArray *invites;
}
@synthesize invitesTable;
@dynamic invites;

/*---------CUSTOM FUNCTIONS-------------*/
- (void) updateInvites
{
    
    //Get invitation data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getInvitations/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
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
    NSString *numInvitesString = [[responseXML child:@"invitations"] attribute:@"number"];
    NSInteger numInvites = [numInvitesString integerValue];
    
    invites = [NSMutableArray arrayWithCapacity:numInvites];
    
    [responseXML iterate:@"invitation" with:^(RXMLElement *i) {
        //NSLog([NSString stringWithFormat: @"%@", [i child:@"from"]]);
        Invitation *invite = [[Invitation alloc] init];
        invite = [[Invitation alloc] init];
        invite.inviteID = [NSString stringWithFormat:@"%@", [i child:@"id"]];
        invite.locationType = [NSString stringWithFormat:@"%@", [i child:@"locationType"]];
        invite.location = [NSString stringWithFormat:@"%@", [i child:@"location"]];
        invite.locationID = [NSString stringWithFormat:@"%@", [i child:@"locationID"]];
        invite.from = [NSString stringWithFormat:@"%@", [i child:@"from"]];
        invite.type = [NSString stringWithFormat:@"%@", [i child:@"type"]];
        invite.date = [NSString stringWithFormat:@"%@", [i child:@"date"]];
        invite.description = [NSString stringWithFormat:@"%@", [i child:@"description"]];
        
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

-(void)viewDidAppear:(BOOL)animated
{
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
    //Get the rowIndex of the table
    NSIndexPath *indexPath =[self.invitesTable indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSUInteger row = indexPath.row;
    Invitation *invite = [invites objectAtIndex:row];
    //NSString *inviteIndex = [NSString stringWithFormat:@"%d", row];
    //NSLog(invite.inviteID);
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/invitationResponse/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<id>%@</id>", invite.inviteID] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<response>accepted</response>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSString *title = [NSString alloc];
    NSString *message = [NSString alloc];
    if ([responseString isEqualToString:@"completed"]) {
        title = @"Accepted!";
        message = @"You have sucessfully accepted the invitation";
    }
    else {
        title = @"Accepted Not Complete";
        message = @"There was an error accepting the invitation";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self updateInvites];

    
}

- (IBAction)btnDecline:(id)sender {
    //Get the rowIndex of the table
    NSIndexPath *indexPath =[self.invitesTable indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSUInteger row = indexPath.row;
    Invitation *invite = [invites objectAtIndex:row];
    
    //Get inkling data
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/invitationResponse/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data];
    [postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<id>%@</id>", invite.inviteID] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"<response>declined</response>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
    [request setHTTPBody: postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSString *title = [NSString alloc];
    NSString *message = [NSString alloc];
    if ([responseString isEqualToString:@"completed"]) {
        title = @"Declined";
        message = @"You have declined the invitation";
    }
    else {
        title = @"Decline Not Complete";
        message = @"There was an error declining the invitation";
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self updateInvites];

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
    return [invites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
    Invitation *invite = [invites objectAtIndex:indexPath.row];
    
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:100];
    locationLabel.text = invite.location;
    
    UILabel *infoLabel = (UILabel *)[cell viewWithTag:101];
    infoLabel.text = [NSString stringWithFormat:@"%@ has invited you to a %@ on %@", invite.from, invite.type, invite.date];
    
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:102];
    descriptionLabel.text = invite.description;
    
    //Get invite image
    if (cell != nil) {
        AsyncImageView* oldImage = (AsyncImageView*)
        [cell.contentView viewWithTag:999];
        [oldImage removeFromSuperview];
    }
    
	CGRect frame;
	frame.size.width=75; frame.size.height=75;
	frame.origin.x=5; frame.origin.y=25;
	AsyncImageView* asyncImage = [[AsyncImageView alloc]
                                   initWithFrame:frame];
	asyncImage.tag = 999;
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.inkleit.com/static/media/images/locations/%@.jpg", invite.locationID]];
    if ([invite.locationType isEqualToString:@"member"]) {
        url = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.inkleit.com/static/media/images/members/%@.jpg", invite.locationID]];
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
