//
//  othersInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "othersInklingsViewController.h"
#import "Inklings.h"

@implementation othersInklingsViewController {
    
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
    
     NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/test/"];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     
     [request setHTTPMethod:@"POST"];
     [request setValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
     
     NSMutableData *postData = [NSMutableData data];
    /*[postData appendData: [[NSString stringWithFormat: @"xml=<xml>"] dataUsingEncoding: NSUTF8StringEncoding]];
     [postData appendData: [[NSString stringWithFormat: @"<email>%@</email>", [email text] ] dataUsingEncoding: NSUTF8StringEncoding]];
     [postData appendData: [[NSString stringWithFormat: @"<password>%@</password>", [password text] ] dataUsingEncoding: NSUTF8StringEncoding]];
     [postData appendData: [[NSString stringWithFormat: @"</xml>"] dataUsingEncoding: NSUTF8StringEncoding]];*/

    [request setHTTPBody: postData];

    //NSLog(@"postData: %@", postData);

     NSURLResponse *response;
     NSError *err;
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
     NSLog(@"responseData: %@", responseString);

    /*if ( [responseString isEqualToString: [NSString stringWithFormat:@"True"]] ) {
     [self performSegueWithIdentifier:@"loginSegue" sender:self];
     }*/
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InklingCell"];
    //The next line uses the array from the AppDelegate
    Inklings *inkling = [self.inklings objectAtIndex:indexPath.row];
    //Inklings *inkling = [self->othersInklings objectAtIndex:indexPath.row];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //The next line uses the array from the AppDelegate
    return [self.inklings count];
    //return [self->othersInklings count];
}


@end
