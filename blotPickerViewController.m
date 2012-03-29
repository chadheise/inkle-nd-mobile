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
    NSMutableArray *categoryNames;
    NSMutableArray *namesArr;
}
@synthesize picker;
@synthesize blotNames;
@synthesize networkNames;
@synthesize resultsLabel;
@synthesize categoryNames;
@synthesize namesArr;

-(IBAction) buttonPressed {
    NSInteger catRow = [picker selectedRowInComponent:leftComponent];
    NSInteger popRow = [picker selectedRowInComponent:rightComponent];
    
    NSString *cat = [self.categoryNames objectAtIndex:catRow];
    
    peopleGroups *group = [self.namesArr objectAtIndex:popRow];
    NSString *pop = group.name;
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %@.",pop];
    NSString *message = [[NSString alloc] initWithFormat:@"%@ is in %@", pop, cat];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

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
    self.categoryNames = [[NSMutableArray alloc] initWithObjects: @"Blots",@"Networks",nil];
    self.namesArr = [NSMutableArray arrayWithCapacity:10];
    peopleGroups *blot = [[peopleGroups alloc]init];
    blot.pid = @"3";
    blot.name = @"Pizza Group";
    [blotNames addObject:blot];

    peopleGroups *network = [[peopleGroups alloc]init];
    network.pid = @"2";
    network.name = @"MIT Network";
    [networkNames addObject:network];
    
   /* network.pid = @"3";
    network.name = @"";
    [namesArr addObject:network];*/
    
   // NSString *selectedCat = [self.categoryNames objectAtIndex:0];
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    [self setResultsLabel:nil];
    self.categoryNames = nil;
    self.blotNames = nil;
    self.networkNames = nil;
    self.namesArr = nil;
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
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == leftComponent)
        return [self.categoryNames count];
    return [self.namesArr count];
 //   return [blotNames count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //peopleGroups *blot = [blotNames objectAtIndex:row];
    //return blot.name;
    if(component == leftComponent)
        return [self.categoryNames objectAtIndex:row];
    peopleGroups *group = [namesArr objectAtIndex:row];
    return group.name;
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (component == leftComponent){
        NSString *selectedCat = [self.categoryNames objectAtIndex:row];
        if (selectedCat == @"Blots")
            self.namesArr = self.blotNames;
        else if(selectedCat == @"Networks")
            self.namesArr = self.networkNames;
        [picker selectRow:0 inComponent:rightComponent animated:YES];
        [picker reloadComponent:rightComponent];
        
    }
   // peopleGroups *blot = [blotNames objectAtIndex:row]; previous #2
   // resultsLabel.text = blot.name;
    
    //resultsLabel.text = [NSString stringWithFormat: @"%@", [blotNames objectAtIndex:row]]; previous #1
}



@end
