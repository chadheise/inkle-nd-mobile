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
    NSString * theDate = [self othersInklingsDate];
    theDate = [self stringFromDate:datePicker.date];
    NSLog(@"1 The date in pickerChanged fcn is: %@",theDate);
    NSString *printOut = [self othersInklingsDate];
    NSLog(@"2 The date in pickerChanged fcn is: %@",printOut);


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

    NSString* theDate = [self othersInklingsDate];
    NSLog(@"The date in othersInklingsDateViewController viewDidLoad is: %@",theDate);

}
-(void)viewDidAppear:(BOOL)animated
{

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
