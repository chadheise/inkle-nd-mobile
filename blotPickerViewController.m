//
//  blotPickerViewController.m
//  Inkle
//
//  Created by Chad Heise on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "blotPickerViewController.h"
#import "peopleGroups.h"
#import "RXMLElement.h"
#import "OthersInklingsDataObject.h"
#import "AppDelegateProtocol.h"

@implementation blotPickerViewController {
    NSMutableArray *blotNames;
    NSMutableArray *networkNames;
    NSMutableArray *categoryNames;
    NSMutableArray *namesArr;
    NSString *bNSelection;//set to the name of the blot or network
    NSString *peopleType;
    NSString *peopleId;
}
@synthesize picker;
@synthesize blotNames;//array of strings containing the user's blots
@synthesize networkNames;//array of strings containing the user's networks
@synthesize categoryNames;//array of strings containing the words 'Blots' or 'Networks'
@synthesize namesArr;//array of peopleGroups containing either blotNames or networkNames--it is modified depending on user selection

- (OthersInklingsDataObject *) theAppDataObject
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    OthersInklingsDataObject *theDataObject;
    theDataObject = (OthersInklingsDataObject*) theDelegate.theAppDataObject;
    return theDataObject;
}

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
    
    self.categoryNames = [[NSMutableArray alloc] initWithObjects: @"Blots",@"Networks",nil];
    
    //Get blots
    NSURL *url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getPeopleGroups/blots/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    //NSLog(responseString);
    
    RXMLElement *responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numBlotsString = [[responseXML child:@"blots"] attribute:@"number"];
    NSInteger numBlots = [numBlotsString integerValue];
        
    self.blotNames = [NSMutableArray arrayWithCapacity:numBlots];
    
    [responseXML iterate:@"blot" with:^(RXMLElement *b) {
        //NSLog([NSString stringWithFormat: @"%@", [b child:@name"]]);
        peopleGroups *blot = [[peopleGroups alloc]init];
        blot.pid = [NSString stringWithFormat:@"%@", [b child:@"id"]];
        blot.name = [NSString stringWithFormat:@"%@", [b child:@"name"]];
        blot.type = @"blot";
        [blotNames addObject:blot];        
    }];
    
    //Get networks
    url = [NSURL URLWithString:@"http://www.inkleit.com/mobile/getPeopleGroups/networks/"];
    request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    //NSLog(responseString);
    
    responseXML = [RXMLElement elementFromXMLData:responseData];
    NSString *numNetworksString = [[responseXML child:@"networks"] attribute:@"number"];
    NSInteger numNetworks = [numNetworksString integerValue];
    
    self.networkNames = [NSMutableArray arrayWithCapacity:numNetworks];
    
    [responseXML iterate:@"network" with:^(RXMLElement *n) {
        //NSLog([NSString stringWithFormat: @"%@", [n child:@name"]]);
        peopleGroups *network = [[peopleGroups alloc]init];
        network.pid = [NSString stringWithFormat:@"%@", [n child:@"id"]];
        network.name = [NSString stringWithFormat:@"%@", [n child:@"name"]];
        network.type = @"network";
        [networkNames addObject:network];        
    }];
    
    //Preload picker with blots
    self.namesArr = self.blotNames; 

}
- (void)viewDidAppear:(BOOL)animated
{
    //Get previous selection
    OthersInklingsDataObject* theDataObject = [self theAppDataObject];
    if (theDataObject.type == @"blot")
    {
        [picker selectRow:0 inComponent:leftComponent animated:YES];
        self.namesArr = self.blotNames;
        NSInteger count = 0;
        BOOL found = NO;
        NSLog(@"blotPicker page: the current DataObject selection is: %@",theDataObject.selection);
        for (peopleGroups *grp in namesArr)
        {
            if([grp.name isEqualToString:theDataObject.selection]){
                found = YES;
                break;
            }
            count++;
        }
        if (found)
            [picker selectRow:count inComponent:rightComponent animated:YES];
        else
            [picker selectRow:0 inComponent:rightComponent animated:YES];
        [picker reloadComponent:rightComponent];
    }
    else if (theDataObject.type == @"network")
    {
        [picker selectRow:1 inComponent:leftComponent animated:YES];
       // [picker selectRow:0 inComponent:rightComponent animated:YES];
        self.namesArr = self.networkNames;
        [picker reloadComponent:rightComponent];
    }

    NSLog(@"blotPicker page: the blot/network is: %@", theDataObject.type);
  //  peopleType = theDataObject.type;
  //  peopleId = theDataObject.pid;
   // [picker selectRow:<#(NSInteger)#> inComponent:<#(NSInteger)#> animated:YES];
    //need to select the row based on what the user has already selected, i.e. Networks, University of Notre Dame
    
   // [picker selectRow:0 inComponent:rightComponent animated:YES];
   // [picker reloadComponent:rightComponent];
    
}
- (void)viewDidUnload
{
    [self setPicker:nil];
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
        NSString* selectedCat = [self.categoryNames objectAtIndex:row];
        if (selectedCat == @"Blots")
            self.namesArr = self.blotNames;
        else if(selectedCat == @"Networks")   
            self.namesArr = self.networkNames;
        [picker selectRow:0 inComponent:rightComponent animated:YES];
        [picker reloadComponent:rightComponent];
        
    }

    OthersInklingsDataObject *theDataObject = [self theAppDataObject];
    peopleGroups *ppl = [self.namesArr objectAtIndex:row];
    theDataObject.selection = ppl.name;
    //theDataObject.peopleGroup = ppl; this doesn't work
    theDataObject.pid = ppl.pid;
    theDataObject.type = ppl.type;
    NSLog(@"pid: %@ -> type: %@", theDataObject.pid, theDataObject.type);
    //NSLog(@"Picker page: the selection is: %@", theDataObject.selection);
   // peopleGroups *blot = [blotNames objectAtIndex:row]; previous #2

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component){
        case 0: 
            return 110.0f;
        case 1: 
            return 180.0f;
    }
    return 0;
}

@end
