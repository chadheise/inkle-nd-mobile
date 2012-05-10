//
//  othersInklingsDateViewController.m
//  Inkle
//
//  Created by Chad Heise and Julie Wamser on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DateViewController.h"
#import "AppDelegateProtocol.h"
#import "InklingDate.h"

@implementation DateViewController

@synthesize datePicker;

/*--------CUSTOM FUNCTION--------*/
- (InklingDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    InklingDate *theDataObject = (InklingDate*) theDelegate.globalInklingDate;
    
    return theDataObject;
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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)dateChanged:(id)sender 
{
    InklingDate* theDataObject = [self theAppDataObject2];
    theDataObject.dateString = [theDataObject stringFromDate:datePicker.date];
    theDataObject.date = datePicker.date;

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize datePicker
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self 
                action:@selector(dateChanged:) 
                forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0.0, 155, pickerSize.width, 460);
    datePicker.backgroundColor = [UIColor blackColor];
    [self.view addSubview:datePicker];
    [datePicker setHidden:NO];

    //Set the date picker to the previously selected date; defaults to current date
    
    InklingDate* theDataObject = [self theAppDataObject2];
    
    if (theDataObject.dateString == NULL)
    {
        theDataObject.dateString = [theDataObject stringFromDate:datePicker.date];
        theDataObject.date = datePicker.date;
    }
    else
        datePicker.date = theDataObject.date;
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
