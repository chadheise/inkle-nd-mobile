//
//  othersInklingsDateViewController.m
//  Inkle
//
//  Created by mobiapps on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "othersInklingsDateViewController.h"
#import "AppDelegateProtocol.h"
#import "OthersInklingsDate.h"

@implementation othersInklingsDateViewController

@synthesize datePicker;

/*--------CUSTOM FUNCTION--------*/
- (OthersInklingsDate *) theAppDataObject2
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDate *theDataObject = (OthersInklingsDate*) theDelegate.theAppDataObject2;
    
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
    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    theDataObject.dateString = [theDataObject stringFromDate:datePicker.date];
    theDataObject.date = datePicker.date;
    NSLog(@"The dateString in othersInklingsDateViewController dateChanged is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController dateChanged is: %@",[theDataObject stringFromDate:theDataObject.date]);

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize datePicker
    datePicker = [[UIDatePicker alloc] init];
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

    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    theDataObject.dateString = [theDataObject stringFromDate:datePicker.date];
    theDataObject.date = datePicker.date;
    NSLog(@"The dateString in othersInklingsDateViewController viewDidLoad is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController viewDidLoad is: %@",[theDataObject stringFromDate:theDataObject.date]);
}
-(void)viewDidAppear:(BOOL)animated
{
    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    NSLog(@"The dateString in othersInklingsDateViewController viewDidAppear is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController viewDidAppear is: %@",[theDataObject stringFromDate:theDataObject.date]);
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

@end
