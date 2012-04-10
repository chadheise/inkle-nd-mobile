//
//  MyInklingsViewController.m
//  Inkle
//
//  Created by Chad Heise on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyInklingsViewController.h"
#import "RXMLElement.h"

@interface MyInklingsViewController ()

@end

@implementation MyInklingsViewController {
    NSDate *inklingDate;
    NSMutableArray *inklingTypes;
    NSMutableArray *myInklings;
}

@synthesize inklingTable;
@synthesize myInklingDate;

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
    myInklings = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
    
    //Set date to today
    inklingDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    myInklingDate.titleLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}

- (void)viewDidUnload
{
    [self setMyInklingDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    
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
    
    /****Inklings *inkling = [othersInklings objectAtIndex:indexPath.row];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:100];
    locationLabel.text = inkling.location;
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    nameLabel.text = inkling.address;
    UILabel *attendeesLabel = (UILabel *)[cell viewWithTag:102];
    attendeesLabel.text = inkling.attendees; ****/
    //  UIImageView * ratingImageView = (UIImageView *)[cell viewWithTag:102];
    //  ratingImageView.image = [self imageForRating:inkling.attendees];
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
