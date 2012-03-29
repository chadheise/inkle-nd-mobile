//
//  blotPickerViewController.m
//  Inkle
//
//  Created by Chad Heise on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "blotPickerViewController.h"
#import "peopleGroups.h"

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
    /*
    self.blotNames = [[NSMutableArray alloc] initWithObjects: @"Blot 1", @"Blot 2", @"Blot 3", @"Network 1", @"Network 2", nil];
  */
    self.blotNames = [NSMutableArray arrayWithCapacity:5];
    self.networkNames = [NSMutableArray arrayWithCapacity:5];
    
    peopleGroups *blot = [[peopleGroups alloc]init];
    blot.pid = @"3";
    blot.name = @"Pizza Group";
    [blotNames addObject:blot];
    peopleGroups *network = [[peopleGroups alloc]init];
    network.pid = @"2";
    network.name = @"MIT Network";
    [networkNames addObject:network];
    //blot = 
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
    peopleGroups *blot = [blotNames objectAtIndex:row];
    return blot.name;
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    peopleGroups *blot = [blotNames objectAtIndex:row];
    resultsLabel.text = blot.name;
    
    //resultsLabel.text = [NSString stringWithFormat: @"%@", [blotNames objectAtIndex:row]];
}



@end
