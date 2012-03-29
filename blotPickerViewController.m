//
//  blotPickerViewController.m
//  Inkle
//
//  Created by Chad Heise on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "blotPickerViewController.h"

@implementation blotPickerViewController {
    NSMutableArray *blotNames;
    NSMutableArray *networkNames;
}
@synthesize blotPicker;
@synthesize blotNames;
@synthesize networkNames;
@synthesize resultsLabel;

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
    self.blotNames = [[NSMutableArray alloc] initWithObjects: @"Blot 1", @"Blot 2", @"Blot 3", @"Network 1", @"Network 2", nil];
    
}

- (void)viewDidUnload
{
    [self setBlotPicker:nil];
    [self setResultsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [blotNames count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [blotNames objectAtIndex:row];
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    

    resultsLabel.text = [NSString stringWithFormat: @"%@", [blotNames objectAtIndex:row]];
}



@end
