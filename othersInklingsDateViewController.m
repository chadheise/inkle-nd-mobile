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
- (NSString *) othersInklingsDate
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    NSString *theDate = (NSString *) theDelegate.othersInklingsDate;

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
- (void)dateChanged:(id)sender {
    //NSString * theDate = [self othersInklingsDate];
    //theDate = [self stringFromDate:datePicker.date];
   //NSLog(@"1 The date in pickerChanged fcn is: %@",theDate);
    //NSString *printOut = [self othersInklingsDate];
    //NSLog(@"2 The date in pickerChanged fcn is: %@",printOut);
    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    theDataObject.dateString = [self stringFromDate:datePicker.date];
    theDataObject.date = datePicker.date;
    NSLog(@"The dateString in othersInklingsDateViewController dateChanged is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController dateChanged is: %@",[self stringFromDate:theDataObject.date]);
    OthersInklingsDate* test = [self theAppDataObject2];
    NSLog(@"test in dateChanged is: %@",test.dateString);
    NSLog(@"test2 in dateChanged is: %@",[self stringFromDate:test.date]);
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

    //NSString* theDate = [self othersInklingsDate];
    //NSLog(@"The date in othersInklingsDateViewController viewDidLoad is: %@",theDate);

    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    theDataObject.dateString = [self stringFromDate:datePicker.date];
    theDataObject.date = datePicker.date;
    NSLog(@"The dateString in othersInklingsDateViewController viewDidLoad is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController viewDidLoad is: %@",[self stringFromDate:theDataObject.date]);
}
-(void)viewDidAppear:(BOOL)animated
{
    OthersInklingsDate* theDataObject = [self theAppDataObject2];
    NSLog(@"The dateString in othersInklingsDateViewController viewDidAppear is: %@",theDataObject.dateString);
    NSLog(@"The date in othersInklingsDateViewController viewDidAppear is: %@",[self stringFromDate:theDataObject.date]);
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
