//
//  othersInklingsDateViewController.m
//  Inkle
//
//  Created by mobiapps on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "othersInklingsDateViewController.h"
#import "AppDelegateProtocol.h"

@implementation othersInklingsDateViewController

@synthesize datePicker;
/*--------CUSTOM FUNCTION--------*/
- (NSDate *) othersInklingsDate
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    NSDate *theDate = (NSDate*) theDelegate.othersInklingsDate;
    
    return theDate;
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

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    return [dateFormat stringFromDate:date];
}
- (IBAction)dateChanged:(id)sender {
    NSDate* theDate = [self othersInklingsDate];
    theDate = datePicker.date;
    NSString *printOut = [self stringFromDate:theDate];
    NSLog(@"The date in pickerChanged fcn is: %@",printOut);
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
    datePicker.frame = CGRectMake(0.0, 195, pickerSize.width, 460);
    datePicker.backgroundColor = [UIColor blackColor];
    [self.view addSubview:datePicker];
    [datePicker setHidden:NO];
    
    NSDate* theDate = [self othersInklingsDate];
    theDate = datePicker.date; //set the date selection
    NSString *printOut = [self stringFromDate:theDate];
    NSLog(@"The date in othersInklingsDateViewController viewDidLoad is: %@",printOut);

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
